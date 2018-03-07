-module(sterlang_xdr_account_id).

-export([encode/1]).

-opaque account_id() :: sterlang_key_pair:key_pair().

-export_type([account_id/0]).

-spec encode(account_id()) -> binary().
encode(Account) ->
  sterlang_xdr_public_key:encode(Account).

%% TODO: Finish me
%%decode(Binary, _2) ->
%%  sterlang_xdr_public_key:decode(Binary, _2).
