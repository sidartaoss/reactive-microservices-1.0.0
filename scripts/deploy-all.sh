#!/usr/bin/env bash
echo "Building microservice JARs through the modules"
echo ""
cd ../
mvn clean install

echo ""

echo "Copying fat JARs to be Dockerized"

echo ""

echo "Copying project-004 fat JAR to project folder"
cd project-004
cp target/project-004-1.0-SNAPSHOT.jar .
echo "Ok"

echo ""

echo "Copying project-005 fat JAR to project folder"
cd ../project-005
cp target/project-005-1.0-SNAPSHOT.jar .
echo "Ok"

echo ""

echo "Deploying microservices to Kubernetes through the YAMLs"

echo ""

echo "Deploying the hello microservice application"
cd ../project-004/yaml
kubectl apply -f rbac.yaml

kubectl apply -f deployment.yaml

echo ""

echo "Deploying the hello-consumer microservice application"
cd ../../project-005/yaml
kubectl apply -f .

echo ""

echo "Well done!"