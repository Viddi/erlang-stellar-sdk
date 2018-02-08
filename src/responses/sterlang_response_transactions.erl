-module(sterlang_response_transactions).

-behaviour(sterlang_response).

-export([encode/1, decode/1, to_map/1]).
-export([href/1]).

-record(response_transactions, {href = undefined :: href_type()}).

-opaque response_transactions() :: #response_transactions{}.

-type href_type() :: undefined | bitstring().

-export_type([response_transactions/0]).

-spec decode(map()) -> response_transactions().
decode(Transactions) ->
  Href = maps:get(<<"href">>, Transactions),
  #response_transactions{href = Href}.

-spec encode(response_transactions()) -> iodata().
encode(#response_transactions{} = Transactions) ->
  Map = to_map(Transactions),
  jiffy:encode(Map).

-spec to_map(response_transactions()) -> map().
to_map(#response_transactions{} = Transactions) ->
  #{<<"href">> => href(Transactions)}.

-spec href(response_transactions()) -> href_type().
href(#response_transactions{href = Href}) ->
  Href.
