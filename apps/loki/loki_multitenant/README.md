## Test

### Send logs to Loki (with tenant ID)

Tenant `foo`

```bash
slu loggen --log-prefix foo --loki-url https://loki-multitenant.loki.sikademo.com/loki/api/v1/push --loki-tenant-id foo
```

Tenant `bar`

```bash
slu loggen --log-prefix bar --loki-url https://loki-multitenant.loki.sikademo.com/loki/api/v1/push --loki-tenant-id bar
```

### Read logs from Loki using LogCLI (with tenant ID)

Tenant `foo`

```bash
logcli --addr https://loki-multitenant.loki.sikademo.com --org-id foo query '{prefix="foo"}' --follow
```

tenant `bar`

```bash
logcli --addr https://loki-multitenant.loki.sikademo.com --org-id bar query '{prefix="bar"}' --follow
```
