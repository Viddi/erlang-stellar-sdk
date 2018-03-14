-module(sterlang_asset_native).

-behaviour(sterlang_asset).

-export([type/0, to_xdr/1]).

-spec type() -> bitstring().
type() ->
  <<"native">>.

-spec to_xdr(any()) -> binary().
to_xdr(_) ->
  sterlang_xdr_asset:encode({native, {undefined}}).