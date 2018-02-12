-module(sterlang_http_sup).

-behaviour(supervisor).

-export([start_child/2]).
-export([start_link/0, init/1]).

start_child(Args, Opts) ->
  supervisor:start_child(?MODULE, [Args, Opts]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
  %% TODO: Extract http module from Args for an injected HTTP behaviour.
  SupFlags = #{strategy => simple_one_for_one,
               intensity => 10,
               period => 10},
  ChildSpecs = [#{id => sterlang_http,
                  start => {sterlang_http_client, start_link, []},
                  restart => temporary,
                  shutdown => 5000,
                  type => worker,
                  modules => [sterlang_http_client]}],
  {ok, {SupFlags, ChildSpecs}}.
