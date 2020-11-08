#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# Author: Yuan-SW-F, yuanswf@163.com
# Created Time: 2019-05-29 13:20:56
# Example wig2bed.py   
import sys, os, re

fp = open(sys.argv[1])

for line in fp:
		line = line.strip()
		re_head = re.search('chrom=(\S+)\s+start=(\d+)',line)
		if re_head:
				chr = re_head.group(1)
				i = re_head.group(2)
				i = int(i)-1
		else:
				print "{}\t{}\t{}\t{}".format(chr, i, i+1, line)
				i += 1
