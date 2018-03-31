-module(sterlang_xdr_memo_test).

-include_lib("eunit/include/eunit.hrl").

encode_memo_none_test() ->
  Memo = sterlang_memo_none:make_memo(),
  Encoded = sterlang_xdr_memo:encode(Memo),

  ?assert(is_binary(Encoded)),
  ?assertEqual(4, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_memo_type:encode(memo_none), EncodedType),
  ?assertEqual(<<>>, EncodedBody).

encode_memo_text_test() ->
  Text = <<"test">>,
  Memo = sterlang_memo_text:make_memo(Text),
  Encoded = sterlang_xdr_memo:encode(Memo),

  ?assert(is_binary(Encoded)),
  ?assertEqual(12, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_memo_type:encode(memo_text), EncodedType),
  ?assertEqual(8, byte_size(EncodedBody)),

  <<Size:32, EncodedText:4/binary, Align/binary>> = EncodedBody,

  ?assertEqual(byte_size(Text), Size),
  ?assertEqual(Text, EncodedText),
  ?assertEqual(<<>>, Align).

encode_memo_id_test() ->
  Id = 9223372036854775807,
  Memo = sterlang_memo_id:make_memo(Id),
  Encoded = sterlang_xdr_memo:encode(Memo),

  ?assert(is_binary(Encoded)),
  ?assertEqual(12, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_memo_type:encode(memo_id), EncodedType),
  ?assertEqual(8, byte_size(EncodedBody)),
  ?assertEqual(Id, sterlang_xdr:decode_uint64(EncodedBody)).

encode_memo_hash_test() ->
  Hash = <<"4142434445464748494a4b4c">>,
  Memo = sterlang_memo_hash:make_memo(Hash),
  Encoded = sterlang_xdr_memo:encode(Memo),

  ?assert(is_binary(Encoded)),
  ?assertEqual(36, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_memo_type:encode(memo_hash), EncodedType),
  ?assertEqual(32, byte_size(EncodedBody)),
  ?assertEqual(<<Hash/binary, 0, 0, 0, 0, 0, 0, 0, 0>>, EncodedBody).

encode_memo_return_test() ->
  Hash = <<"4142434445464748494a4b4c">>,
  Memo = sterlang_memo_return:make_memo(Hash),
  Encoded = sterlang_xdr_memo:encode(Memo),

  ?assert(is_binary(Encoded)),
  ?assertEqual(36, byte_size(Encoded)),

  <<EncodedType:4/binary, EncodedBody/binary>> = Encoded,

  ?assertEqual(sterlang_xdr_memo_type:encode(memo_return), EncodedType),
  ?assertEqual(32, byte_size(EncodedBody)),
  ?assertEqual(<<Hash/binary, 0, 0, 0, 0, 0, 0, 0, 0>>, EncodedBody).
