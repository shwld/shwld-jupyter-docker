FROM jupyter/datascience-notebook
MAINTAINER shwld <shwld@outlook.com>

USER root

RUN apt-get update
RUN apt-get install -y ttf-kochi-gothic xfonts-intl-japanese xfonts-intl-japanese-big xfonts-kaname

RUN git clone https://github.com/taku910/mecab.git \
    && cd mecab/mecab \
    && ./configure  --enable-utf8-only \
    && make \
    && make check \
    && make install \
    && ldconfig \
    && cd ../mecab-ipadic \
    && ./configure --with-charset=utf8 \
    && make \
    && make install


# RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
#     && cd mecab-ipadic-neologd \
#     && mkdir -p `mecab-config --dicdir`"/mecab-ipadic-neologd" \
#     && ./bin/install-mecab-ipadic-neologd -n -y -a

USER $NB_USER

# RUN conda install -y numpy scipy \
#    && conda install -y gensim
# HACK: Intel MKL FATAL ERROR: Cannot load libmkl_avx2.so or libmkl_def.so.
RUN pip install -U numpy scipy \
    && pip install mecab-python3 \
    && pip install -U gensim
