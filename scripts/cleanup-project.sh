#!/usr/bin/env bash
echo "Cleaning up fat JARs"

echo ""

echo "Cleaning up fat JAR from project-004"
cd ../project-004
rm -rf project-004-1.0-SNAPSHOT.jar
echo "Ok"

echo ""

echo "Cleaning up fat JAR from project-005"
cd ../project-005
rm -rf project-005-1.0-SNAPSHOT.jar
echo "Ok"

echo ""

echo "Cleaning up current Kubernetes resources"

echo ""

echo "Cleaning up current Pods and Deployments"
kubectl delete deployment --all

echo ""

echo "Cleaning up current Services"
kubectl delete svc project004 project005

echo ""

echo "Well done!"