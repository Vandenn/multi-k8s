docker build -t evanlivelo/multi-client:latest -t evanlivelo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t evanlivelo/multi-server:latest -t evanlivelo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t evanlivelo/multi-worker:latest -t evanlivelo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push evanlivelo/multi-client:latest
docker push evanlivelo/multi-server:latest
docker push evanlivelo/multi-worker:latest
docker push evanlivelo/multi-client:$SHA
docker push evanlivelo/multi-server:$SHA
docker push evanlivelo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=evanlivelo/multi-client:$SHA
kubectl set image deployments/server-deployment server=evanlivelo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=evanlivelo/multi-worker:$SHA