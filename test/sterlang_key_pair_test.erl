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

  ?assertEqual(Secret, sterlang_key_pair:secret(KeyPair)),
  ?assert(is_binary(PublicKey)),
  ?assertEqual(56, string:length(PublicKey)),
  ?assertEqual(56, byte_size(PublicKey)),
  ?assertMatch(<<"G", _/binary>>, PublicKey).

key_equality_test() ->
  KeyPair = sterlang_key_pair:random(),

  Secret = sterlang_key_pair:secret(KeyPair),
  PublicKey = sterlang_key_pair:public_key(KeyPair),

  %% Make sure the payload is not the same in the secret and the public key.
  <<"S", SecretPayload:32/binary, _/binary>> = Secret,
  <<"G", PublicPayload:32/binary, _/binary>> = PublicKey,

  ?assertNotEqual(SecretPayload, PublicPayload).
