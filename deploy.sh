docker build -t ayucawa/multi-client:latest -t ayucawa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ayucawa/multi-server:latest -t ayucawa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ayucawa/multi-worker:latest -t ayucawa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ayucawa/multi-client:latest
docker push ayucawa/multi-client:$SHA
docker push ayucawa/multi-server:latest
docker push ayucawa/multi-server:$SHA
docker push ayucawa/multi-worker:latest
docker push ayucawa/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ayucawa/multi-client:$SHA
kubectl set image deployments/server-deployment server=ayucawa/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ayucawa/multi-worker:$SHA