# -*- coding: utf-8 -*-

import dircache, os, codecs, string
from Pymacs import lisp
from ustr import *

interactions = {}

def nippou():
    "get leatest nippou data"
    recent_howm_dirs=[]
    howm_files={}
    howm_path = 'c:\\tanemura_work\\document\\home\\.emacs.d\\howm\\'
    nippou_data = ''
    for years in filter(lambda x: os.path.isdir(howm_path + x), os.listdir(howm_path)):
        for month in filter(lambda x: os.path.isdir(os.path.join(howm_path, years, x)), os.listdir(os.path.join(howm_path, years))):
            recent_howm_dirs.append(os.path.join(years, month))

    for howm_dir in recent_howm_dirs[-2:]:
        for dirname, dirnames, filenames in os.walk(os.path.join(howm_path, howm_dir)):
            for fname in filenames:
                title = codecs.open(os.path.join(dirname, fname), 'r', 'Shift-JIS').readline()
                if 0 < title.find(u'[日報]'):
                    date = title[-10:].replace('/', '').replace('\r\n', '')
                    howm_files.update({date: os.path.join(dirname, fname)})

    f = codecs.open(howm_files.get(max(howm_files.keys())), 'r', 'Shift-JIS')
    nippou_data = my_readlines(f, 2, -3)
    f.close()

    return lisp.py_string(ustring2bytes(nippou_data))

def my_readlines(fh, st, ed):
    line_max = 0
    data = []
    ret_str = ''

    for line in fh:
        data.append(line)
        line_max = line_max + 1

    if ed < 0:
        ed = line_max + ed
    else:
        if line_max < ed:
            ed = line_max

    for i in range(st, ed+1):
        ret_str = ret_str + data[i]

    return ret_str

interactions[nippou] = ''
