-module(sterlang_xdr_asset_type_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  ?assertEqual(<<0:32>>, sterlang_xdr_asset_type:encode(native)),
  ?assertEqual(<<1:32>>, sterlang_xdr_asset_type:encode(credit_alphanum4)),
  ?assertEqual(<<2:32>>, sterlang_xdr_asset_type:encode(credit_alphanum12)),
  ?assertThrow(invalid_type, sterlang_xdr_asset_type:encode(test)).
