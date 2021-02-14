#!/bin/bash
# Follow the instructions from https://github.com/google-research/meta-dataset/blob/main/doc/dataset_conversion.md
# The version is committe: https://github.com/google-research/meta-dataset/commit/47671076304ef5fb6b7406b16bc2737bac6baded

which python
python --version

root_dir="/projects/NeuralArch/meta-dataset"
tf_root_dir="/projects/NeuralArch/meta-dataset-tf"
echo "Original data: ${root_dir}"
mkdir -p ${tf_root_dir}

script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
echo $scriptpath
meta_dataset_dir="${scriptpath}/../meta-dataset"
echo "meta dataset: ${meta_dataset_dir}"

cd ${meta_dataset_dir}

# ImageNet
ilsvrc_2012(){
  # to be done
  mkdir -p ILSVRC2012_img_train
  cd ILSVRC2012_img_train
  wget http://www.image-net.org/archive/wordnet.is_a.txt
  wget http://www.image-net.org/archive/words.txt
}

# [2] omniglot
do_omniglot(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=omniglot \
  --omniglot_data_root=${root_dir}/omniglot \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [3] aircraft
download_aircraft(){
  mkdir -p fgvc-aircraft-2013b
  cd fgvc-aircraft-2013b
  wget http://www.robots.ox.ac.uk/~vgg/data/fgvc-aircraft/archives/fgvc-aircraft-2013b.tar.gz
  tar xzvf fgvc-aircraft-2013b.tar.gz
  cd ..
}

# [4] cu_birds
download_cu_birds(){
  mkdir -p CUB_200_2011
  cd CUB_200_2011
  wget http://www.vision.caltech.edu/visipedia-data/CUB-200-2011/CUB_200_2011.tgz
  tar xzvf CUB_200_2011.tgz
  cd ..
}

# [5] dtd
download_dtd(){
  mkdir -p dtd
  cd dtd
  wget https://www.robots.ox.ac.uk/~vgg/data/dtd/download/dtd-r1.0.1.tar.gz
  tar xzvf dtd-r1.0.1.tar.gz
  cd ..
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
}

do_omniglot
