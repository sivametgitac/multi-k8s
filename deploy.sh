docker build -t sivametdockerid/multi-client:latest -t sivametdockerid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sivametdockerid/multi-server:latest -t sivametdockerid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sivametdockerid/multi-worker:latest -t sivametdockerid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sivametdockerid/multi-client:latest
docker push sivametdockerid/multi-server:latest
docker push sivametdockerid/multi-worker:latest

docker push sivametdockerid/multi-client:$SHA
docker push sivametdockerid/multi-server:$SHA
docker push sivametdockerid/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sivametdockerid/multi-server:$SHA
kubectl set image deployments/client-deployment client=sivametdockerid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sivametdockerid/multi-worker:$SHA
