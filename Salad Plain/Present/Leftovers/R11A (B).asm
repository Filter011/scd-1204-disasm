	dc.w	word_20FCEA-$20FCAC
	dc.w	$2408
	dc.w	$2452
	dc.w	$23F2
	dc.w	$2428
	dc.w	$2486
	dc.w	$2000
	dc.w	$31E
	dc.w	$32A
	dc.w	$4000
	dc.w	$4000
	dc.w	$3B7
	dc.w	$3C6
	dc.w	$8399
	dc.w	$4C1
	dc.w	$391
word_20FCEA:
	dc.w	$36B

	include	"Actors (B)/24 - Friend.asm"
	include	"Actors (B)/17 - Goal.asm"

	jmp	$20792C.l

	dc.l	3<<24+$237DBA
	dc.l	2<<24+$236D82
	dc.l	$23A476
	dc.w	bgm_81
	dc.b	4,4

off_20FFB0:
	dc.w	word_20FFC0-off_20FFB0
	dc.w	word_20FFC8-off_20FFB0
	dc.w	word_20FFFA-off_20FFB0
	dc.w	word_20FFC0-off_20FFB0
	dc.w	$210050-off_20FFB0
	dc.w	$21005E-off_20FFB0
	dc.w	$210066-off_20FFB0
	dc.w	$210074-off_20FFB0

word_20FFC0:	ddev_header
	ddev_entry	$237DBA,0
word_20FFC0_end:

word_20FFC8:	ddev_header
	ddev_entry	$231B28,$4FE
	ddev_entry	$231C36,$511
	ddev_entry	$23051E,$520
	ddev_entry	$231832,$568
	ddev_entry	$230740,$5A8
	ddev_entry	$230CD6,$680
	ddev_entry	$23195E,$6D6
	ddev_entry	$2311BE,$7AE
word_20FFC8_end:

word_20FFFA:
	dc.w	13
	dc.l	$233AAA

	dephase