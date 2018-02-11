-module(sterlang_response_succeeds_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Succeeds = sterlang_response_succeeds:decode(succeeds_map()),
  Encoded = sterlang_response_succeeds:encode(Succeeds),

  Test = <<"{\"href\":\"/operations?cursor=402494270214144&order=desc\"}">>,
  ?assertEqual(Test, Encoded).

decode_test() ->
  Succeeds = sterlang_response_succeeds:decode(succeeds_map()),

  ?assertEqual(<<"/operations?cursor=402494270214144&order=desc">>,
               sterlang_response_succeeds:href(Succeeds)).

to_map_test() ->
  Succeeds = sterlang_response_succeeds:decode(succeeds_map()),
  Map = sterlang_response_succeeds:to_map(Succeeds),

  ?assertEqual(succeeds_map(), Map).

succeeds_map() ->
  #{<<"href">> => <<"/operations?cursor=402494270214144&order=desc">>}.
