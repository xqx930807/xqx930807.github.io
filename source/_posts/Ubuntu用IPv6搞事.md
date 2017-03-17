---
title: Ubuntu用IPv6搞事
date: 2017-03-17 18:18:49
tags: Ubuntu,IPv6
---

- Ubuntu ipv6网卡和ipv6地址问题

   Ubuntu升级到15.04之后网卡名字改变的问题，从15.04开始到16.04，网卡一直都是奇奇怪怪的名字，比如原来的eth0变成了enp1s0,wlan0变成了wpxxx。

   修改配置文件：/etc/udev/rules.d/10-network.rules（如果没有的话就创建一个），在里面添加如下代码：
    `SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="20:1a:xx:xx:xx:xx",NAME="eth0"`
    `SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="70:18:xx:xx:xx:xx", NAME="wlan0"`

   那些xxxxxx是你网卡的MAC地址。然后重启就OK了。

   ​

   pppoe拨号的IPv6问题，以前的时候一直没搞定，今天突然发现一个文件： /etc/sysctl.d/10-ipv6-privacy.conf，是配置IPv6选择临时地址还是广播地址的，然后把里面的东西都注释掉，完美解决。

   ​

  里面的内容是这样子的：
```# IPv6 Privacy Extensions (RFC 4941)

	#IPv6 typically uses a device's MAC address when choosing an IPv6 address

	#to use in autoconfiguration. Privacy extensions allow using a randomly

	#generated IPv6 address, which increases privacy.

	#Acceptable values:

	#0 - don’t use privacy extensions.

	#1 - generate privacy addresses

	#2 - prefer privacy addresses and use them over the normal addresses.

	#net.ipv6.conf.all.use_tempaddr = 2

	#net.ipv6.conf.default.use_tempaddr = 2
```


-  socks代理转换为本地http 

 sudo apt-get install polipo
 sudo vim /etc/polipo/config
```
 Uncomment this if you want to use a parent SOCKS proxy:
 socksParentProxy = localhost:1080
 socksProxyType = socks5
```

 sudo service polipo stop
 sudo service polipo start
 export http_proxy=http://localhost:8123
 npm config set proxy=http://localhost:8123
