#!/bin/bash
echo "Opening multiple pages to generate telemetry..."
for i in {1..10}; do
  curl -s http://$(minikube ip)/productpage > /dev/null
done

echo "Launching Kiali dashboard..."
istioctl dashboard kiali
