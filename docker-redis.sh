source ./CONFIG
echo never > enabled
sudo cp  enabled  /sys/kernel/mm/transparent_hugepage/enabled
[ -z $1 ] && Name=redisMaster || Name=$1
[ $Name = "redisMaster" ] && Port=$MasterPort
[ $Name = "redisSlave" ] && Port=$SlavePort

docker run --name $Name \
--privileged \
-v $PWD/$Name.conf:/etc/redis.conf \
-v $PWD/sysctl.conf:/etc/sysctl.conf \
-v $PWD/docker-entrypoint.sh:/usr/local/bin/docker-entrypoint.sh \
-v $PWD/$Name:/data \
-p $Port:$Port \
-p $(($Port+10000)):$(($Port+10000)) \
-d redis /etc/redis.conf
