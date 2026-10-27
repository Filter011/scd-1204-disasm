exit2_set:
	move.w	xposi(a1),d0
	sub.w	xposi(a0),d0
	moveq	#0,d1
	move.b	sprhsize(a0),d1
	add.w	d1,d0
	bmi.s	loc_20580E
	add.w	d1,d1
	cmp.w	d1,d0
	bhs.s	loc_20580E
	move.w	yposi(a1),d0
	sub.w	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a0),d1
	add.w	d1,d0
	bmi.s	loc_20580E
	add.w	d1,d1
	cmp.w	d1,d0
	bhs.s	loc_20580E
	moveq	#1,d0
	rts

loc_20580E:
	moveq	#0,d0
	rts

exit2:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	exit2_move_tbl(pc,d0.w),d0
	jmp	exit2_move_tbl(pc,d0.w)

exit2_move_tbl:
	dc.w	exit2_init-exit2_move_tbl
	dc.w	exit2_move-exit2_move_tbl
	dc.w	exit2_erase-exit2_move_tbl

exit2_init:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.l	#exit2pat,patbase(a0)
	move.b	userflag(a0),mstno(a0)
	moveq	#13,d0
	jsr	pa_set.l
	move.w	#se_A2,d0
	cmpi.b	#2,userflag(a0)
	blo.s	loc_20585C
	move.w	#se_A1,d0

loc_20585C:
	jsr	soundset.l

exit2_move:
	lea	exit2chg.l,a1
	bsr.w	patchg
	jmp	actionsub.l

exit2_erase:
	jmp	frameout.l