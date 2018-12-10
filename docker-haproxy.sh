source ./CONFIG

docker run --name haproxy \
-v $HOME/redis/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
-p $VPORT:$VPORT \
-p 9091:9091 \
--restart=always \
-d haproxy
