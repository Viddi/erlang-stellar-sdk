-module(sterlang_xdr_account_id).

-export([encode/1]).

-spec encode(sterlang_key_pair:key_pair()) -> binary().
encode(Account) ->
  sterlang_xdr_public_key:encode(Account).

%% TODO: Finish me
%%decode(Binary, _2) ->
%%  sterlang_xdr_public_key:decode(Binary, _2).
