-module(sterlang_xdr_public_key_type).

-behaviour(sterlang_xdr).

-export([encode/1]).

-spec encode(atom()) -> <<_:_*32>>.
encode(public_key_type_ed25519) ->
  <<0:32>>;
encode(_) ->
  throw(invalid_public_key_type).

%% TODO: Finish me
%%-spec decode_public_key_type(binary(), non_neg_integer()) -> tuple().
%%decode_public_key_type(Binary, _2) ->
%%  begin
%%    <<_:_2/binary, Type:32, _/binary>> = Binary,
%%    case Type of
%%      0 ->
%%        {public_key_type_ed25519, _2 + 4}
%%    end
%%  end.
