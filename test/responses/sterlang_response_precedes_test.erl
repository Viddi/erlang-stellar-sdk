-module(sterlang_response_precedes_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Precedes = sterlang_response_precedes:decode(precedes_map()),
  Encoded = sterlang_response_precedes:encode(Precedes),

  Test = <<"{\"href\":\"/operations?cursor=402494270214144&order=asc\"}">>,
  ?assertEqual(Test, Encoded).

decode_test() ->
  Precedes = sterlang_response_precedes:decode(precedes_map()),

  ?assertEqual(<<"/operations?cursor=402494270214144&order=asc">>,
               sterlang_response_precedes:href(Precedes)).

to_map_test() ->
  Precedes = sterlang_response_precedes:decode(precedes_map()),
  Map = sterlang_response_precedes:to_map(Precedes),

  ?assertEqual(precedes_map(), Map).

precedes_map() ->
  #{<<"href">> => <<"/operations?cursor=402494270214144&order=asc">>}.
