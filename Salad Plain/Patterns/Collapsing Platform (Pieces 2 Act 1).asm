patd_tbl:
	dc.w	patd00-patd_tbl
	dc.w	patd01-patd_tbl
	dc.w	patd02-patd_tbl
	dc.w	patd03-patd_tbl
	dc.w	patd04-patd_tbl
	dc.w	patd05-patd_tbl
patd00:
	dc.b	3
	dc.b	$E0,5,0,$D,-8
	dc.b	$F0,5,0,$11,-8
	dc.b	0,5,0,$15,-8
	even
patd01:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$29,-8
	dc.b	$10,5,0,$31,-8
	even
patd02:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$33,-8
	dc.b	$10,5,0,$2B,-8
	even
patd03:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$1D,-8
	dc.b	$10,5,0,$19,-8
	even
patd04:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,8,$1D,-8
	dc.b	$10,5,0,$19,-8
	even
patd05:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$21,-8
	dc.b	$10,5,0,$19,-8
	even