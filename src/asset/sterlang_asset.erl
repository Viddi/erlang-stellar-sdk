-module(sterlang_asset).

-callback type() -> bitstring().
-callback to_xdr(any()) -> binary().
