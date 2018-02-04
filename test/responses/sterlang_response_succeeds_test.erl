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

succeeds_map() ->
  #{<<"href">> => <<"/operations?cursor=402494270214144&order=desc">>}.
