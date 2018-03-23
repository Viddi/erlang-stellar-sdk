-module(sterlang_xdr_memo_type_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  ?assertEqual(<<0:32>>, sterlang_xdr_memo_type:encode(memo_none)),
  ?assertEqual(<<1:32>>, sterlang_xdr_memo_type:encode(memo_text)),
  ?assertEqual(<<2:32>>, sterlang_xdr_memo_type:encode(memo_id)),
  ?assertEqual(<<3:32>>, sterlang_xdr_memo_type:encode(memo_hash)),
  ?assertEqual(<<4:32>>, sterlang_xdr_memo_type:encode(memo_return)),
  ?assertThrow(invalid_memo_type, sterlang_xdr_memo_type:encode(test)).
