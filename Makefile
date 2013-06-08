.PHONY: rel clean

APP_NAME=cb
REBAR=./rebar

all: compile

include rebar.mk

setup: rebar
	$(REBAR) get-deps

compile: setup 
	$(REBAR) compile

dist: setup compile
	$(MAKE) -C rel

clean:
	-rel/$(APP_NAME)/bin/$(APP_NAME) stop
	rm -rf rel/$(APP_NAME)

devrel: rel
	$(foreach dep, \
		$(wildcard deps/*), \
	   	rm -rf dev/$(APP_NAME)/lib/$(shell basename $(dep))-* \
		&& ln -sf $(abspath $(dep)) dev/$(APP_NAME)/lib;)
	rm -rf dev/$(APP_NAME)/lib/$(APP_NAME)-*
	rm -rf dev/$(APP_NAME)/lib/$(APP_NAME)
	mkdir dev/$(APP_NAME)/lib/$(APP_NAME)
	ln -sf $(abspath ebin) dev/$(APP_NAME)/lib/$(APP_NAME)/ebin
	ln -sf $(abspath priv) dev/$(APP_NAME)/lib/$(APP_NAME)/priv

rel: compile
	mkdir -p dev
	mkdir -p deps
	(cd rel && rm -rf ../dev/$(APP_NAME) && ../rebar generate target_dir=../dev/$(APP_NAME))
