-module(sterlang_asset_native).

-behaviour(sterlang_asset).

-export([make_asset/0]).
-export([type/0, to_xdr/1]).

-opaque asset_native() :: sterlang_asset_native.

-export_type([asset_native/0]).

-spec make_asset() -> asset_native().
make_asset() ->
  sterlang_asset_native.

-spec type() -> bitstring().
type() ->
  <<"native">>.

-spec to_xdr(any()) -> binary().
to_xdr(_) ->
  sterlang_xdr_asset:encode({native, {}}).
