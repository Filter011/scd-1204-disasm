ring:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	ring_move_tbl(pc,d0.w),d1
	jmp	ring_move_tbl(pc,d1.w)

ring_move_tbl:
	dc.w	ringinit_-ring_move_tbl
	dc.w	ringmove-ring_move_tbl
	dc.w	ringget-ring_move_tbl
	dc.w	ringdie-ring_move_tbl
	dc.w	ringerase-ring_move_tbl

ringtbl:
	dc.b	$10,0
	dc.b	$18,0
	dc.b	$20,0
	dc.b	0,$10
	dc.b	0,$18
	dc.b	0,$20
	dc.b	$10,$10
	dc.b	$18,$18
	dc.b	$20,$20
	dc.b	-$10,$10
	dc.b	-$18,$18
	dc.b	-$20,$20
	dc.b	$10,8
	dc.b	$18,$10
	dc.b	-$10,8
	dc.b	-$18,$10

ringinit_:
	lea	flagwork,a2
	moveq	#0,d0
	move.b	cdsts(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	lea	2(a2,d0.w),a2
	move.b	(a2),d4
	move.b	userflag(a0),d1
	moveq	#0,d0
	move.b	d1,d0
	andi.w	#7,d1
	cmpi.w	#7,d1
	bne.s	loc_208A44
	moveq	#6,d1

loc_208A44:
	swap	d1
	move.w	#1,d1
	lsr.b	#4,d0
	add.w	d0,d0
	move.b	ringtbl(pc,d0.w),d5
	ext.w	d5
	move.b	ringtbl+1(pc,d0.w),d6
	ext.w	d6
	movea.l	a0,a1
	move.w	xposi(a0),d2
	move.w	yposi(a0),d3
	lea	1(a2),a3
	moveq	#0,d0
	move.b	time_flag,d0

loc_208A70:
	move.b	-(a3),d4
	lsr.b	d1,d4
	blo.s	loc_208AEA
	dbf	d0,loc_208A70
	bclr	#7,(a2)
	bra.s	loc_208AA2

loc_208A80:
	swap	d1
	lea	1(a2),a3
	moveq	#0,d0
	move.b	time_flag,d0

loc_208A8E:
	move.b	-(a3),d4
	lsr.b	d1,d4
	blo.s	loc_208AEA
	dbf	d0,loc_208A8E
	bclr	#7,(a2)
	bsr.w	actwkchk
	bne.s	loc_208AF6

loc_208AA2:
	_move.b	#objid_10,actno(a1)
	addq.b	#2,r_no0(a1)
	move.w	d2,xposi(a1)
	move.w	xposi(a0),act32(a1)
	move.w	d3,yposi(a1)
	move.l	#ringpat,patbase(a1)
	move.w	#$A7AE,sproffset(a1)
	move.b	#4,actflg(a1)
	move.b	#2,sprpri(a1)
	move.b	#$47,colino(a1)
	move.b	#8,sprhsize(a1)
	move.b	cdsts(a0),cdsts(a1)
	move.b	d1,act34(a1)

loc_208AEA:
	addq.w	#1,d1
	add.w	d5,d2
	add.w	d6,d3
	swap	d1
	dbf	d1,loc_208A80

loc_208AF6:
	btst	#0,(a2)
	bne.w	frameout

ringmove:
	move.w	act32(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.w	ringerase
	tst.w	word_FF1278
	bne.s	loc_208B2C
	move.b	sys_patno2,patno(a0)

loc_208B2C:
	bra.w	actionsub

ringget:
	addq.b	#2,r_no0(a0)
	move.b	#0,colino(a0)
	move.b	#1,sprpri(a0)
	bsr.w	ringgetsub
	lea	flagwork,a2
	moveq	#0,d0
	move.b	cdsts(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	move.b	act34(a0),d1
	subq.b	#1,d1
	bset	d1,2(a2,d0.w)
ringdie:
	lea	ringchg.l,a1
	bsr.w	patchg
	bra.w	actionsub

ringerase:
	bra.w	frameout

ringgetsub:
	addq.w	#1,plring
	ori.b	#1,plring_f
	move.w	#$95,d0
	cmpi.w	#100,plring
	blo.s	loc_208BC6
	bset	#1,plring_f2
	beq.s	loc_208BB6
	cmpi.w	#200,plring
	blo.s	loc_208BC6
	bset	#2,plring_f2
	bne.s	loc_208BC6

loc_208BB6:
	addq.b	#1,pl_suu
	addq.b	#1,pl_suu_f
	move.w	#$88,d0

loc_208BC6:
	jmp	soundset.l

flyring:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	flyring_move_tbl(pc,d0.w),d1
	jmp	flyring_move_tbl(pc,d1.w)

flyring_move_tbl:
	dc.w	flyringinit-flyring_move_tbl
	dc.w	flyringmove-flyring_move_tbl
	dc.w	flyringget-flyring_move_tbl
	dc.w	flyringdie-flyring_move_tbl
	dc.w	flyringerase-flyring_move_tbl

flyringinit:
	movea.l	a0,a1
	moveq	#0,d5
	move.w	plring,d5
	moveq	#$20,d0
	cmp.w	d0,d5
	blo.s	loc_208BF6
	move.w	d0,d5

loc_208BF6:
	subq.w	#1,d5
	move.w	#$288,d4
	bra.s	loc_208C06

loc_208BFE:
	bsr.w	actwkchk
	bne.w	loc_208C8E

loc_208C06:
	_move.b	#objid_11,actno(a1)
	addq.b	#2,r_no0(a1)
	move.b	#8,sprvsize(a1)
	move.b	#8,sprhs(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.l	#ringpat,patbase(a1)
	move.w	#$A7AE,sproffset(a1)
	move.b	#4,actflg(a1)
	move.b	#3,sprpri(a1)
	move.b	#$47,colino(a1)
	move.b	#8,sprhsize(a1)
	move.b	#-1,sys_pattim4
	tst.w	d4
	bmi.s	loc_208C7E
	move.w	d4,d0
	jsr	sinset.l
	move.w	d4,d2
	lsr.w	#8,d2
	asl.w	d2,d0
	asl.w	d2,d1
	move.w	d0,d2
	move.w	d1,d3
	addi.b	#$10,d4
	bhs.s	loc_208C7E
	subi.w	#$80,d4
	bhs.s	loc_208C7E
	move.w	#$288,d4

loc_208C7E:
	move.w	d2,xspeed(a1)
	move.w	d3,yspeed(a1)
	neg.w	d2
	neg.w	d4
	dbf	d5,loc_208BFE

loc_208C8E:
	move.w	#0,plring
	move.b	#$80,plring_f
	move.b	#0,plring_f2
	move.w	#$94,d0
	jsr	soundset.l

flyringmove:
	move.b	sys_patno4,patno(a0)
	bsr.w	speedset2
	addi.w	#$18,yspeed(a0)
	bmi.s	loc_208CEE
	move.b	systemtimer+3,d0
	add.b	d7,d0
	andi.b	#3,d0
	bne.s	loc_208CEE
	jsr	emycol_d.l
	tst.w	d1
	bpl.s	loc_208CEE
	add.w	d1,yposi(a0)
	move.w	yspeed(a0),d0
	asr.w	#2,d0
	sub.w	d0,yspeed(a0)
	neg.w	yspeed(a0)

loc_208CEE:
	tst.b	sys_pattim4
	beq.s	flyringerase
	move.w	scralim_down.w,d0
	addi.w	#224,d0
	cmp.w	yposi(a0),d0
	blo.s	flyringerase
	bra.w	actionsub

flyringget:
	addq.b	#2,r_no0(a0)
	move.b	#0,colino(a0)
	move.b	#1,sprpri(a0)
	bsr.w	ringgetsub

flyringdie:
	lea	ringchg.l,a1
	bsr.w	patchg
	bra.w	actionsub

flyringerase:
	bra.w	frameout

ringchg:
	dc.w	ringchg0-ringchg

ringchg0:
	dc.b	5
	dc.b	4,5,6,7
	dc.b	$FC
	even

ringpat:
	dc.w	ringsp0-ringpat
	dc.w	ringsp1-ringpat
	dc.w	ringsp2-ringpat
	dc.w	ringsp3-ringpat
	dc.w	ringsp4-ringpat
	dc.w	ringsp5-ringpat
	dc.w	ringsp6-ringpat
	dc.w	ringsp7-ringpat
	dc.w	ringsp8-ringpat
ringsp0:
	dc.b	1
	dc.b	-8,5,0,0,-8
	even
ringsp1:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even
ringsp2:
	dc.b	1
	dc.b	-8,1,0,8,-4
	even
ringsp3:
	dc.b	1
	dc.b	-8,5,8,4,-8
	even
ringsp4:
	dc.b	1
	dc.b	-8,5,0,$A,-8
	even
ringsp5:
	dc.b	1
	dc.b	-8,5,$18,$A,-8
	even
ringsp6:
	dc.b	1
	dc.b	-8,5,$10,$A,-8
	even
ringsp7:
	dc.b	1
	dc.b	-8,5,8,$A,-8
	even
ringsp8:
	dc.b	0
	even