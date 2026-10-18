obj28:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20B826(pc,d0.w),d0
	jsr	off_20B826(pc,d0.w)
	jmp	frameout_s.l

off_20B826:
	dc.w	loc_20B834-off_20B826
	dc.w	loc_20B888-off_20B826
	dc.w	loc_20B8C8-off_20B826
	dc.w	loc_20B9B4-off_20B826
	dc.w	loc_20B908-off_20B826
	dc.w	loc_20B9FC-off_20B826
	dc.w	loc_20B950-off_20B826

loc_20B834:
	move.l	#act28pat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#7,d0
	jsr	pa_set(pc)
	move.b	#$18,sprhs(a0)
	move.b	#4,sprvsize(a0)
	move.b	userflag(a0),d0
	cmpi.b	#1,d0
	beq.w	loc_20B87A
	move.b	#3,mstno(a0)
	move.b	#2,r_no0(a0)
	rts

loc_20B87A:
	move.b	#4,mstno(a0)
	move.b	#4,r_no0(a0)
	rts

loc_20B888:
	moveq	#5,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B8B6
	lea	playerwk.w,a1
	move.l	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)
	move.b	#$A,r_no0(a0)
	move.b	#3,mstno(a0)

loc_20B8B6:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B8C8:
	moveq	#3,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B8F6
	lea	playerwk.w,a1
	move.l	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)
	move.b	#$C,r_no0(a0)
	move.b	#4,mstno(a0)

loc_20B8F6:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B908:
	moveq	#3,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B926
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B926:
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	btst	#cd_walk,cddat(a1)
	bne.w	loc_20B942
	rts

loc_20B942:
	move.w	#$64,act2A(a0)
	move.b	#$C,r_no0(a0)
	rts

loc_20B950:
	move.b	#2,mstno(a0)
	moveq	#4,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B986
	lea	playerwk.w,a1
	move.w	yspeed(a1),d0
	addi.w	#$100,d0
	cmpi.w	#$A00,d0
	bmi.w	loc_20B97A
	move.w	#$A00,d0

loc_20B97A:
	neg.w	d0
	move.w	d0,yspeed(a1)
	move.w	#$64,act2A(a0)

loc_20B986:
	move.w	act2A(a0),d0
	subq.w	#1,d0
	move.w	d0,act2A(a0)
	bne.w	loc_20B9A2
	move.b	#4,r_no0(a0)
	move.b	#4,mstno(a0)
	rts

loc_20B9A2:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B9B4:
	moveq	#5,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B9D2
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B9D2:
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	move.b	#2,r_no0(a0)
	btst	#cd_walk,cddat(a1)
	bne.w	loc_20B9EE
	rts

loc_20B9EE:
	move.w	#$64,act2A(a0)
	move.b	#$A,r_no0(a0)
	rts

loc_20B9FC:
	move.b	#1,mstno(a0)
	moveq	#6,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BA32
	lea	playerwk.w,a1
	move.w	yspeed(a1),d0
	addi.w	#$100,d0
	cmpi.w	#$A00,d0
	bmi.w	loc_20BA26
	move.w	#$A00,d0

loc_20BA26:
	neg.w	d0
	move.w	d0,yspeed(a1)
	move.w	#$64,act2A(a0)

loc_20BA32:
	move.w	act2A(a0),d0
	subq.w	#1,d0
	move.w	d0,act2A(a0)
	bne.w	loc_20BA4E
	move.b	#2,r_no0(a0)
	move.b	#3,mstno(a0)
	rts

loc_20BA4E:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

obj27:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20BA74(pc,d0.w),d0
	jsr	off_20BA74(pc,d0.w)
	jmp	frameout_s.l

off_20BA74:
	dc.w	loc_20BA7C-off_20BA74
	dc.w	loc_20BAA2-off_20BA74
	dc.w	loc_20BAE4-off_20BA74
	dc.w	loc_20BBA8-off_20BA74

loc_20BA7C:
	addq.b	#word,r_no0(a0)
	move.l	#act27pat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#8,d0
	jsr	pa_set(pc)
	rts

loc_20BAA2:
	tst.b	actflg(a0)
	bpl.w	loc_20BADE
	moveq	#9,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BAD2
	lea	playerwk.w,a1
	bclr	#cd_walk,cddat(a1)
	bset	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	move.w	#0,act2A(a0)

loc_20BAD2:
	lea	obj27_ani.l,a1
	jsr	patchg.l

loc_20BADE:
	jmp	actionsub.l

loc_20BAE4:
	tst.b	actflg(a0)
	bpl.s	loc_20BADE
	moveq	#7,d0
	bsr.w	sub_20B684
	tst.b	d1
	bne.w	loc_20BB0C
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	move.b	#6,r_no0(a0)
	move.w	#0,act2A(a0)

loc_20BB0C:
	lea	playerwk.w,a1
	move.w	xposi(a0),d2
	move.w	xposi(a1),d3
	move.w	xspeed(a1),d4
	beq.w	loc_20BB3C
	bmi.w	loc_20BB28
	bpl.w	loc_20BB32

loc_20BB28:
	cmp.w	d2,d3
	bpl.w	loc_20BB4A
	bra.w	loc_20BB3C

loc_20BB32:
	cmp.w	d2,d3
	bmi.w	loc_20BB4A
	bra.w	loc_20BB3C

loc_20BB3C:
	move.l	yposi(a1),d0
	addi.l	#$8000,d0
	move.l	d0,yposi(a1)

loc_20BB4A:
	moveq	#0,d0
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	lea	loc_20BC80.l,a3
	lea	unk_20BC1E.l,a2
	move.w	xposi(a0),d2
	move.w	xposi(a1),d3
	cmp.w	d2,d3
	bmi.w	loc_20BB7C
	lea	unk_20BC34.l,a2
	lea	loc_20BC80.l,a3

loc_20BB7C:
	divu.w	#2,d0
	move.b	(a2,d0.w),d1
	move.b	d1,mstno(a0)
	cmpi.b	#6,d1
	bne.w	loc_20BB96
	bclr	#cd_ride,cddat(a1)

loc_20BB96:
	lea	obj27_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20BBA8:
	tst.b	actflg(a0)
	bne.w	loc_20BADE
	moveq	#9,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BBD8
	lea	playerwk.w,a1
	bclr	#cd_walk,cddat(a1)
	bset	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	move.w	#0,act2A(a0)

loc_20BBD8:
	lea	unk_20BC4A.l,a2
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	move.b	(a2,d0.w),d1
	bmi.w	loc_20BC06
	move.b	d1,mstno(a0)
	lea	obj27_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20BC06:
	move.b	#2,r_no0(a0)
	lea	obj27_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

unk_20BC1E:
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	4
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
unk_20BC34:
	dc.b	7
	dc.b	7
	dc.b	8
	dc.b	8
	dc.b	9
	dc.b	9
	dc.b	$A
	dc.b	$A
	dc.b	$B
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	0
unk_20BC4A:
	dc.b	0
	dc.b	5
	dc.b	4
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	0
	dc.b	$D
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	$B
	dc.b	$A
	dc.b	9
	dc.b	8
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	$D
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	9
	dc.b	8
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	$D
	dc.b	7
	dc.b	8
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	2
	dc.b	1
	dc.b	$D
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	$D
	dc.b	$FF
	even

loc_20BC80:
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	blo.s	locret_20BCA2
	jmp	frameout.l

locret_20BCA2:
	rts