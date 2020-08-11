FROM node:12

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
   && apt-get upgrade -y \
   && apt-get install -y --no-install-recommends \
       build-essential g++ unzip curl groff \
       python \
   && rm -rf /var/lib/apt/lists/* \
   && mkdir -p /tmp \
   && cd /tmp \
   && curl -O https://bootstrap.pypa.io/get-pip.py \
   && python get-pip.py \
   && pip install awscli \
   && npm i -g @architect/architect
