-module(sterlang_http).

-type error() :: {error, Reason :: atom()}.
-type response() :: {Status :: integer(), Headers :: [tuple(), ...], Body :: bitstring() | atom()} | error().
-type connected() :: true | false.

-callback start_link(Args :: list(), Opts :: list()) -> {ok, pid()} | {error, any()}.

-callback close(pid()) -> term().

-callback connected(pid()) -> connected().

-callback get(pid(), Url :: string()) -> response().
