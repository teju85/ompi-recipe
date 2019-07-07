# Introduction
Contains recipe for building cuda-aware OpenMPI with and without ucx support.

# Downloading built recipes
```bash
# w/o UCX
conda install -c teju85 ompi-cuda
# w/ UCX
conda install -c teju85 ompi-cuda-ucx
```

# Building my own recipe?
If you want to build your package and upload it to anaconda cloud, continue
reading...

## Pre-reqs
* docker
* git

## Usage
```bash
git clone https://github.com/teju85/ompi-recipe
cd ompi-recipe
docker build -t conda:dev . && docker run --rm -it conda:dev /bin/bash
inside-container# anaconda login
inside-container# conda build ompi-cuda
inside-container# anaconda upload /path/to/ompi-cuda/package.tar.gz
inside-container# conda build -c anaconda ompi-cuda-ucx
inside-container# anaconda upload /path/to/ompi-cuda-ucx/package.tar.gz
```

# License
[WTFPL](http://www.wtfpl.net/txt/copying/)
