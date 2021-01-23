FROM python:3.8

RUN \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
    && apt update \
    && apt install -y --no-install-recommends \
        software-properties-common \
    && apt-add-repository https://cli.github.com/packages \
    && apt update \
    && apt install -y --no-install-recommends \
        gh \
        time \
        zip \
    && pip install --no-cache poetry \
    && poetry config virtualenvs.create false \
    && rm -rf /var/lib/apt/lists/*
