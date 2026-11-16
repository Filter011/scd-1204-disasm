e_chou_pat_tbl:
	dc.w	byte_20B096-e_chou_pat_tbl
	dc.w	byte_20B0A6-e_chou_pat_tbl
	dc.w	byte_20B0B6-e_chou_pat_tbl
	dc.w	byte_20B096-e_chou_pat_tbl
	dc.w	byte_20B0A6-e_chou_pat_tbl
	dc.w	byte_20B0B6-e_chou_pat_tbl
byte_20B096:
	dc.b	3
	dc.b	$F0,8,0,0,-8
	dc.b	-8,$D,0,3,$F0
	dc.b	8,8,0,$B,$F0
	even
byte_20B0A6:
	dc.b	3
	dc.b	-8,9,0,$E,$F0
	dc.b	0,0,0,$14,8
	dc.b	8,0,0,$15,0
	even
byte_20B0B6:
	dc.b	3
	dc.b	$F0,0,0,$16,$F0
	dc.b	-8,8,0,$17,$F0
	dc.b	0,$D,0,$1A,$F0
	even