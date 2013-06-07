REBAR=./rebar

all:

compile: rebar
	$(REBAR) compile

rebar: .rebar/rebar

.rebar/rebar: .rebar
	cd ./.rebar && make
	cp ./.rebar/rebar .

.rebar:
	git clone https://github.com/basho/rebar.git .rebar

setup: rebar
	$(REBAR) get-deps
