test_act:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_2054E4(pc,d0.w),d0
	jmp	off_2054E4(pc,d0.w)

off_2054E4:
	dc.w	test_init-off_2054E4
	dc.w	test_move-off_2054E4

test_init:
	btst	#7,cddat(a0)
	bne.w	frameout
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.l	#bariapat,patbase(a0)
	move.w	#$541,sproffset(a0)
	move.w	xposi(a0),act30(a0)
	move.b	#6,colino(a0)

test_move:
	move.w	act30(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.w	frameout
	lea	bariachg.l,a1
	bsr.w	patchg
	jmp	actionsub.l