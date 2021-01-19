FROM python:3.7

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends zip \
    && pip install --no-cache poetry \
    && rm -rf /var/lib/apt/lists/*
