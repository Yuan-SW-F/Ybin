#!/public/agis/chengshifeng_group/fuyuan/pip-fuyuan/app/anaconda2/bin/python
# -*- coding: UTF-8 -*-
# Author: fuyuan (907569282@qq.com)
# Created Time: 2019-04-24 15:42:45
# Example annotation_cns.py   
import sys, os, re

gff = sys.argv[1]
bed = sys.argv[2]

fp1 = open(gff)
fp2 = open(bed)

chrs = []
charas = []
character = {}
count = {}
cns = {}
ann = {}
c_cns = 0
ori = {}
for line in fp2:
		line = line.strip('\n')
		list = re.split('\t',line)
		id = list[0]
		list[1] = int(list[1])
		list[2] = int(list[2])
		start = list[1]
		end = list[2]
		c_cns += 1
		for i in range(int(start), int(end+1)):
				if not cns.has_key(id):
						cns[id] = {}
				if not cns[id].has_key(i):
						cns[id][i] = 'cns' + str(c_cns) + ';Class='
				if not ann.has_key(id):
						ann[id] = {}
				if not ann[id].has_key(i):
						ann[id][i] = 'cns' + str(c_cns) + ';ID='
				if not ori.has_key(id):
						ori[id] = {}
				if not ori[id].has_key(i):
						ori[id][i] = '.'


intron = []
c_i = 0
s_i = []
i_ann = ''
sss = ''
eee = ''
for line in fp1:
		ignore = re.match('#',line)
		if ignore:
				continue
		line = line.strip('\n')
		list = re.split('\t',line)
		chr = list[0]
		chara = list[2]
		list[3] = int(list[3])
		list[4] = int(list[4])

		if list[3] > list[4]:
				list[3,4] = list[4,3]

		ann_re = re.search('ID=([^\;\s]+)',list[8])
### intron
		start_i = 0
		end_i = 0
		if c_i == 2:
				if list[6] == '+':
						start_i = list[4]
						end_i = s_i[3]
				else:
						start_i = s_i[4]
						end_i = list[3]
				c_i = 1
### annotation
				for n in range(start_i+1,end_i+1):
						if cns.has_key(chr):
								if cns[chr].has_key(n):
										cns[chr][n] += "intron,"
										ann[chr][n] += "intron:" + i_ann + ann_re.group(1) + ";"
### annotation
		if chara == 'mRNA':
				c_i = 0
		if chara == 'gene':
				if list[6] == "+":
						sss = "upstream"
						eee = "downstream"
						if cns.has_key(chr):
								if cns[chr].has_key(list[3]):
										cns[chr][list[3]] += "TSS,"
										ann[chr][list[3]] += "TSS:" + ann_re.group(1) + ";"
										ori[chr][list[3]] = list[6]
								if cns[chr].has_key(list[4]):
										cns[chr][list[4]] += "TES,"
										ann[chr][list[4]] += "TES:" + ann_re.group(1) + ";"
										ori[chr][list[4]] = list[6]

				else:
						sss = "downstream"
						eee = "upstream"
						if cns.has_key(chr):
								if cns[chr].has_key(list[3]):
										cns[chr][list[3]] += "TES,"
										ann[chr][list[3]] += "TES:" + ann_re.group(1) + ";"
										ori[chr][list[3]] = list[6]
								if cns[chr].has_key(list[4]):
										cns[chr][list[4]] += "TSS,"
										ann[chr][list[4]] += "TSS:" + ann_re.group(1) + ";"
										ori[chr][list[4]] = list[6]

#				if cns.has_key(chr):
#						if cns[chr].has_key(list[3]):
#								cns[chr][ss] += stream + ","
#								ann[chr][ss] += stream + ":" + ann_re.group(1) + ";"
#								ori[chr][ss] = list[6]

				if list[3]-500 > 0:
						for ss in range(list[3]-500,list[3]+1):
								if cns.has_key(chr):
										if cns[chr].has_key(ss):
												cns[chr][ss] += sss + ","
												ann[chr][ss] += sss + ":" + ann_re.group(1) + ";"
												ori[chr][ss] = list[6]
				else:
						for ss in range(1,list[3]+1):
								if cns.has_key(chr):
										if cns[chr].has_key(ss):
												cns[chr][ss] += sss + ","
												ann[chr][ss] += sss + ":" + ann_re.group(1) + ";"
												ori[chr][ss] = list[6]
				for es in range(list[4]+1,list[4]+502):
						if cns.has_key(chr):
								if cns[chr].has_key(es):
										cns[chr][es] += eee + ","
										ann[chr][es] += eee + ":" + ann_re.group(1) + ";"
										ori[chr][es] = list[6]

		if chara == 'exon':
				c_i += 1
				s_i = list
				i_ann = ann_re.group(1)

		for nn in range(list[3],list[4]+1):
				if cns.has_key(chr):
						if cns[chr].has_key(nn):
								cns[chr][nn] += chara + ","
								ann[chr][nn] += ann_re.group(1) + ";"
								ori[chr][nn] = list[6]

fp3 = open(bed)
for line in fp3:
		line = line.strip('\n')
		list = re.split('\t',line)
		id = list[0]
		list[1] = int(list[1])
		list[2] = int(list[2])
		start = list[1]
		end = list[2]
		for i in range(start,end+1):
				if cns.has_key(id):
						if cns[id].has_key(i):
								re_cns = re.search('=$',cns[id][i])
								if re_cns:
										cns[id][i] += 'distal;'
								re_ann = re.search('=$',ann[id][i])
								if re_ann:
										ann[id][i] += 'distal;'
								print '{}\t{}\t{}\t{}\t{}'.format(id, i, ori[id][i], cns[id][i], ann[id][i])
