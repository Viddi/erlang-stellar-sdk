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
sterlang:create_account(PublicKey).
```

### TODO

- [X] Add CI.
- [X] Add `spec`s for all functions.
- [X] Add documentation for all functions.
- [X] Add tests.
- [ ] Add HTTP response records.
- [ ] Send/Receive payments.
- [ ] Better Elixir interop.

## Donations

XLM: GB6YPGW5JFMMP2QB2USQ33EUWTXVL4ZT5ITUNCY3YKVWOJPP57CANOF3
