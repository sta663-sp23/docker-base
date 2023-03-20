FROM rocker/r-ubuntu:22.04

ADD Rprofile.site /usr/lib/R/etc/Rprofile.site

RUN apt-get update \
 && apt-get upgrade -y

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
    gdebi \
    libopenblas-dev \
    libarmadillo-dev \
    libeigen3-dev

RUN install.r remotes \
 && installGithub.r rundel/checklist

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.2.335/quarto-1.2.313-linux-amd64.deb \
    && DEBIAN_FRONTEND=noninteractive gdebi --n quarto-*-linux-amd64.deb \
    && rm quarto-*-linux-amd64.deb

# python and related stuff
RUN apt-get install -y --no-install-recommends \
    python3-dev \
    python3-distutils && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    wget --quiet https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
    python3 /tmp/get-pip.py && \
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
    jax \
    shiny \
    shapely

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
