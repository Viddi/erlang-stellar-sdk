-module(sterlang_key_pair).

-export([random/0, from_bytes/1, from_seed/1, secret/1, private_key/1, public_key/1]).

-record(key_pair, {seed = undefined :: undefined | bitstring(),
                   private_key = undefined :: undefined | binary(),
                   public_key = undefined :: undefined | string()}).

-opaque key_pair() :: #key_pair{}.

-export_type([key_pair/0]).

%%====================================================================
%% API functions
%%====================================================================
-spec random() -> key_pair().
random() ->
  Bytes = crypto:strong_rand_bytes(32),
  from_bytes(Bytes).

-spec from_bytes(<<_:_*32>>) -> key_pair().
from_bytes(<<Bytes:32/binary>>) ->
  Seed = sterlang_key_gen:seed_from_bytes(Bytes),
  make_key_pair(Seed).

%% Binary seed
-spec from_seed(<<_:_*56>>) -> key_pair().
from_seed(<<"S", _:55/binary>> = Seed) ->
  make_key_pair(Seed).

-spec secret(key_pair()) -> binary().
secret(#key_pair{seed = Seed}) ->
  Seed.

-spec private_key(key_pair()) -> binary().
private_key(#key_pair{private_key = PrivateKey}) ->
  PrivateKey.

-spec public_key(key_pair()) -> list().
public_key(#key_pair{public_key = PublicKey}) ->
  PublicKey.

%%====================================================================
%% Internal functions
%%====================================================================
-spec make_key_pair(binary()) -> key_pair().
make_key_pair(<<"S", _:55/binary>> = Seed) ->
  PrivateKey = sterlang_key_gen:bytes_from_base32_seed(Seed),
  PublicKey = sterlang_key_gen:address_from_bytes(PrivateKey),

  #key_pair{seed = Seed,
          private_key = PrivateKey,
          public_key = binary_to_list(PublicKey)}.
