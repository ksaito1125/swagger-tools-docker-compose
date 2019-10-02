PORT_EDITOR=8001
PORT_UI=8002
PORT_API=8003

all: up

up: setup
	-docker-compose rm -f -s
	docker-compose up -d

setup: .env

.env:
	bin/mkenv.sh > $@
	echo PORT_EDITOR=$(PORT_EDITOR) >> $@
	echo PORT_UI=$(PORT_UI) >> $@
	echo PORT_API=$(PORT_API) >> $@
