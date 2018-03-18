-module(sterlang_xdr_asset_test).

-include_lib("eunit/include/eunit.hrl").

encode_native_test() ->
  Asset = sterlang_asset_native:make_asset(),
  Encoded = sterlang_xdr_asset:encode(Asset),

  ?assert(is_binary(Encoded)),
  ?assertEqual(4, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(<<0:32>>, EncodedType),
  ?assertEqual(<<>>, EncodedBody).

encode_alpha_num12_test() ->
  Code = <<"testest">>,
  Issuer = sterlang_key_pair:random(),
  Asset = sterlang_asset_alpha_num12:make_asset(Code, Issuer),
  Encoded = sterlang_xdr_asset:encode(Asset),

  ?assert(is_binary(Encoded)).
