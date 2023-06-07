# WSGI service environment

FROM ubuntu:22.04

# Set locale (i.e. for psql client_encoding)
RUN apt-get update && apt-get install -y locales \
    && locale-gen en_US.UTF-8
ENV LANG en_US.utf8

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -qy uwsgi uwsgi-plugin-python3 python3-pip ca-certificates && \
    pip3 install --no-cache --upgrade pip

ENV SERVICE_UID=33
ENV SERVICE_GID=33
ENV SERVICE_MOUNTPOINT='/'
# http://uwsgi-docs.readthedocs.io/en/latest/Options.html#buffer-size
ENV REQ_HEADER_BUFFER_SIZE=12288
ENV UWSGI_PROCESSES=1
ENV UWSGI_THREADS=4
ENV UWSGI_EXTRA=""
ENV PGSERVICEFILE="/srv/pg_service.conf"

STOPSIGNAL SIGINT

ENTRYPOINT ["/bin/sh", "-c", "\
    mkdir /home/qwc && \
    chown $SERVICE_UID:$SERVICE_GID /home/qwc && \
    HOME=/home/qwc uwsgi --http-socket :9090 --buffer-size $REQ_HEADER_BUFFER_SIZE --processes $UWSGI_PROCESSES \
    --threads $UWSGI_THREADS --plugins python3 $UWSGI_EXTRA --protocol uwsgi --wsgi-disable-file-wrapper \
    --uid $SERVICE_UID --gid $SERVICE_GID --master --chdir /srv/qwc_service --mount $SERVICE_MOUNTPOINT=server:app \
    --manage-script-name"]
