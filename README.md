# Anime downloader for [Twist.Moe](https://twist.moe)

## STATUS: WORKING

## Installation (Setup)

```shell
git clone https://github.com/phanirithvij/twist.moe.git
cd twist.moe/
chmod +x *.sh # optional
```

## Requirements

> Requires `python`, `bash` on linux

> Requires `python`, `bash` on `cmder` on windows

## Windows users

I recommend `cmder` or `git bash`
get them from [cmder](https://cmder.net/) and [git](https://git-scm.com/)
and install python if you don't have it.

The following instructions are based on the assumption that `cmder`|`bash` are being used.

### `Python requirements`

### Linux and Windows

```python
pycryptodomex # this is recommended and nothing else like pycrypto or Crypto or pycryptodome
hashlib
requests
```

Run `./setup.sh` to install `python` and dependencies

```shell
pip install pycryptodomex requests hashlib
```

**Or** you could do

Run `./setup.sh` to install `python` and dependencies

## Usage

```shell
./startp.sh #anime_slug

# eg:
./startp.sh gintama
# or
./startp.sh https://twist.moe/a/gintama
```

### The above step will make the directory of the anime in ./Anime/

This is how it should look till here
![usage](https://user-images.githubusercontent.com/29627898/61578109-2b403c80-ab0f-11e9-9db3-aab05afd56e0.png)

### Go to that directory

```shell
cd Anime/#<anime_name>
./download.sh
```

animelist.txt will soon contain all the anime_names that you've used in `startp.sh`

## TODO

1. [ ] Add a proper database
2. [ ] Provide path as an argument
3. [ ] Rewrite the whole thing in python (not bash)
4. [ ] save as json instead of txt
5. [x] rename output files they look hideous
6. [x] Better and a faster way of decrypting
7. [ ] Use dart or something to create executables replacing `setup.sh` and `startp.sh` to something like `twistmoe.exe`, `twistmoe`. issue #21

### Examples

Check [examples/README.md](/examples)

## Complete json

### Created at `16 September 2019 GMT 08:39`

[JSON](https://github.com/phanirithvij/twist.moe/files/3615323/all-p.zip)
[Minified JSON](https://github.com/phanirithvij/twist.moe/files/3615322/all.zip)

To generate one for yourself

```shell
python3 allanime.py filename.json
```

This project was inspired by [anime downloader](https://github.com/vn-ki/anime-downloader)
