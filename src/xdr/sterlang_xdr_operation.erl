-module(sterlang_xdr_operation).

-behaviour(sterlang_xdr).

-export([encode/1]).

-spec encode({undefined | sterlang_key_pair:key_pair(), {atom(), tuple()}}) -> binary().
encode({SourceAccount, {Type, Body}}) ->
  EncodedSource =
    case SourceAccount of
      undefined ->
        <<0:32>>;
      _ ->
        Encoded = sterlang_xdr_account_id:encode(SourceAccount),
        <<1:32, Encoded/binary>>
    end,

  EncodedType = sterlang_xdr_operation_type:encode(Type),

  EncodedBody =
    case Type of
      create_account ->
        sterlang_xdr_create_account:encode(Body);
      payment ->
        sterlang_xdr_payment:encode(Body);
      _ ->
        %% TODO: Finish other operation xdr encoding
        throw(unsupported_operation)
    end,

  <<EncodedSource/binary, EncodedType/binary, EncodedBody/binary>>.

%% TODO: Finish me
%%dec_Operation(_1, _2) ->
%%  begin
%%    {_3, _4} =
%%      begin
%%        <<_:_2/binary, _5:32/unsigned, _/binary>> = _1,
%%        _6 = _2 + 4,
%%        if
%%          _5 == 0 ->
%%            {void, _6};
%%          _5 == 1 ->
%%            dec_AccountID(_1, _6)
%%        end
%%      end,
%%    {_7, _8} =
%%      begin
%%        <<_:_4/binary, _9:32/signed, _/binary>> = _1,
%%        _12 = _4 + 4,
%%        case _9 of
%%          0 ->
%%            {_10, _11} = dec_CreateAccountOp(_1, _12),
%%            {{'CREATE_ACCOUNT', _10}, _11};
%%          1 ->
%%            {_10, _11} = dec_PaymentOp(_1, _12),
%%            {{'PAYMENT', _10}, _11};
%%          2 ->
%%            {_10, _11} = dec_PathPaymentOp(_1, _12),
%%            {{'PATH_PAYMENT', _10}, _11};
%%          3 ->
%%            {_10, _11} = dec_ManageOfferOp(_1, _12),
%%            {{'MANAGE_OFFER', _10}, _11};
%%          4 ->
%%            {_10, _11} = dec_CreatePassiveOfferOp(_1, _12),
%%            {{'CREATE_PASSIVE_OFFER', _10}, _11};
%%          5 ->
%%            {_10, _11} = dec_SetOptionsOp(_1, _12),
%%            {{'SET_OPTIONS', _10}, _11};
%%          6 ->
%%            {_10, _11} = dec_ChangeTrustOp(_1, _12),
%%            {{'CHANGE_TRUST', _10}, _11};
%%          7 ->
%%            {_10, _11} = dec_AllowTrustOp(_1, _12),
%%            {{'ALLOW_TRUST', _10}, _11};
%%          8 ->
%%            {_10, _11} = dec_AccountID(_1, _12),
%%            {{'ACCOUNT_MERGE', _10}, _11};
%%          9 ->
%%            {_10, _11} = {void, _12},
%%            {{'INFLATION', _10}, _11};
%%          10 ->
%%            {_10, _11} = dec_ManageDataOp(_1, _12),
%%            {{'MANAGE_DATA', _10}, _11}
%%        end
%%      end,
%%    {{_3, _7}, _8}
%%  end.
