-module(sterlang_transaction).

-record(sterlang_transaction, {source_account = undefined :: undefined | sterlang_account:account(),
  time_bounds = undefined :: undefined | non_neg_integer(),
  memo = undefined :: undefined | bitstring(),
  operations = undefined :: undefined | list()}).
