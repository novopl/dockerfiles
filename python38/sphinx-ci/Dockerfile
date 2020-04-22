FROM circleci/python:3.8

USER root

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        graphviz \
        default-jre; \
    apt-get clean; \
    pip install --no-cache-dir \
        Sphinx==2.4.1 \
        sphinxcontrib-plantuml==0.18 \
        sphinx-rtd-theme==0.4.3 \
        m2r==0.2.1; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir -p /plantuml; \
    wget 'http://sourceforge.net/projects/plantuml/files/plantuml-jar-mit-1.2020.2.zip/download' \
        -O /plantuml/plantuml-mit.zip; \
    cd /plantuml && unzip -o plantuml-mit.zip; \
    rm /plantuml/plantuml-mit.zip;

WORKDIR /work
