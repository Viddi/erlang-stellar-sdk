-module(sterlang_xdr_public_key).

-export([encode/1]).

-spec encode({atom(), binary()}) -> binary().
encode({Type, PublicKey}) ->
  EncodedType = sterlang_xdr_public_key_type:encode(Type),

  case Type of
    public_key_type_ed25519 ->
      EncodedPublicKey = sterlang_xdr:encode_uint256(PublicKey),
      <<EncodedType/binary, EncodedPublicKey/binary>>
  end.

%% TODO: Finish me
%%decode_PublicKey(Binary, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32/signed, _/binary>> = Binary,
%%    _6 = _2 + 4,
%%    case _3 of
%%      0 ->
%%        {_4, _5} = dec_uint256(Binary, _6),
%%        {{public_key_type_ed25519, _4}, _5}
%%    end
%%  end.
%%
%%dec_uint256(_1, _2) ->
%%  begin
%%    <<_:_2/binary, _3:32/binary, _/binary>> = _1,
%%    {_3, _2 + 32}
%%  end.
