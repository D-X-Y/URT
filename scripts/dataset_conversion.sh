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
echo "LD_LIBRARY_PATH: ${LD_LIBRARY_PATH}"

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
do_aircraft(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=aircraft \
  --omniglot_data_root=${root_dir}/fgvc-aircraft-2013b \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [4] cu_birds
do_cu_birds(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=aircraft \
  --omniglot_data_root=${root_dir}/CUB_200_2011 \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [5] dtd
do_dtd(){
  python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=aircraft \
  --omniglot_data_root=${root_dir}/dtd \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [6] quickdraw
do_quickdraw(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=quickdraw \
  --quickdraw_data_root=$DATASRC/quickdraw \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [7] fungi
do_fungi(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=fungi \
  --fungi_data_root=$DATASRC/fungi \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [8] vgg_flower
do_vgg_flower(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=vgg_flower \
  --vgg_flower_data_root=$DATASRC/vgg_flower \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [9] traffic_sign
do_traffic_sign(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=traffic_sign \
  --traffic_sign_data_root=$DATASRC/GTSRB \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# [10] mscoco
do_mscoco(){
python -m meta_dataset.dataset_conversion.convert_datasets_to_records \
  --dataset=mscoco \
  --mscoco_data_root=$DATASRC/mscoco \
  --splits_root=${tf_root_dir}/splits \
  --records_root=${tf_root_dir}
}

# Convert the dataset into records
# do_omniglot
# do_aircraft
# do_cu_birds
# do_dtd
# do_quickdraw
# do_fungi
# do_vgg_flower
do_traffic_sign
# do_mscoco
