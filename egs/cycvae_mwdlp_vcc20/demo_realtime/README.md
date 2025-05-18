# Low-latency real-time voice conversion (LLRT-VC) based on multiband WaveRNN with data-driven linear prediction (MWDLP)-based neural vocoder and cyclic variational autoencoder (CycleVAE)-based spectral model


## Requirements

* gcc
* make
* CPU Intel >= Haswell (Q2 2013) or AMD >= Zen (Q1 2017)



## Install

```
$ make clean
$ make
```


## Demo analysis-synthesis

```
$ bash demo_anasyn.sh
```

*output wavs will be placed in wav_anasyn_vcc20_24kHz*



## Demo analysis-synthesis with mel-spectrogram

```
$ bash demo_melsp.sh
```

*output wavs and mel-spec data will be placed in wav_melspsyn_vcc20_24kHz*



## Demo voice conversion

```
$ bash demo_cv_point_dv.sh
$ bash demo_cv_point_ts.sh
```

*output converted wavs will be placed in wav_cv_point_dv and wav_cv_point_ts, respectively*



## Install with model dump

*requires UNIX and virtualenv*

```
$ cd scripts/tools
$ make
$ cd ../../
```

```
$ source scripts/tools/venv/bin/activate
$ ./scripts/dump_sparse-cyclevae_jnt_mwdlp-10b.py models/model_vcc20_360-380-53.conf models/checkpoint_vcc20_360-380-53-53.pkl
$ mv *.h inc
$ mv *.c src
$ make clean
$ make
```


## References

[1] [High-Fidelity and Low-Latency Universal Neural Vocoder based on Multiband WaveRNN with Data-Driven Linear Prediction for Discrete Waveform Modeling](https://arxiv.org/abs/2105.09856.pdf)

[2] [Low-latency real-time non-parallel voice conversion based on cyclic variational autoencoder and multiband WaveRNN with data-driven linear prediction](https://arxiv.org/pdf/2105.09858.pdf)



## Contact

Patrick Lumban Tobing

**Emails**: patrickltobing@gmail.com, patrick.lumbantobing@g.sp.m.is.nagoya-u.ac.jp

**Address**: Toda Laboratory, Nagoya University, Japan
