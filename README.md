# Anime downloader for [Twist.Moe](https://twist.moe)  

## STATUS: WORKING

## Installation (Setup)

```shell

git clone https://github.com/phanirithvij/twist.moe.git
cd twist.moe/
chmod +x *.sh
```

## Requirements

Requires `python`,`bash`

## Windows users

I recommend `cmder` or `git bash`
get them from [cmder](https://cmder.net/) and [git](https://git-scm.com/)
and install python if you don't have it.

### `Python requirements`

### Linux

```python
Crypto
hashlib
```
Run `./setup.sh` to install `python` and dependencies

### Windows

```shell
pip install pycryptodome
```

## Usage

```shell
./startp.sh #arguments
```

### The above step will make the directory of the anime in ./Anime/

### Go to that directory

```shell
cd Anime/#<anime_name>
./download.sh
```

animelist.txt will soon contain all the anime_names that you've used in `startp.sh`

## TODO

1. Add a proper database
2. Provide path as an argument


### Examples

Check [examples/examples.md](https://github.com/phanirithvij/twist.moe/tree/master/examples/examples.md)

## Complete json

### Created at `1 Mar 2018 GMT 15:19`

[JSON](https://raw.githubusercontent.com/phanirithvij/Myanimewebsite/master/twistlinks.json)

[Minified JSON](https://raw.githubusercontent.com/phanirithvij/Myanimewebsite/master/twistlinks.min.json)

This project was inspired by [anime downloader](https://github.com/vn-ki/anime-downloader)
