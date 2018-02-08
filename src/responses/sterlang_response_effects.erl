-module(sterlang_response_effects).

-behaviour(sterlang_response).

-export([encode/1, decode/1, to_map/1]).
-export([href/1, templated/1]).

-record(response_effects, {href = undefined :: href_type(),
                       templated = undefined :: templated_type()}).

-opaque response_effects() :: #response_effects{}.

-type href_type() :: undefined | bitstring().
-type templated_type() :: undefined | true | false.

-export_type([response_effects/0]).

-spec decode(map()) -> response_effects().
decode(Effects) ->
  Href = maps:get(<<"href">>, Effects),
  Templated = maps:get(<<"templated">>, Effects),
  
  #response_effects{href = Href, templated = Templated}.

-spec encode(response_effects()) -> iodata().
encode(#response_effects{} = Effects) ->
  Map = to_map(Effects),
  jiffy:encode(Map).

-spec to_map(response_effects()) -> map().
to_map(#response_effects{} = Effects) ->
  #{<<"href">> => href(Effects), <<"templated">> => templated(Effects)}.

-spec href(response_effects()) -> href_type().
href(#response_effects{href = Href}) ->
  Href.

-spec templated(response_effects()) -> templated_type().
templated(#response_effects{templated = Templated}) ->
  Templated.
