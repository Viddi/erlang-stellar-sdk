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

encode_alpha_num4_test() ->
  Code = <<"test">>,
  Issuer = sterlang_key_pair:from_secret(secret()),
  Asset = sterlang_asset_alpha_num4:make_asset(Code, Issuer),
  Encoded = sterlang_xdr_asset:encode(Asset),

  ?assert(is_binary(Encoded)),
  ?assertEqual(44, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody:40/binary>> = Encoded,
  ?assertEqual(sterlang_xdr_asset_type:encode(credit_alphanum4), EncodedType),

  <<EncodedAssetCode:4/binary, EncodedIssuer:36/binary>> = EncodedBody,
  ?assertEqual(Code, EncodedAssetCode),
  ?assertEqual(sterlang_xdr_account_id:encode(Issuer), EncodedIssuer).

encode_alpha_num12_test() ->
  Code = <<"testest">>,
  Issuer = sterlang_key_pair:from_secret(secret()),
  Asset = sterlang_asset_alpha_num12:make_asset(Code, Issuer),
  Encoded = sterlang_xdr_asset:encode(Asset),

  ?assert(is_binary(Encoded)),
  ?assertEqual(52, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody:48/binary>> = Encoded,
  ?assertEqual(sterlang_xdr_asset_type:encode(credit_alphanum12), EncodedType),

  <<EncodedAssetCode:12/binary, EncodedIssuer:36/binary>> = EncodedBody,
  ?assertEqual(<<Code/binary, 0, 0, 0, 0, 0>>, EncodedAssetCode),
  ?assertEqual(sterlang_xdr_account_id:encode(Issuer), EncodedIssuer).

secret() ->
  <<"SBJZFYAOGKAKCJDT3F5QH6XY4J3SFY7HX3XWYVJLGSVHCGQL6YFCILH3">>.
