-module(sterlang_xdr_memo_type).

-behaviour(sterlang_xdr).

-export([encode/1]).

-spec encode(atom()) -> <<_:_*32>>.
encode(memo_none) ->
  <<0:32>>;
encode(memo_text) ->
  <<1:32>>;
encode(memo_id) ->
  <<2:32>>;
encode(memo_hash) ->
  <<3:32>>;
encode(memo_return) ->
  <<4:32>>;
encode(_) ->
  throw(invalid_memo_type).

%% TODO: Finish me
%%dec_MemoType(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32, _/binary>> = _1,
%%    case _3 of
%%      0 ->
%%        {'MEMO_NONE', _2 + 4};
%%      1 ->
%%        {'MEMO_TEXT', _2 + 4};
%%      2 ->
%%        {'MEMO_ID', _2 + 4};
%%      3 ->
%%        {'MEMO_HASH', _2 + 4};
%%      4 ->
%%        {'MEMO_RETURN', _2 + 4}
%%    end
%%  end.
