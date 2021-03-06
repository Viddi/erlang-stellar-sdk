-module(sterlang_key_pair_test).

-include_lib("eunit/include/eunit.hrl").

secret_test() ->
  KeyPair = sterlang_key_pair:from_secret(secret()),
  Secret = sterlang_key_pair:secret(KeyPair),

  ?assert(is_binary(Secret)),
  ?assertEqual(byte_size(Secret), 56),
  ?assertMatch(<<"S", _/binary>>, Secret).

private_key_test() ->
  Bytes = <<62, 203, 88, 243, 73, 97, 157, 53, 140, 46, 49, 178, 246, 147, 121, 184, 245, 137, 85,
    16, 37, 219, 59, 241, 169, 118, 91, 114, 230, 187, 92, 18>>,
  KeyPair = sterlang_key_pair:from_bytes(Bytes),
  PrivateKey = sterlang_key_pair:private_key(KeyPair),

  ?assert(is_binary(PrivateKey)),
  ?assertEqual(byte_size(PrivateKey), 32),
  ?assertEqual(PrivateKey, Bytes).

public_key_test() ->
  Secret = <<"SCDJ5HX5HFSIPIDYRAHEA7ZXBF2QE2SSRFRPC5IBYOIPRCNB2FANBWIT">>,
  KeyPair = sterlang_key_pair:from_secret(Secret),
  PublicKey = sterlang_key_pair:public_key(KeyPair),

  ?assertEqual(Secret, sterlang_key_pair:secret(KeyPair)),
  ?assert(is_binary(PublicKey)),
  ?assertEqual(56, string:length(PublicKey)),
  ?assertEqual(56, byte_size(PublicKey)),
  ?assertMatch(<<"G", _/binary>>, PublicKey).

key_equality_test() ->
  KeyPair = sterlang_key_pair:from_secret(secret()),

  Secret = sterlang_key_pair:secret(KeyPair),
  PublicKey = sterlang_key_pair:public_key(KeyPair),

  %% Make sure the payload is not the same in the secret and the public key.
  <<"S", SecretPayload:32/binary, _/binary>> = Secret,
  <<"G", PublicPayload:32/binary, _/binary>> = PublicKey,

  ?assertNotEqual(SecretPayload, PublicPayload).

to_xdr_test() ->
  KeyPair = sterlang_key_pair:from_secret(secret()),
  Xdr = sterlang_key_pair:to_xdr(KeyPair),

  ?assert(is_binary(Xdr)),
  ?assertEqual(36, byte_size(Xdr)).

secret() ->
  <<"SBJZFYAOGKAKCJDT3F5QH6XY4J3SFY7HX3XWYVJLGSVHCGQL6YFCILH3">>.
