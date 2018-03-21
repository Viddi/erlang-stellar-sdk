-module(sterlang_account_test).

-include_lib("eunit/include/eunit.hrl").

key_pair_test() ->
  KeyPair = sterlang_key_pair:from_secret(secret()),
  SequenceNumber = 1,

  Account = sterlang_account:make_account(KeyPair, SequenceNumber),

  ?assertEqual(KeyPair, sterlang_account:key_pair(Account)).

sequence_number_test() ->
  KeyPair = sterlang_key_pair:from_secret(secret()),
  SequenceNumber = 17,

  Account = sterlang_account:make_account(KeyPair, SequenceNumber),

  ?assertEqual(SequenceNumber, sterlang_account:sequence_number(Account)).

increment_sequence_number_test() ->
  KeyPair = sterlang_key_pair:from_secret(secret()),
  SequenceNumber = 17,

  Account = sterlang_account:make_account(KeyPair, SequenceNumber),
  Incremented = sterlang_account:increment_sequence_number(Account),

  ?assertEqual(18, sterlang_account:sequence_number(Incremented)).

secret() ->
  <<"SBJZFYAOGKAKCJDT3F5QH6XY4J3SFY7HX3XWYVJLGSVHCGQL6YFCILH3">>.
