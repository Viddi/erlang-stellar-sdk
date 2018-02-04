-module(sterlang_response_transactions_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  Transactions = sterlang_response_transactions:decode(transactions_map()),
  Encoded = sterlang_response_transactions:encode(Transactions),

  Test = <<"{\"href\":\"/transactions/402494270214144\"}">>,
  ?assertEqual(Test, Encoded).

decode_test() ->
  Transactions = sterlang_response_transactions:decode(transactions_map()),

  ?assertEqual(<<"/transactions/402494270214144">>,
               sterlang_response_transactions:href(Transactions)).

transactions_map() ->
  #{<<"href">> => <<"/transactions/402494270214144">>}.
