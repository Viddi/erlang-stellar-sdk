-module(sterlang_operation_payment).

-behaviour(sterlang_operation).

-export([make_operation/4, to_xdr/1]).

-record(operation_payment, {source_account = undefined :: account(),
  destination = undefined :: account(),
  asset = undefined :: asset(),
  amount = undefined :: amount()}).

-type account() :: undefined | sterlang_key_pair:key_pair().
-type asset() :: undefined | sterlang_asset_native:asset_native(). %% TODO: Add other Asset types
-type amount() :: undefined | non_neg_integer().

%% sterlang_xdr_asset needs this type for its encode/1 function
-type operation_payment() :: #operation_payment{}.

make_operation(Source, Destination, Asset, Amount) ->
  #operation_payment{source_account = Source, destination = Destination,
    asset = Asset, amount = Amount}.

-spec to_xdr(operation_payment()) -> binary().
to_xdr(#operation_payment{source_account = Source, destination = Destination,
  asset = Asset, amount = Amount}) ->
  sterlang_operation:to_xdr(Source, {payment, {Destination, Asset, Amount}}).
