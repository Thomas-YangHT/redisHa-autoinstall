source ./CONFIG
docker rm redisadmin -f

docker run  \
--name redisadmin \
-e REDIS_1_HOST=$VIP_IP \
-e REDIS_1_NAME=Cluster \
-e REDIS_1_PORT=$VPORT \
-e REDIS_1_AUTH=$requirepass \
-e REDIS_2_HOST=$NODE1_IP \
-e REDIS_2_NAME=$NODE1_NAME \
-e REDIS_2_PORT=$MasterPort \
-e REDIS_2_AUTH=$requirepass \
-e REDIS_3_HOST=$NODE2_IP \
-e REDIS_3_NAME=$NODE2_NAME \
-e REDIS_3_PORT=$MasterPort \
-e REDIS_3_AUTH=$requirepass \
-e REDIS_4_HOST=$NODE3_IP \
-e REDIS_4_NAME=$NODE3_NAME \
-e REDIS_4_PORT=$MasterPort \
-e REDIS_4_AUTH=$requirepass \
-p 8000:80 \
-d erikdubbelboer/phpredisadmin
