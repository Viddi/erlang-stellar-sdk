-module(sterlang_account).

-export([make_account/2, key_pair/1, sequence_number/1, increment_sequence_number/1]).

-record(account, {key_pair = undefined :: undefined | sterlang_key_pair:key_pair(),
  sequence_number = undefined :: undefineded | non_neg_integer()}).

-opaque account() :: #account{}.

-export_type([account/0]).

-spec make_account(sterlang_key_pair:key_pair(), non_neg_integer()) -> account().
make_account(KeyPair, SequenceNumber) ->
  #account{key_pair = KeyPair, sequence_number = SequenceNumber}.

-spec key_pair(account()) -> sterlang_key_pair:key_pair().
key_pair(#account{key_pair = KeyPair}) ->
  KeyPair.

-spec sequence_number(account()) -> non_neg_integer().
sequence_number(#account{sequence_number = SequenceNumber}) ->
  SequenceNumber.

-spec increment_sequence_number(account()) -> account().
increment_sequence_number(#account{sequence_number = SequenceNumber} = Account) ->
  Account#account{sequence_number = SequenceNumber + 1}.
