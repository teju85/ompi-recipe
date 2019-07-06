ARG baseImage=nvidia/cuda:10.0-devel-ubuntu16.04
FROM $baseImage

RUN apt-get update && \
    apt-get install -y --no-install-recommends  \
        bzip2 \
        ca-certificates \
        curl \
        wget && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o /opt/miniconda.sh \
        -O "https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" && \
    chmod +x /opt/miniconda.sh && \
    /opt/miniconda.sh -b -p /opt/conda && \
    /opt/conda/bin/conda update -n base conda && \
    rm /opt/miniconda.sh

ENV PATH /opt/conda/bin:${PATH}

RUN conda install -c anaconda \
        anaconda-client \
        conda-build \
        conda-verify && \
    conda clean -ya

COPY . /opt/ompi-recipe

WORKDIR /opt/ompi-recipe
