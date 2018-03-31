-module(sterlang_memo_text).

-behaviour(sterlang_memo).

-export([make_memo/1, text/1]).
-export([to_xdr/1]).

-record(memo_text, {text = undefined :: text()}).

-type text() :: undefined | bitstring().

-type memo_text() :: #memo_text{}.

-spec make_memo(text()) -> memo_text().
make_memo(Text) ->
  if
    byte_size(Text) > 28 -> throw(memo_text_too_long);
    true -> #memo_text{text = Text}
  end.

-spec text(memo_text()) -> text().
text(#memo_text{text = Text}) ->
  Text.

-spec to_xdr(memo_text()) -> binary().
to_xdr(#memo_text{} = Memo) ->
  sterlang_xdr_memo:encode(Memo).
