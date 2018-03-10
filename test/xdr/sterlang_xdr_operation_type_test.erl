-module(sterlang_xdr_operation_type_test).

-include_lib("eunit/include/eunit.hrl").

encode_test() ->
  ?assertEqual(<<0:32>>, sterlang_xdr_operation_type:encode(create_account)),
  ?assertEqual(<<1:32>>, sterlang_xdr_operation_type:encode(payment)),
  ?assertEqual(<<2:32>>, sterlang_xdr_operation_type:encode(path_payment)),
  ?assertEqual(<<3:32>>, sterlang_xdr_operation_type:encode(manage_offer)),
  ?assertEqual(<<4:32>>, sterlang_xdr_operation_type:encode(create_passive_offer)),
  ?assertEqual(<<5:32>>, sterlang_xdr_operation_type:encode(set_options)),
  ?assertEqual(<<6:32>>, sterlang_xdr_operation_type:encode(change_trust)),
  ?assertEqual(<<7:32>>, sterlang_xdr_operation_type:encode(allow_trust)),
  ?assertEqual(<<8:32>>, sterlang_xdr_operation_type:encode(account_merge)),
  ?assertEqual(<<9:32>>, sterlang_xdr_operation_type:encode(inflation)),
  ?assertEqual(<<10:32>>, sterlang_xdr_operation_type:encode(manage_data)).

