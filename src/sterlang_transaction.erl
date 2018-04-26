-module(sterlang_transaction).

-export([make_transaction/4, source_account/1, time_bounds/1, memo/1, operations/1, fee/1]).

-define(BASE_FEE, 100).

-record(transaction, {source_account = undefined :: source_account(),
  time_bounds = undefined :: time_bounds(),
  memo = undefined :: memo(),
  operations = undefined :: operations(),
  fee = undefined :: non_neg_integer(),
  sequence_number = undefined :: non_neg_integer()}).

-type source_account() :: undefined | sterlang_account:account().
-type time_bounds() :: undefined | non_neg_integer().
-type memo() :: undefined | sterlang_memo_none:memo_none() | sterlang_memo_hash:memo_hash()
  | sterlang_memo_id:memo_id() | sterlang_memo_return:memo_return() | sterlang_memo_text:memo_text().
-type operations() :: undefined | [sterlang_operation_create_account:operation_create_account() |
  sterlang_operation_payment:operation_payment()].

-opaque transaction() :: #transaction{}.

-export_type([transaction/0]).
-export_type([source_account/0, time_bounds/0, memo/0, operations/0]).

-spec make_transaction(source_account(), time_bounds(), memo(), operations()) -> transaction().
make_transaction(Source, TimeBounds, Memo, Operations) ->
  Fee = length(Operations) * ?BASE_FEE,

  Transaction = #transaction{source_account = Source,
    time_bounds = TimeBounds,
    memo = Memo,
    operations = Operations,
    fee = Fee,
    sequence_number = sterlang_account:sequence_number(Source)},

  %% Increment sequence number if there are no erros.
  sterlang_account:increment_sequence_number(Source),

  Transaction.

-spec source_account(transaction()) -> source_account().
source_account(#transaction{source_account = Source}) ->
  Source.

-spec time_bounds(transaction()) -> time_bounds().
time_bounds(#transaction{time_bounds = TimeBounds}) ->
  TimeBounds.

-spec memo(transaction()) -> memo().
memo(#transaction{memo = Memo}) ->
  Memo.

-spec operations(transaction()) -> operations().
operations(#transaction{operations = Operations}) ->
  Operations.

-spec fee(transaction()) -> non_neg_integer().
fee(#transaction{fee = Fee}) ->
  Fee.
