-module(sterlang_response).

-callback encode(any()) -> iodata().

-callback decode(map()) -> any().

-callback to_map(any()) -> map().
