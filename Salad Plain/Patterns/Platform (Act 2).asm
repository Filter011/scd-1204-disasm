dai12a_pat_tbl:
	dc.w	byte_20DB58-dai12a_pat_tbl
	dc.w	byte_20DB6E-dai12a_pat_tbl
	dc.w	byte_20DB98-dai12a_pat_tbl
byte_20DB58:
	dc.b	4
	dc.b	$F0,5,0,$31,$F0
	dc.b	$F0,5,8,$31,0
	dc.b	0,5,0,$35,$F0
	dc.b	0,5,8,$35,0
	even
byte_20DB6E:
	dc.b	8
	dc.b	$F0,5,0,$31,$E0
	dc.b	$F0,5,8,$31,$F0
	dc.b	0,5,0,$35,$E0
	dc.b	0,5,8,$35,$F0
	dc.b	$F0,5,0,$31,0
	dc.b	$F0,5,8,$31,$10
	dc.b	0,5,0,$35,0
	dc.b	0,5,8,$35,$10
	even
byte_20DB98:
	dc.b	12
	dc.b	$F0,5,0,$31,$D0
	dc.b	$F0,5,8,$31,$E0
	dc.b	0,5,0,$35,$D0
	dc.b	0,5,8,$35,$E0
	dc.b	$F0,5,0,$31,$F0
	dc.b	$F0,5,8,$31,0
	dc.b	0,5,0,$35,$F0
	dc.b	0,5,8,$35,0
	dc.b	$F0,5,0,$31,$10
	dc.b	$F0,5,8,$31,$20
	dc.b	0,5,0,$35,$10
	dc.b	0,5,8,$35,$20
	even