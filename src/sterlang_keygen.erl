-module(sterlang_keygen).

-export([seed_from_bytes/1]).

%%====================================================================
%% API functions
%%====================================================================
seed_from_bytes(Payload) when is_binary(Payload) and (byte_size(Payload) =:= 32) ->
  Version = byte_seed(),
  Checksum = checksum(<<Version, Payload/binary>>),
  base32:encode(<<Version, Payload/binary, Checksum/binary>>).

bytes_from_base32_seed(Base32Seed) when is_binary(Base32Seed) ->
  Decoded = base32:decode(Base32Seed),
  <<Version:8, Payload:256, Checksum:16>> = Decoded,

  ExpectedVersion = byte_seed(),
  ExpectedChecksum = checksum(<<Version, Payload>>),

  if
    Version =/= ExpectedVersion ->
      throw(invalid_seed);
    Checksum =/= ExpectedChecksum ->
      throw(invalid_checksum);
    true ->
      Payload
  end.


%%====================================================================
%% Internal functions
%%====================================================================
byte_account_id() ->
  6 bsl 3.

byte_seed() ->
  18 bsl 3.

byte_pre_auth_tx() ->
  19 bsl 3.

byte_sha256_hash() ->
  23 bsl 3.

checksum(Binary) when is_binary(Binary) ->
  BinList = binary_to_list(Binary),
  binary:encode_unsigned(sterlang_crc16:ccitt(BinList)).
