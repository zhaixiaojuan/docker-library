alpine:3.19中没有php7, 这里使用php83来替换
在安装完php83后，/etc/php83/conf.d/ 目录为空

在源码中使用以下代码：
COPY ["conf/etc/php7/conf.d/99-zabbix.ini", "/etc/php83/conf.d/"]
