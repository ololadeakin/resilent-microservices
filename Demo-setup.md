![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.25+-blue)
![Istio](https://img.shields.io/badge/Istio-v1.20+-purple)
![AKS](https://img.shields.io/badge/AKS-Azure%20Kubernetes%20Service-brightgreen)

# Demo Setup Guide for Resilient Microservices with Istio

This guide provides step-by-step instructions for setting up the demo environment for the "Resilient Microservices with Istio Service Mesh" project using Azure Kubernetes Service (AKS) and Istio.

## 🔧 Prerequisites

- Azure CLI (`az`)
- `kubectl` (v1.25+)
- `istioctl` (v1.20+)
- Docker (optional for image builds)
- Azure Subscription with credits

---

## 🚀 AKS Cluster Setup (Azure CLI)

### Step 1: Create a Resource Group
```bash
az group create --name istio-rg --location canadacentral
```

### Step 2: Create AKS Cluster
```bash
az aks create --resource-group istio-rg --name istio-cluster \
  --node-count 3 --enable-addons monitoring --generate-ssh-keys
```

### Step 3: Get AKS Credentials
```bash
az aks get-credentials --resource-group istio-rg --name istio-cluster
```

---

## 🧪 Istio Installation

### Step 4: Download and Install Istio
```bash
curl -L https://istio.io/downloadIstio | sh -
cd istio-*/bin
export PATH=$PWD:$PATH
```

### Step 5: Install Istio and Enable Injection
```bash
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
```

---

## 📦 Deploy Bookinfo Application

### Step 6: Deploy App and Gateway
```bash
kubectl apply -f manifests/bookinfo.yaml
kubectl apply -f manifests/gateway.yaml
```

### Step 7: Retrieve External IP
```bash
kubectl get svc istio-ingressgateway -n istio-system
```
Test the app:
```
http://<EXTERNAL-IP>/productpage
```

---

## 🛠️ Apply Istio Resiliency Features

### Step 8: Apply Configurations
```bash
kubectl apply -f manifests/retry.yaml
kubectl apply -f manifests/circuit-breaker.yaml
kubectl apply -f manifests/traffic-split.yaml
```

---

## 📈 Enable Observability

### Step 9: Deploy Add-ons
```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons
```

### Step 10: Open Dashboards
```bash
istioctl dashboard kiali
istioctl dashboard jaeger
istioctl dashboard grafana
```

---

## 💥 Simulate Failures

### Step 11: Run Simulation Script
```bash
bash scripts/failure-sim.sh
```

---

## 🧼 Optional Cleanup

### Step 12: Delete All Resources
```bash
kubectl delete -f manifests/
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons
istioctl uninstall --purge -y
az group delete --name istio-rg --yes --no-wait
```

---

## 👥 Authors

Team Awesome: Abou-Assaly Daniel, Akinrinsola Ololade Modinat, Alkhlaf Rahaf, Chhabra Jaspreet Singh