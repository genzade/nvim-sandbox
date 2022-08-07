FROM alpine:edge

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  bash \
  curl \
  gcc \
  git \
  linux-headers \
  musl-dev\
  vim \
  neovim \
  neovim-doc \
  fzf \
  make \
  ripgrep \
  py-pip \
  python3-dev \
  py3-pip && \
  rm -rf /var/cache/apk/*

RUN pip3 install --upgrade pip neovim pynvim && \
  rm -rf /root/.cache

RUN mkdir -p /root/.config/nvim

COPY code_samples /root/code_samples
COPY nvim /root/.config/nvim

WORKDIR /root

ENTRYPOINT ["sh"]
