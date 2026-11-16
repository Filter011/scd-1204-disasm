springpat:
	dc.w	spat00-springpat
	dc.w	spat01-springpat
	dc.w	spat02-springpat

spring90pat:
	dc.w	spat03-spring90pat
	dc.w	spat04-spring90pat
	dc.w	spat05-spring90pat

spat00:
	dc.b	2
	dc.b	-8,$C,0,0,$F0
	dc.b	0,$C,0,4,$F0
	even
spat01:
	dc.b	1
	dc.b	0,$C,0,0,$F0
	even
spat02:
	dc.b	3
	dc.b	$E0,$C,0,0,$F0
	dc.b	$E8,6,0,8,-8
	dc.b	0,$C,0,$E,$F0
	even
spat03:
	dc.b	2
	dc.b	$F0,3,0,$12,0
	dc.b	$F0,3,0,$16,-8
	even
spat04:
	dc.b	1
	dc.b	$F0,3,0,$12,-8
	even
spat05:
	dc.b	3
	dc.b	$F0,3,0,$12,$18
	dc.b	-8,9,0,$1A,0
	dc.b	$F0,3,0,$20,-8
	even