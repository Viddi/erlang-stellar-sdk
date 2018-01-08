-module(sterlang_keypair).

-record(keypair, {seed, private_key, public_key}).

random() ->
  Bytes = crypto:strong_rand_bytes(32),
  Seed = sterlang_keygen:seed_from_bytes(Bytes),
  make_keypair(Seed).

random(Bytes) when is_binary and (byte_size(Bytes) =:= 32) ->
  Seed = sterlang_keygen:seed_from_bytes(Bytes),
  make_keypair(Seed).

make_keypair(Seed) when is_binary(Seed) ->
  PrivateKey = sterlang_keygen:bytes_from_base32_seed(Seed),

  #keypair{seed = Seed,
          private_key = PrivateKey}.
