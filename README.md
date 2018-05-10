# Sterlang

[![Build Status](https://travis-ci.org/Viddi/erlang-stellar-sdk.svg?branch=master)](https://travis-ci.org/Viddi/erlang-stellar-sdk)

An Erlang library to interact with [Stellar's Horizon API](https://github.com/stellar/go/tree/master/services/horizon).

## WARNING :warning:

This is project is still being developed and should not be used in its current state.

## Usage

**NOTE**: There are still missing components. This is a work in progress.

### Erlang

```
KeyPair = sterlang_key_pair:random().
PublicKey = sterlang_key_pair:public_key(KeyPair).

{ok, Pid} = sterlang:connect().
{Status, Headers, Body} = sterlang:create_account(Pid, PublicKey).
```

### TODO

- [X] Add CI.
- [X] Add HTTP response records.
- [ ] Send/Receive payments.
- [ ] Better Elixir interop.

## Donations

XLM: GBS7NXADHWHFDOB74EL4NVV3KWTZGBPCLBBX54NJ5CCY6OMJCUMOJ5VS
