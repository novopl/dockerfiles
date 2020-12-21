FROM alpine:3.7

WORKDIR /app

COPY ./files/pyenv.sh /etc/profile.d/pyenv.sh
COPY ./files/devrequirements.txt /tmp/devrequirements.txt

RUN \
    # Install system build dependencies
    apk add --no-cache --virtual .build-deps \
        bash \
        build-base \
        curl \
        git \
        openssh \
        sqlite-dev \
        linux-headers \
        libffi-dev \
        docker \
        libressl-dev \
        zlib-dev \
        zip \
        ; \
    # Install pyenv
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash; \
    source /etc/profile;  \
    pyenv install 3.6.6; \
    pyenv install 3.4.8; \
    pyenv install 2.7.15; \
    pyenv global 3.6.6 3.4.8 2.7.15; \
    # Install python dev dependencies into the main interpreter
    pip install --no-cache-dir -U pip setuptools; \
    pip install --no-cache-dir wheel; \
    pip install --no-cache-dir -r/tmp/devrequirements.txt; \
    # Cleanup after the build
    bash -c 'find / \( -name "__pycache__" -or -name "*.py[cod]" \) -prune -exec rm -rf {} \;' \
    bash -c 'find /root/.pyenv \( -name -name test -or -name tests \) -prune -exec rm -rf {} \;' \
    rm /tmp/devrequirements.txt;

ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:/root/.pyenv/versions/3.6.6/bin:$PATH"
