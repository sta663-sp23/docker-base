FROM rocker/r-ubuntu:20.04

ADD Rprofile.site /usr/lib/R/etc/Rprofile.site

RUN apt-get update \
 && apt-get upgrade -y

RUN install.r devtools rmarkdown tidyverse gifski \
 && installGithub.r rundel/checklist rundel/parsermd

RUN apt-get install -y --no-install-recommends \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    pandoc \
    libmagick++-dev \
    libglpk-dev \
    libnode-dev

RUN apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    git \
    vim \
    jed \
    build-essential \
    unzip \
    libsm6 \
    pandoc \
    manpages \
    manpages-dev \
    man \
    gdebi

RUN apt-get install -yq --no-install-recommends \
    libopenblas-dev \
    libarmadillo-dev \
    libeigen3-dev

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v0.9.24/quarto-0.9.24-linux-amd64.deb \
    && DEBIAN_FRONTEND=noninteractive gdebi --n quarto-0.9.24-linux-amd64.deb \
    && rm quarto-0.9.24-linux-amd64.deb


# python and related stuff
RUN apt-get install -y --no-install-recommends \
    python3.9-dev \
    python3.9-distutils && \
    ln -sf /usr/bin/python3.9 /usr/bin/python3 && \
    ln -sf /usr/bin/python3.9 /usr/bin/python && \
    wget --quiet https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
    python3.9 /tmp/get-pip.py && \
    rm -f /tmp/get-pip.py

RUN pip install \
    jupyter \
    notebook \
    jupyterlab \
    ipykernel \
    numpy \
    ipywidgets \
    pandas \
    matplotlib \
    scipy \
    seaborn \
    scikit-learn \
    scikit-image \
    statsmodels \
    sympy \
    cython \
    patsy \
    numba \
    bokeh \
    sqlalchemy \
    beautifulsoup4 \
    pandas-datareader \
    ipython-sql \
    pandasql \
    memory_profiler \
    ipyparallel \
    pymc3 \
    pystan \
    arrow \
    scikit-plot \
    torch

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
