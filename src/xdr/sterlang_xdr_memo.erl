-module(sterlang_xdr_memo).

-behaviour(sterlang_xdr).

-export([encode/1]).

%%====================================================================
%% API functions
%%====================================================================
encode(Memo) ->
  {Type, Body} = make_xdr(Memo),

  EncodedBody =
    case Type of
      memo_none ->
        <<>>;
      memo_text ->
        %% Body is text bitstring
        Size = byte_size(Body),
        if
          Size =< 28 ->
            Aligned = encode_align(Size),
            <<Size:32/unsigned, Body/binary, Aligned/binary>>;
          true -> throw(memo_text_too_long)
        end;
      memo_id ->
        %% Body is id integer
        sterlang_xdr:encode_uint64(Body);
      memo_hash ->
        <<>>;
      memo_return ->
        <<>>
    end,

  EncodedType = sterlang_xdr_memo_type:encode(Type),

  <<EncodedType/binary, EncodedBody/binary>>.

%%  case Memo of
%%    {_2, _3} ->
%%      [enc_MemoType(_2),
%%        case _2 of
%%          memo_none ->
%%            [];
%%          memo_text ->
%%            begin
%%              Size = io_list_len(_3),
%%              if
%%                Size =< 28 ->
%%                  [<<Size:32/unsigned>>, _3, encode_align(Size)];
%%                true ->
%%                  exit({xdr, limit})
%%              end
%%            end;
%%          memo_id ->
%%            enc_uint64(_3);
%%          memo_hash ->
%%            enc_Hash(_3);
%%          memo_return ->
%%            enc_Hash(_3)
%%        end]
%%  end.

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
make_xdr(sterlang_memo_none) ->
  {memo_none, {}};
make_xdr({memo_text, _, _} = Memo) ->
  Text = sterlang_memo_id:id(Memo),
  {memo_id, {Text}};
make_xdr({memo_id, _, _} = Memo) ->
  Id = sterlang_memo_id:id(Memo),
  {memo_id, {Id}}.

encode_align(Len) ->
  case Len rem 4 of
    0 -> <<>>;
    1 -> <<0, 0, 0>>;
    2 -> <<0, 0>>;
    3 -> <<0>>
  end.

encode_hash(Hash) ->
  case byte_size(Hash) of
    32 ->
      Hash;
    _ ->
      exit({xdr, limit})
  end.

%% TODO: Finish me
%%dec_Hash(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32/binary, _/binary>> = _1,
%%    {_3, _2 + 32}
%%  end.
