-module(sterlang_util).

-export([pad/2]).

%%====================================================================
%% API functions
%%====================================================================
%% @doc Adds padding for the given binary to fit the padding size.
%% example:
%% padding: 8, Bin: <<1>>
%% => <<1,0,0,0,0,0,0,0>>.
%% 7 additional 0's were added as padding.
pad(Upper, Bin) ->
  pad(Upper, byte_size(Bin), Bin).

%%====================================================================
%% Internal functions
%%====================================================================
-spec pad(non_neg_integer(), non_neg_integer(), bitstring()) -> binary().
pad(Padding, N, Acc) when N < Padding ->
  pad(Padding, N + 1, <<Acc/binary, 0>>);
pad(_Padding, _N, Acc) ->
  Acc.
