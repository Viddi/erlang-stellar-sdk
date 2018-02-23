-module(sterlang_xdr).

-callback to_xdr() -> bitstring().
