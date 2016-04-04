# 1863BFAF
apparently we're the RFC police.

1863BFAF is a project to validate adherence to HTTP/1.1 (RFC 2616)

# storytime

# what is the problem?

(usually) regular expressions/parsing mechanisms that do not strictly follow the RFC

# tests
language     | library          | version  | success? | context
-------------|------------------|----------|----------|---------
binary       | `curl`           | `7.37.1` | [x]      |
binary       | `wget`           | `1.15 `  | [ ]      | (number) `ERROR -1: Malformed status line.`, additionally: reported with exit code 4, 'Network failure.'
perl         | `HTTP::Tiny`     | `5.10.0` | [ ]      | (number) `ERROR: 599`
perl         | `LWP::UserAgent` | `5.10.0` | [x]      |
php          | `http_get`       | `5.5.14` | [ ]      | (number) <unknown, bug in reporting>
python       | `urllib2`        | `2.7`    | [ ]      | (number) `BadStatusLine: HTTP/1.1 16`
ruby         | `net-http`       | `2.2.2`  | [ ]      | (number) `wrong status line: `"HTTP/1.1 40  "`
