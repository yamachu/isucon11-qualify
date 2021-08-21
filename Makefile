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

log_rotate: log_rotate/nginx log_rotate/mysql

build/go:
	make -C go isucondition

restart/go:
	sudo systemctl restart isucondition.go.service

pre-bench: restart/mysql restart/nginx build/go restart/go

post-bench: log_rotate

dump-log: dump-log/nginx dump-log/mysql

dump-log/nginx:
	ls ~/log/nginx/access*.log | head -n1 | alp ltsv --sort sum -r --format md

dump-log/mysql:
	mysqldumpslow -s t `ls ~/log/mysql/mariadb-slow-*.log | head -n1`

log/go/tail:
	journalctl -u isucondition.go.service -n10 -f