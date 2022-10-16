# FROM alpine:edge

# RUN apk update && \
#   apk upgrade && \
#   apk add --no-cache \
#   alpine-sdk \
#   bash \
#   curl \
#   fzf \
#   gcc \
#   git \
#   libluv \
#   linux-headers \
#   lua5.3 \
#   make \
#   musl-dev\
#   neovim-doc \
#   neovim=0.8.0-r0 \
#   nodejs \
#   py-pip \
#   py3-pip \
#   python3-dev \
#   ripgrep \
#   ruby \
#   vim && \
#   rm -rf /var/cache/apk/*

# RUN pip3 install --upgrade pip neovim pynvim && \
#   rm -rf /root/.cache

# RUN mkdir -p /root/.config/nvim

# COPY code_samples /root/code_samples
# COPY nvim /root/.config/nvim

# WORKDIR /root

# ENV SHELL='bash'

# ENTRYPOINT ["sh"]

# FROM sickcodes/docker-osx:latest

# # RUN pip3 install --upgrade pip neovim pynvim && \
# #   rm -rf /root/.cache

# ENV HOME=


# RUN mkdir -p HOME/.config/nvim

# COPY code_samples /root/code_samples
# COPY nvim /root/.config/nvim

# WORKDIR /root

# ENV SHELL='bash'

# ENTRYPOINT ["sh"]

ARG ARCHLINUX_VERSION=latest

FROM archlinux:${ARCHLINUX_VERSION} as base
# ARCHLINUX_VERSION is specified again because the FROM directive resets ARGs
# (but their default value is retained if set previously)

ARG ARCHLINUX_VERSION
ARG USER=genzade

ENV SHELL='bash'

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

# Add [multilib] to mirrolist since some deps come from that mirror
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" > /tmp/multilib \
  && cat /etc/pacman.conf /tmp/multilib > /tmp/pacman.conf \
  && mv /tmp/pacman.conf /etc/pacman.conf

# Install base deps for development
RUN pacman -Syyu --noconfirm \
  && pacman -S --noconfirm \
  base-devel \
  git \
  neovim \
  sudo \
  unzip \
  && rm -rf /tmp/* /var/tmp/*

ENV EDITOR nvim

RUN useradd -m ${USER} \
  && passwd -d ${USER} \
  && sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers \
  && echo "${USER} ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
  && usermod -a -G wheel ${USER} \
  && rm -rf /home/${USER}/.bashrc

# Install yay - https://github.com/Jguer/yay
ARG YAY_VERSION=11.3.0
ENV YAY_FOLDER=yay_${YAY_VERSION}_x86_64
RUN cd /tmp \
  && curl -L https://github.com/Jguer/yay/releases/download/v${YAY_VERSION}/${YAY_FOLDER}.tar.gz | tar zx \
  && install -Dm755 ${YAY_FOLDER}/yay /usr/bin/yay \
  && install -Dm644 ${YAY_FOLDER}/yay.8 /usr/share/man/man8/yay.8

COPY ./scripts/asdf_setup .
RUN ./asdf_setup

RUN mkdir -p $HOME/.config/nvim/

COPY nvim /root/.config/nvim
COPY code_samples /home/${USER}/code_samples

COPY .bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

WORKDIR /home/${USER}
