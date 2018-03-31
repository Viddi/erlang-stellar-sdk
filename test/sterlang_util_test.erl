-module(sterlang_util_test).

-include_lib("eunit/include/eunit.hrl").

pad_test() ->
  ?assertEqual(<<1, 0, 0, 0>>, sterlang_util:pad(4, <<1>>)),
  ?assertEqual(<<1, 2, 3>>, sterlang_util:pad(2, <<1, 2, 3>>)),
  ?assertEqual(<<1, 1, 2>>, sterlang_util:pad(3, <<1, 1, 2>>)).
