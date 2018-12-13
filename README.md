
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
*  git clone https://github.com/Thomas-YangHT/redisHa-autoinstall.git;cp *tgz redisHa-autoinstall; cd redisHa-autoinstall

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
`sh -x install.sh all`
* [see video](https://asciinema.org/a/WAxXfKq68ADvp1b8vRNXEWAJY)
[![asciicast](https://asciinema.org/a/216290.svg)](https://asciinema.org/a/216290)

## Check Result by browse svc-redis.html
---
`sh install status`
![image](http://upload-images.jianshu.io/upload_images/12123313-ef9b3829ef5856ae?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 注：
- 如果有clock skew detect on xxx报警， 执行 
```
sh  cluster_cmd.sh  "sudo ntpdate <NTP SERVER IP>"
```
- 安装后会生成**svc-ceph.html**, 包含dashboard/grafana/prometheus等的页面链接，依次打开验证
#### svc-ceph.html
![](http://upload-images.jianshu.io/upload_images/12123313-1823460dabd0b4e8?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### ceph dashboard
![](http://upload-images.jianshu.io/upload_images/12123313-2b1c7297f27b95d7?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### prometheus
![](http://upload-images.jianshu.io/upload_images/12123313-9e3844eaea390433?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### **修改grafana的datasource prometheus IP为node1的IP**
![](http://upload-images.jianshu.io/upload_images/12123313-a674991fbaf3d8af?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](http://upload-images.jianshu.io/upload_images/12123313-cef605cf795d4977?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## More Usage:
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
-----
## weixin public accunt: [LinuxMan]

* [linux command HELP,try input some cmd, such as lsof]

  <img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/linuxman.png" width="400">
                           
* [Linux命令用法速查公众号，如：输入ls，返回用法链接，可查500+命令用法]

```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```

