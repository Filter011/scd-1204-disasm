patbase_kuzure_b_tbl:
	dc.w	patb00-patbase_kuzure_b_tbl
	dc.w	patb00-patbase_kuzure_b_tbl
	dc.w	patb01-patbase_kuzure_b_tbl
	dc.w	patb02-patbase_kuzure_b_tbl
	dc.w	patb03-patbase_kuzure_b_tbl
	dc.w	patb04-patbase_kuzure_b_tbl
patb00:
	dc.b	18
	dc.b	$E0,5,0,$D,$D0
	dc.b	$E0,5,0,$D,$E0
	dc.b	$E0,5,0,$D,$F0
	dc.b	$E0,5,0,$D,0
	dc.b	$E0,5,0,$D,$10
	dc.b	$E0,5,0,$D,$20
	dc.b	$F0,5,0,$11,$D0
	dc.b	$F0,5,0,$11,$E0
	dc.b	$F0,5,0,$11,$F0
	dc.b	$F0,5,0,$11,0
	dc.b	$F0,5,0,$11,$10
	dc.b	$F0,5,0,$11,$20
	dc.b	0,5,0,$15,$D0
	dc.b	0,5,0,$15,$E0
	dc.b	0,5,0,$15,$F0
	dc.b	0,5,0,$15,0
	dc.b	0,5,0,$15,$10
	dc.b	0,5,0,$15,$20
patb01:
	dc.b	20
	dc.b	$D0,5,0,$D,$E0
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$D0,5,0,$D,$10
	dc.b	$E0,5,0,$11,$E0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$E0,5,0,$11,$10
	dc.b	$F0,5,0,$15,$E0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	$F0,5,0,$15,$10
	dc.b	0,5,0,$29,$E0
	dc.b	0,5,0,$33,$F0
	dc.b	0,5,0,$33,0
	dc.b	0,5,0,$33,$10
	dc.b	$10,5,0,$31,$E0
	dc.b	$10,5,0,$2B,$F0
	dc.b	$10,5,0,$2B,0
	dc.b	$10,5,0,$2B,$10
	even
patb02:
	dc.b	20
	dc.b	$D0,5,0,$D,$E0
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$D0,5,0,$D,$10
	dc.b	$E0,5,0,$11,$E0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$E0,5,0,$11,$10
	dc.b	$F0,5,0,$15,$E0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	$F0,5,0,$15,$10
	dc.b	0,5,0,$33,$E0
	dc.b	0,5,0,$33,$F0
	dc.b	0,5,0,$33,0
	dc.b	0,5,0,$33,$10
	dc.b	$10,5,0,$2B,$E0
	dc.b	$10,5,0,$2B,$F0
	dc.b	$10,5,0,$2B,0
	dc.b	$10,5,0,$2B,$10
patb03:
	dc.b	10
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	0,5,0,$1D,$F0
	dc.b	0,5,0,$21,0
	dc.b	$10,5,0,$19,$F0
	dc.b	$10,5,0,$19,0
	even
patb04:
	dc.b	10
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	0,5,0,$21,$F0
	dc.b	0,5,8,$1D,0
	dc.b	$10,5,0,$19,$F0
	dc.b	$10,5,0,$19,0
	even