-module(sterlang_memo_none).

-behaviour(sterlang_memo).

-export([make_memo/0]).
-export([to_xdr/1]).

-type memo_none() :: memo_none.

-spec make_memo() -> memo_none().
make_memo() ->
  memo_none.

-spec to_xdr(any()) -> binary().
to_xdr(_) ->
  sterlang_xdr_memo:encode(memo_none).
