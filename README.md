# Anime downloader

## for [Twist.Moe](https://twist.moe)

#### STATUS: WORKING

#### Installation (Setup)

This branch is a dart re-write.

TODO:

- [x] startp.sh
- [x] api.sh
- [x] decrypt.py
- [ ] download.sh

```shell
git clone https://github.com/phanirithvij/twist.moe.git
cd twist.moe/
```

## Requirements

> Requires `bash`, `wget` or `curl` on linux

> TODO: reduce requirements on windows
> for now it requires `curl` or `wget` and `bash` on `cmder`

```shell
bin/twist.exe <urls or anime-ids>
# or
bin/twist.exe
# A prompt will
```

> The above step will make the directory of the anime in ./Anime/

> Go to that directory

```shell
cd Anime/#<anime_name>
./download.sh
```

## TODO

1. [ ] Add a proper database
2. [ ] Provide path as an argument
3. [ ] Rewrite the whole thing in python (not bash)
4. [ ] save as json instead of txt
5. [x] rename output files they look hideous
6. [x] Better and a faster way of decrypting
7. [ ] Use dart or something to create executables replacing `setup.sh` and `startp.sh` to something like `twistmoe.exe`, `twistmoe`. issue #21

### Examples

TODO: add example

## Complete json

### Created at `16 September 2019 GMT 08:39`

[JSON](https://github.com/phanirithvij/twist.moe/files/3615323/all-p.zip)
[Minified JSON](https://github.com/phanirithvij/twist.moe/files/3615322/all.zip)

To generate one for yourself

```shell
python3 allanime.py filename.json
```

### To build

```shell
dart2native.bat lib/main.dart -o bin/twist.exe # bin/twist on linux
```

### LICENSES

- Progress bar for dart By [Jaron Tai](https://github.com/jarontai/progress_bar) : [LICENSE](https://github.com/jarontai/progress_bar/blob/master/LICENSE)
- FileSize by [Erdbeer Schnitzel](https://github.com/erdbeerschnitzel/filesize.dart): [LICENSE](erdbeerschnitzel)

This project was inspired by [anime downloader](https://github.com/vn-ki/anime-downloader)
