[![CI](https://github.com/qwc-services/qwc-uwsgi-base/actions/workflows/uwsgi-base.yml/badge.svg)](https://github.com/qwc-services/qwc-uwsgi-base/actions)
[![docker](https://img.shields.io/docker/v/sourcepole/qwc-uwsgi-base?label=qwc-uwsgi-base%20image&sort=semver)](https://hub.docker.com/r/sourcepole/qwc-uwsgi-base)

QWC uWSGI Base
==============

QWC docker uWSGI base images for QWC services.

Multiple environment variables are available:

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| `LOCALE` | For the ubuntu-based `qwc-uwsgi-base`, defines the runtime locale in the form `lang_COUNTRY` (i.e. `de_CH`) | `en_US` |
| `PGSERVICEFILE` | Path to pg_service.conf file | `/srv/pg_service.conf` |
| `REQ_HEADER_BUFFER_SIZE` | Internal [uWSGI buffer size](http://uwsgi-docs.readthedocs.io/en/latest/Options.html#buffer-size) | `12288` |
| `SERVICE_GID` | GID used for running the service | `33` |
| `SERVICE_MOUNTPOINT` | Route from which the service will be mounted (e.g. `/api/v1/feature-info`) | `/` |
| `SERVICE_UID` | UID used for running the service | `33` |
| `UV_COMPILE_BYTECODE` | Enable UV byte code compilation | `1` |
| `UWSGI_EXTRA` | Extra parameter to pass to uWSGI command line - see below | empty |
| `UWSGI_PROCESSES` | Number of uWSGI processes to spawn | `1` |
| `UWSGI_THREADS` | Number of uWSGI threads for each processes | `4` |

Extra uWSGI parameters
----------------------

When using `UWSGI_EXTRA`, there are some caveats:

- The variable will be expanded as a _single_ argument, thus you should use `UWSGI_EXTRA: --parameter-name=parameter-value`, not `UWSGI_EXTRA: --parameter-name parameter-value`
- As a consequence, you cannot use multiple parameters. A workaround is to use a mounted uwsgi.ini file, for instance:
  1. define `UWSGI_EXTRA: --ini=/etc/uwsgi.ini`
  2. add the parameters in a `uwsgi.ini` file:

      ```ini
      [uwsgi]
      logdate = %%Y-%%m-%%d %%H:%%M:%%S
      logformat-strftime = true
      logformat = [%(ftime).%(msecs)] "%(method) %(uri) %(proto)" %(status)
      ```

  3. mount that file in your Docker container
