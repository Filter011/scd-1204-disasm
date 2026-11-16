banepat:
	dc.w	banevsp00-banepat
	dc.w	banevsp01-banepat
	dc.w	banevsp02-banepat
	dc.w	banehsp00-banepat
	dc.w	banehsp01-banepat
	dc.w	banehsp02-banepat

banevsp00:
	dc.b	2
	dc.b	-8,$C,0,0,$F0
	dc.b	0,$C,0,4,$F0
banevsp01:
	dc.b	1
	dc.b	0,$C,0,0,$F0
banevsp02:
	dc.b	3
	dc.b	$E8,$C,0,0,$F0
	dc.b	$F0,5,0,8,-8
	dc.b	0,$C,0,$C,$F0
banehsp00:
	dc.b	1
	dc.b	$F0,7,0,0,-8
banehsp01:
	dc.b	1
	dc.b	$F0,3,0,4,-8
banehsp02:
	dc.b	4
	dc.b	$F0,3,0,4,$10
	dc.b	-8,9,0,8,-8
	dc.b	$F0,0,0,0,-8
	dc.b	8,0,0,3,-8