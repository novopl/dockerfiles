FROM circleci/node:12

WORKDIR /app

COPY files/pyenv.sh /etc/profile.d/pyenv.sh

RUN \
    # Install system build dependencies
    sudo apt-get install python3-pip; \
    pip3 install --no-cache-dir peltak; \
    sudo npm i -g yarn;

