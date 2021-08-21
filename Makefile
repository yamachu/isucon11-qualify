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

log_rotate/nginx:
	-sudo mv /var/log/nginx/access.log ~/log/nginx/access-${DATE}.log
	-sudo chmod 666 ~/log/nginx/access-${DATE}.log

restart/nginx:
	sudo systemctl restart nginx

build/go:
	make -C go isucondition

restart/go:
	sudo systemctl restart isucondition.go.service

pre-bench: restart/mysql restart/nginx build/go restart/go
