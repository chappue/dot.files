# -*- coding: utf-8 -*-
## ustr.py --- Pymacs で、ユニコード文字列使うためのモジュール

def ustring2bytes(ustring):
    """
    ユニコード文字列に対するユニバイトのリストを返す
    つまり u'森鴎外' ==> [104,238,157,14,89,22] という変換をする。
    これは、elisp 側で、↓のようにして元の文字列に戻せる(mule-ucs が必要)
    (decode-coding-string (concat '(104 238 157 14 89 22)) 'utf-16be)
    """
    # Pythonのユニコード文字列を、キャラクタコード(2Byte)のリストに変換
    # u'森鴎外' ==> [26862, 40206, 22806]
    chr_codes = [ord(c) for c in ustring]

    # キャラクタコードを、ユニバイトリストにして返す
    # [26862, 40206, 22806] ==> [104,238,157,14,89,22]
    return wbyte_seq_to_unibyte_seq(chr_codes)

def bytes2ustring(bytes):
    """
    ユニバイトのリストをユニコード文字列に変換する。
    つまり [104,238,157,14,89,22] ==> u'森鴎外'という変換をする。
    これによって、elisp 側で以下のようにバイト列に変換された文字列を復元
    (vconcat (encode-coding-string \"森鴎外\" 'utf-16be))
    """
    return repr(reduce((lambda x,y: x+y),
		  [unichr(c) for c in unibyte_seq_to_wbyte_seq(bytes)]))

def unibyte_seq_to_wbyte_seq(seq):
    '''ユニバイトの列をダブルバイトのリストに変換する。
    例えば、 [0,116,0,104,0,105,0,115,104,238] ==> [116,104,105,26862]'''
    
    base = 16 ** 2
    result = []
    
    for i in range(0,len(seq),2): # [0,2,4...]
	result.append(seq[i] * base + seq[i+1])

    return result

def wbyte_seq_to_unibyte_seq(seq):
    '''ダブルバイトの列をユニバイトのリストに変換する。
    例えば、 [116,104,105,26862] ==> [0,116,0,104,0,105,0,115,104,238]'''

    base = 16 ** 2
    result = []
    
    for i in range(len(seq)): 
	result.append(seq[i] / base)	# 上位バイト
	result.append(seq[i] % base)	# 下位バイト
    return result
