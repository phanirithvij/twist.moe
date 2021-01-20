import json

import requests

from x_access_token import X_ACCESS_TOKEN

try:
    from tqdm import tqdm
except ImportError:
    # https://stackoverflow.com/a/50983362/8608146
    tqdm = lambda x, *args: (x,) + args if args else x
anime_api = "https://api.twist.moe/api/anime"
headers = {"x-access-token": X_ACCESS_TOKEN}

r = requests.get(anime_api, headers=headers, stream=True)
CONTENT_CHUNK_SIZE = 2 * 1024
data = b''
with open("new.json", 'wb+') as f:
    # eyeballing total here (i.e. rough hardcoded number)
    for x in tqdm(r.iter_content(CONTENT_CHUNK_SIZE), total=72):
        f.write(x)
        data += x

with open("new.min.json", 'w+') as f:
    minj = json.loads(data)
    json.dump(minj, f, separators=(',', ':'))
