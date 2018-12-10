source ./CONFIG

cat <<EOF >svc-redis.html
<h1>Redis Service目录</h1>
<ul>
	  <li><a href='http://$NODE1_IP:8080  '>[phpredmin_Master1]   </a></li>
	  <li><a href='http://$NODE2_IP:8080  '>[phpredmin_Master2]   </a></li>
	  <li><a href='http://$NODE3_IP:8080  '>[phpredmin_Master3]   </a></li>
	  <li><a href='http://$NODE1_IP:8000  '>[phpredisadmin     </a></li>
	  <li><a href='http://$VIP_IP:9091/haproxy_stats '>[haproxy_stats]   </a></li>
	  <li><a href='tcp://$VIP_IP:6379     '>[Redis_VIP]       </a></li>
	  <li><a href='tcp://$NODE1_IP:6380   '>[Redis_Master1]   </a></li>
	  <li><a href='tcp://$NODE2_IP:6380   '>[Redis_Master2]   </a></li>
	  <li><a href='tcp://$NODE3_IP:6380   '>[Redis_Master3]   </a></li>
	  <li><a href='tcp://$NODE1_IP:6381   '>[Redis_Slave2]    </a></li>
	  <li><a href='tcp://$NODE2_IP:6381   '>[Redis_Slave3]    </a></li>
	  <li><a href='tcp://$NODE3_IP:6381   '>[Redis_Slave1]    </a></li>
</ul>
EOF

#scp svc-redis.html <to a web hosts>
