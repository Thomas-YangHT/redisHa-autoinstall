source ./CONFIG
REDIS_CLI="docker exec redisMaster redis-cli -p $MasterPort -a $requirepass"

while read VALUE KEY
do
  if   [ "$KEY" = "$NODE2_IP:$MasterPort" ]
  then
      hashMaster2=$VALUE
  elif [ "$KEY" = "$NODE3_IP:$MasterPort" ]
  then
      hashMaster3=$VALUE
  else
      hashMaster1=$VALUE
  fi
done<<EOF
`cat nodeInfo|grep $MasterPort|awk -F'out:' '{print $2}'|awk -F'@' '{print $1}'`
EOF

cat >hashmaster<<EOF
hashMaster1=$hashMaster1
hashMaster2=$hashMaster2
hashMaster3=$hashMaster3
EOF

