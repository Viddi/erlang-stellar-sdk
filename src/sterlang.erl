-module(sterlang).

-export([connect/0, connect/2, close/1, connected/1]).
-export([create_account/2]).

%%====================================================================
%% API functions
%%====================================================================

%% @doc Opens a connection to the horizon base url endpoint.
-spec connect() -> supervisor:startchild_ret().
connect() ->
  sterlang_http_sup:start_child([], []).

-spec connect(list(), list()) -> supervisor:startchild_ret().
connect(Args, Opts) ->
  sterlang_http_sup:start_child(Args, Opts).

%% @doc Closes the connection for the given sterlang_http Pid.
-spec close(pid()) -> ok.
close(Pid) ->
  sterlang_http_client:close(Pid).

-spec connected(pid()) -> sterlang_http:connected().
connected(Pid) ->
  sterlang_http_client:connected(Pid).

%% @doc Makes a request to create an account for the given account id.
-spec create_account(pid(), <<_:_*56>>) -> sterlang_http_client:response().
create_account(Pid, PublicKey) ->
  Url = horizon_create_account_url(PublicKey),
  sterlang_http_client:get(Pid, Url).

%%====================================================================
%% Internal functions
%%====================================================================
-spec horizon_create_account_url(binary()) -> [byte(), ...].
horizon_create_account_url(PublicKey) ->
  "/friendbot?addr=" ++ binary_to_list(PublicKey).

%% -spec horizon_account_details_url(string()) -> string().
%% horizon_account_details_url(PublicKey) ->
%%   "/accounts/" ++ binary_to_list(PublicKey).
