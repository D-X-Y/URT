# [ICLR 2021] A Universal Representation Transformer Layer for Few-Shot Image Classification

Few-shot classification aims to recognize unseen classes when presented with only a small number of samples. We consider the problem of multi-domain few-shot image classification, where unseen classes and examples come from diverse data sources. This problem has seen growing interest and has inspired the development of benchmarks such as Meta-Dataset. A key challenge in this multi-domain setting is to effectively integrate the feature representations from the diverse set of training domains. Here, we propose a Universal Representation Transformer (URT) layer, that meta-learns to leverage universal features for few-shot classification by dynamically re-weighting and composing the most appropriate domain-specific representations. In experiments, we show that URT sets a new state-of-the-art result on Meta-Dataset. Specifically, it achieves top-performance on the highest number of data sources compared to competing methods. We analyze variants of URT and present a visualization of the attention score heatmaps that sheds light on how the model performs cross-domain generalization.

## Install

Please use this command to download this repo:
```
git clone --recurse-submodules git@github.com:D-X-Y/URT.git
```

### Dependencies
This repo requires the following:
* Python 3.6 or greater
* PyTorch 1.0 or greater
* TensorFlow 1.14 or greater

The following is required by meta-dataset:
* pip install absl-py
* pip install gin-config>=0.1.2
* pip install tensorflow-gpu


## Data Preparation 
1. Meta-Dataset:

    Follow the the "User instructions" in the [Meta-Dataset repository](https://github.com/google-research/meta-dataset#user-instructions) for "Installation" and "Downloading and converting datasets".

    For simplicity, we also provided two scripts to download and convert the datasets, i.e., `bash scripts/download.sh` and `bash scripts/dataset_conversion.sh`.

2. Additional Test Datasets:

    If you want to test on additional datasets, i.e.,  MNIST, CIFAR10, CIFAR100, follow the installation instructions in the [CNAPs repository](https://github.com/cambridge-mlg/cnaps) to get these datasets.

## Getting the Feature Extractors

URT can be built on top of backbones pretrained in any ways. 

By default, this repo uses [SUR's pre-trained models](https://github.com/dvornikita/SUR) to extract features, 
Please execute the following command to download them and put into proper locations:
```
wget http://thoth.inrialpes.fr/research/SUR/all_weights.zip
unzip all_weights.zip
rm all_weights.zip
mv weights ~/.torch/sur-weights
```
It will donwnload all the weights and place them in the `~/.torch/sur-weights` directory.

If you want to pretrain the backbone by yourself on the training sets of Meta-Dataset, you need to customize some codes.


## Repo Structureo
```
.
├── lib [Library for configuration, dataset, mode and training strategy]
|     ├── config_utils
|     ├── data [The main codes to handle meta-dataset in PyTorch fashion]
|     ├── dataset [The codes to support episodic fast training]
|     └── models [The model and loss codes]
|
├── exps [The entry files for our algorithms]
|
└── scripts [Easy-to-use scripts]
          ├── download.sh [A script to download the whole meta-dataset except for ImageNet]
	  ├── dataset_conversion.sh [A script to convert all meta-dataset into tf-record]
```
Note that [`lib/data`](https://github.com/D-X-Y/URT/tree/master/lib/data) is modified from [CNAPs repo](https://github.com/cambridge-mlg/cnaps/blob/master/src).


## Train and evaluate URT

### Dumping features (for efficient training and evaluation)

We found that the bottleneck of training URT is extracting features from CNN. Since we freeze the CNN when training the URT, we found dumping the extracted feature episodes can significantly speed up the training procedure from days to ~2 hours. The easiest way is to download all the extracted features from [HERE](https://drive.google.com/drive/folders/1Z3gsa4TSSiH2wTZj1Jp5bD7UEKPOVzx5?usp=sharing) and put it in the ${cache_dir}.
Or you can extract by your own via ```bash ./scripts/pre-extract-feature.sh resnet18 ${cache_dir}```

### Train and evaluate

Run command from the dir of this repo:
```
bash ./fast-scripts/urt-avg-head.sh ${log_dir} ${num_head} ${penalty_coef} ${cache_dir}
```, where the ${num_head}=2 and ${penalty_coef}=0.1 in our paper.


## Citation

If you find that this project helps your research, please consider citing our work.
```
@inproceedings{liu2020universal,
	title={A Universal Representation Transformer Layer for Few-Shot Image Classification},
	author={Liu, Lu and Hamilton, William and Long, Guodong and Jiang, Jing and Larochelle, Hugo},
	booktitle={International Conference on Learning Representations (ICLR)},
	year={2021}
}
```
