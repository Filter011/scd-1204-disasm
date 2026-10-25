	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20EE7E(pc,d0.w),d0
	jsr	off_20EE7E(pc,d0.w)
	jmp	$20517A.l

off_20EE7E:
	dc.w	loc_20EE86-off_20EE7E
	dc.w	loc_20EEFA-off_20EE7E
	dc.w	loc_20EF40-off_20EE7E
	dc.w	loc_20EF84-off_20EE7E

loc_20EE86:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#3,sprpri(a0)
	move.w	#$4000,sproffset(a0)
	lea	off_20F19A(pc),a1
	lea	unk_20F210(pc),a2
	move.b	userflag(a0),d0
	bpl.w	loc_20EEB4
	lea	off_20F266(pc),a1
	lea	off_20F32A(pc),a2

loc_20EEB4:
	move.l	a1,patbase(a0)
	btst	#4,d0
	beq.w	loc_20EECC
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)

loc_20EECC:
	andi.w	#$F,d0
	move.b	d0,patno(a0)
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	move.b	(a2,d0.w),d1
	addq.b	#1,d1
	asl.b	#3,d1
	move.b	d1,sprhsize(a0)
	move.b	1(a2,d0.w),d1
	bpl.w	loc_20EEF0
	neg.b	d1

loc_20EEF0:
	addq.b	#1,d1
	asl.b	#3,d1
	addq.b	#2,d1
	move.b	d1,sprvsize(a0)

loc_20EEFA:
	tst.b	actflg(a0)
	bpl.s	locret_20EF2E
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	lea	playerwk.w,a3
	lea	player2wk.w,a1
	move.b	main_play,d0
	beq.w	loc_20EF1C
	exg.l	a1,a3

loc_20EF1C:
	jsr	$209E14.l
	exg.l	a1,a3
	jsr	$209E14.l
	bne.w	loc_20EF30

locret_20EF2E:
	rts

loc_20EF30:
	addq.b	#word,r_no0(a0)
	move.b	userflag(a0),d0
	bpl.w	loc_20EFBE
	bra.w	loc_20F0B0

loc_20EF40:
	lea	act2A(a0),a3
	addi.w	#-1,(a3)
	bne.w	loc_20EF50
	addq.b	#word,r_no0(a0)

loc_20EF50:
	move.b	act3E(a0),d0
	beq.w	locret_20EF82
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	lea	playerwk.w,a1
	bsr.w	sub_20EF6C
	lea	player2wk.w,a1

sub_20EF6C:
	jsr	$209E14.l
	beq.w	locret_20EF82
	tst.w	(a3)
	bne.w	locret_20EF82
	bclr	#cd_ride,cddat(a1)

locret_20EF82:
	rts

loc_20EF84:
	move.l	act2C(a0),d0
	add.l	d0,yposi(a0)
	addi.l	#$4000,act2C(a0)
	move.w	yposi(a0),d0
	lea	playerwk.w,a1
	move.b	main_play,d1
	beq.w	loc_20EFAA
	lea	player2wk.w,a1

loc_20EFAA:
	sub.w	yposi(a1),d0
	cmpi.w	#$200,d0
	bgt.w	loc_20EFB8
	rts

loc_20EFB8:
	jmp	$2051FE.l

loc_20EFBE:
	move.b	userflag(a0),d0
	suba.l	a4,a4
	btst	#4,d0
	beq.w	loc_20EFD0
	lea	loc_20EFBE(pc),a4

loc_20EFD0:
	lea	unk_20F210(pc),a6
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
	bne.w	loc_20EFFA
	neg.w	d0
	neg.w	d1

loc_20EFFA:
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

loc_20F01C:
	move.w	a5,d5
	move.w	a2,d3
	move.w	d2,d1

