-module(sterlang_memo_id).

-behaviour(sterlang_memo).

-export([make_memo/1, id/1]).
-export([to_xdr/1]).

-record(memo_id, {id = undefined :: id()}).

-type id() :: undefined | non_neg_integer().
-type memo_id() :: #memo_id{}.

-spec make_memo(id()) -> memo_id().
make_memo(Id) ->
  #memo_id{id = Id}.

-spec id(memo_id()) -> id().
id(#memo_id{id = Id}) ->
  Id.

-spec to_xdr(memo_id()) -> binary().
to_xdr(#memo_id{} = Memo) ->
  sterlang_xdr_memo:encode(Memo).
