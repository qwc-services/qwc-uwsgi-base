[![CI](https://github.com/qwc-services/qwc-uwsgi-base/actions/workflows/uwsgi-base.yml/badge.svg)](https://github.com/qwc-services/qwc-uwsgi-base/actions)
[![docker](https://img.shields.io/docker/v/sourcepole/qwc-uwsgi-base?label=qwc-uwsgi-base%20image&sort=semver)](https://hub.docker.com/r/sourcepole/qwc-uwsgi-base)

QWC uWSGI Base
==============

QWC docker uWSGI base images for QWC services.

Locale configuration
--------------------

The ubuntu-based `qwc-uwsgi-base` supports a `LOCALE` environment variable, in the form `lang_COUNTRY` (i.e. `de_CH`) to set the runtime locale.
