-module(sterlang_response_self).

-behaviour(sterlang_response).

-export([encode/1, decode/1]).
-export([href/1]).

-record(response_self, {href = undefined :: href_type()}).

-opaque response_self() :: #response_self{}.

-type href_type() :: undefined | bitstring().

-export_type([response_self/0]).

-spec decode(map()) -> response_self().
decode(Self) ->
  Href = maps:get(<<"href">>, Self),
  #response_self{href = Href}.

-spec encode(response_self()) -> iodata().
encode(#response_self{} = Self) ->
  Map = #{<<"href">> => href(Self)},
  jiffy:encode(Map).

-spec href(response_self()) -> href_type().
href(#response_self{href = Href}) ->
  Href.
