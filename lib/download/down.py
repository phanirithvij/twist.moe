import signal
import sys

import requests
import cfscrape
from tqdm import tqdm

scraper = cfscrape.create_scraper()

# to prevent ctrl+c traceback
signal.signal(signal.SIGINT, lambda x, y: sys.exit(0))

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101 Firefox/69.0',
    'Referer': 'https://twist.moe/',
}

def fetch_or_resume(url, filename, params=tuple(), headers={}, session=None):
    """Downloads a file from url with continue support"""
    # https://stackoverflow.com/a/51812486/8608146
    if session is None:
        session = Session()
    with open(filename, "ab") as file:
        pos = file.tell()
        if pos:
            headers["Range"] = f"bytes={pos}-"
        response = session.get(url, headers=headers, params=params, stream=True)
        if response.status_code == 416:
            return
        if response.status_code >= 300:
            print(response.status_code, response.text)
            file.close()
            os.remove(filename)
            exit(1)
            # return False
        total_size = int(response.headers.get("content-length"))
        for data in tqdm(
            iterable=response.iter_content(chunk_size=1024),
            total=total_size // 1024,
            unit="KB",
            leave=False,
        ):
            file.write(data)


if __name__ == "__main__":
    print(sys.argv)
    fetch_or_resume(sys.argv[1], sys.argv[2])
