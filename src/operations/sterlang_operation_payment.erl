-module(sterlang_operation_payment).

-behaviour(sterlang_operation).

-export([make_operation/4, to_xdr/1]).

-record(operation_payment, {source_account = undefined :: account(),
  destination = undefined :: account(),
  asset = undefined, %% TODO: Add Asset module
  amount = undefined :: amount()}).

-type account() :: undefined | sterlang_key_pair:key_pair().
-type amount() :: undefined | non_neg_integer().

-opaque operation_payment() :: #operation_payment{}.

-export_type([account/0, amount/0]).
-export_type([operation_payment/0]).

make_operation(Source, Destination, Asset, Amount) ->
  #operation_payment{source_account = Source, destination = Destination,
    asset = Asset, amount = Amount}.

-spec to_xdr(operation_payment()) -> binary().
to_xdr(#operation_payment{source_account = Source, destination = Destination,
  asset = Asset, amount = Amount}) ->
  sterlang_operation:to_xdr(Source, {payment, {Destination, Asset, Amount}}).
