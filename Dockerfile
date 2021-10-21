# Copyright (c) 2016 Kaito Udagawa
# Copyright (c) 2016-2020 3846masa
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM debian:bullseye-slim

ARG TARGETARCH
ENV PATH /usr/local/texlive/bin:$PATH

RUN apt-get update && apt-get install -y \
  perl \
  wget \
  xz-utils

WORKDIR /install-tl-unx
COPY texlive.profile ./
ADD https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz ./
RUN tar -xzf install-tl-unx.tar.gz --strip-components=1
RUN ./install-tl --profile=texlive.profile
RUN case $TARGETARCH in \
      amd64 ) ln -sf /usr/local/texlive/2021/bin/x86_64-linux /usr/local/texlive/bin ;; \
      arm64 ) ln -sf /usr/local/texlive/2021/bin/aarch64-linux /usr/local/texlive/bin ;; \
      arm ) ln -sf /usr/local/texlive/2021/bin/armhf-linux /usr/local/texlive/bin ;; \
    esac
RUN tlmgr update --self --all
RUN tlmgr install \
  collection-latexextra \
  collection-fontsrecommended \
  collection-langjapanese
RUN tlmgr install \
  latexmk \
  light-latex-make \
  newtx \
  physics \
  siunitx

FROM debian:bullseye-slim

ENV PATH /usr/local/texlive/bin:$PATH
COPY --from=0 /usr/local/texlive /usr/local/texlive
WORKDIR /workdir

RUN apt-get update && apt-get install -y \
  gnuplot \
  perl \
  wget \
  && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
