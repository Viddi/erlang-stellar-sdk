-module(sterlang_xdr).

-export([encode_uint256/1]).

%%====================================================================
%% API functions
%%====================================================================
-spec encode_uint256(non_neg_integer()) -> non_neg_integer() | {xdr, limit}.
encode_uint256(N) when is_binary(N) ->
  case byte_size(N) of
    32 ->
      N;
    _ ->
      exit({xdr, limit})
  end.
