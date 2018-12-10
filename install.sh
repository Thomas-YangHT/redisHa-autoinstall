#  _       _                          __  __                 
# | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
# | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
# | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
# |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
#                                                             
#

#start timestamp
D1=`date +%s`

#if no fab cmd, then install fabric
which fab;[ $? -eq 1 ] && echo "install fabric" && yum install -y fabric 
#or: pip install fabric==1.14.0

source ./CONFIG
source ./FUNCTION

#start timestamp
D1=`date +%s`

#if no fab cmd, then install fabric
which fab;[ $? -eq 1 ] && echo "install fabric" && yum install -y fabric 
#or: pip install fabric==1.14.0

case $1 in
p|prepare)
  echo "prepare..."
  func_prepare
;;
p1|prepareMon)
  echo "start Mon prepare..."
  func_prepareMon
;;
p2|haprepare)
  echo "start ha prepare..."
  func_ha_prepare
;;
keepalived)
  echo "start keepalived..."
  func_keepalived
;;
haproxy)
  echo "start haproxy..."
  func_haproxy
;;
redis)
  echo "redis"
  func_redis
;;
redisMeet)
  echo "redisMeet"
  func_redisMeet
;;
addSlots)
  echo "addSlots"
  func_addSlots
;;
nodeInfo)
  echo "nodeInfo"
  func_nodeInfo
;;
addSlave)
  echo "addSlave"
  func_addSlave
;;
redisAdmin)
  echo "redisAdmin"
  func_redisAdmin
;;
phpRedmin)
  echo "phpRedmin"
  func_phpRedmin
;;
repaireRedis)
  echo "repaireRedis"
  func_repaireRedis
;;
reset)
  echo "reset"
  func_reset
;;
status)
  echo "status"
  func_status
;;
start)
  echo "start"
  func_start
;;
reboot)
  echo "reboot:"
  func_reboot
;;
all)
  echo "all"
  func_prepare
  func_haprepare
  func_keepalived
  func_haproxy
  func_redis
  func_redisMeet
  func_addSlots
  func_nodeInfo
  func_addSlave
  func_prepareMon
  func_redisAdmin
  func_phpRedmin
  func_status
;;
help|*)
  echo "usage: $0 [OPTION]"
  echo -e "OPTIONS:\n\
        p|prepare      :prepare redis.tgz .etc.\n\
        p1|prepareMon  :prepare redismon.tgz\n\
        p2|haprepare   :prepare ha.tgz.\n\
        keepalived     :install keepalived.\n\
        haproxy        :install haproxy.\n\
        status         :get redis status.\n\
        reset          :when reinstall, delete all.\n\
        start          :start all redis container.\n\
        redis          :start redis container.\n\
        redisMeet      :handshake nodes.\n\
        addSlots       :seprate 16384 slots to three nodes\n\
        nodeInfo       :get nodeInfo\n\
        addSlave       :add slave to master\n\
        redisAdmin     :install phpredisadmin on node1\n\
        phpRedmin      :install phpredmin on all nodes\n\
        reaireRedis    :fix aof file & restart failed redis\n\
        all            :install all components.\n\
        reboot         :reboot all nodes in CEPH cluster.\n\
  "
;;
esac

#cost seconds
D2=`date +%s`
echo ALL Mission completed in $((D2-D1)) seconds

