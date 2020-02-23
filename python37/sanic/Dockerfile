FROM python:3.6-alpine

RUN mkdir /app
WORKDIR /app

RUN \
    # apt-get update; \
    # apt-get install -y --no-install-recommends gcc libc6-dev zsh; \
    # rm -rf /var/lib/apt/lists/*; \
    apk add --no-cache --virtual .build-deps \
        bash \
        build-base \
        libffi-dev \
        libressl-dev \
        linux-headers; \
    pip install --no-cache-dir \
        asyncpg==0.17.0 \
        attrs==16.3.0 \
        click==6.7 \
        click-completion==0.4.1 \
        gino==0.7.5 \
        jsonschema==2.6.0 \
        passlib==1.7.1 \
        psutil==5.4.6 \
        pyOpenSSL==18.0.0 \
        PyYAML==3.12 \
#        restible==0.2.23 \
        sanic==0.8.3 \
#        serafin==0.10.2 \
        tabulate==0.8.2; \
    bash -c 'find / \
            \( -name __pycache__ -or -name "*.py[cod]" \) \
            -prune -exec rm -rf {} \;'; \
    bash -c 'find /usr/local/lib/python3.6 \
            -type d \
            \( -name test -or -name tests \) \
            -prune -exec rm -rf {} \;'; \
    apk del .build-deps;

CMD /bin/bash

