## Test

### Send logs to Loki

```bash
slu loggen --loki-url https://loki-k8s.loki.sikademo.com/loki/api/v1/push
```

### Read logs from Loki using LogCLI

```bash
logcli --addr https://loki-k8s.loki.sikademo.com query '{prefix="loggen"}' --follow
```
