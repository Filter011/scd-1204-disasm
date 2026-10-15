score:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	score_move_tbl(pc,d0.w),d0
	jmp	score_move_tbl(pc,d0.w)

score_move_tbl:
	dc.w	score_init-score_move_tbl
	dc.w	score_move-score_move_tbl

score_init:
	addq.b	#word,r_no0(a0)
	move.l	#scorepat,patbase(a0)
	move.w	#$8568,sproffset(a0)
	move.w	#$90,xposi(a0)
	move.w	#$88,$A(a0)
	tst.w	debugflag
	beq.s	loc_209724
	move.b	#2,patno(a0)

loc_209724:
	tst.b	userflag(a0)
	beq.s	score_move
	move.w	#$90,xposi(a0)
	move.w	#$148,$A(a0)
	move.b	#1,patno(a0)

score_move:
	tst.b	userflag(a0)
	bne.s	loc_209756
	move.b	#0,patno(a0)
	tst.w	debugflag
	beq.s	loc_209756
	move.b	#2,patno(a0)

loc_209756:
	jmp	actionsub.l

scorepat:
	dc.w	scoresp00-scorepat
	dc.w	scoresp01-scorepat
	dc.w	scoresp02-scorepat
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