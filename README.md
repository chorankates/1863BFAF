# 1863BFAF
apparently we're the RFC police.

1863BFAF is a project to validate adherence to HTTP/1.1 as defined by [RFC2616](https://www.ietf.org/rfc/rfc2616.txt)

# storytime

we found this problem while writing some exploratory Ruby code using Sinatra and Sequel, which boiled down to:
```rb
require 'sequel'
require 'sinatra'

# model
class Foo < Sequel::Model
...
end

# database
db = Sequel.connect('sqlite://test.db')
db.create_table? :bar do
  primary_key :id
  String :name
end

# routes
post '/api/baz' do
  db[:foo].insert(params['fizz'])
end

```

and when trying to test it with `wget --post-data 'fizz=buzz' http://localhost:4567/api/baz`, were seeing unexpected results to seemingly innocuous HTTP requests..

wget -O- --post-data='{"some data to post..."}' --header=Content-Type:application/json "http://www.example.com:9000/json"

so we tried `curl -d fizz=buzz -X POST http://localhost:4567/api/baz`, didn't have the same problem, and kept moving forward with the POC.

but something was wrong - and for ~once, it wasn't our code.

# what is the problem?

(presumed/usually) regular expressions/parsing mechanisms that do not strictly follow RFC2616.

and less apocalyptically: Sinatra was following Ruby standards and returning the result of the last line of the route method - which in our case was the ID of the entry in the DB

# tests
language     | library          | language version | library version  | success? | context
-------------|------------------|------------------|------------------|----------|---------
binary       | `curl`           | `7.37.1` | N/A | yes       |
binary       | `wget`           | `1.15`   | N/A | no        | (number) `ERROR -1: Malformed status line.`, additionally: reported with exit code 4, 'Network failure.'
java         | `java.net.UrlHTTPConnection` | `1.7` | `1.7` | yes/no  | (number) body is conflated as HTTP status code, that even when invalid, no error is raised - so we raise our own
perl         | `HTTP::Tiny`     | `5.10.0`,  `5.18.2` | `0.025` | no       | (number) `ERROR: 599`
perl         | `LWP::UserAgent` | `5.10.0`, `5.18.2` | `6.05` | yes      |
php          | `http_get`       | `5.5.14` | `468225` | no       | (number) <unknown, bug in reporting>
python       | `httplib2`       | `2.7.5`  | `2.7.5` | no       | (number) `BadStatusLine: HTTP/1.1 36`
python       | `urllib2`        | `2.7.5`  | `2.7`   | no       | (number) `BadStatusLine: HTTP/1.1 16`
ruby         | `net-http`       | `2.2.2`  | `2.2.2` | no       | (number) `wrong status line: "HTTP/1.1 40  "`

`599`, `36`, `16` and `40` are not error codes returned by the library/binary, but the random number returned by our `number` route

## running tests yourself

the entry point to all* tests is `test/<language>/<library>/test.sh` which does some dependency checking and exits with 0 to avoid false positives.

most developer machines will already have all pre-requisites

\* for tests that use binary files directly, the expected path changes to `test/binary/<binary>/test.sh`

### pre-built gem installation (stable)

[![Gem Version](https://badge.fury.io/rb/1863BFAF.png)](https://rubygems.org/gems/1863BFAF)

```sh
$ gem install 1863BFAF
...
$ echo $?
0
```

### from-source installation (latest)

```sh
$ git clone https://github.com/chorankates/1863BFAF.git
$ cd 1836BFAF
$ bundle install
...
$ rake server
== Sinatra (v1.4.7) has taken the stage on 4567 for development with backup from WEBrick
$ rake test
...
failed[7]
tests[
binary/wget
java/java.net
perl/httptiny
php/http_get
python/httplib2
python/urllib2
ruby/net-https]
$ echo $?
0
$ rake test:perl test:java
...
$ echo $?
0
...
$ rake server:stop
== Sinatra has ended his set (crowd applauds)
```
