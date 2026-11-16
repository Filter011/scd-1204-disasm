k_daipat_tbl:
	dc.w	k_daipat0-k_daipat_tbl
	dc.w	k_daipat1-k_daipat_tbl
	dc.w	k_daipat2-k_daipat_tbl
k_daipat0:
	dc.b	2
	dc.b	-8,5,0,0,$F0
	dc.b	-8,5,8,0,0
	even
k_daipat1:
	dc.b	2
	dc.b	-8,5,0,0,$F0
	dc.b	-8,5,8,0,0
	even
k_daipat2:
	dc.b	1
	dc.b	-8,$D,0,4,$F0
	even