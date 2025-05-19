![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.25+-blue)
![Istio](https://img.shields.io/badge/Istio-v1.20+-purple)
![AKS](https://img.shields.io/badge/AKS-Azure%20Kubernetes%20Service-brightgreen)

# Resilient Microservices with Istio Service Mesh

This project demonstrates how to build resilient microservices using Istio on Kubernetes. It covers core concepts such as retries, circuit breaking, traffic shaping, and observability using Istio's Bookinfo sample application.

## 📘 Project Overview

This project explores how service meshes like Istio enhance microservice resiliency. Using Istio's Bookinfo sample app, we demonstrate features such as retry logic, circuit breaking, fault injection, and real-time telemetry using observability dashboards. The goal is to show how modern service mesh capabilities reduce downtime and increase reliability in distributed systems.

## 🔧 Tools Used

- Azure Kubernetes Service (AKS)
- Istio
- Istio Add-ons: Kiali, Grafana, Prometheus, Jaeger
- Istio Bookinfo Sample App

Bookinfo manifest adapted from:
https://github.com/istio/istio/tree/release-1.20/samples/bookinfo/platform/kube

## 📦 Setup Instructions

### 1. Prerequisites

- Azure CLI (`az`)
- `kubectl` (v1.25+)
- `istioctl` (v1.20+)
- Docker (for image builds if needed)
- Azure Subscription with available credits

### 2. Create an AKS Cluster

---

### Option A: Using Azure CLI (Recommended for Automation)

#### Create an AKS Cluster

```bash
# Create resource group
az group create --name istio-rg --location canadacentral

# Create AKS cluster
az aks create --resource-group istio-rg --name istio-cluster \
  --node-count 3 --enable-addons monitoring --generate-ssh-keys

# Get AKS credentials
az aks get-credentials --resource-group istio-rg --name istio-cluster
```

#### Install Istio

```bash
curl -L https://istio.io/downloadIstio | sh -
cd istio-*/bin
export PATH=$PWD:$PATH

istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
```

---

### Option B: Using Azure Portal (Dashboard UI)

1. Go to [Azure Portal](https://portal.azure.com)
2. Navigate to **Kubernetes Services > + Create**
3. Set the following:
   - **Resource Group**: `istio-rg`
   - **Cluster Name**: `istio-cluster`
   - **Region**: `Canada central`
   - **Node Count**: 3
   - **Enable Monitoring**: Yes (Azure Monitor for containers)
4. Click **Review + Create** → **Create**
5. After deployment, go to the cluster → Click **"Connect"** to get connection instructions
6. Use **Cloud Shell** or local terminal for the Istio install:


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

Get external IP:
```bash
kubectl get svc istio-ingressgateway -n istio-system
```

Copy the `EXTERNAL-IP` and test the app:
```bash
http://<EXTERNAL-IP>/productpage
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

Open dashboards:
```bash
istioctl dashboard kiali
istioctl dashboard jaeger
istioctl dashboard grafana
```

### 7. Simulate Failures

The `failure-sim.sh` script simulates service-level failures by killing pods, blocking service responses, or injecting delays to test Istio's resiliency features.

```bash
bash scripts/failure-sim.sh
```

## 📊 Grafana Dashboard

Import from Istio's GitHub dashboards:
https://github.com/istio/istio/tree/release-1.20/samples/addons/dashboards

Use: `istio-service-dashboard.json`, `istio-workload-dashboard.json`

## 🧹 Optional Cleanup

```bash
kubectl delete -f manifests/
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons
istioctl uninstall --purge -y
az group delete --name istio-rg --yes --no-wait
```

## 👥 Authors

Team Awesome: Abou-Assaly Daniel, Akinrinsola Ololade Modinat, Alkhlaf Rahaf, Chhabra Jaspreet Singh
