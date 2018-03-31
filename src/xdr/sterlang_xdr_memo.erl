-module(sterlang_xdr_memo).

-behaviour(sterlang_xdr).

-export([encode/1]).

-type memo() :: sterlang_memo_none:memo_none()
  | sterlang_memo_text:memo_text()
  | sterlang_memo_id:memo_id()
  | sterlang_memo_hash:memo_hash()
  | sterlang_memo_return:memo_return().

%%====================================================================
%% API functions
%%====================================================================
-spec encode(memo()) -> binary().
encode(Memo) ->
  {Type, Body} = make_xdr(Memo),

  EncodedBody =
    case Type of
      memo_none ->
        <<>>;
      memo_text ->
        Size = byte_size(Body),
        if
          Size =< 28 ->
            %% Is 'Aligned' necessary?
            Aligned = encode_align(Size),
            <<Size:32/unsigned, Body/binary, Aligned/binary>>;
          true -> throw(memo_text_too_long)
        end;
      memo_id ->
        sterlang_xdr:encode_uint64(Body);
      memo_hash ->
        Body;
      memo_return ->
        Body
    end,

  EncodedType = sterlang_xdr_memo_type:encode(Type),

  <<EncodedType/binary, EncodedBody/binary>>.

%% TODO: Finish me
%%dec_Memo(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32/signed, _/binary>> = _1,
%%    _6 = _2 + 4,
%%    case _3 of
%%      0 ->
%%        {_4, _5} = {void, _6},
%%        {{'MEMO_NONE', _4}, _5};
%%      1 ->
%%        {_4, _5} =
%%          begin
%%            <<_:_6/binary, _7:32/unsigned, _/binary>> = _1,
%%            if
%%              _7 > 28 ->
%%                exit({xdr, limit});
%%              true ->
%%                _8 = _6 + 4,
%%                <<_:_8/binary, _9:_7/binary, _/binary>> =
%%                  _1,
%%                {_9, _8 + align(_7)}
%%            end
%%          end,
%%        {{'MEMO_TEXT', _4}, _5};
%%      2 ->
%%        {_4, _5} = dec_uint64(_1, _6),
%%        {{'MEMO_ID', _4}, _5};
%%      3 ->
%%        {_4, _5} = dec_Hash(_1, _6),
%%        {{'MEMO_HASH', _4}, _5};
%%      4 ->
%%        {_4, _5} = dec_Hash(_1, _6),
%%        {{'MEMO_RETURN', _4}, _5}
%%    end
%%  end.

%%====================================================================
%% Internal functions
%%====================================================================
-spec make_xdr(memo()) -> {atom(), any()}.
make_xdr(memo_none) ->
  {memo_none, {}};
make_xdr({memo_text, _} = Memo) ->
  Text = sterlang_memo_text:text(Memo),
  {memo_text, Text};
make_xdr({memo_id, _} = Memo) ->
  Id = sterlang_memo_id:id(Memo),
  {memo_id, Id};
make_xdr({memo_hash, _} = Memo) ->
  Hash = sterlang_memo_hash:hash(Memo),
  {memo_hash, Hash};
make_xdr({memo_return, _} = Memo) ->
  Hash = sterlang_memo_return:hash(Memo),
  {memo_return, Hash}.

-spec encode_align(non_neg_integer()) -> binary().
encode_align(Len) ->
  case Len rem 4 of
    0 -> <<>>;
    1 -> <<0, 0, 0>>;
    2 -> <<0, 0>>;
    3 -> <<0>>
  end.

%% TODO: Finish me
%%dec_Hash(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32/binary, _/binary>> = _1,
%%    {_3, _2 + 32}
%%  end.
