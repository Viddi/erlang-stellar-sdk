-module(sterlang_memo_hash).

-behaviour(sterlang_memo).

-export([make_memo/1, hash/1]).
-export([to_xdr/1]).

-record(memo_hash, {hash = undefined :: hash()}).

-type hash() :: undefined | <<_:_*32>>.

-type memo_hash() :: #memo_hash{}.

-spec make_memo(hash()) -> memo_hash().
make_memo(Hash) ->
  %% Pad Hash
  #memo_hash{hash = Hash}.

-spec hash(memo_hash()) -> hash().
hash(#memo_hash{hash = Hash}) ->
  Hash.

-spec to_xdr(memo_hash()) -> binary().
to_xdr(#memo_hash{} = Memo) ->
  sterlang_xdr_memo:encode(Memo).
