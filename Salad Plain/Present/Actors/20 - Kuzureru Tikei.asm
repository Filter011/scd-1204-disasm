kuzureru_tikei:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20D030(pc,d0.w),d0
	jsr	off_20D030(pc,d0.w)
	jmp	actionsub.l

off_20D030:
	dc.w	acta_init-off_20D030
	dc.w	acta_check-off_20D030
	dc.w	actb_wait-off_20D030
	dc.w	actb_down-off_20D030

acta_init:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#3,sprpri(a0)
	move.w	#$4000,sproffset(a0)
	lea	patbase_kuzure_a(pc),a1
	lea	tbla(pc),a2
	move.b	userflag(a0),d0
	bpl.w	loc_20D066
	lea	patbase_kuzure_b(pc),a1
	lea	tblb(pc),a2

loc_20D066:
	move.l	a1,patbase(a0)
	btst	#4,d0
	beq.w	loc_20D07E
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)

loc_20D07E:
	andi.w	#$F,d0
	move.b	d0,patno(a0)
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	move.b	(a2,d0.w),d1
	addq.b	#1,d1
	asl.b	#3,d1
	move.b	d1,sprhsize(a0)
	move.b	1(a2,d0.w),d1
	bpl.w	loc_20D0A2
	neg.b	d1

loc_20D0A2:
	addq.b	#1,d1
	asl.b	#3,d1
	addq.b	#2,d1
	move.b	d1,sprvsize(a0)

acta_check:
	tst.b	actflg(a0)
	bpl.s	locret_20D0E0
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	lea	playerwk.w,a3
	lea	byte_FFD040.w,a1
	move.b	main_play,d0
	beq.w	loc_20D0CE
	exg.l	a1,a3

loc_20D0CE:
	jsr	ride_on_chk.l
	exg.l	a1,a3
	jsr	ride_on_chk.l
	bne.w	loc_20D0E2

locret_20D0E0:
	rts

loc_20D0E2:
	addq.b	#word,r_no0(a0)
	move.b	userflag(a0),d0
	bpl.w	actb_init_a
	bra.w	actb_init_b

actb_wait:
	lea	act2A(a0),a3
	addi.w	#-1,(a3)
	bne.w	loc_20D102
	addq.b	#word,r_no0(a0)

loc_20D102:
	move.b	act3E(a0),d0
	beq.w	locret_20D134
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	lea	playerwk.w,a1
	bsr.w	sub_20D11E
	lea	byte_FFD040.w,a1

sub_20D11E:
	jsr	ride_on_chk.l
	beq.w	locret_20D134
	tst.w	(a3)
	bne.w	locret_20D134
	bclr	#3,cddat(a1)

locret_20D134:
	rts

actb_down:
	move.l	act2C(a0),d0
	add.l	d0,yposi(a0)
	addi.l	#$4000,act2C(a0)
	move.w	yposi(a0),d0
	lea	playerwk.w,a1
	move.b	main_play,d1
	beq.w	loc_20D15C
	lea	byte_FFD040.w,a1

loc_20D15C:
	sub.w	yposi(a1),d0
	cmpi.w	#$200,d0
	bgt.w	loc_20D16A
	rts

loc_20D16A:
	jmp	frameout.l

actb_init_a:
	move.b	userflag(a0),d0
	suba.l	a4,a4
	btst	#4,d0
	beq.w	loc_20D182
	lea	actb_init_a(pc),a4

loc_20D182:
	lea	tbla(pc),a6
	andi.w	#$F,d0
	add.w	d0,d0
	move.w	(a6,d0.w),d0
	lea	(a6,d0.w),a6
	moveq	#0,d0
	move.b	(a6)+,d0
	movea.w	d0,a5
	asl.w	#3,d0
	move.w	#-$10,d1
	cmpa.w	#0,a4
	bne.w	loc_20D1AC
	neg.w	d0
	neg.w	d1

loc_20D1AC:
	add.w	xposi(a0),d0
	movea.w	d0,a2
	movea.w	d1,a3
	moveq	#0,d6
	move.b	(a6)+,d6
	move.w	d6,d4
	asl.w	#3,d4
	add.w	yposi(a0),d4
	move.w	#9,d2
	_move.b	actno(a0),act3F(a0)
	_clr.b	actno(a0)

loc_20D1CE:
	move.w	a5,d5
	move.w	a2,d3
	move.w	d2,d1

loc_20D1D4:
	jsr	actwkchk2.l
	bne.w	locret_20D260
	move.b	(a6)+,d0
	bmi.w	loc_20D24C
	move.b	d0,patno(a1)
	ori.b	#4,actflg(a1)
	move.b	#3,sprpri(a1)
	move.w	#$4000,sproffset(a1)
	move.l	#patc,patbase(a1)
	move.l	#$20000,act2C(a1)
	_move.b	act3F(a0),actno(a1)
	move.b	r_no0(a0),r_no0(a1)
	cmpa.w	#0,a4
	beq.w	loc_20D22A
	bset	#0,actflg(a1)
	bset	#0,cddat(a1)

