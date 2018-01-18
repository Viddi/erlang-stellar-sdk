-module(sterlang_key_gen).

-export([seed_from_bytes/1, bytes_from_base32_seed/1, address_from_bytes/1]).

%%====================================================================
%% API functions
%%====================================================================

%% @doc Generates a 56 byte Base32 encoded binary from the given seed.
-spec seed_from_bytes(<<_:_*32>>) -> <<_:_*56>>.
seed_from_bytes(<<Payload:32/binary>>) ->
  Version = byte_seed(),
  Checksum = checksum(<<Version, Payload/binary>>),
  base32:encode(<<Version, Payload/binary, Checksum/binary>>).

%% @doc Retrieves the 'payload', or the 'raw bytes' that were used to generate
%% the given secret binary. Both the version byte and the checksum bytes are
%% verified if they are correct. If they are, then the 32 byte seed that was
%% used to generate the secret key is returned.
-spec bytes_from_base32_seed(<<_:_*56>>) -> <<_:_*32>>.
bytes_from_base32_seed(<<Base32Seed:56/binary>>) ->
  Decoded = base32:decode(Base32Seed),
  <<Version:8, Payload:32/binary, Checksum:2/binary>> = Decoded,

  ExpectedVersion = byte_seed(),
  ExpectedChecksum = checksum(<<Version, Payload/binary>>),

  if
    Version =/= ExpectedVersion ->
      throw(invalid_version_byte);
    Checksum =/= ExpectedChecksum ->
      throw(invalid_checksum);
    true ->
      Payload
  end.

%% @doc Generates and returns the 'address' or the 'public key' based
%% on the given 32 binary seed.
-spec address_from_bytes(<<_:_*32>>) -> <<_:_*56>>.
address_from_bytes(<<Payload:32/binary>>) ->
  Version = byte_account_id(),
  Checksum = checksum(<<Version, Payload/binary>>),
  base32:encode(<<Version, Payload/binary, Checksum/binary>>).

%%====================================================================
%% Internal functions
%%====================================================================
-spec byte_account_id() -> 48.
byte_account_id() ->
  6 bsl 3.

-spec byte_seed() -> 144.
byte_seed() ->
  18 bsl 3.

%% -spec byte_pre_auth_tx() -> 153.
%% byte_pre_auth_tx() ->
%%   19 bsl 3.
%%
%% -spec byte_sha256_hash() -> 184.
%% byte_sha256_hash() ->
%%   23 bsl 3.

-spec checksum(binary()) -> binary().
checksum(Binary) when is_binary(Binary) ->
  BinList = binary_to_list(Binary),
  binary:encode_unsigned(sterlang_crc16:ccitt(BinList), little).
