source ./CONFIG
source ./hashmaster
REDIS_CLI="docker exec redisMaster redis-cli -p $MasterPort -a $requirepass"

echo $hashMaster1 $hashMaster2 $hashMaster3

$REDIS_CLI -h $NODE1_IP -p $SlavePort -a $requirepass CLUSTER REPLICATE $hashMaster2
$REDIS_CLI -h $NODE2_IP -p $SlavePort -a $requirepass CLUSTER REPLICATE $hashMaster3
$REDIS_CLI -h $NODE3_IP -p $SlavePort -a $requirepass CLUSTER REPLICATE $hashMaster1
