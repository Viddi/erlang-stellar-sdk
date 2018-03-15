-module(sterlang_xdr_asset_test).

-include_lib("eunit/include/eunit.hrl").

encode_native_test() ->
  Encoded = sterlang_xdr_asset:encode({native, {undefined}}),

  ?assert(is_binary(Encoded)),
  ?assertEqual(4, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(<<0:32>>, EncodedType),
  ?assertEqual(<<>>, EncodedBody).
