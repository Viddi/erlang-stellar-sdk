-module(sterlang_xdr_public_key_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  KeyPair = key_pair(),
  PublicKey = sterlang_key_pair:public_key(KeyPair),
  Decoded = base32:decode(PublicKey),
  Type = public_key_type_ed25519,
  <<_Version:8, Payload:32/binary, _Checksum:2/binary>> = Decoded,

  Input = {Type, Payload},
  Binary = sterlang_xdr_public_key:encode(Input),

  ?assertEqual(36, byte_size(Binary)),

  <<TypeBinary:4/binary, PublicKeyBinary:32/binary>> = Binary,

  ?assertEqual(TypeBinary, sterlang_xdr_public_key_type:encode(Type)),
  ?assertEqual(PublicKeyBinary, Payload).

key_pair() ->
  sterlang_key_pair:random().
