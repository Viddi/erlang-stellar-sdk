-module(sterlang_response_links).

-behaviour(sterlang_response).

-export([encode/1, decode/1]).

-record(response_links, {effects = undefined :: sterlang_response_effects:response_effects(),
                         precedes = undefined :: sterlang_response_precedes:response_precedes(),
                         self = undefined :: sterlang_response_self:response_self(),
                         succeeds = undefined :: sterlang_response_succeeds:response_succeeds(),
                         transactions = undefined :: sterlang_response_transactions:response_transactions()}).

-opaque response_links() :: #response_links{}.

-export_type([response_links/0]).

decode(Links) ->
  Effects = sterlang_response_effects:decode(maps:get(<<"effects">>, Links)),
  Precedes = sterlang_response_precedes:decode(maps:get(<<"precedes">>, Links)),
  Self = sterlang_response_self:decode(maps:get(<<"self">>, Links)),
  Succeeds = sterlang_response_succeeds:decode(maps:get(<<"succeeds">>, Links)),
  Transactions = sterlang_response_transactions:decode(maps:get(<<"transactions">>, Links)),

  #response_links{effects = Effects, precedes = Precedes, self = Self,
                 succeeds = Succeeds, transactions = Transactions}.

encode(#response_links{} = Links) ->
  ok.
