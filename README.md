### Installation (Setup)

You can go to the [releases](https://github.com/phanirithvij/twist.moe/releases) page and download the exact distribution for your os.
Then add the download path of the executable to `PATH`.

Adding to PATH on [Windows](#win-path), [Linux](https://unix.stackexchange.com/a/26059/312058) and on Mac it's same as linux.

```shell
git clone https://github.com/phanirithvij/twist.moe.git
cd twist.moe/
```

#### Requirements

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

#### Examples

> `twist.exe` on windows and `twist` on linux/mac

<!-- TODO -->

```shell
twist.exe url, url, url
```

#### To build

```
git clone https://github.com/phanirithvij/twist.moe
cd twist.moe/
```

```shell
# On Windows
dart2native.bat lib\main.dart -o bin\twist.exe
# On linux and Mac
dart2native lib/main.dart -o bin/twist
```

#### Win Path

Start > Search for "Env" > "Edit environment variables for your account" > Find the `Path` > New > Paste this path > Ok

### LICENSES

- Progress bar for dart By [Jaron Tai](https://github.com/jarontai/progress_bar) : [LICENSE](https://github.com/jarontai/progress_bar/blob/master/LICENSE)
- FileSize by [Erdbeer Schnitzel](https://github.com/erdbeerschnitzel/filesize.dart): [LICENSE](erdbeerschnitzel)

> This project was inspired by [anime downloader](https://github.com/vn-ki/anime-downloader)
