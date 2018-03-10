-module(sterlang_operation_create_account).

-behavior(sterlang_operation).

-export([make_operation/3, source_account/1, destination/1, starting_balance/1]).
-export([to_xdr/1]).

-record(operation_create_account, {source_account = undefined :: account(),
  destination = undefined :: account(),
  starting_balance = undefined :: starting_balance()}).

-type account() :: undefined | sterlang_key_pair:key_pair().
-type starting_balance() :: undefined | non_neg_integer().

-opaque operation_create_account() :: #operation_create_account{}.

-export_type([account/0]).
-export_type([operation_create_account/0]).
-export_type([starting_balance/0]).

-spec make_operation(account(), account(), starting_balance()) -> operation_create_account().
make_operation(Source, Destination, Balance) ->
  #operation_create_account{source_account = Source, destination = Destination,
    starting_balance = Balance}.

-spec source_account(operation_create_account()) -> account().
source_account(#operation_create_account{source_account = Source}) ->
  Source.

-spec destination(operation_create_account()) -> account().
destination(#operation_create_account{destination = Destination}) ->
  Destination.

-spec starting_balance(operation_create_account()) -> starting_balance().
starting_balance(#operation_create_account{starting_balance = StartingBalance}) ->
  StartingBalance.

-spec to_xdr(operation_create_account()) -> binary().
to_xdr(#operation_create_account{source_account = Source, destination = Destination,
  starting_balance = StartingBalance}) ->
  sterlang_operation:to_xdr(Source, {create_account, {Destination, StartingBalance}}).
