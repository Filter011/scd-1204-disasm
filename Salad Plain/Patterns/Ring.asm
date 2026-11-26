ringpat_tbl:
	dc.w	ringsp0-ringpat_tbl
	dc.w	ringsp1-ringpat_tbl
	dc.w	ringsp2-ringpat_tbl
	dc.w	ringsp3-ringpat_tbl
	dc.w	ringsp4-ringpat_tbl
	dc.w	ringsp5-ringpat_tbl
	dc.w	ringsp6-ringpat_tbl
	dc.w	ringsp7-ringpat_tbl
	dc.w	ringsp8-ringpat_tbl
ringsp0:
	dc.b	1
	dc.b	-8,5,0,0,-8
	even
ringsp1:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even
ringsp2:
	dc.b	1
	dc.b	-8,1,0,8,-4
	even
ringsp3:
	dc.b	1
	dc.b	-8,5,8,4,-8
	even
ringsp4:
	dc.b	1
	dc.b	-8,5,0,$A,-8
	even
ringsp5:
	dc.b	1
	dc.b	-8,5,$18,$A,-8
	even
ringsp6:
	dc.b	1
	dc.b	-8,5,$10,$A,-8
	even
ringsp7:
	dc.b	1
	dc.b	-8,5,8,$A,-8
	even
ringsp8:
	dc.b	0
	even