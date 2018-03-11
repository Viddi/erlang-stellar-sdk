-module(sterlang_xdr_public_key_type_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Type = public_key_type_ed25519,

  ?assertEqual(<<0:32>>, sterlang_xdr_public_key_type:encode(Type)),
  ?assertThrow(invalid_type, sterlang_xdr_public_key_type:encode(test)).
