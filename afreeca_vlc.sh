#!/bin/bash
# afreeca stream switcher

# available streams: aws_sd (worst), aws_hd, aws_original (best)
QUALITY="aws_original"

# player - afreeca id map
declare -A players=(
 ["asl"]="aslenglish"
 ["horang"]="rudals5467"
 ["shine"]="lyh8808"
 ["afstar"]="afstar1"
 ["stork"]="koreasbg"
 ["asl2"]="afstar1"
 ["thrill"]="iahnow2"
 ["horang2"]="horang2"
 ["miso"]="hdy4546"
 ["firebathero"]="firebathero"
 ["rain"]="ioioiobb"
 ["bysun"]="ioioiobb"
 ["soulkey"]="minchul"
 ["jaedong"]="jaedong23"
 ["sonic"]="sogodtt"
 ["effort"]="momo130"
 ["britney"]="khm11903"
 ["hero"]="byhero"
 ["mong"]="cksgmldbs"
 ["shuttle"]="jk890202"
 ["zero"]="kimmyungwun"
 ["free"]="dbsdydx"
 ["flash"]="byflash"
 ["sea.kh"]="youngskh"
 ["best"]="wodnrdldia"
 ["july"]="julyzerg"
 ["kimeunho"]="dmsghdlekd"
 ["kds"]="cantob"
 ["rush"]="yoo376"
 ["leto"]="sereniss87"
 ["envy.bisu"]="tjdwo0000"
 ["soulblacktv"]="goodplay"
 ["spotimes"]="bsscamp"
 ["kal"]="rngusdl"
 ["ErOs_LYH"]="kisszzang14"
 ["hwan"]="wlghks910903"
 ["ETStarTV"]="scv306306"
 ["leta"]="palko1"
 ["saber"]="jackpot"
 ["rapsodytoss"]="younggunz91"
 ["41tv"]="isee1541"
 ["hint"]="kyuhoikim"
 ["onicle"]="onicle"
 ["koala"]="cyskkscv"
 ["lovetv"]="sr629"
 ["sharp"]="sharpragu"
 ["jat.tv"]="yyy2222"
 ["zelot"]="jh3697"
 ["larva"]="dpfgc3"
 ["terror"]="y1026"
 ["ample"]="hoonykkk"
 ["yellow"]="lifeisjust"
 ["hwasin"]="piroopirong"
 ["mook"]="limtaemook"
 ["by.sun"]="ioioiobb"
 ["rock"]="aghhi"
 ["sea"]="yuambo"
 ["casy"]="casy"
 ["piano"]="organ333"
 ["jaehoon"]="rlawogns019"
 ["zeus"]="70jeontaekyu"
 ["force[name]"]="bs1369"
 ["ssak"]="ghtjs3833"
 ["eagle"]="cjsdkxjddlf"
 ["guemchi"]="rlatldgus"
 ["savior"]="mjy1123"
 ["last"]="rlatjdgus228"
 ["hyuk"]="rlekfu6"
 ["roro"]="skwangs7"
 ["icarus"]="psn1555"
 ["hiya"]="aisiteru99"
 ["mind"]="peros777"
 ["nada"]="nada11200"
 ["starcue"]="jimeang"
 ["bisu"]="rlaxordyd"
 ["killer"]="h78ert"
 ["shinee"]="onlysibar"
 ["hoejja"]="gkm905"
 ["tyson"]="subeom12"
 ["pure"]="psj0436"
 ["iris"]="bht0205"
 ["sexy"]="rfvtgb778"
 ["fishcast"]="fishcast"
 ["jsmtv"]="hiji0312"
 ["movie"]="jyh8610"
 ["by.spire"]="idch0726"
 ["sky"]="gksmfaowj"
 ["mini"]="bye1013"
 ["shark"]="starbell87"
 ["lazy"]="hateliar"
 ["kwanro"]="ehrflq2013"
 ["nal_ra"]="nalra82"
 ["snow"]="tmsh401"
 ["july"]="julyzerg"
 ["pusan"]="jou1025"
 ["jangbi"]="mycou"
 ["brave"]="xorbzzang111"
 ["calm"]="brainzerg7"
 ["boxer"]="sblyh119"
 ["light"]="scv6256"
 ["midas"]="sangwk"
 ["mahell"]="alsd1323"
 ["modesty"]="tearstt"
 ["sabitv"]="zzzz2z"
 ["beast"]="rjsrkdgkwk12"
 ["smile"]="worud0608"
 ["zergman"]="jun10280"
 ["hogil"]="nspzerg"
 ["scat.horang2"]="comby4343"
)

while true; do
  read -p "Play stream: " INPUT
  if [[ "$INPUT" == "exit" ]]; then
    exit 0
  fi
  if [[ "$INPUT" == "!online" ]]; then
    echo ""
    curl -s https://afreecabw.appspot.com/ | sed -e '/<tr class="offline show">/,+7d' | awk  -F '[<>]' 'BEGIN {ORS=" "}; /<td / { gsub(/<b>/, ""); sub(/ .*/, "", $3); print $3 } ' | sed s'/  /\n/'g
    echo ""
    continue
  fi
  if [ -z $INPUT ]; then
      echo "Please provide player's name or check who's online via !online command"
      echo "You can also set a stream quality via !original, !hd or !sd commands"
      echo -e "Type exit to quit\n"
      continue
  fi
  if [[ "$INPUT" == "!original" ]]; then
      QUALITY="aws_original"
      echo -e "Stream quality: gs_original\n"
      continue
  elif [[ "$INPUT" == "!hd" ]]; then
      QUALITY="aws_hd"
      echo -e "Stream quality: gs_hd\n"
      continue
  elif [[ "$INPUT" == "!sd" ]]; then
      QUALITY="aws_sd"
      echo -e "Stream quality: gs_sd\n"
      continue
  fi
  if [ -z ${players[${INPUT,,}]} ]; then
      echo "Uh-oh, ${INPUT,,} does not exist in the player's list :("
      echo -e "Check if you typed it correctly or add it to the list yourself ;)\n"
      continue
  fi
  echo -e "Starting " ${players[${INPUT,,}]} " stream (it might take a while), be patient...\n"
  streamlink --quiet --loglevel=error --player="/usr/bin/vlc --file-caching=5000 --network-caching=5000 --meta-title=$INPUT" afreeca.com/${players[$INPUT]} $QUALITY &
done
