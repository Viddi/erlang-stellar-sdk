-module(sterlang_operation).

-export([to_xdr/2]).

-callback to_xdr(any()) -> binary().

-spec to_xdr(sterlang_key_pair:key_pair(), tuple()) -> list().
to_xdr(Source, XdrBody) ->
  XdrSource = sterlang_key_pair:xdr_public_key(Source),
  Xdr = {XdrSource, XdrBody}, %% Operation
  sterlang_xdr_transaction:enc_Operation(Xdr).

%% TODO: Finish me
%%to_base64(Xdr) ->
%%  XdrEncoded = sterlang_xdr_transaction:enc_Operation(Xdr),
%%  base64:encode(XdrEncoded).

%% TODO: Finish me
%%-spec from_xdr(binary()) -> any().
%%from_xdr(Binary) ->
%%  ok.
