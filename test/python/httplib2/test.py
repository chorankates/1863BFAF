#!/usr/bin/env python

import httplib2
import sys
import traceback

meta_url = 'http://1863BFAF.pwnz.org:4567/meta'
response, content = httplib2.Http().request(meta_url)
urls = content.split(',')

for url in urls:
  try:
    url = url.replace('[', '')
    url = url.replace(']', '')
    url = url.replace('"', '')
    response, content = httplib2.Http().request(url)
  except Exception:
    print traceback.print_exc(file=sys.stdout)
    sys.exit(1)

sys.exit(0)