-module(sterlang_http_client).

-behaviour(sterlang_http).
-behaviour(gen_server).

-export([start_link/2, close/1, connected/1, get/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-record(state, {gun_pid :: pid(), connected = false :: true | false}).

%%====================================================================
%% API functions
%%====================================================================
-spec start_link(list(), list()) -> {ok, pid()} | {error, any()}.
start_link(Args, Opts) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, Args, Opts).

-spec close(pid()) -> ok.
close(Pid) ->
  gen_server:call(Pid, close).

-spec connected(pid()) -> true | false.
connected(Pid) ->
  gen_server:call(Pid, connected).

get(Pid, Url) ->
  gen_server:call(Pid, {get, Url}).

%%====================================================================
%% GenServer callbacks
%%====================================================================
init(_Args) ->
  %% TODO: Extract a custom url for testing purposes.
  case gun:open("horizon-testnet.stellar.org", 443) of
    {ok, Pid} ->
      State = #state{gun_pid = Pid},
      {ok, State};
    {error, Reason} ->
      {error, Reason}
  end.

handle_call(connected, _From, State) ->
  {reply, State#state.connected, State};

handle_call(close, _From, State) ->
  Pid = State#state.gun_pid,
  gun:shutdown(Pid),
  {stop, shutdown, ok, State};

handle_call({get, Url}, _From, State) ->
  Pid = State#state.gun_pid,
  io:format("Making a get request to URL: ~s~n", [Url]),
  Ref = gun:get(Pid, Url),
  Res = await_response(Pid, Ref),
  {reply, Res, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info({gun_up, Pid, http}, State) ->
  io:format("gun_up message: ~p~n", [Pid]),
  {noreply, State#state{connected = true}};

handle_info({gun_down, Pid, http}, State) ->
  io:format("gun_down message: ~p~n", [Pid]),
  {noreply, State#state{connected = false}}.

terminate(_Reason, _State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================
-spec await_response(pid(), reference()) -> sterlang_http:response().
await_response(Pid, Ref) ->
  case gun:await(Pid, Ref) of
    {response, fin, Status, Headers} ->
      {Status, Headers, no_data};
    {response, nofin, Status, Headers} ->
      {ok, Body} = gun:await_body(Pid, Ref),
      io:format("~s~n", [Body]),
      {Status, Headers, Body};
    {error, timeout} ->
      {error, timeout};
    _ ->
      {error, wtf}
  end.
