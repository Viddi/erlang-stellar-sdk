-module(sterlang_key_pair).

-export([random/0, from_bytes/1, from_secret/1, secret/1, private_key/1, public_key/1]).
-export([xdr_public_key/1]).

-record(key_pair, {seed = undefined :: undefined | bitstring(),
  private_key = undefined :: undefined | binary(),
  public_key = undefined :: undefined | bitstring()}).

-opaque key_pair() :: #key_pair{}.

-export_type([key_pair/0]).

%%====================================================================
%% API functions
%%====================================================================

%% @doc Generates a new key pair with random 32 bytes.
-spec random() -> key_pair().
random() ->
  Bytes = crypto:strong_rand_bytes(32),
  from_bytes(Bytes).

%% @doc Generates a new key pair with the given 32 bytes. This is the same as
%% random/1 only with predefined generated bytes.
-spec from_bytes(<<_:_*32>>) -> key_pair().
from_bytes(<<Bytes:32/binary>>) ->
  Seed = sterlang_key_gen:seed_from_bytes(Bytes),
  make_key_pair(Seed).

%% @doc Generates a key pair with the given secret key.
-spec from_secret(<<_:_*56>>) -> key_pair().
from_secret(<<"S", _:55/binary>> = Seed) ->
  make_key_pair(Seed).

%% @doc Retrieves the secret for the given key pair.
-spec secret(key_pair()) -> binary().
secret(#key_pair{seed = Seed}) ->
  Seed.

%% @doc Retrieves the private key for the given key pair.
-spec private_key(key_pair()) -> binary().
private_key(#key_pair{private_key = PrivateKey}) ->
  PrivateKey.

%% @doc Retrieves the public key for the given key pair.
%% This key is the same as an account id.
-spec public_key(key_pair()) -> binary().
public_key(#key_pair{public_key = PublicKey}) ->
  PublicKey.

%% @doc Converts the public key for the given key pair to an Xdr tuple.
-spec xdr_public_key(key_pair()) -> binary().
xdr_public_key(#key_pair{} = KeyPair) ->
  sterlang_xdr_public_key:encode(KeyPair).

%%====================================================================
%% Internal functions
%%====================================================================
-spec make_key_pair(<<_:_*56>>) -> key_pair().
make_key_pair(<<"S", _:55/binary>> = Seed) ->
  PrivateKey = sterlang_key_gen:bytes_from_base32_seed(Seed),
  PublicKey = sterlang_key_gen:address_from_bytes(PrivateKey),

  #key_pair{seed = Seed, private_key = PrivateKey, public_key = PublicKey}.
