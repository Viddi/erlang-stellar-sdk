-module(sterlang_xdr_public_key_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  KeyPair = key_pair(),

  Binary = sterlang_xdr_public_key:encode(KeyPair),

  ?assertEqual(36, byte_size(Binary)),

  <<TypeBinary:4/binary, _:32/binary>> = Binary,

  ?assertEqual(TypeBinary, sterlang_xdr_public_key_type:encode(public_key_type_ed25519)).

key_pair() ->
  sterlang_key_pair:random().
