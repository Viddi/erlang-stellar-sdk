-module(sterlang_transaction).

-record(transaction, {source_account = undefined :: source_account(),
  time_bounds = undefined :: time_bounds(),
  memo = undefined :: memo(),
  operations = undefined :: operations()}).

-type source_account() :: undefined | sterlang_account:account().
-type time_bounds() :: undefined | non_neg_integer().
-type memo() :: undefined | bitstring(). %% TODO: Make Memo module
-type operations() :: undefined | list().

-opaque transaction() :: #transaction{}.

-export_type([transaction/0]).
-export_type([source_account/0, time_bounds/0, memo/0, operations/0]).
