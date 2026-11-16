blockpat_tbl:
	dc.w	byte_209048-blockpat_tbl
	dc.w	byte_20904A-blockpat_tbl
	dc.w	byte_20905A-blockpat_tbl
	dc.w	byte_20906A-blockpat_tbl
	dc.w	byte_209076-blockpat_tbl
	dc.w	byte_209082-blockpat_tbl
byte_209048:
	dc.b	0
	even
byte_20904A:
	dc.b	3
	dc.b	$F4,9,0,0,$F4
	dc.b	4,0,0,0,$FC
	dc.b	4,0,0,0,4
	even
byte_20905A:
	dc.b	3
	dc.b	$F4,9,8,0,$F4
	dc.b	4,0,8,0,$F4
	dc.b	4,0,8,0,$FC
byte_20906A:
	dc.b	2
	dc.b	$F4,9,$18,0,$F4
	dc.b	4,0,$18,0,$FC
	even
byte_209076:
	dc.b	2
	dc.b	$F4,9,$10,0,$F4
	dc.b	4,0,$10,0,$FC
	even
byte_209082:
	dc.b	1
	dc.b	$F4,$A,0,6,$F4
	even