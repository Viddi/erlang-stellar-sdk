-module(sterlang_response).

-callback encode(any()) -> iodata().

-callback decode(map()) -> any().
