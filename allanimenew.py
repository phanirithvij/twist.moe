import json
import sys

import requests
import os

from decrypt import decrypt_export
from x_access_token import X_ACCESS_TOKEN

try:
    from tqdm import tqdm
except ImportError:
    # https://stackoverflow.com/a/50983362/8608146
    tqdm = lambda x, *args: (x,) + args if args else x
anime_api = "https://api.twist.moe/api/anime"
headers = {"x-access-token": X_ACCESS_TOKEN}


def get_api_details(slug):
    api_url = f"https://api.twist.moe/api/anime/{slug}/sources"
    response = requests.get(
        api_url, headers={'x-access-token': X_ACCESS_TOKEN})
    urls = []
    for s in response.json():
        urls.append(decrypt_export(s['source']))
    return urls


def main():
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


def main_eps():
    with open("new.min.json", 'r') as j:
        data = json.load(j)
        for item in tqdm(data):
            slug = item['slug']['slug']
            # TODO can check if already fetched
            # To save 20 mins time
            urls = get_api_details(slug)
            urls = [f"https://twistcdn.bunny.sh{url}" for url in urls]
            item['episodes'] = urls
        with open('new.eps.json', 'w+') as f:
            json.dump(data, f)
        with open('new.eps.min.json', 'w+') as f:
            json.dump(data, f, separators=(',', ':'))


if __name__ == "__main__":
    main_episodes = False
    force_main = False
    if len(sys.argv) > 1:
        if '--eps' in sys.argv or '--episodes' in sys.argv:
            main_episodes = True
        if '-f' in sys.argv or '--force' in sys.argv:
            force_main = True
    else:
        print("[INFO] you can use --eps or --episodes flag to get all episode urls")
        print("[INFO] you can use -f or --force flag to force fetch json again")
    if force_main or (not os.path.exists("new.min.json") or not os.path.exists("new.json")):
        main()
    if main_episodes:
        main_eps()
