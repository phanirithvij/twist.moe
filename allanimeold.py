
# https://www.shellvoide.com/python/scraping-websites-python-bypass-sucuri-firewall-filter-javascript/

import json
import os
import subprocess
import sys
from datetime import datetime
from shutil import copyfile

import requests
from bs4 import BeautifulSoup as soup
from tqdm import tqdm

from decrypt import decrypt_export
from x_access_token import X_ACCESS_TOKEN

sucuri_cookies = {}
reqHeaders = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Referer': 'https://twist.moe/',
    'Connection': 'close',
}


def combine(acookies, bcookies):
    for key in list(bcookies.keys()):
        acookies[key] = bcookies[key]
    return acookies


def decode(html):
    # https://stackoverflow.com/a/63151716/8608146
    script = html.find("script").string
    script = script.replace("e(r)", "console.log(r)")
    script = subprocess.check_output(['node', '--eval', script])
    script = script.decode('utf-8')
    script = script.replace("document.cookie", "var cookie")
    script = script.replace("location.reload()", "console.log(cookie)")
    cookie = subprocess.check_output(['node', '--eval', script])
    cookie = cookie.decode('utf-8')
    if cookie.strip() != '':
        (key, value) = cookie.split(";")[0].split("=")
        sucuri_cookies[key] = value

get_count = 0

def get(url, params=None, headers=reqHeaders, cookies={}, timeout=60, allow_redirects=False):
    global get_count
    get_count += 1
    if get_count > 20:
        print("[*] Trouble reaching the server too many redirects")
        exit(-1)
    cookies = combine(sucuri_cookies, cookies)
    r = requests.get(url, params=None, headers=headers, cookies=cookies,
                     timeout=timeout, allow_redirects=allow_redirects)
    if r.status_code == 200 and r.headers['Server'] == "Sucuri/Cloudproxy" and "You are being redirected" in r.text:
        decode(soup(r.text, "html.parser"))
        return get(url, params, headers, cookies, timeout, allow_redirects)
    return r


def post(url, data=None, json=None, headers=reqHeaders, cookies={}, timeout=60, allow_redirects=False):
    cookies = combine(sucuri_cookies, cookies)
    r = requests.post(url, data=data, json=json, headers=headers,
                      cookies=cookies, timeout=timeout, allow_redirects=allow_redirects)
    if r.status_code == 200 and r.headers['Server'] == "Sucuri/Cloudproxy" and "You are being redirected" in r.text:
        decode(soup(r.text, "html.parser"))
        return post(url, data, json, headers, cookies, timeout, allow_redirects)
    return r


def get_names_json(file_name="data.json", force=False):
    total = 0
    original = None
    if os.path.isfile(os.path.join(".", file_name)):
        print("[*] Reading from ", file_name, "...")
        with open(file_name) as f:
            original = json.load(f)
            total = original['total']

    if not force:
        if original:
            return original

    print("[>] Requesting Site")
    resp = get("https://twist.moe/")
    print("[*] Status Code: ", resp.status_code)
    print(f"[*] Content Length: {len(resp.text)}")

    data = soup(resp.text, "html.parser")
    ul = data.find("ul")
    if ul is None:
        print(data)
        print("[ERROR] No results found, server might be down")
        exit(-1)
    ret = {'total': len(ul), 'data': [], 'created': str(datetime.now())}
    if total != 0 and total == ret['total']:
        return original

    for li in ul:
        name, slug = " ".join(li.a.text.split()), li.a["href"].split("/")[-2]
        ret["data"].append([name, slug])

    with open(file_name, 'w+') as f:
        json.dump(ret, f)

    return ret


def get_api_details(slug):
    api_url = f"https://api.twist.moe/api/anime/{slug}/sources"
    response = requests.get(
        api_url, headers={'x-access-token': X_ACCESS_TOKEN})
    urls = []
    for s in response.json():
        urls.append(decrypt_export(s['source']))
    return urls


def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


def get_all(data, filename):
    datax = data['data']
    if not os.path.isfile(filename):
        print(f'[*] Created {filename}')
        with open(filename, 'w+') as fa:
            cont = {'data': {}}
            cont = json.dump(cont, fa)

    with open(filename) as f:
        existing = json.load(f)
        before = existing.__len__()
    backup = filename + "-bc.json"
    copyfile(filename, backup)

    with open(filename, 'w') as f:
        f.write("{")
        count = 0
        tot = 0
        current = {}
        last_char = ""
        for s in tqdm(datax):
            if count == 5:
                dumper = json.dumps(current)
                f.write(dumper[1:-1] + ",")
                last_char = ","
                current = {}
                count = 0
                tot += 5
            try:
                slug = s[1]
                if slug in existing:
                    current[slug] = existing[slug]
                    tot += 1
                    continue
                else:
                    count += 1
                # urls = []
                urls = get_api_details(slug)
                urls = [f"https://twist.moe{url}" for url in urls]
                temp = {'n': s[0], 'u': urls}
                current[slug] = temp
            except KeyboardInterrupt:
                print('[*] Interrupted exiting...')
                if last_char == "," and len(current) == 0:
                    # this will get removed automatically
                    # when if : continue is executed
                    last_char = ""
                    f.write(f"\"temp{tot}{count}\" : false")
                    f.write("}")
                else:
                    dumper = json.dumps(current)
                    f.write(dumper[1:-1] + "}")
                sys.exit(1)
            except requests.exceptions.ConnectionError:
                print('[*] Connection error')
                if last_char == ",":
                    # this will get removed automatically
                    # when if : continue is executed
                    last_char = ""
                    f.write(f"\"temp{tot}{count}\" : false")
                f.write("}")
                sys.exit(1)

        # remaining data
        current = {}
        print("[*] remaining ", len(datax[tot:]))
        for rem in (datax[tot:]):
            slug = rem[1]
            if slug in existing:
                current[slug] = existing[slug]
                continue
            else:
                count += 1
            # urls = []
            urls = get_api_details(slug)
            urls = [f"https://twist.moe{url}" for url in urls]
            temp = {'n': rem[0], 'u': urls}
            current[slug] = temp
        dumper = json.dumps(current)
        f.write(dumper[1:-1] + "}")

    with open(filename) as f:
        data = json.load(f)
        after = data.__len__()

    if before > after:
        # stuff got removed
        # happens when nothing gets changed
        print("[*] restoring from backup")
        copyfile(backup, filename)
        os.remove(backup)


if __name__ == "__main__":
    filename = "all.json"
    datafile = "data.json"
    if sys.argv.__len__() > 1:
        filename = sys.argv[1]
        if sys.argv.__len__() > 2:
            datafile = sys.argv[2]
    print(f'Reading from "{datafile}" and storing in "{filename}"')
    data = get_names_json(datafile)
    get_all(data, filename)
