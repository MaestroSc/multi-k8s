docker build -t maestrosc/multi-client:latest -t maestrosc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maestrosc/multi-server:latest -t maestrosc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maestrosc/multi-worker:latest -t maestrosc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push maestrosc/multi-client:latest
docker push maestrosc/multi-server:latest
docker push maestrosc/multi-worker:latest
docker push maestrosc/multi-client:$SHA
docker push maestrosc/multi-server:$SHA
docker push maestrosc/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maestrosc/multi-server:$SHA
kubectl set image deployments/client-deployment client=maestrosc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maestrosc/multi-worker:$SHA
