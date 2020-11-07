#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# Author: Yuan-SW-F, yuanswf@163.com
# Created Time: 2019-05-13 13:54:25
# Example chioce_sp.py   
import sys, os, re

fp1 = open(sys.argv[1])
fp2 = open(sys.argv[2])
if len(sys.argv) != 3:
		exit('chioce_sp_from_roast.py sp.list MSA')
dict_sp = {}
for line in fp1:
		re_sp = re.search('(\w+)',line)
		dict_sp[re_sp.group(1)] = 1
head = fp2.readline()
print head
list = []
for line in fp2:
		re_line = re.match('^(\S)',line)
		if re_line:
				id = re_line.group(1)
				if id == "#":
						continue
				if id == 'a':
						if len(list) >= 2:
								print "".join(list)
						list = []
						list.append(line)
				if id == 's':
						re_id = re.search('\S\s+(\w+)',line)
						if re_id:
								if dict_sp.has_key(re_id.group(1)):
										list.append(line)