loc_20F022:
	jsr	$208E7A.l
	bne.w	locret_20F0AE
	move.b	(a6)+,d0
	bmi.w	loc_20F09A
	move.b	d0,patno(a1)
	ori.b	#4,actflg(a1)
	move.b	#3,sprpri(a1)
	move.w	#$4000,sproffset(a1)
	move.l	#off_20F228,patbase(a1)
	move.l	#$20000,act2C(a1)
	_move.b	act3F(a0),actno(a1)
	move.b	r_no0(a0),r_no0(a1)
	cmpa.w	#0,a4
	beq.w	loc_20F078
	bset	#0,actflg(a1)
	bset	#0,cddat(a1)

loc_20F078:
	tst.w	d6
	bne.w	loc_20F08E
	st	act3E(a1)
	move.b	#8,sprhsize(a1)
	move.b	#9,sprvsize(a1)

loc_20F08E:
	move.w	d4,yposi(a1)
	move.w	d3,xposi(a1)
	move.w	d1,act2A(a1)

loc_20F09A:
	add.w	a3,d3
	addi.w	#$C,d1
	dbf	d5,loc_20F022

	addi.w	#-$10,d4
	addq.w	#5,d2
	dbf	d6,loc_20F01C

locret_20F0AE:
	rts

loc_20F0B0:
	move.b	userflag(a0),d2
	lea	off_20F32A(pc),a6
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
	bne.w	loc_20F0F0
	lsl.b	#2,d2
	bra.w	loc_20F112

loc_20F0F0:
	lea	playerwk.w,a1
	move.b	main_play,d0
	beq.w	loc_20F102
	lea	player2wk.w,a1

loc_20F102:
	move.w	xspeed(a1),d0
	btst	#5,d2
	beq.w	loc_20F110
	neg.w	d0

loc_20F110:
	tst.w	d0

loc_20F112:
	bpl.w	loc_20F120
	lea	(a6,d5.w),a6
	neg.w	d4
	neg.w	d3
	neg.w	d6

loc_20F120:
	add.w	xposi(a0),d4
	move.w	#9,d2
	_move.b	actno(a0),act3F(a0)
	_clr.b	actno(a0)

loc_20F132:
	jsr	$208E7A.l
	bne.w	locret_20F198
	move.b	#3,sprpri(a1)
	move.w	#$4000,sproffset(a1)
	ori.b	#4,actflg(a1)
	move.l	#off_20F336,patbase(a1)
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
	dbf	d5,loc_20F132

locret_20F198:
	rts

off_20F19A:
	dc.w	byte_20F19C-off_20F19A
byte_20F19C:
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

unk_20F210:
	dc.b	0
	dc.b	2
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

off_20F228:
	dc.w	byte_20F236-off_20F228
	dc.w	byte_20F23C-off_20F228
	dc.w	byte_20F242-off_20F228
	dc.w	byte_20F248-off_20F228
	dc.w	byte_20F24E-off_20F228
	dc.w	byte_20F254-off_20F228
	dc.w	byte_20F25A-off_20F228
byte_20F236:
	dc.b	1
	dc.b	-8,5,0,$19,-8
byte_20F23C:
	dc.b	1
	dc.b	-8,5,8,$25,-8
byte_20F242:
	dc.b	1
	dc.b	-8,5,0,$1D,-8
byte_20F248:
	dc.b	1
	dc.b	-8,5,0,$21,-8
byte_20F24E:
	dc.b	1
	dc.b	-8,5,8,$1D,-8
byte_20F254:
	dc.b	1
	dc.b	-8,5,8,$15,-8
byte_20F25A:
	dc.b	2
	dc.b	$E8,5,8,$D,-8
	dc.b	-8,5,8,$11,-8
	even

off_20F266:
	dc.w	byte_20F26A-off_20F266
	dc.w	byte_20F26A-off_20F266
byte_20F26A:
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

off_20F32A:
	dc.w	unk_20F32E-off_20F32A
	dc.w	unk_20F32E-off_20F32A
unk_20F32E:
	dc.b	5
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	even

off_20F336:
	dc.w	byte_20F338-off_20F336
byte_20F338:
	dc.b	3
	dc.b	$E0,5,0,$D,-8
	dc.b	$F0,5,0,$11,-8
	dc.b	0,5,0,$15,-8
	even