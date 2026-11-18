	phase	$FF0000
	ds.b	$580
ta_flag:		ds.b	1
	dephase

	phase	$FFFF8000
	ds.b	$4000
bitdevwk:		ds.b	$200
	ds.b	$3700
lpcolorwk:		ds.b	$80
lpcolorwk_end:
lpcolorwk2:		ds.b	$80
lpcolorwk2_end:
	ds.b	$308
intmd:			ds.l	1
	dephase
	!org 0