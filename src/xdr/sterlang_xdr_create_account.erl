-module(sterlang_xdr_create_account).

-export([encode/1]).

-spec encode({sterlang_xdr_account_id:account_id(), non_neg_integer()}) -> binary().
encode({Account, StartingBalance}) ->
  EncodedAccount = sterlang_xdr_account_id:encode(Account),
  EncodedBalance = sterlang_xdr:encode_int64(StartingBalance),
  <<EncodedAccount/binary, EncodedBalance/binary>>.

%% TODO: Finish me
%%decode(Binary, _2) ->
%%  begin
%%    {_3, _4} = dec_AccountID(Binary, _2),
%%    {_5, _6} = dec_int64(Binary, _4),
%%    {{_3, _5}, _6}
%%  end.
