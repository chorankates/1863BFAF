# 1863BFAF
apparently we're the RFC police.

1863BFAF is a project to validate adherence to HTTP/1.1 (RFC 2616)

# storytime

# what is the problem?

(usually) regular expressions/parsing mechanisms that do not strictly follow the RFC

# tests
language     | library          | version  | success? | context
-------------|------------------|----------|----------|---------
binary       | `curl`           | `7.37.1` | yes      |
binary       | `wget`           | `1.15 `  | no       | (number) `ERROR -1: Malformed status line.`, additionally: reported with exit code 4, 'Network failure.'
perl         | `HTTP::Tiny`     | `5.10.0` | no       | (number) `ERROR: 599`
perl         | `LWP::UserAgent` | `5.10.0` | yes      |
php          | `http_get`       | `5.5.14` | no       | (number) <unknown, bug in reporting>
python       | `httplib2`       | `2.7`    | no       | (number) `BadStatusLine: HTTP/1.1 36`
python       | `urllib2`        | `2.7`    | no       | (number) `BadStatusLine: HTTP/1.1 16`
ruby         | `net-http`       | `2.2.2`  | no       | (number) `wrong status line: "HTTP/1.1 40  "`

## running tests yourself

the entrypoint to all tests is `test/<language>/<library>/test.sh` which does some dependency checking and exits with 0 to avoid false positives.

most developer machines will already have all pre-requisites

```
$ git clone https://github.com/chorankates/1863BFAF.git
$ cd 1836BFAF
$ rake test:ruby
...
$ rake test:perl test:java
...
$ rake test
```

the rake tasks start a basic WEBrick server and then executes every relevant `test.sh` file