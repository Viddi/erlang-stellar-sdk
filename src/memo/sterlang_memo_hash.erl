-module(sterlang_memo_hash).

-behaviour(sterlang_memo).

-export([make_memo/1, hash/1]).
-export([to_xdr/1]).

-record(memo_hash, {hash = undefined :: hash()}).

-type hash() :: undefined | binary().

-type memo_hash() :: #memo_hash{}.

-spec make_memo(hash()) -> memo_hash().
make_memo(Hash) ->
  if
    byte_size(Hash) > 32 -> throw(mem_hash_too_long);
    true -> #memo_hash{hash = sterlang_util:pad(32, Hash)}
  end.

-spec hash(memo_hash()) -> hash().
hash(#memo_hash{hash = Hash}) ->
  Hash.

-spec to_xdr(memo_hash()) -> binary().
to_xdr(#memo_hash{} = Memo) ->
  sterlang_xdr_memo:encode(Memo).
