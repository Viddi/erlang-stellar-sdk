-module(sterlang_response_links_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Links = sterlang_response_links:decode(links_map()),
  Encoded = sterlang_response_links:encode(Links),

  Transactions = <<"\"transactions\":{\"href\":\"/transactions/77309415424\"},">>,
  Succeeds = <<"\"succeeds\":{\"href\":\"/operations?cursor=77309415424&order=desc\"},">>,
  Self = <<"\"self\":{\"href\":\"/operations/77309415424\"},">>,
  Precedes = <<"\"precedes\":{\"href\":\"/operations?cursor=77309415424&order=asc\"},">>,
  Effects = <<"\"effects\":{\"templated\":true,\"href\":\"/operations/77309415424/effects/{?cursor,limit,order}\"}">>,

  Test = <<"{", Transactions/binary, Succeeds/binary, Self/binary, Precedes/binary, Effects/binary, "}">>,

  ?assertEqual(Test, Encoded).

decode_test() ->
  Links = sterlang_response_links:decode(links_map()),

  Effects = sterlang_response_effects:decode(effects_map()),
  Precedes = sterlang_response_precedes:decode(precedes_map()),
  Self = sterlang_response_self:decode(self_map()),
  Succeeds = sterlang_response_succeeds:decode(succeeds_map()),
  Transactions = sterlang_response_transactions:decode(transactions_map()),

  ?assertEqual(Effects, sterlang_response_links:effects(Links)),
  ?assertEqual(Precedes, sterlang_response_links:precedes(Links)),
  ?assertEqual(Self, sterlang_response_links:self(Links)),
  ?assertEqual(Succeeds, sterlang_response_links:succeeds(Links)),
  ?assertEqual(Transactions, sterlang_response_links:transactions(Links)).

links_map() ->
  #{<<"effects">> => #{<<"href">> => <<"/operations/77309415424/effects/{?cursor,limit,order}">>, <<"templated">> => true},
    <<"precedes">> => #{<<"href">> => <<"/operations?cursor=77309415424&order=asc">>},
    <<"self">> => #{<<"href">> => <<"/operations/77309415424">>},
    <<"succeeds">> => #{<<"href">> => <<"/operations?cursor=77309415424&order=desc">>},
    <<"transactions">> => #{<<"href">> => <<"/transactions/77309415424">>}}.

effects_map() ->
  #{<<"href">> => <<"/operations/77309415424/effects/{?cursor,limit,order}">>, <<"templated">> => true}.

precedes_map() ->
  #{<<"href">> => <<"/operations?cursor=77309415424&order=asc">>}.

self_map() ->
  #{<<"href">> => <<"/operations/77309415424">>}.

succeeds_map() ->
  #{<<"href">> => <<"/operations?cursor=77309415424&order=desc">>}.

transactions_map() ->
  #{<<"href">> => <<"/transactions/77309415424">>}.
