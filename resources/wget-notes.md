```
[1] http://localhost:4567/numbers..
--2016-04-03 12:33:24--  http://localhost:4567/numbers
Resolving localhost... 127.0.0.1, ::1, fe80::1
Connecting to localhost|127.0.0.1|:4567... connected.
HTTP request sent, awaiting response... -1
2016-04-03 12:33:24 ERROR -1: Malformed status line.
Retrying.
...
--2016-04-03 12:35:50--  (try:20)  http://localhost:4567/numbers
Connecting to localhost|127.0.0.1|:4567... connected.
HTTP request sent, awaiting response... -1
2016-04-03 12:35:50 ERROR -1: Malformed status line.
Giving up.
```

this is reported as

```
non-0 exitcode[4] response[]
```

which claims to be

````
EXIT STATUS
       Wget may return one of several error codes if it encounters problems.

       0   No problems occurred.
...
       4   Network failure.

```

