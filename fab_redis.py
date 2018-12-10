from fabric.api import *

#for ha
def prepare_ha():
    local('sh haproxy_conf.sh')
    local('sh hosts_conf.sh')
    put('ha.tgz', '')
    put('haproxy.cfg','redis/haproxy.cfg')
    put('hosts','redis/hosts')
    run('tar zxvf ha.tgz -C redis')
    run('echo -e "haproxy.tar\n keepalived.tar"|awk \'{print "docker load <redis/"$1}\'|sh')
    run('[ -f hosts.bak ] || cp /etc/hosts hosts.bak;cat hosts.bak redis/hosts >hosts.tmp;sudo cp hosts.tmp /etc/hosts')

#for ha
def keepalived():
    run('docker rm keepalived -f;pwd')
    run('sudo modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh')
    run('cd redis;sh docker-keepalived.sh')

#for ha
def haproxy():
    run('docker rm haproxy -f;pwd')
    run('cd redis;sh docker-haproxy.sh')

def prepare():
    local('sh config.dist.php.sh')
    local('sh redis_conf.sh')
    local('tar zcvf config.tgz docker*sh CONFIG haproxy.cfg hosts redis*conf sysctl.conf docker-entrypoint.sh redis-*sh config.dist.php* terminal.php')
    put('config.tgz','')
    put('redis.tgz','')
    run('mkdir redis;tar zxvf config.tgz -C redis;tar zxvf redis.tgz -C redis')
    run('ls redis/*.tar|awk \'{print "docker load <"$1}\'|sh')

def prepareMon():
    put('redismon.tgz','')
    run('tar zxvf redismon.tgz -C redis')
    run('ls redis/php*tar|awk \'{print "docker load <"$1}\'|sh')

def redis():  
    run('cd redis;sh docker-redis.sh redisMaster')
    run('cd redis;sh docker-redis.sh redisSlave')

def redisMeet():
    run('cd redis;sh redis-meet.sh')

def nodeInfo():
    run('cd redis;sh redis-nodeinfo.sh')

def addSlots():
    run('cd redis;sh redis-addslots.sh')

def addSlave():
    local('sh redis-nodehash.sh')
    put('hashmaster','redis/hashmaster')
    run('cd redis;sh redis-addSlave.sh')

def redisAdmin():
    run('cd redis;sh docker-redisadmin.sh')

def phpRedmin():
    run('cd redis;sh docker-phpredmin.sh')

def repaireRedis():
    run('cd redis;sh redis-repaire.sh')
    run('cd redis;sh redis-repaire.sh redisSlave')

def status():
    #run('source $HOME/redis/CONFIG;cat /etc/motd;docker exec redisMaster redis-cli -p $MasterPort -a $requirepass cluster info;uname -a')
    run('cd redis;sh redis-nodeinfo.sh')

def reset():
    run('A=`docker ps -a|grep -P "redis"`;[ -n "$A" ] && echo $A|awk \'{print $1}\'|xargs docker rm -f || echo 0')

def start():
    run('sudo modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh')
    run('docker start redisMaster')
    run('docker start redisSlave')
    run('docker start phpredmin')

def reboot():
    run('echo "reboot $HOSTNAME";sudo reboot;')

