patbase_kuzure_a_tbl:
	dc.w	pata00-patbase_kuzure_a_tbl

pata00:
	dc.b	23
	dc.b	$D0,5,8,1,$D8
	dc.b	$D0,5,8,1,$E8
	dc.b	$D0,5,8,1,-8
	dc.b	$D0,5,8,1,8
	dc.b	$D0,5,8,1,$18
	dc.b	$E0,5,8,5,$D8
	dc.b	$E0,5,8,5,$E8
	dc.b	$E0,5,8,5,-8
	dc.b	$E0,5,8,5,8
	dc.b	$E0,5,8,5,$18
	dc.b	$F0,5,0,$11,$D8
	dc.b	$F0,5,8,9,$E8
	dc.b	$F0,5,8,9,-8
	dc.b	$F0,5,8,9,8
	dc.b	$F0,5,8,9,$18
	dc.b	0,5,8,$19,$D8
	dc.b	0,5,0,$15,$E8
	dc.b	0,5,0,$D,-8
	dc.b	0,5,0,$D,8
	dc.b	0,5,8,$15,$18
	dc.b	$10,5,0,$11,-8
	dc.b	$10,5,0,$11,8
	dc.b	$10,5,0,$11,$18
	even