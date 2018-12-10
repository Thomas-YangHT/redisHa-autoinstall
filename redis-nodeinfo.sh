source ./CONFIG
REDIS_Master_CLI="docker exec redisMaster redis-cli -p $MasterPort -a $requirepass"

cat /etc/motd
uname -a
echo "RedisClusterInfo:"
echo "-----------------"
$REDIS_Master_CLI cluster info
echo "\n RedisClusterNodes:"
echo "-----------------"
$REDIS_Master_CLI CLUSTER nodes|sort -k 2,3
echo "\n For Manager,see svc-redis.html."
