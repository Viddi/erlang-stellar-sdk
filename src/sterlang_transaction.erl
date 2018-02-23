-module(sterlang_transaction).

-record(sterlang_transaction, {source_account = undefined :: undefined | sterlang_account:account(),
  memo = undefined :: undefined | bitstring(),
  operations = undefined :: undefined | list()}).
