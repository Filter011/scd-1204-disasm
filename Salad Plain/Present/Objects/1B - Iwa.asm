iwa:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	iwa_move_tbl(pc,d0.w),d0
	jsr	iwa_move_tbl(pc,d0.w)
	jsr	actionsub.l
	jmp	frameout_s.l

iwa_move_tbl:
	dc.w	iwa_init-iwa_move_tbl
	dc.w	iwa_move-iwa_move_tbl

iwa_init:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)
	move.l	#iwapat,patbase(a0)
	move.b	#16,sprhsize(a0)
	move.b	#16,sprvsize(a0)
	move.b	#0,patno(a0)
	moveq	#11,d0
	jsr	pa_set.l

iwa_move:
	tst.b	actflg(a0)
	bpl.s	locret_2083D8
	lea	playerwk.w,a1
	bsr.w	ride_on_chk_iwa
	lea	player2wk.w,a1

ride_on_chk_iwa:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	ride_on_chk.l

locret_2083D8:
	rts

iwapat:
	dc.w	iwasp00-iwapat

iwasp00:
	dc.b	2
	dc.b	-8,2,0,0,$EC
	dc.b	$F0,$F,0,3,$F4
	even