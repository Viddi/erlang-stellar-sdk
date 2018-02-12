-module(sterlang_http_client).

-behaviour(sterlang_http).
-behaviour(gen_server).

-export([start_link/2, close/1, get/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

-record(state, {gun_pid :: pid(), connected = false :: true | false}).

%%====================================================================
%% API functions
%%====================================================================
-spec start_link(list(), list()) -> {ok, pid()} | {error, any()}.
start_link(Args, Opts) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, Args, Opts).

-spec close(pid()) -> ok.
close(Pid) ->
  gun:shutdown(Pid).

get(Pid, Url) ->
  gen_server:call(Pid, Url).

%%====================================================================
%% Internal functions
%%====================================================================
init(_Args) ->
  case gun:open("horizon-testnet.stellar.org", 443) of
    {ok, Pid} ->
      State = #state{gun_pid = Pid},
      {ok, State};
    {error, Reason} ->
      {error, Reason}
  end.

handle_call({get, Url}, _From, State) ->
  Pid = State#state.gun_pid,
  Ref = gun:get(Pid, Url),
  {reply, await_response(Pid, Ref), State}.

handle_cast(_, State) ->
  {noreply, State}.

handle_info({gun_up, Pid, http}, State) ->
  io:format("gun_up message: ~p~n", [Pid]),
  {noreply, State#state{connected = true}};

handle_info({gun_down, Pid, http}, State) ->
  io:format("gun_down message: ~p~n", [Pid]),
  {noreply, State#state{connected = false}}.

-spec await_response(pid(), reference()) -> sterlang_http:response().
await_response(Pid, Ref) ->
  case gun:await(Pid, Ref) of
    {response, fin, Status, Headers} ->
      {Status, Headers, no_data};
    {response, nofin, Status, Headers} ->
      {ok, Body} = gun:await_body(Pid, Ref),
      io:format("~s~n", [Body]),
      {Status, Headers, Body}
  end.
