-module(sterlang_xdr_create_account_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Input = {public_key(), 1000},
  ok.

public_key() ->
  KeyPair = sterlang_key_pair:random(),
  sterlang_key_pair:xdr_public_key(KeyPair).
