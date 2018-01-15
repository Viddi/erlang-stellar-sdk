-module(sterlang_key_pair_test).

-include_lib("eunit/include/eunit.hrl").

secret_test() ->
  KeyPair = sterlang_key_pair:random(),
  Secret = sterlang_key_pair:secret(KeyPair),

  ?assert(is_binary(Secret)),
  ?assertEqual(byte_size(Secret), 56),
  ?assertMatch(<<"S", _/binary>>, Secret).

private_key_test() ->
  Bytes = crypto:strong_rand_bytes(32),
  KeyPair = sterlang_key_pair:from_bytes(Bytes),
  PrivateKey = sterlang_key_pair:private_key(KeyPair),

  ?assert(is_binary(PrivateKey)),
  ?assertEqual(byte_size(PrivateKey), 32),
  ?assertEqual(PrivateKey, Bytes).

public_key_test() ->
  Secret = sterlang_key_pair:secret(sterlang_key_pair:random()),
  KeyPair = sterlang_key_pair:from_secret(Secret),
  PublicKey = sterlang_key_pair:public_key(KeyPair),
  PublicKeyBinary = list_to_binary(PublicKey),

  ?assertEqual(Secret, sterlang_key_pair:secret(KeyPair)),
  ?assert(is_list(PublicKey)),
  ?assertEqual(56, string:length(PublicKey)),
  ?assertEqual(56, byte_size(PublicKeyBinary)),
  ?assertMatch(<<"G", _/binary>>, PublicKeyBinary).
