-module(sterlang_response_succeeds).

-behaviour(sterlang_response).

-export([encode/1, decode/1]).
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
  Map = #{<<"href">> => href(Succeeds)},
  jiffy:encode(Map).

-spec href(response_succeeds()) -> href_type().
href(#response_succeeds{href = Href}) ->
  Href.
