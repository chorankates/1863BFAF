#!/usr/bin/python

import urllib2
import sys
import traceback

meta_url = 'http://1863BFAF.pwnz.org:4567/meta'
meta = urllib2.urlopen(meta_url).read()

urls = meta.split(',')

for url in urls:
  try:
    url = url.replace('[', '')
    url = url.replace(']', '')
    url = url.replace('"', '')
    response = urllib2.urlopen(url).read()
  except Exception:
    print traceback.print_exc(file=sys.stdout)
    sys.exit(1)

sys.exit(0)