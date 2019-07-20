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

### Linux

```python
pycryptodome # this is recommended and nothing else like pycrypto or Crypto
hashlib
```
Run `./setup.sh` to install `python` and dependencies

### Windows

```shell
pip install pycryptodome
```

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
5. [ ] rename output files they look hideous

### Examples

Check [examples/README.md](/examples)

## Complete json

### Created at `1 Mar 2018 GMT 15:19`

[JSON](https://raw.githubusercontent.com/phanirithvij/Myanimewebsite/master/twistlinks.json)

[Minified JSON](https://raw.githubusercontent.com/phanirithvij/Myanimewebsite/master/twistlinks.min.json)

This project was inspired by [anime downloader](https://github.com/vn-ki/anime-downloader)
