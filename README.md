### Installation (Setup)

You can go to the [releases](https://github.com/phanirithvij/twist.moe/releases) page and download the exact distribution for your os.
Then add the download path of the executable to `PATH`.

Adding to PATH on [Windows](#win-path), [Linux](https://unix.stackexchange.com/a/26059/312058) and on Mac it's same as linux.

```shell
git clone https://github.com/phanirithvij/twist.moe.git
cd twist.moe/
```

#### Requirements

> Requires `bash`, and optionally `wget` or `curl` on Linux and Mac

> Requires `cmd` or `bash`, and optionally `wget` or `curl` on Windows

```shell
bin/twist.exe <urls or anime-ids>
# or
bin/twist.exe
# A prompt will ask for urls
# enter urls or anime-ids
```

> The above step will make the directory of the anime in ./Anime/

#### To download

This twist executable has built-in download functionality with resuming support but it's safer to use `curl` or `wget` as they are sophisticated software.

You can download using one of the following:

Using this executable:

```shell
twist.exe url -d
# or
twist.exe -i urls.txt
```

Using curl or wget.
To download using `curl` or `wget`

#### Usage:

```
twist.exe --help
```

```
-h, --help                           Shows this help message
-d, --[no-]download                  Download the episodes
-s, --start=<number>                 The start value.
                                     (defaults to "1")

-e, --end=<number>                   The end episode to download.
                                     Defaults to the last episode in the list.
                                     Specify --count or -c for specifying number of episodes instead.

-c, --count=<number>                 The number of episodes to download.
                                     Specify --end or -e for specifying the end instead.

-i, --if=<path to list.txt>          Path to a urls.txt file
                                           IMPORTANT: Must pass the name of the anime when using this flag.
                                           Using: --name "anime name" option.

-n, --name=<Anime name>              Using: --name "anime name" option.
                                           This name will be used to replace the ":name" when formatting the episode names after downloading.
                                           Default value will be "episode" when using with --if(-i).
                                           Default value when downloading directly from url the name is extracted from the url
                                           This will override that name.

-f, --format=<format>                The format of the episode output name.
                                     Examples: ':number-:Pnumber-:name'
                                       You can pass just ':number' to get 1.mp4, 2.mp4 etc.
                                       ':Pnumber' is for padded numbers i.e. 1 will be 001, 300 will be 300
                                     Defaults to :name-:Pnumber.mp4.
                                     (defaults to ":name-:Pnumber")

-o, --dir=<destination directory>    Defaults to Anime/{provided name} or Anime/{fetched name}
                                     (defaults to "./Anime/")
```

#### Examples

> Note: `twist.exe` on windows and `twist` on linux/mac

```shell
twist.exe gintama, one-piece
# This will fetch the urls for those two anime
```

```shell
twist.exe gintama -d -s 1 -c 3
# This will fetch the urls and start downloading episode 1, and downloads three episodes including the first one i.e. 1, 2, 3
```

```shell
twist.exe gintama -d -e 3 -f ':name-:Pnumber'
# This will fetch the urls and sets the download format as `gintama-001.mp4`, `gintama-002.mp4`, and `gintama-003.mp4`
```

```shell
twist.exe gintama -d -o Anime/gint
# This will fetch the urls and download to the given directory
```

#### When interrupted they can be run again and the downloads will resume

Example:

```shell
twist.exe gintama -d -o Anime/gint

^C

twist.exe gintama -d -o Anime/gint

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
