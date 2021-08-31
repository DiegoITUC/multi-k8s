docker build -t diegomirandadeleon/multi-client:latest -t diegomirandadeleon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diegomirandadeleon/multi-server:latest -t diegomirandadeleon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diegomirandadeleon/multi-worker:latest -t diegomirandadeleon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push diegomirandadeleon/multi-client:latest
docker push diegomirandadeleon/multi-server:latest
docker push diegomirandadeleon/multi-worker:latest

docker push diegomirandadeleon/multi-client:$SHA
docker push diegomirandadeleon/multi-server:$SHA
docker push diegomirandadeleon/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diegomirandadeleon/multi-server:$SHA
kubectl set image deployments/client-deployment client=diegomirandadeleon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diegomirandadeleon/multi-worker:$SHA
