
![](https://img.shields.io/badge/Dist-CoreOS-blue.svg)  ![](https://img.shields.io/badge/Redis-HA-brightgreen.svg)  ![](https://img.shields.io/badge/Proxy-IPVS-orange.svg)  ![](https://img.shields.io/badge/Haproxy-LB-yellow.svg) ![](https://img.shields.io/badge/Keepalived-HA-green.svg)

# Redis 5.0 Cluster in CoreOS
---
## 基本结构
   ||前端 : VIP:6379  haproxy_stats:9091||
   |------------|:--------------:|:--------------:|
   |**Node1**            |**Node2**               |**Node3**            |       
   |master1:6380 |master2:6380  |master3:6380  |   
   |slave2:6381   |slave3:6381     |slave1:6381   |               
   |phpredmin:8080    |phpredmin:8080    |phpredmin:8080 |
   |redisadmin:8000|||
  |分片slots(0-5461)| slots(5462-10922)| slots(10923-16383)|

## Download
---
*  [ha.tgz](https://pan.baidu.com/s/1Cj_BAiohKnZOi2MKCEX10g)
*  [redis.tgz](https://pan.baidu.com/s/1EEToojubfhGChvH8suILWg)
*  [redismon.tgz](https://pan.baidu.com/s/1GkxIaTGcnQlUuHtO6VeQmw)
*  git clone https://github.com/Thomas-YangHT/redisHa.git;cp *tgz redisHa; cd redisHa

## vim CONFIG
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
`sh -x install.sh all` **and waiting for a moment...**

[see video](https://asciinema.org/a/WAxXfKq68ADvp1b8vRNXEWAJY)

[![install video](https://upload-images.jianshu.io/upload_images/12123313-0b4d51ce26f3e8fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://asciinema.org/a/216290)

## Check STATUS
`sh install.sh status`  **and see all nodes connected**
![cluster info & nodes status](https://upload-images.jianshu.io/upload_images/12123313-8a41850563e73c12.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Check Result by browse svc-redis.html
---
![svc-redis.html](https://upload-images.jianshu.io/upload_images/12123313-f0502bda3bb64269.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![phpredmin带统计和命令终端](https://upload-images.jianshu.io/upload_images/12123313-33d7d664aba48be6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![RedisAdmin支持多主机管理](https://upload-images.jianshu.io/upload_images/12123313-4bafdaab4f9fe7fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![haproxy_stats](https://upload-images.jianshu.io/upload_images/12123313-b7b1a57c6c1fdeef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## More about install.sh:
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
        repaireRedis   :fix aof file & restart failed redis
        all            :install all components.
        reboot         :reboot all nodes in CEPH cluster.
```
## Q&A
* 集群模式的限制
  * Redis集群模式只支持一个库，即db0
  * 分片存储，Master1(0-5461slots) Master2(5462-10922) Master3(10923-16383)，keys *将只返回连接结点的KEY
  * redis-cli -c 需要加-c 选项，其它常用选项：-p \$MasterPort -a \$requirepass -h \$node[1-3]
  * 可通过VIP：VPORT，或任一NODEIP：MasterPort访问集群
  * 集群通讯是通过通讯端口（数据端口+10000）互连
* 参考
  *  [Redis集群规范](https://blog.csdn.net/u010258235/article/details/50060127)
  * [WEB管理：phpredisadmin](https://github.com/erikdubbelboer/phpRedisAdmin)
  * [WEB管理：phpredmin](https://github.com/sasanrose/phpredmin)
  * [redis常用命令](https://www.cnblogs.com/kongzhongqijing/p/6867960.html)
-----
## CMD Search公众号：[LinuxMan]

![Linux命令用法速查公众号，如：输入ls，返回用法链接，含500+命令用法](https://upload-images.jianshu.io/upload_images/12123313-21545308f7327a9b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



