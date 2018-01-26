-module(sterlang_json).

-callback encode(bitstring()) -> #{}.

-callback decode(#{}) -> bitstring().
