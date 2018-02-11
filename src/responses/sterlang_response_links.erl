-module(sterlang_response_links).

-behaviour(sterlang_response).

-export([encode/1, decode/1, to_map/1]).
-export([effects/1, precedes/1, self/1, succeeds/1, transactions/1]).

-record(response_links, {effects = undefined :: sterlang_response_effects:response_effects(),
                         precedes = undefined :: sterlang_response_precedes:response_precedes(),
                         self = undefined :: sterlang_response_self:response_self(),
                         succeeds = undefined :: sterlang_response_succeeds:response_succeeds(),
                         transactions = undefined :: sterlang_response_transactions:response_transactions()}).

-opaque response_links() :: #response_links{}.

-export_type([response_links/0]).

-spec decode(map()) -> response_links().
decode(Links) ->
  Effects = sterlang_response_effects:decode(maps:get(<<"effects">>, Links)),
  Precedes = sterlang_response_precedes:decode(maps:get(<<"precedes">>, Links)),
  Self = sterlang_response_self:decode(maps:get(<<"self">>, Links)),
  Succeeds = sterlang_response_succeeds:decode(maps:get(<<"succeeds">>, Links)),
  Transactions = sterlang_response_transactions:decode(maps:get(<<"transactions">>, Links)),

  #response_links{effects = Effects, precedes = Precedes, self = Self,
                 succeeds = Succeeds, transactions = Transactions}.

-spec encode(response_links()) -> iodata().
encode(#response_links{} = Links) ->
  Map = to_map(Links),
  jiffy:encode(Map).

-spec to_map(response_links()) -> map().
to_map(#response_links{} = Links) ->
  #{<<"effects">> => sterlang_response_effects:to_map(effects(Links)),
    <<"precedes">> => sterlang_response_precedes:to_map(precedes(Links)),
    <<"self">> => sterlang_response_self:to_map(self(Links)),
    <<"succeeds">> => sterlang_response_succeeds:to_map(succeeds(Links)),
    <<"transactions">> => sterlang_response_transactions:to_map(transactions(Links))}.

-spec effects(response_links()) -> sterlang_response_effects:response_effects().
effects(#response_links{effects = Effects}) ->
  Effects.

-spec precedes(response_links()) -> sterlang_response_precedes:response_precedes().
precedes(#response_links{precedes = Precedes}) ->
  Precedes.

-spec self(response_links()) -> sterlang_response_self:response_self().
self(#response_links{self = Self}) ->
  Self.

-spec succeeds(response_links()) -> sterlang_response_succeeds:response_succeeds().
succeeds(#response_links{succeeds = Succeeds}) ->
  Succeeds.

-spec transactions(response_links()) -> sterlang_response_transactions:response_transactions().
transactions(#response_links{transactions = Transactions}) ->
  Transactions.
