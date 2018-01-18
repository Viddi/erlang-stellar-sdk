-module(sterlang_key_gen_test).

-include_lib("eunit/include/eunit.hrl").

seed_from_bytes_test() ->
  Bytes = random_bytes(),
  Binary = sterlang_key_gen:seed_from_bytes(Bytes),

  ?assertEqual(56, byte_size(Binary)),
  ?assertMatch(<<"S", _/binary>>, Binary).

bytes_from_base32_seed_test() ->
  Bytes = random_bytes(),
  KeyPair = sterlang_key_pair:from_bytes(Bytes),
  Secret = sterlang_key_pair:secret(KeyPair),
  Payload = sterlang_key_gen:bytes_from_base32_seed(Secret),

  ?assertEqual(32, byte_size(Payload)),
  ?assertEqual(Bytes, Payload).

bytes_from_base32_seed_invalid_version_test() ->
  Bytes = random_bytes(),
  Seed = sterlang_key_gen:seed_from_bytes(Bytes),
  <<"S", Rest/binary>> = Seed,
  TestBinary = <<"Z", Rest/binary>>, %% Fake the first byte to trigger the error.

  ?assertThrow(invalid_version_byte, sterlang_key_gen:bytes_from_base32_seed(TestBinary)).

bytes_from_base32_seed_invalid_checksum_test() ->
  Bytes = random_bytes(),
  Seed = sterlang_key_gen:seed_from_bytes(Bytes),
  <<Head:54/binary, _/binary>> = Seed,
  TestBinary = <<Head/binary, "X", "Z">>, %% Some random 2-byte checksum to trigger the error.

  ?assertThrow(invalid_checksum, sterlang_key_gen:bytes_from_base32_seed(TestBinary)).

address_from_bytes_test() ->
  Bytes = random_bytes(),
  Address = sterlang_key_gen:address_from_bytes(Bytes),

  ?assertEqual(56, byte_size(Address)),
  ?assertMatch(<<"G", _/binary>>, Address).

random_bytes() ->
  crypto:strong_rand_bytes(32).
