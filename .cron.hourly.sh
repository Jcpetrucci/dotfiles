#!/bin/bash
printf "MO River: %sft |" "$(grep -Po '(?<=Latest Stage: )\d+\.\d+' <(curl 'http://water.weather.gov/ahps2/river.php?wfo=eax&wfoid=18687&riverid=203276&pt%5B%5D=141703&allpoints=150186%2C148003%2C143543%2C141586%2C144582%2C148002%2C144796%2C144098%2C144240%2C141320%2C141614%2C142968%2C144183%2C142574%2C148204%2C142193%2C142760%2C142003%2C142610%2C142396%2C144496%2C147345%2C141899%2C143355%2C142050%2C141570%2C144165%2C143476%2C141703%2C142023%2C144123%2C141863%2C143539%2C143436%2C141917%2C143009%2C142688%2C142640%2C143925%2C143734%2C142729&data%5B%5D=hydrograph'))" > /tmp/tmux-left.txt 2>/dev/null
printf " Blue River: %sft" "$(grep -Po '(?<=Latest Stage: )\d+\.\d+' <(curl 'http://water.weather.gov/ahps2/river.php?wfo=eax&wfoid=18687&riverid=203454&pt%5B%5D=142304&allpoints=142304%2C145700%2C143345%2C142323%2C142828%2C152762%2C141380%2C143031%2C143229%2C142979&data%5B%5D=impacts'))" >> /tmp/tmux-left.txt 2>/dev/null