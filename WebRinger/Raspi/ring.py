#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import urllib2

getFunction = 'http://127.0.0.1:8000/GPIO/4/function'
setOutput =  'http://127.0.0.1:8000/GPIO/4/function'
setPulse = 'http://127.0.0.1:8000/GPIO/4/pulse/'

passMgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
passMgr.add_password(None, 'http://127.0.0.1:8000/', 'webiopi', 'raspberry')
authHandler = urllib2.HTTPBasicAuthHandler(passMgr)
opener = urllib2.build_opener(authHandler)
urllib2.install_opener(opener)

function = urllib2.urlopen(getFunction).read()

if function != 'OUT':
  urllib2.urlopen(setOutput, '').read()

data = urllib2.urlopen(setPulse, '').read()

print "Content-Type: text/html\n\n<h1>ring! "+function+"</h1>"

