#############  the first conda package  ############
REF:
    https://www.bookstack.cn/read/CMake-Cookbook/content-chapter11-11.4-chinese.md

requires:
conda install conda-build
conda install cmake
conda install make
conda install --use-local conda-example-lzy

scripts:
conda build conda-recipe


