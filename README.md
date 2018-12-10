```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```
# Redis 5.0 Cluster in CoreOS
---
           VIP:6379  haproxy_stats:9091
Node1  master1:6380  slave2:6381  phpredmin:8080 redisadmin:8000
Node2  master2:6380  slave3:6381  phpredmin:8080 
Node3  master3:6380  slave1:6381  phpredmin:8080

## PREPARE
---
*  [ha.tgz](https://pan.baidu.com/s/1Cj_BAiohKnZOi2MKCEX10g)
*  [redis.tgz](https://pan.baidu.com/s/1EEToojubfhGChvH8suILWg)
*  [redismon.tgz](https://pan.baidu.com/s/1GkxIaTGcnQlUuHtO6VeQmw)

## CONFIG
---
```
NODE1_NAME=node1
NODE2_NAME=node2
NODE3_NAME=node3
NODE1_IP=192.168.253.41
NODE2_IP=192.168.253.42
NODE3_IP=192.168.253.43
VIP_IP=192.168.253.40
VR_ID=53
VPORT=6379
MasterPort=6380
SlavePort=6381
REMOTE_USER=core
masterauth=123321
requirepass=123321 
NODES=$NODE1_IP,$NODE2_IP,$NODE3_IP

#for kvm clone sh
KVM_NAME=$NODE1_NAME,$NODE2_NAME,$NODE3_NAME
GATEWAY=192.168.253.125  
DNS1=192.168.253.110
DNS2=114.114.114.114
PJ=redis
```
## INSTALL
---
** sh -x install.sh all **

## more usage:
```
usage: install.sh [OPTION]
OPTIONS:
        p|prepare      :prepare redis.tgz .etc.
        p1|prepareMon  :prepare redismon.tgz
        p2|haprepare   :prepare ha.tgz.
        keepalived     :install keepalived.
        haproxy        :install haproxy.
        status         :get redis status.
        reset          :when reinstall, delete all.
        start          :start all redis container.
        redis          :start redis container.
        redisMeet      :handshake nodes.
        addSlots       :seprate 16384 slots to three nodes
        nodeInfo       :get nodeInfo
        addSlave       :add slave to master
        redisAdmin     :install phpredisadmin on node1
        phpRedmin      :install phpredmin on all nodes
        reaireRedis    :fix aof file & restart failed redis
        all            :install all components.
        reboot         :reboot all nodes in CEPH cluster.
```
-----
## weixin public accunt: [LinuxMan]
* [linux command HELP,try input some cmd, such as lsof]
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/linuxman.png" width="500">

