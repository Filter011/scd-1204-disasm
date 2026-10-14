bakuha:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_205558(pc,d0.w),d0
	jmp	off_205558(pc,d0.w)

off_205558:
	dc.w	baku_init-off_205558
	dc.w	baku_move-off_205558
	dc.w	baku_die-off_205558

baku_init:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.w	#$680,sproffset(a0)
	move.l	#bakupat,patbase(a0)
	move.b	#0,colino(a0)
	move.w	#1,mstno(a0)

baku_move:
	lea	bakuchg.l,a1
	bsr.w	patchg
	jmp	actionsub.l

baku_die:
	tst.b	r_no1(a0)
	beq.s	loc_2055A4
	jmp	frameout.l

loc_2055A4:
	_move.b	#flower_act,actno(a0)
	move.b	#0,r_no0(a0)
	rts

flower:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_2055C6(pc,d0.w),d0
	jsr	off_2055C6(pc,d0.w)
	jmp	actionsub.l

off_2055C6:
	dc.w	flow_init-off_2055C6
	dc.w	flow_move0-off_2055C6
	dc.w	flow_move1-off_2055C6
	dc.w	flow_move2-off_2055C6
	dc.w	flow_move3-off_2055C6

flow_init:
	ori.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#0,sprvsize(a0)
	move.w	#$46D6,sproffset(a0)
	move.l	#flow_pat,patbase(a0)
	bsr.w	flow_sub
	move.b	(a1),d0
	move.b	#4,r_no0(a0)
	move.b	#3,mstno(a0)
	btst	#6,d0
	bne.s	flow_move1
	move.w	#2,mstno(a0)
	move.b	#2,r_no0(a0)
	move.w	#$6D6,sproffset(a0)

flow_move0:
	jsr	emycol_d.l
	tst.w	d1
	bpl.s	loc_205658
	add.w	d1,yposi(a0)
	bsr.w	flow_sub
	lea	flowerwk,a2
	move.b	(a2,d1.w),d0
	addq.b	#1,(a2,d1.w)
	bsr.w	flow_sub1
	move.w	xposi(a0),(a1,d0.w)
	move.w	yposi(a0),2(a1,d0.w)
	move.b	#4,r_no0(a0)
	move.b	#1,mstno(a0)
	rts

loc_205658:
	addq.w	#2,yposi(a0)

flow_move1:
	lea	flowchg.l,a1
	bra.w	patchg

flow_sub:
	moveq	#0,d0
	move.b	cdsts(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	bclr	#7,d1
	add.w	d1,d0
	lea	flagwork,a1
	lea	2(a1,d0.w),a1
	rts

flow_sub1:
	andi.w	#$3F,d0
	add.w	d0,d0
	add.w	d0,d0
	moveq	#0,d1
	move.b	time_flag,d1
	bclr	#7,d1
	lsl.w	#8,d1
	add.w	d1,d0
	lea	flowercnt,a1
	rts

flow_move2:
	move.w	#$46D6,sproffset(a0)
	move.b	#2,mstno(a0)
	bra.s	flow_move1

flow_move3:
	move.b	#3,mstno(a0)
	move.b	#4,r_no0(a0)
	bra.s	flow_move1