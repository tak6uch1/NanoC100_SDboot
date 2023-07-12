#!/bin/sh

for f in `grep -v '^#' cp.list`
do
    newfile=/mnt/${f#*/}
    dirname=${newfile%/*}
    if [ ! -d $dirname ]; then
        echo sudo mkdir -p $dirname
        sudo mkdir -p $dirname
    fi
    echo sudo cp -r $f $newfile
    sudo cp -r $f $newfile
done
sync
