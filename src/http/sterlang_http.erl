-module(sterlang_http).

-type response() :: {Status :: integer(), Headers :: [{}], Body :: bitstring() | atom()}.

-callback connect() -> {ok, pid()} | {error, term()}.

-callback close(pid()) -> term().

-callback get(pid(), Url :: string()) -> response().
  
