-module(sterlang_xdr_payment).

-behaviour(sterlang_xdr).

-export([encode/1]).

-spec encode({sterlang_key_pair:key_pair(), tuple(), non_neg_integer()}) -> binary().
encode({Account, Asset, Amount}) ->
  EncodedAccount = sterlang_xdr_account_id:encode(Account),
  EncodedAsset = sterlang_xdr_asset:encode(Asset),
  EncodedAmount = sterlang_xdr:encode_int64(Amount),
  <<EncodedAccount/binary, EncodedAsset/binary, EncodedAmount/binary>>.
