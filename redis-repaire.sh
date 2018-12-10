source ./CONFIG
echo never > enabled
sudo cp  enabled  /sys/kernel/mm/transparent_hugepage/enabled
[ -z $1 ] && Name=redisMaster || Name=$1
[ $Name = "redisMaster" ] && Port=$MasterPort
[ $Name = "redisSlave" ] && Port=$SlavePort

A=`docker ps -a|grep  "$Name"|grep Exit`

[ -n "$A" ] && \
docker run  \
-v $PWD/$Name:/data \
--rm -i \
redis redis-check-aof --fix appendonly.aof \
&& docker start $Name|| echo "No need to fix"

