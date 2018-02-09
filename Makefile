project ?= ci-tool-stack
env ?= dev
sudo ?= sudo -E

compose_build_args = --force-rm
# compose_build_args += --no-cache
compose_args += -f docker-compose.yml
compose_args += $(shell [ -f  docker-compose.$(env).yml ] && echo "-f docker-compose.$(env).yml")

compose_out ?= docker-compose.out.yml

default: help
	
help:
	@echo "make pull build stop up clean logs restart SERVICE='service-config'"

all: stop rm up

.PHONY: clean config build pull up restart rm stop logs
# Build
clean:
	$(sudo) docker system prune -f
config:
	$(sudo) docker-compose $(compose_args) config
services:
	$(sudo) docker-compose $(compose_args) config --services
build: config
	$(sudo) docker-compose $(compose_args) build $(SERVICE)
pull:
	$(sudo) docker-compose $(compose_args) pull $(SERVICE)
# Run
up: config
	$(sudo) docker-compose $(compose_args) up -d $(SERVICE)
restart:
	$(sudo) docker-compose $(compose_args) restart $(SERVICE)
rm:
	$(sudo) docker-compose $(compose_args) rm -f $(SERVICE)
stop:
	$(sudo) docker-compose $(compose_args) stop $(SERVICE)
logs:
	$(sudo) docker-compose $(compose_args) logs $(SERVICE)

.PHONY: template build-template pull-template up-template restart-template stop-template rm-template
# template: generate docker-compose.out.yml from all docker-compose args (docker-compose.yml + docker-composoe.$env.yml)
# Build
template:
	$(sudo) docker-compose $(compose_args) config | tee $(compose_out)
config-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) config
services-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) config --services
build-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) build $(compose_build_args) $(SERVICE)
pull-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) pull $(SERVICE)
up-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) up -d $(SERVICE)
restart-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) restart $(SERVICE)
stop-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) stop $(SERVICE)
rm-template: $(compose_out)
	$(sudo) docker-compose -f $(compose_out) rm -f $(SERVICE)


.PHONY: package test publish
package:
	bash ./tools/package.sh
test:
	bash ./tools/test.sh $(compose_args)
publish:
	bash ./tools/publish.sh $(compose_args)
