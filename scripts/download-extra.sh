#!/bin/bash
# bash scripts/download-extra.sh
# Follow the instructions from https://github.com/cambridge-mlg/cnaps

root_dir="/projects/NeuralArch/meta-dataset"

cd ${root_dir}

# MNIST
wget http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

# CIFAR-10
wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
tar -zxvf cifar-10-python.tar.gz

# CIFAR-100
wget https://www.cs.toronto.edu/~kriz/cifar-100-python.tar.gz
tar -zxvf cifar-100-python.tar.gz
