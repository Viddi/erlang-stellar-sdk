-module(sterlang_xdr_asset).

-behaviour(sterlang_xdr).

-export([encode/1]).

%%====================================================================
%% API functions
%%====================================================================
-spec encode(sterlang_asset_native:asset_native()) -> binary().
encode(Asset) ->
  {Type, Body} = make_xdr(Asset),

  EncodedBody =
    case Type of
      native ->
        <<>>;
      credit_alphanum4 ->
        {AssetCode, Issuer} = Body,
        EncodedAssetCode = encode_alpha_num(4, AssetCode),
        EncodedIssuer = sterlang_xdr_account_id:encode(Issuer),

        <<EncodedAssetCode/binary, EncodedIssuer/binary>>;
      credit_alphanum12 ->
        {AssetCode, Issuer} = Body,

        EncodedAssetCode = encode_alpha_num(12, AssetCode),
        EncodedIssuer = sterlang_xdr_account_id:encode(Issuer),

        <<EncodedAssetCode/binary, EncodedIssuer/binary>>
    end,

  EncodedType = sterlang_xdr_asset_type:encode(Type),

  <<EncodedType/binary, EncodedBody/binary>>.

%% TODO: Finish me
%%dec_Asset(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32/signed, _/binary>> = _1,
%%    _6 = _2 + 4,
%%    case _3 of
%%      0 ->
%%        {_4, _5} = {void, _6},
%%        {{'ASSET_TYPE_NATIVE', _4}, _5};
%%      1 ->
%%        {_4, _5} =
%%          begin
%%            begin
%%              <<_:_6/binary, _11:4/binary, _/binary>> = _1,
%%              _12 = _6 + 4
%%            end,
%%            {_13, _14} = dec_AccountID(_1, _12),
%%            {{_11, _13}, _14}
%%          end,
%%        {{'ASSET_TYPE_CREDIT_ALPHANUM4', _4}, _5};
%%      2 ->
%%        {_4, _5} =
%%          begin
%%            begin
%%              <<_:_6/binary, _7:12/binary, _/binary>> = _1,
%%              _8 = _6 + 12
%%            end,
%%            {_9, _10} = dec_AccountID(_1, _8),
%%            {{_7, _9}, _10}
%%          end,
%%        {{'ASSET_TYPE_CREDIT_ALPHANUM12', _4}, _5}
%%    end
%%  end.

%%====================================================================
%% Internal functions
%%====================================================================
-spec make_xdr(sterlang_asset_native) -> binary().
make_xdr(sterlang_asset_native) ->
  {native, {}}.

-spec encode_alpha_num(non_neg_integer(), bitstring()) -> binary().
encode_alpha_num(N, AssetCode) ->
  case byte_size(AssetCode) of
    N ->
      AssetCode;
    _ ->
      exit({xdr, limit})
  end.
