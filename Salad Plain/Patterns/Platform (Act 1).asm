dai11a_pat_tbl:
	dc.w	dai11a_pat1-dai11a_pat_tbl
	dc.w	dai11a_pat2-dai11a_pat_tbl
	dc.w	dai11a_pat3-dai11a_pat_tbl
dai11a_pat1:
	dc.b	4
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,8,1,0
	dc.b	0,5,0,5,$F0
	dc.b	0,5,8,5,0
	even
dai11a_pat2:
	dc.b	8
	dc.b	$F0,5,0,1,$E0
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,0,1,0
	dc.b	$F0,5,0,1,$10
	dc.b	0,5,0,5,$E0
	dc.b	0,5,0,9,$F0
	dc.b	0,5,0,9,0
	dc.b	0,5,8,5,$10
	even
dai11a_pat3:
	dc.b	12
	dc.b	$F0,5,0,1,$D0
	dc.b	$F0,5,0,1,$E0
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,0,1,0
	dc.b	$F0,5,0,1,$10
	dc.b	$F0,5,0,1,$20
	dc.b	0,5,0,5,$D0
	dc.b	0,5,0,9,$E0
	dc.b	0,5,0,9,$F0
	dc.b	0,5,0,9,0
	dc.b	0,5,0,9,$10
	dc.b	0,5,8,5,$20
	even