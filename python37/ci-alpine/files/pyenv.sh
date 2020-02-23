#!/bin/sh

export PATH="/root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv global 3.6.6 3.4.8 2.7.15
