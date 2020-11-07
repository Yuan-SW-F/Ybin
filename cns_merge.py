#!app/anaconda2/bin/python
# -*- coding: UTF-8 -*-
# Author: Yuan-SW-F, yuanswf@163.com
# Created Time: 2019-04-25 14:42:50
# Example cns_merge.py   
import sys, os, re

fp = open(sys.argv[1])
loc = 0
count = 0
start = 0
end = 0
word = ''
for line in fp:
		line = line.strip('\n')
		list = re.split('\s+',line)
		list[1] = int(list[1])
		if list[-1] == word:
				end = list[1]
		else:
				word = list[-1]
				if start > 0:
						print '{}\t{}\t{}\t'.format(list[0], start, end),
						print '\t'.join(list[2:])

				start = list[1]

print '{}\t{}\t{}\t'.format(list[0], start, end),
print '\t'.join(list[2:])

