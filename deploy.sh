docker build -t ansariajmal2020/multi-client:latest -t ansariajmal2020/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ansariajmal2020/multi-server:latest -t ansariajmal2020/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ansariajmal2020/multi-worker:latest -t ansariajmal2020/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ansariajmal2020/multi-client:latest
docker push ansariajmal2020/multi-server:latest
docker push ansariajmal2020/multi-worker:latest

docker push ansariajmal2020/multi-client:$SHA
docker push ansariajmal2020/multi-server:$SHA
docker push ansariajmal2020/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ansariajmal2020/multi-server:$SHA
kubectl set image deployments/client-deployment client=ansariajmal2020/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ansariajmal2020/multi-worker:$SHA