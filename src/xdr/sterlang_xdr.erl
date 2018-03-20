-module(sterlang_xdr).

-export([encode_uint256/1]).
-export([encode_int64/1]).

-callback encode(any()) -> binary().

%%====================================================================
%% API functions
%%====================================================================
-spec encode_uint256(binary()) -> binary().
encode_uint256(N) when is_binary(N) ->
  case byte_size(N) of
    32 ->
      N;
    _ ->
      exit({xdr, limit})
  end.

-spec encode_int64(non_neg_integer()) -> <<_:_*64>>.
encode_int64(N) ->
  <<N:64>>.
