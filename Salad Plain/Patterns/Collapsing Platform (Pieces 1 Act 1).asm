patc_tbl:
	dc.w	patc00-patc_tbl
	dc.w	patc01-patc_tbl
	dc.w	patc02-patc_tbl
	dc.w	patc03-patc_tbl
	dc.w	patc04-patc_tbl
	dc.w	patc05-patc_tbl
	dc.w	patc06-patc_tbl

patc00:
	dc.b	1
	dc.b	-8,5,0,$19,-8
	even
patc01:
	dc.b	1
	dc.b	-8,5,8,$25,-8
	even
patc02:
	dc.b	1
	dc.b	-8,5,0,$1D,-8
	even
patc03:
	dc.b	1
	dc.b	-8,5,0,$21,-8
	even
patc04:
	dc.b	1
	dc.b	-8,5,8,$1D,-8
	even
patc05:
	dc.b	1
	dc.b	-8,5,8,$15,-8
	even
patc06:
	dc.b	2
	dc.b	$E8,5,8,$D,-8
	dc.b	-8,5,8,$11,-8
	even