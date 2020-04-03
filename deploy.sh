docker build -t rak2112/multi-client:latest -t rak2112/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rak2112/multi-server:latest -t rak2112/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rak2112/multi-worker:latest -t rak2112/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rak2112/multi-client:latest
docker push rak2112/multi-server:latest
docker push rak2112/multi-worker:latest

docker push rak2112/multi-client:$SHA
docker push rak2112/multi-server:$SHA
docker push rak2112/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rak2112/multi-server:$SHA
kubectl set image deployments/client-deployment client=rak2112/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rak2112/multi-worker:$SHA