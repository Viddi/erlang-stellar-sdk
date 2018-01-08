-module(sterlang_keypair).

-export([random/0, from_seed/1, make_keypair/1]).

-record(key_pair, {seed, private_key, public_key}).

random() ->
  Bytes = crypto:strong_rand_bytes(32),
  Seed = sterlang_keygen:seed_from_bytes(Bytes),
  make_keypair(Seed).

from_seed(Bytes) when is_binary(Bytes) and (byte_size(Bytes) =:= 32) ->
  Seed = sterlang_keygen:seed_from_bytes(Bytes),
  make_keypair(Seed).

make_keypair(Seed) when is_binary(Seed) ->
  PrivateKey = sterlang_keygen:bytes_from_base32_seed(Seed),
  PublicKey = sterlang_keygen:address_from_bytes(PrivateKey),

  #key_pair{seed = Seed,
          private_key = PrivateKey,
          public_key = binary_to_list(PublicKey)}.
