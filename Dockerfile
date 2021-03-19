FROM debian:stable-slim

ENV DUMB_INIT_VER 1.2.5
ENV S3_BUCKET ''
ENV S3_ENDPOINT ''
ENV S3_ACCESS_KEY_ID ''
ENV S3_SECRET_ACCESS_KEY ''
ENV MNT_POINT /data

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update --fix-missing && \
    apt-get install -y s3fs wget && s3fs --version && \
    wget -O /tmp/dumb-init_${DUMB_INIT_VER}_amd64.deb https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VER}/dumb-init_${DUMB_INIT_VER}_amd64.deb && \
    dpkg -i /tmp/dumb-init_*.deb

RUN mkdir -p "$MNT_POINT"

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -y wget && \
    apt-get -y autoremove --purge && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD docker-entrypoint.sh .
ENTRYPOINT ["/usr/bin/dumb-init", "--", "bash", "-c", "/docker-entrypoint.sh"]
