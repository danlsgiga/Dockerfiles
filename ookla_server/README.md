## Build the docker image:

```bash
$ docker build --build-arg OOKLA_INSTALL_SCRIPT_URL="http://install.speedtest.net/ooklaserver/ooklaserver.sh" --build-arg OOKLA_LEGACY_FALLBACK_FILES_URL="http://install.speedtest.net/httplegacy/http_legacy_fallback.zip" -t danlsgiga/ooklaserver:latest .
```
