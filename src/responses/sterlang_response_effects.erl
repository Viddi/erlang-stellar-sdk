-module(sterlang_response_effects).

-behaviour(sterlang_response).

-export([encode/1, decode/1]).
-export([href/1, templated/1]).

-record(response_effects, {href = undefined :: href_type(),
                       templated = undefined :: templated_type()}).

-opaque response_effects() :: #response_effects{}.
-opaque href_type() :: undefined | bitstring().
-opaque templated_type() :: undefined | true | false.

-export_type([response_effects/0]).

-spec decode(map()) -> response_effects().
decode(Effect) ->
  Href = maps:get(<<"href">>, Effect),
  Templated = maps:get(<<"templated">>, Effect),
  
  #response_effects{href = Href, templated = Templated}.

-spec encode(response_effects()) -> iodata().
encode(#response_effects{} = Effect) ->
  Map = #{<<"href">> => href(Effect), <<"templated">> => templated(Effect)},
  jiffy:encode(Map).

-spec href(response_effects()) -> href_type().
href(#response_effects{href = Href}) ->
  Href.

-spec templated(response_effects()) -> templated_type().
templated(#response_effects{templated = Templated}) ->
  Templated.
