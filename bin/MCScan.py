#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# Author: fuyuan (907569282@qq.com)
# Created Time: 2019-05-16 16:00:47
# Example MCScan.py   
import sys, os, re

fp = open(sys.argv[1])

blast = ''
gff = ''

list = []
for line in fp:
		line = line.strip('\n')
		list.append(line)

for i in list:
		for j in list:
				cmd  = "source ~/.bashrc\n"
				cmd += "cp " + blast + i + '-' + j + '.m8 ' + i + '-' + j + '.blast\n'
				cmd += "cat " + gff + i + '.gff '
				if i != j:
						cmd += gff + j + '.gff '
				cmd += '|togff > ' + i + '-' + j + '.gff\n'
				cmd += "MCScanX " + i + '-' + j
				ft = open(i + '-' + j + '.sh','w')
				ft.write(cmd)
