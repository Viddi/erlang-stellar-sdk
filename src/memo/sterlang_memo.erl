-module(sterlang_memo).

-callback to_xdr(any()) -> binary().
