-module(sterlang_asset_alpha_num4).

-behaviour(sterlang_asset).

-export([make_asset/2, code/1, issuer/1]).
-export([type/0, to_xdr/1]).

-record(asset_alpha_num4, {code = undefined :: code(),
  issuer = undefined :: issuer()}).

-type code() :: undefined | bitstring().
-type issuer() :: undefined | sterlang_key_pair:key_pair().

-opaque asset_alpha_num4() :: #asset_alpha_num4{}.

-export_type([asset_alpha_num4/0]).

-spec make_asset(code(), issuer()) -> asset_alpha_num4().
make_asset(Code, Issuer) ->
  #asset_alpha_num4{code = Code, issuer = Issuer}.

-spec code(asset_alpha_num4()) -> code().
code(#asset_alpha_num4{code = Code}) ->
  Code.

-spec issuer(asset_alpha_num4()) -> issuer().
issuer(#asset_alpha_num4{issuer = Issuer}) ->
  Issuer.

-spec type() -> bitstring().
type() ->
  <<"credit_alphanum4">>.

-spec to_xdr(asset_alpha_num4()) -> binary().
to_xdr(#asset_alpha_num4{} = Asset) ->
  sterlang_xdr_asset:encode(Asset).
