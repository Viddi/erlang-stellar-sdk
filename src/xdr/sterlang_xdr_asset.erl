-module(sterlang_xdr_asset).

-behaviour(sterlang_xdr).

-export([encode/1]).

%%====================================================================
%% API functions
%%====================================================================
-spec encode({atom(), tuple()}) -> binary().
encode(Asset) ->
  {Type, Body} = make_xdr(Asset),

  EncodedBody =
    case Type of
      native ->
        <<>>;
      credit_alphanum4 ->
        {AssetCode, Issuer} = Body,
        EncodedAssetCode = encode_alpha_num(AssetCode, byte_size(AssetCode), 0, 4),
        EncodedIssuer = sterlang_xdr_account_id:encode(Issuer),

        <<EncodedAssetCode/binary, EncodedIssuer/binary>>;
      credit_alphanum12 ->
        {AssetCode, Issuer} = Body,

        EncodedAssetCode = encode_alpha_num(AssetCode, byte_size(AssetCode), 5, 12),
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
-spec make_xdr(
    sterlang_asset_native |
    sterlang_asset_alpha_num12:asset_alpha_num12())
      -> {atom(), tuple()}.
make_xdr(sterlang_asset_native) ->
  {native, {}};
make_xdr(Asset) ->
  {Mod, _, _} = Asset,

  case Mod of
    asset_alpha_num4 ->
%%      Code = sterlang_asset_alpha_num4:code(Asset),
%%      Issuer = Mod:issuer(Asset),
%%      {credit_alphanum4, {Code, Issuer}};
      {};
    asset_alpha_num12 ->
      Code = sterlang_asset_alpha_num12:code(Asset),
      Issuer = sterlang_asset_alpha_num12:issuer(Asset),
      {credit_alphanum12, {Code, Issuer}}
  end.


-spec encode_alpha_num(bitstring(), non_neg_integer(), non_neg_integer(), non_neg_integer()) -> binary().
encode_alpha_num(_, Size, Lower, _) when Size < Lower ->
  throw(invalid_alphanum_code_lower);
encode_alpha_num(_, Size, _, Upper) when Size > Upper ->
  throw(invalid_alphanum_code_upper);
encode_alpha_num(Code, _, _, Upper) ->
  pad(Upper - byte_size(Code), 0, Code).

-spec pad(non_neg_integer(), non_neg_integer(), bitstring()) -> binary().
pad(Padding, N, Acc) when N < Padding ->
  pad(Padding, N + 1, <<Acc/binary, 0>>);
pad(Padding, N, Acc) when Padding >= N ->
  Acc.
