-module(sterlang_http).

-type response() :: {Status :: integer(), Headers :: [tuple(), ...], Body :: bitstring() | atom()}.

-callback start_link(Args :: list(), Opts :: list()) -> {ok, pid()} | {error, any()}.

-callback close(pid()) -> term().

-callback get(pid(), Url :: string()) -> response().
