-module(sterlang).

-export([create_account/1, account_details/1]).

%% TODO: Remove this type in favor of response records.
-type http_response() :: {ok, term()} | {ok, saved_to_file} | {error, term()}.

%%====================================================================
%% API functions
%%====================================================================
-spec create_account(string()) -> http_response().
create_account(AccountId) ->
  handle_http_call(get, horizon_create_account_url(AccountId)).

-spec account_details(string()) -> http_response().
account_details(AccountId) ->
  handle_http_call(get, horizon_account_details_url(AccountId)).

%%====================================================================
%% Internal functions
%%====================================================================
-spec horizon_base_url() -> string().
horizon_base_url() ->
  "https://horizon-testnet.stellar.org".

-spec horizon_create_account_url(string()) -> string().
horizon_create_account_url(Addr) ->
  horizon_base_url() ++ "/friendbot?addr=" ++ Addr.

-spec horizon_account_details_url(string()) -> string().
horizon_account_details_url(Addr) ->
  horizon_base_url() ++ "/accounts/" ++ Addr.

-spec handle_http_call(atom(), string()) -> http_response().
handle_http_call(Method, Url) ->
  inets:start(),
  httpc:request(Method, {Url, []}, [], []).
