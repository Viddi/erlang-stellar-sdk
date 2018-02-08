-module(sterlang_response_effects_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Effects = sterlang_response_effects:decode(effects_map()),
  Encoded = sterlang_response_effects:encode(Effects),

  Test =
    <<"{\"templated\":true,\"href\":\"/operations/402494270214144/effects/{?cursor,limit,order}\"}">>,
  ?assertEqual(Test, Encoded).

decode_test() ->
  Effects = sterlang_response_effects:decode(effects_map()),

  ?assertEqual(<<"/operations/402494270214144/effects/{?cursor,limit,order}">>,
              sterlang_response_effects:href(Effects)),
  ?assert(sterlang_response_effects:templated(Effects)).

to_map_test() ->
  Effects = sterlang_response_effects:decode(effects_map()),
  Map = sterlang_response_effects:to_map(Effects),

  ?assertEqual(effects_map(), Map).

effects_map() ->
  #{<<"href">> => <<"/operations/402494270214144/effects/{?cursor,limit,order}">>,
    <<"templated">> => true}.
