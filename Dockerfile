FROM wenbinf/base

MAINTAINER Stephen Tudor <smt@smt.io>

# Install some development tools
RUN apt-get -qq update && apt-get -qq install \
    emacs \
    vim-nox \
    tmux \
    git \
    wget \
    curl \
    unzip \
    build-essential

# Install dotfiles
ADD conf/.tmux.conf /root/.tmux.conf
RUN rm -rf /root/.emacs.d && \
    git clone --recursive https://github.com/syl20bnr/spacemacs.git /root/.emacs.d && \
    git clone https://github.com/smt/spacemacs-config.git /root/src/github.com/smt/spacemacs-config && \
    ln -s /root/src/github.com/smt/spacemacs-config/.spacemacs /root/.spacemacs && \
    ln -s /root/src/github.com/smt/spacemacs-config/smt /root/.emacs.d/private/smt

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
