#!/bin/bash
echo "Deleting all reviews pods to simulate failure..."
kubectl delete pods -l app=reviews
