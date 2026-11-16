b_chou_pat_tbl:
	dc.w	byte_20B0EC-b_chou_pat_tbl
	dc.w	byte_20B0FC-b_chou_pat_tbl
	dc.w	byte_20B10C-b_chou_pat_tbl
	dc.w	byte_20B0EC-b_chou_pat_tbl
	dc.w	byte_20B0FC-b_chou_pat_tbl
	dc.w	byte_20B10C-b_chou_pat_tbl
byte_20B0EC:
	dc.b	3
	dc.b	$F0,8,0,0,-8
	dc.b	-8,$D,0,$22,$F0
	dc.b	8,8,0,$B,$F0
	even
byte_20B0FC:
	dc.b	3
	dc.b	-8,9,0,$E,$F0
	dc.b	0,0,0,$14,8
	dc.b	8,0,0,$15,0
	even
byte_20B10C:
	dc.b	3
	dc.b	$F0,0,0,$16,$F0
	dc.b	-8,8,0,$17,$F0
	dc.b	0,$D,0,$2A,$F0
	even