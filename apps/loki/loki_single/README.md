## Test

### Send logs to Loki

```bash
slu loggen --loki-url https://loki-single.loki.sikademo.com/loki/api/v1/push
```

### Read logs from Loki using LogCLI

```bash
logcli --addr https://loki-single.loki.sikademo.com query '{prefix="loggen"}' --follow
```
