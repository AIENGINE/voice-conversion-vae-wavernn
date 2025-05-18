#!/bin/bash

spks=(SEF1 SEF2 SEM1 SEM2 TFM1 TGM1 TMM1 TEF1 TEM1 TEF2 TEM2 TFF1 TGF1 TMF1)
spks_src=(SEF1 SEF2 SEM1 SEM2)

in_dir=wav_vcc20_24kHz_ts
out_dir=wav_cv_point_ts

mkdir -p $out_dir

for spk_src in ${spks_src[@]};do
    find ${in_dir} -name "*.wav" | grep "\/${spk_src}"  |  sort > tmp_${spk_src}_ts.list
    spk_idx=1
    for spk in ${spks[@]};do
        if [[ "$spk" =~ .*"TE".* ]] || \
                [[ "$spk" =~ .*"TF".* ]] || \
                [[ "$spk" =~ .*"TG".* ]] || \
                [[ "$spk" =~ .*"TM".* ]]; then
            out_dir_spk=${out_dir}/${spk_src}-${spk}
            mkdir -p ${out_dir_spk}
            while read line;do
                name=`basename $line .wav`
                out_file=${out_dir_spk}/${name}_${spk_src}-${spk}.wav
                echo $line $name $out_file
                ./bin/test_cycvae_mwdlp -i ${spk_idx} $line $out_file
            done < tmp_${spk_src}_ts.list
        fi
        spk_idx=$(( ${spk_idx}+1  ))
    done
    rm -f tmp_${spk_src}_ts.list
done

