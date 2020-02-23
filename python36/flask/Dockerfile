FROM alpine:3.7

WORKDIR /app

COPY ./files/pyenv.sh /etc/profile.d/pyenv.sh
COPY ./files/requirements.txt /tmp/requirements.txt

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
        postgresql-dev \
        zlib-dev \
        zip \
        ; \
    # Install pyenv
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash; \
    . /etc/profile;  \
    pyenv install 3.6.8; \
    pyenv global 3.6.8; \
    # Install python dev dependencies into the main interpreter
    pip install --no-cache-dir -r/tmp/requirements.txt; \
    # Cleanup after the build
    bash -c 'find / \( -name "__pycache__" -or -name "*.py[cod]" \) -prune -exec rm -rf {} \;' \
    bash -c 'find /root/.pyenv \( -name -name test -or -name tests \) -prune -exec rm -rf {} \;' \
    rm /tmp/requirements.txt;

ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:/root/.pyenv/versions/3.6.6/bin:$PATH"
#FROM python:3.6-alpine
#
#RUN mkdir /app
#WORKDIR /app
#
#RUN \
    # apt-get update; \
    # apt-get install -y --no-install-recommends gcc libc6-dev zsh; \
    # rm -rf /var/lib/apt/lists/*; \
#    apk add --no-cache --virtual .build-deps \
#        bash \
#        build-base \
#        curl \
#        git \
#        openssh \
#        sqlite-dev \
#        linux-headers \
#        libffi-dev \
#        docker \
#        libressl-dev \
#        zlib-dev \
#        zip \
#        ; \
#    apk add --no-cache postgresql-dev; \
#    pip install -U pip \
#    pip install --no-cache-dir \
#        attrs~=16.3.0 \
#        click~=7.0 \
#        Flask~=1.0.2 \
#        Flask-JWT~=0.3.2 \
#        Flask-SQLAlchemy~=2.3.2 \
#        gunicorn~=19.8.1 \
#        jsonschema==2.6.0 \
#        passlib==1.7.1 \
#        psutil==5.4.6 \
#        pyOpenSSL==18.0.0 \
#        psycopg2~=2.8.3 \
#        PyYAML==3.12 \
#        SQLAlchemy==1.2.7 \
#        sqlalchemy_utils==0.33.3 \
#        tabulate==0.8.2; \
#    bash -c 'find / \
#            \( -name __pycache__ -or -name "*.py[cod]" \) \
#            -prune -exec rm -rf {} \;'; \
#    bash -c 'find /usr/local/lib/python3.6 \
#            -type d \
#            \( -name test -or -name tests \) \
#            -prune -exec rm -rf {} \;'; \
#    apk del .build-deps;
#
#CMD /bin/bash
#
