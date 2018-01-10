-module(sterlang).

%% API exports
-export([create_account/1, account_details/1]).

%%====================================================================
%% API functions
%%====================================================================
create_account(AccountId) ->
  handle_http_call(get, horizon_create_account_url(AccountId)).

account_details(AccountId) ->
  handle_http_call(get, horizon_account_details_url(AccountId)).

%%====================================================================
%% Internal functions
%%====================================================================
horizon_base_url() ->
  "https://horizon-testnet.stellar.org".

horizon_create_account_url(Addr) ->
  horizon_base_url() ++ "/friendbot?addr=" ++ Addr.

horizon_account_details_url(Addr) ->
  horizon_base_url() ++ "/accounts/" ++ Addr.

handle_http_call(Method, Url) ->
  inets:start(),
  httpc:request(Method, {Url, []}, [], []).
