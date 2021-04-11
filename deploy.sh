docker build -t sivametdockid/multi-client:latest -t sivametdockid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sivametdockid/multi-server:latest -t sivametdockid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sivametdockid/multi-worker:latest -t sivametdockid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sivametdockid/multi-client:latest
docker push sivametdockid/multi-server:latest
docker push sivametdockid/multi-worker:latest

docker push sivametdockid/multi-client:$SHA
docker push sivametdockid/multi-server:$SHA
docker push sivametdockid/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sivametdockid/multi-server:$SHA
kubectl set image deployments/client-deployment client=sivametdockid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sivametdockid/multi-worker:$SHA
