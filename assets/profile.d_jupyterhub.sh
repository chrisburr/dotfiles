#!/bin/sh

if [ "$USER" != "jupyterhub" ]; then
   export PATH=/home/cburr/miniconda/envs/jupyter/bin:$PATH
fi
source activate jupyter
