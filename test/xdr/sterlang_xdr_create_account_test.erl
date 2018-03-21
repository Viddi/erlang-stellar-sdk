-module(sterlang_xdr_create_account_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Account = sterlang_key_pair:from_secret(<<"SBJZFYAOGKAKCJDT3F5QH6XY4J3SFY7HX3XWYVJLGSVHCGQL6YFCILH3">>),
  Balance = 1000,
  Encoded = sterlang_xdr_create_account:encode({Account, Balance}),

  ?assert(is_binary(Encoded)),
  ?assertEqual(44, byte_size(Encoded)),

  <<EncodedAccount:36/binary, EncodedBalance:8/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_account_id:encode(Account), EncodedAccount),
  ?assertEqual(<<Balance:64>>, EncodedBalance).
