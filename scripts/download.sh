#!/bin/bash
# Follow the instructions from https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md
# The version is committe: https://github.com/google-research/meta-dataset/commit/47671076304ef5fb6b7406b16bc2737bac6baded

root_dir="/projects/NeuralArch/meta-dataset"

cd ${root_dir}

# ImageNet
ilsvrc_2012(){
  # to be done
  mkdir -p ILSVRC2012_img_train
  cd ILSVRC2012_img_train
  wget http://www.image-net.org/archive/wordnet.is_a.txt
  wget http://www.image-net.org/archive/words.txt
}

# [2] omniglot
download_omniglot(){
  mkdir -p omniglot
  cd omniglot
  wget https://github.com/brendenlake/omniglot/raw/master/python/images_background.zip
  wget https://github.com/brendenlake/omniglot/raw/master/python/images_evaluation.zip
  unzip images_background.zip
  unzip images_evaluation.zip
  cd ..
}

# [3] aircraft
download_aircraft(){
  wget http://www.robots.ox.ac.uk/~vgg/data/fgvc-aircraft/archives/fgvc-aircraft-2013b.tar.gz
  tar xzvf fgvc-aircraft-2013b.tar.gz
}

# [4] cu_birds
download_cu_birds(){
  # wget http://www.vision.caltech.edu/visipedia-data/CUB-200-2011/CUB_200_2011.tgz
  gdown https://drive.google.com/u/0/uc?id=1hbzc_P1FuxMkcabkgn9ZKinBwW683j45
  tar xzvf CUB_200_2011.tgz
}

# [5] dtd
download_dtd(){
  wget https://www.robots.ox.ac.uk/~vgg/data/dtd/download/dtd-r1.0.1.tar.gz
  tar xzvf dtd-r1.0.1.tar.gz
}

# [6] quickdraw
download_quickdraw(){
  mkdir -p quickdraw
  gsutil -m cp gs://quickdraw_dataset/full/numpy_bitmap/*.npy ./quickdraw/
}

# [7] fungi
download_fungi(){
  mkdir -p fungi
  cd fungi
  wget https://labs.gbif.org/fgvcx/2018/fungi_train_val.tgz
  wget https://labs.gbif.org/fgvcx/2018/train_val_annotations.tgz
  tar xzvf fungi_train_val.tgz
  tar xzvf train_val_annotations.tgz
  cd ..
}

# [8] vgg_flower
download_vgg_flower(){
  mkdir -p vgg_flower
  cd vgg_flower
  wget http://www.robots.ox.ac.uk/~vgg/data/flowers/102/102flowers.tgz
  wget http://www.robots.ox.ac.uk/~vgg/data/flowers/102/imagelabels.mat
  tar xzvf 102flowers.tgz
  cd ..
}

# [9] traffic_sign
download_traffic_sign(){
  wget https://sid.erda.dk/public/archives/daaeac0d7ce1152aea9b61d9f1e19370/GTSRB_Final_Training_Images.zip
  unzip GTSRB_Final_Training_Images.zip
}

# [10] mscoco
download_mscoco(){
  mkdir -p mscoco
  cd mscoco
  wget http://images.cocodataset.org/zips/train2017.zip
  wget http://images.cocodataset.org/annotations/annotations_trainval2017.zip
  unzip train2017.zip
  unzip annotations_trainval2017.zip
  cd ..
}

# start download
download_omniglot
download_aircraft
download_cu_birds
download_dtd
download_quickdraw
download_fungi
download_vgg_flower
download_traffic_sign
download_mscoco

