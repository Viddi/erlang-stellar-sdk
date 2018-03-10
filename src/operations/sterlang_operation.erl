-module(sterlang_operation).

-export([to_xdr/2]).

-callback to_xdr(any()) -> binary().

-spec to_xdr(sterlang_key_pair:key_pair(), {tuple(), tuple()}) -> list().
to_xdr(Source, {Type, OperationBody}) ->
  sterlang_xdr_operation:encode({Source, {Type, OperationBody}}).

%% TODO: Finish me
%%to_base64(Xdr) ->
%%  XdrEncoded = sterlang_xdr_transaction:enc_Operation(Xdr),
%%  base64:encode(XdrEncoded).

%% TODO: Finish me
%%-spec from_xdr(binary()) -> any().
%%from_xdr(Binary) ->
%%  ok.
