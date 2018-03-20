-module(sterlang_xdr_create_account_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Account = sterlang_key_pair:random(),
  Balance = 1000,
  Encoded = sterlang_xdr_create_account:encode({Account, Balance}),

  ?assert(is_binary(Encoded)),
  ?assertEqual(44, byte_size(Encoded)),

  <<EncodedAccount:36/binary, EncodedBalance:8/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_account_id:encode(Account), EncodedAccount),
  ?assertEqual(<<Balance:64>>, EncodedBalance).
