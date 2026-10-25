futa:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	futa_move_tbl(pc,d0.w),d0
	jsr	futa_move_tbl(pc,d0.w)
	jsr	actionsub.l
	jmp	frameout_s.l

futa_move_tbl:
	dc.w	futa_init-futa_move_tbl
	dc.w	futa_move-futa_move_tbl
	dc.w	futa_move2-futa_move_tbl
	dc.w	futa_move3-futa_move_tbl

ride_on_chk_f:
	tst.w	yspeed(a1)
	bpl.s	.jump
	bsr.w	exit2_set
	beq.s	.jump
	move.b	#4,r_no0(a0)
	tst.b	userflag(a0)
	bne.s	.end
	jsr	actwkchk.l
	bne.s	.worknai
	_move.b	#exit2_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	subq.w	#4,yposi(a1)
	move.w	#$A4,d0
	jmp	soundset.l

.worknai:
.end:
	rts

.jump:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	ride_on_chk.l

futa_init:
	addq.b	#word,r_no0(a0)
	move.l	#futapat,patbase(a0)
	move.b	#1,sprpri(a0)
	ori.b	#4,actflg(a0)
	move.b	#$2C,sprhsize(a0)
	move.b	#8,sprvsize(a0)
	moveq	#$C,d0
	jsr	pa_set.l

futa_move:
	lea	playerwk.w,a1
	bsr.w	ride_on_chk_f
	lea	player2wk.w,a1
	bra.w	ride_on_chk_f

futa_move2:
	lea	futachg.l,a1
	bra.w	patchg

futa_move3:
	move.b	#1,mstrestart(a0)
	move.b	#0,patno(a0)
	subq.b	#4,r_no0(a0)
	rts