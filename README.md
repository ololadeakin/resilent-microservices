# Resilient Microservices with Istio Service Mesh

This project demonstrates how to build resilient microservices using Istio on Kubernetes. It covers core concepts such as retries, circuit breaking, traffic shaping, and observability using Istio's Bookinfo sample application.

## 🔧 Tools Used

- Kubernetes (via Minikube)
- Istio
- Istio Add-ons: Kiali, Grafana, Prometheus, Jaeger
- Istio Bookinfo Sample App

## 📦 Setup Instructions

### 1. Prerequisites

- `kubectl` (v1.25+)
- `minikube` (8 GB RAM recommended)
- `istioctl` (v1.20+)
- `docker`

### 2. Start Minikube

```bash
minikube start --memory=8192 --cpus=4
minikube tunnel
```

### 3. Install Istio

```bash
curl -L https://istio.io/downloadIstio | sh -
cd istio-*/bin
export PATH=$PWD:$PATH

istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
```

### 4. Deploy Bookinfo App

```bash
kubectl apply -f manifests/bookinfo.yaml
kubectl apply -f manifests/gateway.yaml
```

Access via:
```bash
kubectl get svc istio-ingressgateway -n istio-system
```

Or if using Minikube:
```bash
minikube service istio-ingressgateway -n istio-system
```

### 5. Apply Istio Features

```bash
kubectl apply -f manifests/retry.yaml
kubectl apply -f manifests/circuit-breaker.yaml
kubectl apply -f manifests/traffic-split.yaml
```

### 6. Enable Observability Tools

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons
```

Then open dashboards:

```bash
istioctl dashboard kiali
istioctl dashboard jaeger
istioctl dashboard grafana
```

### 7. Simulate Failures

```bash
bash scripts/failure-sim.sh
```

## 📊 Grafana Dashboard

Import from Istio's GitHub dashboards:
https://github.com/istio/istio/tree/release-1.20/samples/addons/dashboards

Use: `istio-service-dashboard.json`, `istio-workload-dashboard.json`

## 👥 Authors

Team Awesome: Member A, Member B, Member C, Member D
