# The Dockerfile tells Docker how to construct the image.
FROM thomas-core:latest

LABEL maintainer="Melle Sieswerda <m.sieswerda@iknl.nl>"

# thomas-server runs on port 5000
EXPOSE 5000

# Server package is separate
COPY thomas-server /usr/local/python/thomas-server/
COPY thomas-server/config.yaml /config.yaml

WORKDIR /usr/local/python

RUN pip install ./thomas-server

# Load fixtures here (users & networks) & run thomas!
# WORKDIR /usr/local/python/thomas-server/
WORKDIR /

RUN ln -s /usr/local/lib/python3.8/site-packages ./
RUN ln -s /root/.local/share/thomas ./

RUN thomas load-fixtures --environment=prod
CMD thomas start --environment=prod
