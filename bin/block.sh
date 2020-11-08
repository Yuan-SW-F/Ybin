#!/bin/bash
# File Name: block.sh
# Author  : Yuan-SW-F, yuanswf@163.com
# Created Time: Fri 23 Nov 2018 08:59:16 PM HKT
mkdir ../6block | ls *html | perl -ne 'chomp; `mv $_ ../6block` if `grep -P "<td>6</td>" $_` '
mkdir ../5block | ls *html | perl -ne 'chomp; `mv $_ ../5block` if `grep -P "<td>5</td>" $_` '
mkdir ../4block | ls *html | perl -ne 'chomp; `mv $_ ../4block` if `grep -P "<td>4</td>" $_` '
mkdir ../3block | ls *html | perl -ne 'chomp; `mv $_ ../3block` if `grep -P "<td>3</td>" $_` '
mkdir ../2block | ls *html | perl -ne 'chomp; `mv $_ ../2block` if `grep -P "<td>2</td>" $_` '
mkdir ../1block | ls *html | perl -ne 'chomp; `mv $_ ../1block` if `grep -P "<td>1</td>" $_` '

