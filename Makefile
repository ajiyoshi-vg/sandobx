REBAR=./rebar

rebar: .rebar/rebar

.rebar/rebar: .rebar
	cd ./.rebar && make
	cp ./.rebar/rebar .

.rebar:
	git clone https://github.com/basho/rebar.git .rebar
