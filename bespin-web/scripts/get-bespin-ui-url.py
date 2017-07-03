#!/usr/bin/env python
import urllib2
import json

releases_url = 'https://api.github.com/repos/Duke-GCB/bespin-ui/releases/latest'

f = urllib2.urlopen(releases_url)
print json.loads(f.read())['assets'][0]['browser_download_url']
