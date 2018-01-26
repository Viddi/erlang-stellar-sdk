-module(sterlang).

-export([connect/0, close/1, create_account/2]).

%%====================================================================
%% API functions
%%====================================================================

%% @doc Opens a connection to the horizon base url endpoint.
-spec connect() -> {ok, pid()} | {error, any()}.
connect() ->
  sterlang_http_client:connect().

%% @doc Closes the connection for the given Pid.
-spec close(pid()) -> ok.
close(Pid) ->
  sterlang_http_client:close(Pid).

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
