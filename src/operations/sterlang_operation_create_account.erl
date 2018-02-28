-module(sterlang_operation_create_account).

-behavior(sterlang_operation).

-export([make_operation/3]).
-export([to_xdr/1]).

-record(operation_create_account, {source_account = undefined :: undefined | sterlang_key_pair:key_pair(),
  destination = undefined :: undefined | sterlang_key_pair:key_pair(),
  starting_balance = undefined :: undefined | non_neg_integer()}).

-opaque operation_create_account() :: #operation_create_account{}.

-export_type([operation_create_account/0]).

-spec make_operation(sterlang_key_pair:key_pair(), sterlang_key_pair:key_pair(), non_neg_integer())
      -> operation_create_account().
make_operation(Source, Dest, Balance) ->
  #operation_create_account{source_account = Source, destination = Dest, starting_balance = Balance}.

-spec to_xdr(operation_create_account()) -> binary().
to_xdr(#operation_create_account{source_account = Source, destination = Dest,
  starting_balance = StartingBalance}) ->
  XdrDestination = sterlang_key_pair:xdr_public_key(Dest), %% AccountID
  CreateAccountOp = {XdrDestination, StartingBalance},
  OperationBody = {'CREATE_ACCOUNT', CreateAccountOp},
  sterlang_operation:to_xdr(Source, OperationBody).
