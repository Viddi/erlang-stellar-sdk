-module(sterlang_xdr_operation_type).

-export([encode/1]).

-spec encode(atom()) -> binary().
encode(Type) ->
  case Type of
    create_account ->
      <<0:32>>;
    payment ->
      <<1:32>>;
    path_payment ->
      <<2:32>>;
    manage_offer ->
      <<3:32>>;
    create_passive_offer ->
      <<4:32>>;
    set_options ->
      <<5:32>>;
    change_trust ->
      <<6:32>>;
    allow_trust ->
      <<7:32>>;
    account_merge ->
      <<8:32>>;
    inflation ->
      <<9:32>>;
    manage_data ->
      <<10:32>>
  end.

%% TODO: Finish me
%%dec_OperationType(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32, _/binary>> = _1,
%%    case _3 of
%%      0 ->
%%        {'CREATE_ACCOUNT', _2 + 4};
%%      1 ->
%%        {'PAYMENT', _2 + 4};
%%      2 ->
%%        {'PATH_PAYMENT', _2 + 4};
%%      3 ->
%%        {'MANAGE_OFFER', _2 + 4};
%%      4 ->
%%        {'CREATE_PASSIVE_OFFER', _2 + 4};
%%      5 ->
%%        {'SET_OPTIONS', _2 + 4};
%%      6 ->
%%        {'CHANGE_TRUST', _2 + 4};
%%      7 ->
%%        {'ALLOW_TRUST', _2 + 4};
%%      8 ->
%%        {'ACCOUNT_MERGE', _2 + 4};
%%      9 ->
%%        {'INFLATION', _2 + 4};
%%      10 ->
%%        {'MANAGE_DATA', _2 + 4}
%%    end
%%  end.
