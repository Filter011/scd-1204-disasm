togepat_tbl:
	dc.w	byte_20CF9C-togepat_tbl
	dc.w	byte_20CFA7-togepat_tbl
	dc.w	byte_20CFBC-togepat_tbl
	dc.w	byte_20CFD1-togepat_tbl
	dc.w	byte_20CFD8-togepat_tbl
	dc.w	byte_20CFDE-togepat_tbl
byte_20CF9C:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20CFA7:
	dc.b	4
	dc.b	$F0,$C,0,8,$F0
	dc.b	-8,$C,0,8,$F0
	dc.b	0,$C,0,8,$F0
	dc.b	8,$C,0,8,$F0
	even
byte_20CFBC:
	dc.b	4
	dc.b	$F0,$C,8,8,$F0
	dc.b	-8,$C,8,8,$F0
	dc.b	0,$C,8,8,$F0
	dc.b	8,$C,8,8,$F0
byte_20CFD1:
	dc.b	1
	dc.b	$F0,3,0,0,-4
	even
byte_20CFD8:
	dc.b	1
	dc.b	-4,$C,0,8,$F0
	even
byte_20CFDE:
	dc.b	1
	dc.b	-4,$C,8,8,$F0
	even