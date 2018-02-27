-module(sterlang_operation).

-export([to_xdr/2, to_base64/1]).

-callback to_xdr(any()) -> binary().

-spec to_xdr(sterlang_key_pair:key_pair(), tuple()) -> list().
to_xdr(Source, XdrBody) ->
  XdrSource = sterlang_key_pair:xdr_public_key(Source),
  {XdrSource, XdrBody}. %% Operation

%%-spec to_base64({{atom(), bitstring()}, })
to_base64(Xdr) ->
  sterlang_xdr_transaction:enc_Operation(Xdr).
%%  XdrEncoded = sterlang_xdr_transaction:enc_Operation(Xdr),
%%  base64:encode(XdrEncoded).


-spec from_xdr(binary()) -> any().
from_xdr(Binary) ->
  ok.
