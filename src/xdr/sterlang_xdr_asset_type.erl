-module(sterlang_xdr_asset_type).

-behaviour(sterlang_xdr).

-export([encode/1]).

-spec encode(atom()) -> <<_:_*32>>.
encode(native) ->
  <<0:32>>;
encode(credit_alphanum4) ->
  <<1:32>>;
encode(credit_alphanum12) ->
  <<2:32>>;
encode(_) ->
  throw(invalid_asset_type).

%% TODO: Finish me
%%dec_AssetType(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32, _/binary>> = _1,
%%    case _3 of
%%      0 ->
%%        {'ASSET_TYPE_NATIVE', _2 + 4};
%%      1 ->
%%        {'ASSET_TYPE_CREDIT_ALPHANUM4', _2 + 4};
%%      2 ->
%%        {'ASSET_TYPE_CREDIT_ALPHANUM12', _2 + 4}
%%    end
%%  end.
