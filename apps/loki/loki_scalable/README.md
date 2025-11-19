## Test

### Send logs to Loki

```bash
slu loggen --loki-url https://loki-scalable.loki.sikademo.com/loki/api/v1/push
```

### Read logs from Loki using LogCLI

```bash
logcli --addr https://loki-scalable.loki.sikademo.com query '{prefix="loggen"}' --follow
```