loc_20D22A:
	tst.w	d6
	bne.w	loc_20D240
	st	act3E(a1)
	move.b	#8,sprhsize(a1)
	move.b	#9,sprvsize(a1)

loc_20D240:
	move.w	d4,yposi(a1)
	move.w	d3,xposi(a1)
	move.w	d1,act2A(a1)

loc_20D24C:
	add.w	a3,d3
	addi.w	#$C,d1
	dbf	d5,loc_20D1D4

	addi.w	#-$10,d4
	addq.w	#5,d2
	dbf	d6,loc_20D1CE

locret_20D260:
	rts

actb_init_b:
	move.b	userflag(a0),d2
	lea	tblb(pc),a6
	move.b	d2,d0
	andi.w	#$1F,d0
	add.w	d0,d0
	move.w	(a6,d0.w),d0
	lea	(a6,d0.w),a6
	move.b	(a6)+,d5
	move.b	(a6)+,d1
	addq.b	#1,d1
	asl.b	#3,d1
	addq.b	#2,d1
	andi.w	#$FF,d5
	move.w	d5,d4
	lsl.w	#3,d4
	neg.w	d4
	move.w	#$10,d3
	moveq	#1,d6
	btst	#6,d2
	bne.w	loc_20D2A2
	lsl.b	#2,d2
	bra.w	loc_20D2C4

loc_20D2A2:
	lea	playerwk.w,a1
	move.b	main_play,d0
	beq.w	loc_20D2B4
	lea	byte_FFD040.w,a1

loc_20D2B4:
	move.w	xspeed(a1),d0
	btst	#5,d2
	beq.w	loc_20D2C2
	neg.w	d0

loc_20D2C2:
	tst.w	d0

loc_20D2C4:
	bpl.w	loc_20D2D2
	lea	(a6,d5.w),a6
	neg.w	d4
	neg.w	d3
	neg.w	d6

loc_20D2D2:
	add.w	xposi(a0),d4
	move.w	#9,d2
	_move.b	actno(a0),act3F(a0)
	_clr.b	actno(a0)

loc_20D2E4:
	jsr	actwkchk2.l
	bne.w	locret_20D34A
	move.b	#3,sprpri(a1)
	move.w	#$4000,sproffset(a1)
	ori.b	#4,actflg(a1)
	move.l	#patd,patbase(a1)
	move.l	#$20000,act2C(a1)
	_move.b	act3F(a0),actno(a1)
	move.b	r_no0(a0),r_no0(a1)
	move.w	yposi(a0),yposi(a1)
	st	act3E(a1)
	move.b	#8,sprhsize(a1)
	move.b	d1,sprvsize(a1)
	move.b	(a6),patno(a1)
	lea	(a6,d6.w),a6
	move.w	d4,xposi(a1)
	add.w	d3,d4
	move.w	d2,act2A(a1)
	addi.w	#$C,d2
	dbf	d5,loc_20D2E4

locret_20D34A:
	rts

patbase_kuzure_a:
	dc.w	pata00-patbase_kuzure_a
pata00:
	dc.b	23
	dc.b	$D0,5,8,$D,$D8
	dc.b	$D0,5,8,$D,$E8
	dc.b	$D0,5,8,$D,-8
	dc.b	$D0,5,8,$D,8
	dc.b	$D0,5,8,$D,$18
	dc.b	$E0,5,8,$11,$D8
	dc.b	$E0,5,8,$11,$E8
	dc.b	$E0,5,8,$11,-8
	dc.b	$E0,5,8,$11,8
	dc.b	$E0,5,8,$11,$18
	dc.b	$F0,5,0,$19,$D8
	dc.b	$F0,5,8,$15,$E8
	dc.b	$F0,5,8,$15,-8
	dc.b	$F0,5,8,$15,8
	dc.b	$F0,5,8,$15,$18
	dc.b	0,5,8,$25,$D8
	dc.b	0,5,0,$1D,$E8
	dc.b	0,5,0,$21,-8
	dc.b	0,5,0,$21,8
	dc.b	0,5,8,$1D,$18
	dc.b	$10,5,0,$19,-8
	dc.b	$10,5,0,$19,8
	dc.b	$10,5,0,$19,$18
	even

tbla:
	dc.w	tbla00-tbla
tbla00:
	dc.b	4
	dc.b	3
	dc.b	$FF
	dc.b	$FF
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	0
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	even

patc:
	dc.w	patc00-patc
	dc.w	patc01-patc
	dc.w	patc02-patc
	dc.w	patc03-patc
	dc.w	patc04-patc
	dc.w	patc05-patc
	dc.w	patc06-patc
patc00:
	dc.b	1
	dc.b	-8,5,0,$19,-8
	even
patc01:
	dc.b	1
	dc.b	-8,5,8,$25,-8
	even
patc02:
	dc.b	1
	dc.b	-8,5,0,$1D,-8
	even
patc03:
	dc.b	1
	dc.b	-8,5,0,$21,-8
	even
