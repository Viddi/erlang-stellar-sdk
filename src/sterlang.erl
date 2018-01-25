-module(sterlang).

-export([connect/0, close/1, create_account/2]).

%%====================================================================
%% API functions
%%====================================================================

%% @doc Opens a connection to the horizon base url endpoint.
-spec connect() -> {ok, pid()} | {error, any()}.
connect() ->
  gun:open("horizon-testnet.stellar.org", 443).

%% @doc Closes the connection for the given Pid.
-spec close(pid()) -> ok.
close(Pid) ->
  gun:shutdown(Pid).

%% @doc Makes a request to create an account for the given account id.
-spec create_account(pid(), <<_:_*56>>) -> atom().
create_account(Pid, PublicKey) ->
  Url = horizon_create_account_url(PublicKey),
  Ref = gun:get(Pid, Url),
  receive_response(Pid, Ref).

%%====================================================================
%% Internal functions
%%====================================================================
-spec horizon_create_account_url(binary()) -> [byte(), ...].
horizon_create_account_url(PublicKey) ->
  "/friendbot?addr=" ++ binary_to_list(PublicKey).

%% -spec horizon_account_details_url(string()) -> string().
%% horizon_account_details_url(PublicKey) ->
%%   "/accounts/" ++ binary_to_list(PublicKey).

receive_response(ConnPid, Ref) ->
  receive
    {gun_response, ConnPid, Ref, fin, _Status, _Headers} ->
      no_data;
    {gun_response, ConnPid, Ref, nofin, _Status, _Headers} ->
      receive_data(ConnPid, Ref);
    {'DOWN', _, process, ConnPid, Reason} ->
      error_logger:error_msg("Oops!"),
      exit(Reason)
  after 10000 ->
    exit(timeout)
  end.

receive_data(ConnPid, Ref) ->
  receive
    {gun_data, ConnPid, Ref, nofin, Data} ->
      io:format("~s~n", [Data]),
      receive_data(ConnPid, Ref);
    {gun_data, ConnPid, Ref, fin, Data} ->
      io:format("~s~n", [Data]);
    {'DOWN', _, process, ConnPid, Reason} ->
      error_logger:error_msg("Oops!"),
      exit(Reason)
  after 10000 ->
    exit(timeout)
  end.
