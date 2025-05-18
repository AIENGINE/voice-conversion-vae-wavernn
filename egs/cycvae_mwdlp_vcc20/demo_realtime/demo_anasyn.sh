#!/bin/bash

in_dir=wav_vcc20_24kHz
out_dir=wav_anasyn_vcc20_24kHz

mkdir -p $out_dir

ls ${in_dir}/*.wav > tmp_anasyn.list

while read line;do
    name=`basename $line`
    echo $line $name
   ./bin/test_cycvae_mwdlp $line ${out_dir}/$name
done < tmp_anasyn.list

rm -f tmp_anasyn.list

