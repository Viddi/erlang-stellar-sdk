-module(sterlang_xdr_operation_test).

-include_lib("eunit/include/eunit.hrl").

encode_create_account_test() ->
  Source = sterlang_key_pair:random(),
  Dest = sterlang_key_pair:random(),
  Balance = 1000,
  Encoded = sterlang_xdr_operation:encode({Source, {create_account, {Dest, Balance}}}),

  ?assert(is_binary(Encoded)),
  ?assertEqual(88, byte_size(Encoded)),

  <<EncodedSource:40/binary, EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertMatch(<<1:32, _/binary>>, EncodedSource),

  %% Unpack the actual account xdr without the first operation bit.
  <<_:32, SourceTest/binary>> = EncodedSource,
  ?assertEqual(sterlang_xdr_public_key:encode(Source), SourceTest),

  ?assertEqual(<<0:32>>, EncodedType),

  <<EncodedDest:36/binary, EncodedBalance/binary>> = EncodedBody,

  ?assertEqual(sterlang_xdr_public_key:encode(Dest), EncodedDest),
  ?assertEqual(<<Balance:64>>, EncodedBalance).

