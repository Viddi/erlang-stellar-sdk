-module(sterlang_crc16_test).

-include_lib("eunit/include/eunit.hrl").

ccitt_test() ->
  ?assertEqual(sterlang_crc16:ccitt("123456789"), 16#31C3).
