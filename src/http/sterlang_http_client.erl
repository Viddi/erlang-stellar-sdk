-module(sterlang_http_client).

-behaviour(sterlang_http).

-export([connect/0, close/1, get/2]).

%%====================================================================
%% API functions
%%====================================================================
-spec connect() -> {ok, pid()} | {error, any()}.
connect() ->
  gun:open("horizon-testnet.stellar.org", 443).

-spec close(pid()) -> ok.
close(Pid) ->
  gun:shutdown(Pid).

get(Pid, Url) ->
  Ref = gun:get(Pid, Url),
  await_response(Pid, Ref).
  %% receive_response(Pid, Ref).

%%====================================================================
%% Internal functions
%%====================================================================
-spec await_response(pid(), reference()) -> sterlang_http:response().
await_response(Pid, Ref) ->
  case gun:await(Pid, Ref) of
    {response, fin, Status, Headers} ->
      {Status, Headers, no_data};
    {response, nofin, Status, Headers} ->
      {ok, Body} = gun:await_body(Pid, Ref),
      io:format("~s~n", [Body]),
      {Status, Headers, Body}
  end.
