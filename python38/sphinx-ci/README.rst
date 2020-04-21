###########################################
Docker image for building Sphinx based docs
###########################################


Initialize new docs using this image:
=====================================

.. code-block:: bash

    $ docker run \
        -it --rm \
        -v $(pwd):/work \
        novopl/python38:sphinx-ci \
        sphinx-quickstart .


Build documentation
===================

.. code-block:: bash


    $ docker run \
        -it --rm \
        -v $(pwd):/work \
        novopl/python38:sphinx-ci \
        sphinx-build \
            -b html \
            -d out/.build/docs \
            . \
            out/html


