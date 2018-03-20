-module(sterlang_asset_alpha_num12).

-behaviour(sterlang_asset).

-export([make_asset/2, code/1, issuer/1]).
-export([type/0, to_xdr/1]).

-record(asset_alpha_num12, {code = undefined :: code(),
  issuer = undefined :: issuer()}).

-type code() :: undefined | bitstring().
-type issuer() :: undefined | sterlang_key_pair:key_pair().

%% sterlang_xdr_asset needs this type for its encode/1 function
-type asset_alpha_num12() :: #asset_alpha_num12{}.

-spec make_asset(code(), issuer()) -> asset_alpha_num12().
make_asset(Code, Issuer) ->
  #asset_alpha_num12{code = Code, issuer = Issuer}.

-spec code(asset_alpha_num12()) -> code().
code(#asset_alpha_num12{code = Code}) ->
  Code.

-spec issuer(asset_alpha_num12()) -> issuer().
issuer(#asset_alpha_num12{issuer = Issuer}) ->
  Issuer.

-spec type() -> bitstring().
type() ->
  <<"credit_alphanum12">>.

-spec to_xdr(asset_alpha_num12()) -> binary().
to_xdr(#asset_alpha_num12{} = Asset) ->
  sterlang_xdr_asset:encode(Asset).