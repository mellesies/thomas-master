# The Dockerfile tells Docker how to construct the image.
FROM python:3

LABEL maintainer="Melle Sieswerda <m.sieswerda@iknl.nl>"

# Install packages
COPY docker/requirements.txt /requirements.txt
RUN pip install -r requirements.txt

RUN apt-get update
RUN apt-get install -y nodejs npm

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@1

# Note:
#   The above command may fail if there is insufficient memory. Either increase
#   memory available to docker, or prevent jupyter from minimizing the build as
#   follows:
# RUN jupyter labextension install --minimize=False @jupyter-widgets/jupyterlab-manager@1

CMD /bin/bash
