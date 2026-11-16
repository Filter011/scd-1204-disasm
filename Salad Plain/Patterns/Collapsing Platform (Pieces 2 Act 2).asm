patd_tbl:
	dc.w	patd00-patd_tbl
	dc.w	patd01-patd_tbl
patd00:
	dc.b	4
	dc.b	$D8,5,0,1,-8
	dc.b	$E8,5,0,5,-8
	dc.b	-8,5,0,9,-8
	dc.b	8,5,0,$D,-8
patd01:
	dc.b	3
	dc.b	$E0,5,0,1,-8
	dc.b	$F0,5,0,5,-8
	dc.b	0,5,0,9,-8
	even