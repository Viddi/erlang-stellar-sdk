-module(sterlang_xdr_payment).

-behaviour(sterlang_xdr).

-export([encode/1]).

encode({Account, Asset, Amount}) ->
  EncodedAccount = sterlang_xdr_account_id:encode(Account),
  <<>>.
