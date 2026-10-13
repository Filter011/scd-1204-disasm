loc_209088:
	tst.b	byte_FF0580_ext
	beq.s	loc_209096
	jmp	frameout.l

loc_209096:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_2090B0(pc,d0.w),d0
	jsr	off_2090B0(pc,d0.w)
	jsr	actionsub.l
	jmp	frameout_s.l

off_2090B0:
	dc.w	loc_2090B8-off_2090B0
	dc.w	loc_209124-off_2090B0
	dc.w	loc_209154-off_2090B0
	dc.w	locret_20917A-off_2090B0

loc_2090B8:
	addq.b	#2,r_no0(a0)
	move.b	#$E,sprvsize(a0)
	move.b	#$E,sprhs(a0)
	move.l	#itempat,patbase(a0)
	move.w	#$5A8,sproffset(a0)
	move.b	#4,actflg(a0)
	move.b	#3,sprpri(a0)
	move.b	#$F,sprhsize(a0)
	move.b	userflag(a0),mstno(a0)
	bsr.w	flagwkadr
	bclr	#7,2(a2,d0.w)
	move.b	#$A,patno(a0)
	cmpi.b	#8,userflag(a0)
	beq.s	loc_20910A
	addq.b	#2,patno(a0)
loc_20910A:
	btst	#0,2(a2,d0.w)
	beq.s	loc_20911E
	addq.b	#1,patno(a0)
	move.b	#6,r_no0(a0)
	rts

loc_20911E:
	move.b	#$DF,colino(a0)

loc_209124:
	tst.b	colicnt(a0)
	beq.s	locret_209152
	move.b	#$3C,act2A(a0)
	addq.b	#2,r_no0(a0)
	bsr.w	flagwkadr
	bset	#0,2(a2,d0.w)
	move.b	#$FF,time_item.w
	cmpi.b	#8,userflag(a0)
	beq.s	locret_209152
	move.b	#1,time_item.w

locret_209152:
	rts

loc_209154:
	subq.b	#1,act2A(a0)
	beq.s	loc_209164
	lea	itemchg.l,a1
	bra.w	patchg

loc_209164:
	addq.b	#2,r_no0(a0)
	move.b	#$B,patno(a0)
	cmpi.b	#8,userflag(a0)
	beq.s	locret_20917A
	addq.b	#2,patno(a0)

locret_20917A:
	rts

