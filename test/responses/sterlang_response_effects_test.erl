-module(sterlang_response_effects_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  ok.

decode_test() ->
  Effect = sterlang_response_effects:decode(effect_map()),

  ?assertEqual(<<"/operations/402494270214144/effects/{?cursor,limit,order}">>,
              sterlang_response_effects:href(Effect)),
  ?assert(sterlang_response_effects:templated(Effect)).

effect_map() ->
  #{<<"href">> => <<"/operations/402494270214144/effects/{?cursor,limit,order}">>,
    <<"templated">> => true}.
