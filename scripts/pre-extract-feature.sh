#!/bin/bash
#
# bash ./scripts/pre-extract-feature.sh resnet18 ./outputs/extract-feature /projects/NeuralArch/meta-dataset-tf
#
echo script name: $0
echo $# arguments
if [ "$#" -ne 3 ] ;then
  echo "Input illegal number of parameters " $#
  echo "Need 3 args: "
  exit 1
fi
if [ "$TORCH_HOME" = "" ]; then
  export TORCH_HOME="${HOME}/.torch"
else
  echo "TORCH_HOME : $TORCH_HOME"
fi

# get the meta-dataset-dir
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
echo $scriptpath
meta_dataset_dir="${scriptpath}/../meta-dataset"
echo "meta dataset: ${meta_dataset_dir}"

backbone=$1
save_dir=$2
tf_root_dir=$3

echo "ROOT: $(pwd)"

ulimit -n 100000

python exps/pre-extract-feature.py --save_dir ${save_dir} \
	--meta_records_root ${tf_root_dir} \
	--model.backbone=${backbone}
