-module(sterlang_response_self_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Self = sterlang_response_self:decode(self_map()),
  Encoded = sterlang_response_self:encode(Self),

  Test = <<"{\"href\":\"/operations/402494270214144\"}">>,
  ?assertEqual(Test, Encoded).

decode_test() ->
  Self = sterlang_response_self:decode(self_map()),

  ?assertEqual(<<"/operations/402494270214144">>, sterlang_response_self:href(Self)).

to_map_test() ->
  Self = sterlang_response_self:decode(self_map()),
  Map = sterlang_response_self:to_map(Self),

  ?assertEqual(self_map(), Map).

self_map() ->
  #{<<"href">> => <<"/operations/402494270214144">>}.
