#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# Author: Yuan-SW-F, yuanswf@163.com
# Created Time: 2019-05-20 13:28:33
# Example mummer2maf.py   
import sys, os, re

def mer2axt(cmd):
	fp = os.popen(cmd)
	tmp = fp.readline()
	tmp = fp.readline()
	tmp = fp.readline()
	
	ids = fp.readline()
	re_id = re.search('(\S+)\s+and\s+(\S+)',ids)
	tmp = fp.readline()
	
	locs = fp.readline()
	re_loc = re.search('\[\s+(.*)\s+\]',locs)
	if re_loc:
			list = re.split('\s+',re_loc.group(1))


	tmp = fp.readline()
	tmp = fp.readline()

	ref = ''
	que = ''
	ref_seq = ''
	que_seq = ''

	mref = 0
	for line in fp:
			re_line = re.match('\d+\s+(\S+)',line)
			if re_line:
					if mref == 0:
							ref += re_line.group(1)
							mref = 1
					else:
							que += re_line.group(1)
							mref = 0
		
	list[5] = list[5].replace('1','')
	print ' ' + " ".join([re_id.group(1),list[1],list[3],re_id.group(2),list[6],list[8],list[5]])
	ref = ref.upper()
	ref = ref.replace('.','-')
	print ref
	que = que.upper()
	que = que.replace('.','-')
	print que

fpp = open(sys.argv[1])
count = -1
for i in fpp:
		re_i = re.match('>(\S+)\s+(\S+)',i)
		if re_i:
				count += 1
				cmd = 'show-aligns ' + sys.argv[1] + ' ' + re_i.group(1) + ' ' + re_i.group(2)
				print count,
				mer2axt(cmd)

