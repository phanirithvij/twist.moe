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

# https://stackoverflow.com/a/51812486/8608146


def fetch_or_resume(url, filename):
    with open(filename, 'ab') as file:
        # headers = {
        #     'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36'
        # }
        pos = file.tell()
        if pos:
            headers['Range'] = f'bytes={pos}-'
        response = requests.get(url, headers=headers, stream=True)
        # if pos:
        #     validate_as_paranoid_as_you_want_to_be_(pos, response)
        total_size = int(response.headers.get('content-length'))
        for data in tqdm(iterable=response.iter_content(chunk_size=1024), total=total_size//1024, unit='KB'):
            file.write(data)


if __name__ == "__main__":
    print(sys.argv)
    fetch_or_resume(sys.argv[1], sys.argv[2])
