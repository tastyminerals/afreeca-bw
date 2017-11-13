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

Player   Race     Viewers  High    Avail
TerrOr   Zerg     25852    129726  Now
FlaSh    Terran   3968     73755   Now
Effort   Zerg     1423     25522   Now
Mind     Terran   513      14185   Now
hero     Zerg     309      20901   Now
Last     Terran   276      10163   Now
BySun    Protoss  265      10566   Now
Soulkey  Zerg     258      12856   Now
GuemChi  Protoss  230      14275   Now
BeSt     Protoss  192      21616   Now
Mini     Protoss  163      1200    Now
leto     unknown  163      2020    Now
zeus     Protoss  147      35052   Now
Rock     Protoss  104      6733    Now
Iris     Terran   52       1667    Now
July     Zerg     49       3005    Now
Hyuk     Zerg     31       407     Now
Calm     Zerg     29       4814    Now
Shinee   Terran   26       3353    Now
jat.tv   unknown  21       3216    Now
Sharp    Terran   19       2453    Now
trOt     Terran   17       1845    Now
IcaruS   Terran   16       985     Now
MIsO     Zerg     15       1570    Now
Nal_rA   Protoss  11       29174   Now
Sexy     Terran   3        389     Now
LoveTV   unknown  0        2279    Now

Play stream: last
Starting  rlatjdgus228  stream (it might take a while), be patient...

Play stream: !hd
Stream quality: aws_hd

Play stream: mini
Starting  bye1013  stream (it might take a while), be patient...

Play stream: exit
```
