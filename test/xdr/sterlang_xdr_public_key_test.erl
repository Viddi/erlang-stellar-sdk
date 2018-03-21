-module(sterlang_xdr_public_key_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  KeyPair = sterlang_key_pair:from_secret(<<"SAKTJLVMQTB3ALEN27CTBUUPSJHRPNJ44SZEDSOII44CJ76K2CRLCSDT">>),
  Binary = sterlang_xdr_public_key:encode(KeyPair),

  ?assertEqual(36, byte_size(Binary)),

  <<TypeBinary:4/binary, _:32/binary>> = Binary,
  ?assertEqual(TypeBinary, sterlang_xdr_public_key_type:encode(public_key_type_ed25519)).
