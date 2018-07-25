# Anime downloader for [Twist.Moe](https://twist.moe)

## NOT WORKING

## Using [anime_downloader](https://github.com/vn-ki/anime-downloader) for now

## Use old data from this link

[JSON](https://raw.githubusercontent.com/phanirithvij/Myanimewebsite/master/twistlinks.json)

## Installation (Setup)

```shell
git clone --single-branch -b pythontwist https://github.com/phanirithvij/twist.moe.git
cd twist.moe
python3 setup.py install
```

## Usage

```python
import pythontwist

print(pythontwist.get_anime_class('twist.moe')('gintama').get_data())
```