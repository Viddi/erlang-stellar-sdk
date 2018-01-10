-module(sterlang_key_pair).

-export([random/0, from_seed/1, secret/1, private_key/1, public_key/1]).

-record(key_pair, {seed = undefined :: undefined | bitstring(),
                   private_key = undefined :: undefined | binary(),
                   public_key = undefined :: undefined | string()}).

-opaque key_pair() :: #key_pair{}.

-export_type([key_pair/0]).

%%====================================================================
%% API functions
%%====================================================================
random() ->
  Bytes = crypto:strong_rand_bytes(32),
  from_seed(Bytes).

from_seed(Bytes) when is_binary(Bytes) and (byte_size(Bytes) =:= 32) ->
  Seed = sterlang_key_gen:seed_from_bytes(Bytes),
  make_keypair(Seed);

%% Binary seed
from_seed(<<"S", _/binary>> = Seed) when is_binary(Seed) and (byte_size(Seed) =:= 56) ->
  make_keypair(Seed).

secret(#key_pair{seed = Seed}) ->
  Seed.

private_key(#key_pair{private_key = PrivateKey}) ->
  PrivateKey.

public_key(#key_pair{public_key = PublicKey}) ->
  PublicKey.

%%====================================================================
%% Internal functions
%%====================================================================
make_keypair(Seed) when is_binary(Seed) ->
  PrivateKey = sterlang_key_gen:bytes_from_base32_seed(Seed),
  PublicKey = sterlang_key_gen:address_from_bytes(PrivateKey),

  #key_pair{seed = Seed,
          private_key = PrivateKey,
          public_key = binary_to_list(PublicKey)}.
