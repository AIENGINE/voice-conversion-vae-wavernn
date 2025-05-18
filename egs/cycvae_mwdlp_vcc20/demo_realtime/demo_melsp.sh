#!/bin/bash


in_dir=wav_vcc20_24kHz
out_dir=wav_melspsyn_vcc20_24kHz

mkdir -p $out_dir

ls ${in_dir}/*.wav > tmp_melspsyn.list
#
while read line;do
    name=`basename $line .wav`
    melsp_bin=${out_dir}/${name}_melsp.bin
    melsp_txt=${out_dir}/${name}_melsp.txt
    echo $line $name
    ./bin/test_cycvae_mwdlp -o ${melsp_bin} ${melsp_txt} $line ${out_dir}/${name}_anasyn.wav
    ./bin/test_cycvae_mwdlp -b ${melsp_bin} ${out_dir}/${name}_binsyn.wav
    ./bin/test_cycvae_mwdlp -t ${melsp_txt} ${out_dir}/${name}_txtsyn.wav
done < tmp_melspsyn.list

rm -f tmp_melspsyn.list

