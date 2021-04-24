# Setup Kind

```
kind create cluster --name k8s-operator  --config=kind/config.yaml
```


```
docker network connect "kind" 6a2d907ba5d6
```

# Setup Operator-Sdk

```
operator-sdk init --domain frestyle --repo github.com/frestyle/k8s-operator
```

```
operator-sdk create api --group queue --version v1alpha1 --kind RabbitQueue --resource --controller
```

```
make bundle IMG="frestyle/k8s-operator:v0.0.1"
```

## olm Deploy

```
operator-sdk run bundle frestyle/k8s-operator:v0.0.1

```
## Direct deploy 

```
make docker-build docker-push IMG="frestyle/k8s-operator:v0.0.1"
```

```
make deploy IMG="frestyle/k8s-operator:v0.0.1"
```