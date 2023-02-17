# Установка Zabbix

## Установка Zabbix Server

```bash
helm repo add cetic https://cetic.github.io/helm-charts
helm show values cetic/zabbix > zabbix-server-values.yaml
```

Добавить переменные в zabbix-server.yaml:
```bash
helm install -f zabbix-server.yaml -n zabbix zabbix cetic/zabbix
```

## Установка Zabbix Proxy в Kubernetes

### Установка Helm Chart

```bash
helm repo add zabbix-chart-6.0 https://cdn.zabbix.com/zabbix/integrations/kubernetes-helm/6.0/
helm show values zabbix-chart-6.0/zabbix-helm-chrt > zabbix-proxy-values-src.yaml
```

Добавить переменные в zabbix-proxy.yaml:
```bash
helm install -f zabbix-proxy.yaml -n zabbix zabbix-proxy zabbix-chart-6.0/zabbix-helm-chrt
```

Получить token zabbix-service-account для долступа в API Kubernetes:
```bash
kubectl get secret -n zabbix -o jsonpath={.data.token} zabbix-service-account | base64 -d
```

### Настройка Zabbix

1. Administration -> Proxies -> Create Proxy -> name **zabbix-proxy** (default)
2. Configuration -> Host Groups -> Create a Host Group -> name **Kubernetes**
3. Configuration -> Hosts -> Create Host -> name **Kubernetes nodes**, templates **Kubernetes nodes by HTTP**, groups **Kubernetes**, monitored by proxy **zabbix-proxy**
4. In **Macros** tab select **Inherited and host macros**:
    - {KUBE.API.ENDPOINT.URL} = https://kubernetes.default.svc.cluster.local:443/api
    - {KUBE.API.TOKEN} = token zabbix-service-account
5. Configuration -> Hosts -> Create Host -> name **Kubernetes Cluster State**, templates **Kubernetes Cluster State template by HTTP**, groups **Kubernetes**, monitored by proxy **zabbix-proxy**
6. In **Macros** tab select **Inherited and host macros**:
    - {KUBE.API.ENDPOINT.URL} = https://kubernetes.default.svc.cluster.local:443
    - {KUBE.API.TOKEN} = token zabbix-service-account

## Настройка HTTP agent
1. Configuration → Hosts → find your host
2. Items → Create item
    - Type → HTTP agent
    - key, name and URL
    - Type of information → Text
    - Request body, Required status codes (Optionally)
3. Test button → Get value and test