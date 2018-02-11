-module(sterlang_response_succeeds).

-behaviour(sterlang_response).

-export([encode/1, decode/1, to_map/1]).
-export([href/1]).

-record(response_succeeds, {href = undefined :: href_type()}).

-opaque response_succeeds() :: #response_succeeds{}.

-type href_type() :: undefined | bitstring().

-export_type([response_succeeds/0]).

-spec decode(map()) -> response_succeeds().
decode(Succeeds) ->
  Href = maps:get(<<"href">>, Succeeds),
  #response_succeeds{href = Href}.

-spec encode(response_succeeds()) -> iodata().
encode(#response_succeeds{} = Succeeds) ->
  Map = to_map(Succeeds),
  jiffy:encode(Map).

-spec to_map(response_succeeds()) -> map().
to_map(#response_succeeds{} = Succeeds) ->
  #{<<"href">> => href(Succeeds)}.

-spec href(response_succeeds()) -> href_type().
href(#response_succeeds{href = Href}) ->
  Href.
