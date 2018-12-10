#!/bin/bash
source ./CONFIG
REDIS_CLI="docker exec redisMaster redis-cli -p $MasterPort -a $requirepass"

# node1 
$REDIS_CLI -h $NODE1_IP -p $MasterPort -a $requirepass  CLUSTER ADDSLOTS {0..5461}
 
# node2 
$REDIS_CLI -h $NODE2_IP -p $MasterPort -a $requirepass  CLUSTER ADDSLOTS {5462..10922}
 
# node3 
$REDIS_CLI -h $NODE3_IP -p $MasterPort -a $requirepass  CLUSTER ADDSLOTS {10923..16383}

$REDIS_CLI CLUSTER nodes
