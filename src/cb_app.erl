-module(cb_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, reload/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->

    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
            {env, [{dispatch, route()}]}
        ]),
    cb_sup:start_link().

stop(_State) ->
    ok.

reload() ->
    cowboy:set_env(http, dispatch, route()).

route() ->
    cowboy_router:compile([ {'_', [
                    {"/", toppage_handler, []}
                    ,{"/vsn", vsn_handler, []}
                ]} ]).

