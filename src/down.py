import signal
import sys

import requests
from tqdm import tqdm

# to prevent ctrl+c traceback
signal.signal(signal.SIGINT, lambda x, y: sys.exit(0))


# https://stackoverflow.com/a/51812486/8608146
def fetch_or_resume(url, filename):
    with open(filename, 'ab') as file:
        headers = {}
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