patc04:
	dc.b	1
	dc.b	-8,5,8,$1D,-8
	even
patc05:
	dc.b	1
	dc.b	-8,5,8,$15,-8
	even
patc06:
	dc.b	2
	dc.b	$E8,5,8,$D,-8
	dc.b	-8,5,8,$11,-8
	even

patbase_kuzure_b:
	dc.w	patb00-patbase_kuzure_b
	dc.w	patb00-patbase_kuzure_b
	dc.w	patb01-patbase_kuzure_b
	dc.w	patb02-patbase_kuzure_b
	dc.w	patb03-patbase_kuzure_b
	dc.w	patb04-patbase_kuzure_b
patb00:
	dc.b	18
	dc.b	$E0,5,0,$D,$D0
	dc.b	$E0,5,0,$D,$E0
	dc.b	$E0,5,0,$D,$F0
	dc.b	$E0,5,0,$D,0
	dc.b	$E0,5,0,$D,$10
	dc.b	$E0,5,0,$D,$20
	dc.b	$F0,5,0,$11,$D0
	dc.b	$F0,5,0,$11,$E0
	dc.b	$F0,5,0,$11,$F0
	dc.b	$F0,5,0,$11,0
	dc.b	$F0,5,0,$11,$10
	dc.b	$F0,5,0,$11,$20
	dc.b	0,5,0,$15,$D0
	dc.b	0,5,0,$15,$E0
	dc.b	0,5,0,$15,$F0
	dc.b	0,5,0,$15,0
	dc.b	0,5,0,$15,$10
	dc.b	0,5,0,$15,$20
patb01:
	dc.b	20
	dc.b	$D0,5,0,$D,$E0
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$D0,5,0,$D,$10
	dc.b	$E0,5,0,$11,$E0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$E0,5,0,$11,$10
	dc.b	$F0,5,0,$15,$E0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	$F0,5,0,$15,$10
	dc.b	0,5,0,$29,$E0
	dc.b	0,5,0,$33,$F0
	dc.b	0,5,0,$33,0
	dc.b	0,5,0,$33,$10
	dc.b	$10,5,0,$31,$E0
	dc.b	$10,5,0,$2B,$F0
	dc.b	$10,5,0,$2B,0
	dc.b	$10,5,0,$2B,$10
	even
patb02:
	dc.b	20
	dc.b	$D0,5,0,$D,$E0
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$D0,5,0,$D,$10
	dc.b	$E0,5,0,$11,$E0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$E0,5,0,$11,$10
	dc.b	$F0,5,0,$15,$E0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	$F0,5,0,$15,$10
	dc.b	0,5,0,$33,$E0
	dc.b	0,5,0,$33,$F0
	dc.b	0,5,0,$33,0
	dc.b	0,5,0,$33,$10
	dc.b	$10,5,0,$2B,$E0
	dc.b	$10,5,0,$2B,$F0
	dc.b	$10,5,0,$2B,0
	dc.b	$10,5,0,$2B,$10
patb03:
	dc.b	10
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	0,5,0,$1D,$F0
	dc.b	0,5,0,$21,0
	dc.b	$10,5,0,$19,$F0
	dc.b	$10,5,0,$19,0
	even
patb04:
	dc.b	10
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	0,5,0,$21,$F0
	dc.b	0,5,8,$1D,0
	dc.b	$10,5,0,$19,$F0
	dc.b	$10,5,0,$19,0
	even

tblb:
	dc.w	tblb00-tblb
	dc.w	tblb00-tblb
	dc.w	tblb01-tblb
	dc.w	tblb02-tblb
	dc.w	tblb03-tblb
	dc.w	tblb04-tblb
tblb00:
	dc.b	5
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	even
tblb01:
	dc.b	3
	dc.b	3
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	2
	even
tblb02:
	dc.b	3
	dc.b	3
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	even
tblb03:
	dc.b	1
	dc.b	3
	dc.b	3
	dc.b	5
	even
tblb04:
	dc.b	1
	dc.b	3
	dc.b	5
	dc.b	4
	even

patd:
	dc.w	patd00-patd
	dc.w	patd01-patd
	dc.w	patd02-patd
	dc.w	patd03-patd
	dc.w	patd04-patd
	dc.w	patd05-patd
patd00:
	dc.b	3
	dc.b	$E0,5,0,$D,-8
	dc.b	$F0,5,0,$11,-8
	dc.b	0,5,0,$15,-8
	even
patd01:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$29,-8
	dc.b	$10,5,0,$31,-8
	even
patd02:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$33,-8
	dc.b	$10,5,0,$2B,-8
	even
patd03:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$1D,-8
	dc.b	$10,5,0,$19,-8
	even
patd04:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,8,$1D,-8
	dc.b	$10,5,0,$19,-8
	even
patd05:
	dc.b	5
	dc.b	$D0,5,0,$D,-8
	dc.b	$E0,5,0,$11,-8
	dc.b	$F0,5,0,$15,-8
	dc.b	0,5,0,$21,-8
	dc.b	$10,5,0,$19,-8
	even