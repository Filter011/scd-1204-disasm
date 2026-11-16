ari_pat_tbl:
	dc.w	byte_20B1B6-ari_pat_tbl
	dc.w	byte_20B1C6-ari_pat_tbl
	dc.w	byte_20B1CC-ari_pat_tbl
	dc.w	byte_20B1D2-ari_pat_tbl
	dc.w	byte_20B1D8-ari_pat_tbl
	dc.w	byte_20B1DE-ari_pat_tbl
	dc.w	byte_20B14E-ari_pat_tbl
	dc.w	byte_20B168-ari_pat_tbl
	dc.w	byte_20B182-ari_pat_tbl
	dc.w	byte_20B19C-ari_pat_tbl
byte_20B14E:
	dc.b	5
	dc.b	$EA,5,0,0,$F4
	dc.b	$FA,0,0,4,$F4
	dc.b	$FA,5,0,5,-4
	dc.b	2,5,0,9,-8
	dc.b	$FA,0,0,$11,$E
	even
byte_20B168:
	dc.b	5
	dc.b	$EB,5,0,0,$F4
	dc.b	$FB,0,0,4,$F4
	dc.b	$FB,5,0,5,-4
	dc.b	2,5,0,$D,-8
	dc.b	$FA,0,0,$11,$12
	even
byte_20B182:
	dc.b	5
	dc.b	$EA,5,0,$12,$F4
	dc.b	$FA,0,0,4,$F4
	dc.b	$FA,5,0,5,-4
	dc.b	2,5,0,9,-8
	dc.b	$FA,0,0,$11,$E
	even
byte_20B19C:
	dc.b	5
	dc.b	$EB,5,0,$12,$F4
	dc.b	$FB,0,0,4,$F4
	dc.b	$FB,5,0,5,-4
	dc.b	2,5,0,$D,-8
	dc.b	$FA,0,0,$11,$12
	even
byte_20B1B6:
	dc.b	3
	dc.b	$F0,5,0,0,$F4
	dc.b	0,0,0,4,$F4
	dc.b	0,5,0,5,-4
	even
byte_20B1C6:
	dc.b	1
	dc.b	-8,5,0,9,-8
	even
byte_20B1CC:
	dc.b	1
	dc.b	-8,5,0,$D,-8
	even
byte_20B1D2:
	dc.b	1
	dc.b	-4,0,0,$11,-4
	even
byte_20B1D8:
	dc.b	1
	dc.b	-4,0,0,$11,0
	even
byte_20B1DE:
	dc.b	3
	dc.b	$F0,5,0,$12,$F4
	dc.b	0,0,0,4,$F4
	dc.b	0,5,0,5,-4
	even