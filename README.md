# afreeca_vlc.sh
This script allows you to watch afreeca.com streams via **vlc** using **streamlink** as backend.
It uses a simple list of bw streamers which should be updated manually in case some player is missing.

### Installation (Archlinux/Manjaro, use your distro package manager otherwise)
1. Make sure you have **vlc** installed.
```
sudo pacman -S vlc
```
2. Install streamlink
```
sudo pacman -S streamlink
```
3. Use `afreecatv.py` (which is provided in this repo) to replace the one installed with **streamlink**.
```
sudo cp afreecatv.py /usr/lib/python3.6/site-packages/streamlink/plugins/afreecatv.py
```
4. Put the script somewhere in `/usr/local/bin` for example.
```
sudo cp afreeca_vlc.sh /usr/local/bin
```
### Usage

```
$ afreeca_vlc.sh 
Play stream: !online

Shuttle Protoss 1322 35872 Now
Effort Zerg 1102 25522 Now
GuemChi Protoss 528 14275 Now
BeSt Protoss 287 21616 Now
Last Terran 224 10163 Now
Snow Protoss 131 880 Now
Mini Protoss 90 1125 Now
Sharp Terran 74 2453 Now
leto
65 2020 Now
BySun Protoss 51 10566 Now
LoveTV
39 2279 Now
Rush Terran 38 2312 Now
IcaruS Terran 30 985 Now
Movie Protoss 23 5876 Now
Nal_rA Protoss 12 29174 Now
Force[name] Zerg 3 190 Now

Play stream: last
Starting  rlatjdgus228  stream (it might take a while), be patient...

Play stream: !hd
Stream quality: aws_hd

Play stream: mini
Starting  bye1013  stream (it might take a while), be patient...

Play stream: exit
$
```
