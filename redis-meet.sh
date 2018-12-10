source ./CONFIG
REDIS_CLI="docker exec redisMaster redis-cli -p $MasterPort -a $requirepass"

$REDIS_CLI CLUSTER MEET $NODE2_IP $MasterPort
$REDIS_CLI CLUSTER MEET $NODE3_IP $MasterPort
$REDIS_CLI CLUSTER MEET $NODE1_IP $SlavePort
$REDIS_CLI CLUSTER MEET $NODE2_IP $SlavePort
$REDIS_CLI CLUSTER MEET $NODE3_IP $SlavePort

$REDIS_CLI CLUSTER nodes
