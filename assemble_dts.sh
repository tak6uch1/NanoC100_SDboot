#!/bin/sh

for dtb in data/boot/*.dtb* data/boot/dtb/*.dtb*
do
    dts=`echo $dtb | sed -e 's@^data/boot@src@' -e 's/\.dtb.*$/\.dts/'`
    output=`echo $dtb | sed 's@^data@output@'`
    echo $dts
    dtc -I dts -O dtb -o $output $dts
done
