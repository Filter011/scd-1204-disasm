scorepat_tbl:
	dc.w	scoresp00-scorepat_tbl
	dc.w	scoresp01-scorepat_tbl
	dc.w	scoresp02-scorepat_tbl
scoresp00:
	dc.b	17
	dc.b	0,1,0,0,0
	dc.b	0,5,0,2,8
	dc.b	0,1,0,6,$18
	dc.b	0,1,0,8,$20
	dc.b	0,9,0,$1B,$30
	dc.b	0,9,0,$21,$48
	dc.b	$10,9,0,$A,0
	dc.b	$10,1,0,8,$18
	dc.b	$10,1,0,$27,$28
	dc.b	$10,0,0,$18,$30
	dc.b	$10,5,0,$29,$38
	dc.b	$10,0,0,$19,$48
	dc.b	$10,5,0,$2D,$50
	dc.b	$20,1,0,$10,0
	dc.b	$20,9,0,$12,8
	dc.b	$20,1,0,0,$20
	dc.b	$20,9,0,$31,$30
	even
scoresp01:
	dc.b	3
	dc.b	0,5,0,$37,0
	dc.b	8,0,0,$1A,$10
	dc.b	0,1,0,$3B,$18
	even
scoresp02:
	dc.b	14
	dc.b	0,1,0,0,0
	dc.b	0,5,0,2,8
	dc.b	0,1,0,6,$18
	dc.b	0,1,0,8,$20
	dc.b	0,9,0,$1B,$30
	dc.b	0,9,0,$21,$48
	dc.b	$10,9,0,$A,0
	dc.b	$10,1,0,8,$18
	dc.b	$10,5,0,$29,$40
	dc.b	$10,5,0,$2D,$50
	dc.b	$20,1,0,$10,0
	dc.b	$20,9,0,$12,8
	dc.b	$20,1,0,0,$20
	dc.b	$20,9,0,$31,$30
	even