#!/app/anaconda2/bin/python
# -*- coding: UTF-8 -*-
# Author: Yuan-SW-F, yuanswf@163.com
# Created Time: 2019-05-08 17:44:00
# Example get_genome.py   
import sys, os, re

infile = 'list'
if len(sys.argv) == 2:
		infile = sys.argv[1]
fp = os.popen('less '+infile)
http = "http://gigadb.org/search/new?keyword="
data = "http://gigadb.org/dataset/"
for line in fp:
		line = line.strip('\n')
		list = re.split('\s+',line)
		file = list[0]+'_'+list[1]
		os.system('mkdir '+file)
		readme = file + '/' + list[0]+'_'+list[1] + '.readme'
		os.system('wget ' + http + list[0] + '+' +list[1] + " -O " + readme)
		fp1 = open(readme)
		for i in fp1:
				ftp = re.search('href="(' + data + '\d+)">',i)
				if ftp:
						cmd = 'wget '+ftp.group(1) + ' -O ' + readme + '.info'
						os.system(cmd)
						fp2 = open(readme + '.info')
						for i in fp2:
								wget = re.search('href="([^\"]+)"\>\(FTP site\)',i)
								if wget:
										cmd = 'cd '+file+';wget '+wget.group(1)+'*;cd -'
										os.system(cmd)
										os.system('rm '+readme+'*;echo "'+wget.group(1)+'" > '+readme+'.md')
#										break
								wget = re.search('href="([^\"]+gz)"\>',i)
								if wget:
										re_f = re.search('([^\/]+$)',wget.group(1))
										if not os.path.exists(file+'/'+re_f.group(1)):
												os.system('cd '+file+';wget '+wget.group(1)+';cd -')
						break
