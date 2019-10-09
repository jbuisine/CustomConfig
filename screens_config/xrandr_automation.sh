#! /bin/bash

results=$(xrandr --query | grep ' connected')

dp=""
for i in $results; do
    
    checkdp=$(echo $i | grep DP)

    # get current DP
    if [ ! -z $checkdp ]; then
        dp=$i
    fi

    res=$(echo $i | grep +0+0)

    if [ ! -z $res ]; then
        resolution=${i%+0+0}

        # find `width` and `height` attributes of resolution
        width=${resolution%x*}
        height=${resolution#*x}

        # 3000 is used as limit of HiDPI 
        if [ ! $width -ge 3000 ]; then
            echo "Configure $dp with new scale for HiDPI"
            xrandr --output $dp --mode ${width}x${height} --scale 2x2
        else
            echo "No need to configure $dp as HiDPI monitor"
        fi
    fi
done

