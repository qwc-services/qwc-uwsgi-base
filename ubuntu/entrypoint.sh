#!/bin/sh

# Generate any requested non-en_US locale
if [ $LOCALE != 'en_US' ]; then
  echo "Compiling locale definition for $LOCALE"
  # NOTE: Write to /tmp/locale-archive to allow unprivileged users to create locales
  mkdir -p /tmp/locale-archive
  localedef -i $LOCALE -c -f UTF-8 -A /usr/share/locale/locale.alias /tmp/locale-archive/$LOCALE.UTF-8
  export LOCPATH=/tmp/locale-archive
  export LANG=${LOCALE}.UTF-8
else
  export LANG=en_US.UTF-8
fi

# NOTE: Set home to /tmp to ensure a writeable home directory exists
HOME=/tmp uwsgi --http-socket :9090 --buffer-size $REQ_HEADER_BUFFER_SIZE --processes $UWSGI_PROCESSES \
    --threads $UWSGI_THREADS --plugins python3 $UWSGI_EXTRA --protocol uwsgi --wsgi-disable-file-wrapper \
    --uid $SERVICE_UID --gid $SERVICE_GID --master --chdir /srv/qwc_service --mount $SERVICE_MOUNTPOINT=server:app \
    --manage-script-name
