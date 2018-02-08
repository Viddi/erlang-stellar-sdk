-module(sterlang_response_precedes).

-behaviour(sterlang_response).

-export([encode/1, decode/1, to_map/1]).
-export([href/1]).

-record(response_precedes, {href = undefined :: href_type()}).

-opaque response_precedes() :: #response_precedes{}.

-type href_type() :: undefined | bitstring().

-export_type([response_precedes/0]).

-spec decode(map()) -> response_precedes().
decode(Precedes) ->
  Href = maps:get(<<"href">>, Precedes),
  #response_precedes{href = Href}.

-spec encode(response_precedes()) -> iodata().
encode(#response_precedes{} = Precedes) ->
  Map = to_map(Precedes),
  jiffy:encode(Map).

-spec to_map(response_precedes()) -> map().
to_map(#response_precedes{} = Precedes) ->
  #{<<"href">> => href(Precedes)}.

-spec href(response_precedes()) -> href_type().
href(#response_precedes{href = Href}) ->
  Href.
