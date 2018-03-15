-module(sterlang_xdr_public_key).

-behaviour(sterlang_xdr).

-export([encode/1]).

-opaque xdr_public_key() :: {atom(), binary()}.

%%====================================================================
%% API functions
%%====================================================================
-spec encode(sterlang_key_pair:key_pair()) -> binary().
encode(KeyPair) ->
  {Type, PublicKey} = make_xdr(KeyPair),
  EncodedType = sterlang_xdr_public_key_type:encode(Type),

  case Type of
    public_key_type_ed25519 ->
      EncodedPublicKey = sterlang_xdr:encode_uint256(PublicKey),
      <<EncodedType/binary, EncodedPublicKey/binary>>
  end.

%% TODO: Finish me
%%decode(Binary, _2) ->
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

%%====================================================================
%% Internal functions
%%====================================================================
-spec make_xdr(sterlang_key_pair:key_pair()) -> xdr_public_key().
make_xdr(KeyPair) ->
  PublicKey = sterlang_key_pair:public_key(KeyPair),
  Decoded = base32:decode(PublicKey),
  <<_:8, Payload:32/binary, _:2/binary>> = Decoded,
  {public_key_type_ed25519, Payload}.
