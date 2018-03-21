-module(sterlang_xdr_operation_test).

-include_lib("eunit/include/eunit.hrl").

encode_create_account_test() ->
  Source = sterlang_key_pair:from_secret(<<"SBDTL3K23MTDMSSCHWOGBGFAF32THKPKOME3SIWTRNQPERQMAYZMRWNN">>),
  Dest = sterlang_key_pair:from_secret(<<"SBA22K2MVQPBV7FCIHY3SZAYO2NYRUWZV4YBYBM5X47CFPQB7IAISZBF">>),
  Balance = 1000,
  Encoded = sterlang_xdr_operation:encode({Source, {create_account, {Dest, Balance}}}),

  ?assert(is_binary(Encoded)),
  ?assertEqual(88, byte_size(Encoded)),

  <<EncodedSource:40/binary, EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertMatch(<<1:32, _/binary>>, EncodedSource),

  %% Unpack the actual account xdr without the first operation bit.
  <<_:32, SourceTest/binary>> = EncodedSource,
  ?assertEqual(sterlang_xdr_public_key:encode(Source), SourceTest),

  ?assertEqual(sterlang_xdr_operation_type:encode(create_account), EncodedType),

  <<EncodedDest:36/binary, EncodedBalance/binary>> = EncodedBody,

  ?assertEqual(sterlang_xdr_public_key:encode(Dest), EncodedDest),
  ?assertEqual(<<Balance:64>>, EncodedBalance).

encode_payment_test() ->
  Source = sterlang_key_pair:from_secret(<<"SBDTL3K23MTDMSSCHWOGBGFAF32THKPKOME3SIWTRNQPERQMAYZMRWNN">>),
  Dest = sterlang_key_pair:from_secret(<<"SBA22K2MVQPBV7FCIHY3SZAYO2NYRUWZV4YBYBM5X47CFPQB7IAISZBF">>),
  Asset = sterlang_asset_native:make_asset(),
  Amount = 1000,
  Encoded = sterlang_xdr_operation:encode({Source, {payment, {Dest, Asset, Amount}}}),

  ?assert(is_binary(Encoded)),
  ?assertEqual(92, byte_size(Encoded)),

  <<EncodedSource:40/binary, EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertMatch(<<1:32, _/binary>>, EncodedSource),

  %% Unpack the actual account xdr without the first operation bit.
  <<_:32, SourceTest/binary>> = EncodedSource,
  ?assertEqual(sterlang_xdr_public_key:encode(Source), SourceTest),

  ?assertEqual(sterlang_xdr_operation_type:encode(payment), EncodedType),

  <<EncodedDest:36/binary, EncodedAsset:4/binary, EncodedAmount:8/binary>> = EncodedBody,

  ?assertEqual(sterlang_xdr_public_key:encode(Dest), EncodedDest),
  ?assertEqual(sterlang_xdr_asset_type:encode(native), EncodedAsset),
  ?assertEqual(<<Amount:64>>, EncodedAmount).
