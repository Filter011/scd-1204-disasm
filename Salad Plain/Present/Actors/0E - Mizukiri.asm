mizukiri:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	mizuki_move_tbl(pc,d0.w),d0
	jmp	mizuki_move_tbl(pc,d0.w)

mizuki_move_tbl:
	dc.w	mizuki_init-mizuki_move_tbl
	dc.w	mizuki_move-mizuki_move_tbl
	dc.w	mizuki_move2-mizuki_move_tbl

mizuki_init:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.l	#mizukipat,patbase(a0)
	move.w	#$31E,sproffset(a0)
	move.b	#1,sprpri(a0)

mizuki_move:
	lea	mizukichg.l,a1
	bsr.w	patchg
	jmp	actionsub.l

mizuki_move2:
	jmp	frameout.l