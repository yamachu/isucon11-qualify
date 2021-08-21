SHELL=/bin/bash
DATE:=$(shell date "+%Y%m%d-%H%M%S")

mysql/client:
	mysql -u isucon -pisucon isucondition

log_rotate/mysql:
	-sudo mv /var/log/mysql/mariadb-slow.log ~/log/mysql/mariadb-slow-${DATE}.log
	-sudo chmod 666 ~/log/mysql/mariadb-slow-${DATE}.log
	mysqladmin -pisucon flush-logs

restart/mysql:
	sudo systemctl restart mysql
