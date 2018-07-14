# Anime downloader for [Twist.Moe](https://twist.moe)

## Installation (Setup)

```shell

git clone https://github.com/phanirithvij/twist.moe.git
cd twist.moe/
chmod +x *.sh

```

```shell
./startp.sh #URL

#Here URL is from https://twist.moe

#after comlpetion

#cd Anime/anime_name_folder/

./download.sh
```

animelist.txt will soon contain all the anime_names that you've used in startp.sh

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

## Examples

```shell
./startp.sh
```

**Output**:

```shell
Enter link from https://twist.moe/

https://twist.moe/a/one-piece/1/

Creating Anime/one-piece

Fetching info...

Creating Anime/one-piece/list.txt

copying download.sh to one-piece

Done
```

```shell
./startp.sh https://twist.moe/a/gintama
```

**Output**:

```shell
Creating Anime/gintama

Fetching info...

Creating Anime/gintama/list.txt

copying download.sh to gintama

Done
```

```shell
./startp.sh corpse-party      #Just the anime name which is exactly from the website

Creating Anime/corpse-party

Fetching info...

Creating Anime/corpse-party/list.txt

copying download.sh to corpse-party

Done

```

### Now go inside Anime/one-piece/

```shell
phani200-pc:~/twist.moe/Anime/one-piece$ ./download.sh

```

**Output**:

```shell
Total no of episodes : 819

start at :

3 (ENTER THIS where you want to BEGIN)

end at :

55 (ENTER THIS where you want to END)

[HorribleSubs] One Piece - 003 [1080p   8%[=====>                                       ]   17.6M   2.12MB/s    eta 3m 30s
```