flagwkadr:
	lea	flagwork,a2
	moveq	#0,d0
	move.b	cdsts(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	rts

sub_20919A:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	move.b	#1,r_no1(a0)
	jmp	sub_207F56.l

item:
	cmpi.b	#8,userflag(a0)
	bhs.w	loc_209088
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_2091C6(pc,d0.w),d1
	jmp	off_2091C6(pc,d1.w)

off_2091C6:
	dc.w	iteminit-off_2091C6
	dc.w	itemmove-off_2091C6
	dc.w	itemget-off_2091C6
	dc.w	itemmove2-off_2091C6
	dc.w	itemmove3-off_2091C6

iteminit:
	addq.b	#2,r_no0(a0)
	move.b	#$E,sprvsize(a0)
	move.b	#$E,sprhs(a0)
	move.l	#itempat,patbase(a0)
	move.w	#$5A8,sproffset(a0)
	move.b	#4,actflg(a0)
	move.b	#3,sprpri(a0)
	move.b	#$F,sprhsize(a0)
	bsr.w	flagwkadr
	bclr	#7,2(a2,d0.w)
	btst	#0,2(a2,d0.w)
	beq.s	loc_209220
	move.b	#8,r_no0(a0)
	move.b	#$11,patno(a0)
	rts

loc_209220:
	move.b	#$46,colino(a0)
	move.b	userflag(a0),mstno(a0)

itemmove:
	tst.b	actflg(a0)
	bpl.w	itemmove3
	move.b	r_no1(a0),d0
	beq.s	loc_20925A
	bsr.w	speedset
	jsr	emycol_d.l
	tst.w	d1
	bpl.w	itemmove2
	add.w	d1,yposi(a0)
	clr.w	yspeed(a0)
	clr.b	r_no1(a0)
	bra.w	itemmove2

loc_20925A:
	tst.b	actflg(a0)
	bpl.s	itemmove2
	lea	playerwk.w,a1
	bsr.w	sub_20919A
	lea	byte_FFD040.w,a1
	bsr.w	sub_20919A

itemmove2:
	tst.w	time_stop
	bne.s	itemmove3
	lea	itemchg.l,a1
	bsr.w	patchg

itemmove3:
	bsr.w	actionsub
	jmp	frameout_s.l

itemget:
	move.w	#$96,d0
	jsr	soundset.l
	addq.b	#4,r_no0(a0)
	move.b	#0,colino(a0)
	bsr.w	actwkchk
	bne.s	loc_2092BE
	_move.b	#item2_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	mstno(a0),mstno(a1)

loc_2092BE:
	bsr.w	actwkchk
	bne.s	loc_2092DC
	_move.b	#bakuha_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	#1,r_no1(a1)

loc_2092DC:
	bsr.w	flagwkadr
	bset	#0,2(a2,d0.w)
	move.b	#$11,patno(a0)
	bra.w	actionsub

item2:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_209302(pc,d0.w),d1
	jsr	off_209302(pc,d1.w)
	bra.w	actionsub

off_209302:
	dc.w	item2init-off_209302
	dc.w	item2move-off_209302
	dc.w	item2die-off_209302

item2init:
	addq.b	#2,r_no0(a0)
	move.w	#$5A8,sproffset(a0)
	move.b	#$24,actflg(a0)
	move.b	#3,sprpri(a0)
	move.b	#8,sprhsize(a0)
	move.w	#-$300,yspeed(a0)
	moveq	#0,d0
	move.b	mstno(a0),d0
	move.b	d0,patno(a0)
	movea.l	#itempat,a1
	add.b	d0,d0
	adda.w	(a1,d0.w),a1
	addq.w	#1,a1
	move.l	a1,patbase(a0)

item2move:
	tst.w	yspeed(a0)
	bpl.w	loc_20935A
	bsr.w	speedset2
	addi.w	#$18,yspeed(a0)
	rts

loc_20935A:
	addq.b	#2,r_no0(a0)
	move.w	#29,pattim(a0)
	jsr	sub_2023EA.l
	move.b	mstno(a0),d0
	bne.s	loc_209386

loc_209370:
	addq.b	#1,pl_suu
	addq.b	#1,pl_suu_f
	move.w	#$88,d0
	jmp	bgmset.l

loc_209386:
	cmpi.b	#1,d0
	bne.s	loc_2093D2
	addi.w	#10,plring
	ori.b	#1,plring_f
	cmpi.w	#100,plring
	blo.s	loc_2093C8
	bset	#1,plring_f2
	beq.w	loc_209370
	cmpi.w	#200,plring
	blo.s	loc_2093C8
	bset	#2,plring_f2
	beq.w	loc_209370

loc_2093C8:
	move.w	#$B5,d0
	jmp	bgmset.l

loc_2093D2:
	cmpi.b	#2,d0
	bne.s	loc_2093F0

sub_2093D8:
	move.b	#1,plpower_b
	move.b	#baria_act,byte_FFD180.w
	move.w	#$AF,d0
	jmp	bgmset.l

loc_2093F0:
	cmpi.b	#3,d0
	bne.s	loc_209450

sub_2093F6:
	move.b	#1,plpower_m
	move.w	#1200,mutekitimer(a6)
	move.b	#baria_act,byte_FFD200.w
	move.b	#1,byte_FFD200+mstno.w
	move.b	#baria_act,byte_FFD240.w
	move.b	#2,byte_FFD240+mstno.w
	move.b	#baria_act,byte_FFD280.w
	move.b	#3,byte_FFD280+mstno.w
	move.b	#baria_act,byte_FFD2C0.w
	move.b	#4,byte_FFD2C0+mstno.w
	tst.b	bossstart.w
	bne.s	locret_20944E
	cmpi.w	#$C,pl_air
	bls.s	locret_20944E
	move.w	#$87,d0
	jmp	bgmset.l

locret_20944E:
	rts

loc_209450:
	cmpi.b	#4,d0
	bne.s	loc_209480

loc_209456:
	move.b	#1,plpower_s
	move.w	#1200,speeduptimer(a6)
	move.w	#$C00,plmaxspdwk.w
	move.w	#$18,pladdspdwk.w
	move.w	#$80,plretspdwk.w
	move.w	#$E2,d0
	jmp	bgmset.l

loc_209480:
	cmpi.b	#5,d0
	bne.s	loc_209490
	move.w	#300,time_stop
	rts

loc_209490:
	cmpi.b	#6,d0
	bne.s	loc_209498
	nop

loc_209498:
	bsr.w	sub_2093D8
	bsr.w	sub_2093F6
	bra.s	loc_209456

item2die:
	subq.w	#1,pattim(a0)
	bmi.w	frameout
	rts

itemchg:
	dc.w	unk_2094C0-itemchg
	dc.w	unk_2094CC-itemchg
	dc.w	unk_2094D8-itemchg
	dc.w	unk_2094E4-itemchg
	dc.w	unk_2094F0-itemchg
	dc.w	unk_2094FC-itemchg
	dc.w	unk_209508-itemchg
	dc.w	unk_209514-itemchg
	dc.w	unk_209520-itemchg
	dc.w	unk_20952A-itemchg
unk_2094C0:
	dc.b	1
	dc.b	$10,0,0,8,0,0,9,0,0
	dc.b	$FF
	even
unk_2094CC:
	dc.b	1
	dc.b	$10,1,1,8,1,1,9,1,1
	dc.b	$FF
	even
unk_2094D8:
	dc.b	1
	dc.b	$10,2,2,8,2,2,9,2,2
	dc.b	$FF
	even
unk_2094E4:
	dc.b	1
	dc.b	$10,3,3,8,3,3,9,3,3
	dc.b	$FF
	even
unk_2094F0:
	dc.b	1
	dc.b	$10,4,4,8,4,4,9,4,4
	dc.b	$FF
	even
unk_2094FC:
	dc.b	1
	dc.b	$10,5,5,8,5,5,9,5,5
	dc.b	$FF
	even
unk_209508:
	dc.b	1
	dc.b	$10,6,6,8,6,6,9,6,6
	dc.b	$FF
	even
unk_209514:
	dc.b	1
	dc.b	$10,7,7,8,7,7,9,7,7
	dc.b	$FF
	even
unk_209520:
	dc.b	1
	dc.b	$A,$E,$F,$E,$B,$E,$F,$E
	dc.b	$FF
	even
unk_20952A:
	dc.b	1
	dc.b	$C,$E,$F,$E,$D,$E,$F,$E
	dc.b	$FF
	even

itempat:
	dc.w	byte_209558-itempat
	dc.w	byte_20956E-itempat
	dc.w	byte_209584-itempat
	dc.w	byte_20959A-itempat
	dc.w	byte_2095B0-itempat
	dc.w	byte_2095C6-itempat
	dc.w	byte_2095DC-itempat
	dc.w	byte_2095F2-itempat
	dc.w	byte_209608-itempat
	dc.w	byte_20961E-itempat
	dc.w	byte_209634-itempat
	dc.w	byte_20964E-itempat
	dc.w	byte_209668-itempat
	dc.w	byte_209682-itempat
	dc.w	byte_20969C-itempat
	dc.w	byte_2096B6-itempat
	dc.w	byte_2096D0-itempat
	dc.w	byte_2096E0-itempat
byte_209558:
	dc.b	4
	dc.b	$F6,5,0,$12,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_20956E:
	dc.b	4
	dc.b	$F6,5,0,$16,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_209584:
	dc.b	4
	dc.b	$F6,5,0,$1A,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_20959A:
	dc.b	4
	dc.b	$F6,5,0,$1E,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_2095B0:
	dc.b	4
	dc.b	$F6,5,0,$22,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_2095C6:
	dc.b	4
	dc.b	$F6,5,0,$26,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_2095DC:
	dc.b	4
	dc.b	$F6,5,0,$2A,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_2095F2:
	dc.b	4
	dc.b	$F6,5,0,$2E,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_209608:
	dc.b	4
	dc.b	$F6,5,0,$48,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_20961E:
	dc.b	4
	dc.b	$F6,5,8,$48,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
byte_209634:
	dc.b	5
	dc.b	$D8,$D,0,$32,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
byte_20964E:
	dc.b	5
	dc.b	$D8,$D,8,$32,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
byte_209668:
	dc.b	5
	dc.b	$D8,$D,0,$3A,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
byte_209682:
	dc.b	5
	dc.b	$D8,$D,8,$3A,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
byte_20969C:
	dc.b	5
	dc.b	$D8,5,0,$42,-8
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
byte_2096B6:
	dc.b	5
	dc.b	$D8,1,0,$46,$FC
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
byte_2096D0:
	dc.b	3
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
byte_2096E0:
	dc.b	1
	dc.b	0,$D,0,$A,$F0