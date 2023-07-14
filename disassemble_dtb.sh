#!/bin/sh

for dtb in data/boot/*.dtb* data/boot/dtb/*.dtb*
do
    dts=`echo $dtb | sed -e 's@^data/boot@src@' -e 's/\.dtb.*$/\.dts/'`
    echo $dts
    dtc -I dtb -O dts -o $dts $dtb
done
