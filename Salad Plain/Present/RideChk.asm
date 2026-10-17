ride_on_clr:
	btst	#3,cddat(a0)
	beq.s	locret_207EDA
	btst	#cd_ride,cddat(a1)
	beq.s	locret_207EDA
	moveq	#0,d0
	move.b	act3D(a1),d0
	lsl.w	#6,d0
	addi.l	#actwk&$FFFFFF,d0
	cmpa.w	d0,a0
	bne.s	locret_207EDA
	clr.b	convexflag(a1)
	bset	#cd_walk,cddat(a1)
	bclr	#cd_ride,cddat(a1)
	bclr	#3,cddat(a0)

locret_207EDA:
	rts

ride_on_set:
	clr.b	r_no1(a0)
	clr.b	jumpflag(a1)
	bset	#3,cddat(a0)
	bne.s	loc_207F0A
	bclr	#cd_ball,cddat(a1)
	beq.s	loc_207F0A
	move.b	#walkheight,sprvsize(a1)
	move.b	#walkwidth,sprhs(a1)
	subq.w	#walkheight-rollheight,yposi(a1)
	move.b	#0,mstno(a1)

loc_207F0A:
	bset	#cd_ride,cddat(a1)
	beq.s	loc_207F2C
	moveq	#0,d0
	move.b	act3D(a1),d0
	lsl.w	#6,d0
	addi.l	#actwk&$FFFFFF,d0
	cmpa.w	d0,a0
	beq.s	locret_207F54
	movea.l	d0,a2
	bclr	#3,cddat(a2)

loc_207F2C:
	move.w	a0,d0
	subi.w	#actwk&$FFFF,d0
	lsr.w	#6,d0
	andi.w	#$7F,d0
	move.b	d0,act3D(a1)
	move.b	#0,direc(a1)
	move.w	#0,yspeed(a1)
	move.w	xspeed(a1),mspeed(a1)
	bclr	#cd_jump,cddat(a1)

locret_207F54:
	rts

ride_on_chk:
	cmpi.b	#4,r_no0(a1)
	bhs.w	loc_20805C
	cmpi.b	#$2B,mstno(a1)
	beq.w	loc_20805C
	_tst.b	actno(a1)
	beq.w	loc_20805C
	tst.b	actflg(a0)
	bpl.w	loc_20805C
	tst.b	editmode
	bne.w	loc_20805C
	moveq	#0,d1
	moveq	#0,d2
	move.b	sprvsize(a0),d2
	move.b	sprhsize(a0),d1
	moveq	#$10,d5
	add.w	d1,d5
	move.w	xposi(a1),d0
	sub.w	d3,d0
	add.w	d5,d0
	bmi.w	loc_20805C
	move.w	d5,d6
	add.w	d5,d5
	cmp.w	d5,d0
	bhs.w	loc_20805C
	move.w	d0,d5
	move.w	xposi(a1),d0
	sub.w	d3,d0
	add.w	d1,d0
	bmi.w	loc_208068
	add.w	d1,d1
	cmp.w	d1,d0
	bhs.w	loc_208068
	tst.b	r_no1(a0)
	beq.s	loc_207FD0
	cmpi.b	#2,mstno(a1)
	beq.w	loc_20805C

loc_207FD0:
	btst	#1,actflg(a0)
	beq.s	loc_207FE2
	tst.w	yspeed(a1)
	bpl.w	loc_20805C
	bra.s	loc_207FEA

loc_207FE2:
	tst.w	yspeed(a1)
	bmi.w	loc_20805C

loc_207FEA:
	move.w	yposi(a1),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	btst	#1,actflg(a0)
	beq.s	loc_208000
	sub.w	d1,d0
	bra.s	loc_208002

loc_208000:
	add.w	d1,d0

loc_208002:
	addq.w	#2,d2
	sub.w	d4,d0
	add.w	d2,d0
	bmi.s	loc_20805C
	add.w	d2,d2
	cmp.w	d2,d0
	bhs.s	loc_20805C
	move.w	d4,yposi(a1)
	lsr.w	#1,d2
	add.w	d1,d2
	subq.w	#2,d2
	btst	#1,actflg(a0)
	beq.s	loc_208028
	add.w	d2,yposi(a1)
	bra.s	loc_20802C

loc_208028:
	sub.w	d2,yposi(a1)

loc_20802C:
	moveq	#0,d1
	move.w	xspeed(a0),d1
	ext.l	d1
	asl.l	#8,d1
	move.l	xposi(a1),d0
	add.l	d1,d0
	move.l	d0,xposi(a1)
	moveq	#0,d1
	move.w	yspeed(a0),d1
	ext.l	d1
	asl.l	#8,d1
	move.l	yposi(a1),d0
	add.l	d1,d0
	move.l	d0,yposi(a1)
	bsr.w	ride_on_set
	moveq	#1,d0
	rts

loc_20805C:
	bsr.w	ride_on_clr
	clr.b	r_no1(a0)
	moveq	#0,d0
	rts

loc_208068:
	bsr.w	ride_on_clr
	btst	#cd_jump,cddat(a1)
	bne.s	loc_2080DA
	subq.w	#2,d2
	move.w	yposi(a1),d0
	add.b	sprvsize(a1),d0
	sub.w	d4,d0
	add.w	d2,d0
	bmi.s	loc_2080DA
	add.b	sprvsize(a1),d2
	add.w	d2,d2
	cmp.w	d2,d0
	bhs.s	loc_2080DA
	move.w	xposi(a1),d0
	cmp.w	d3,d0
	bhs.s	loc_20809E
	tst.w	xspeed(a1)
	bpl.s	loc_2080B2
	bra.s	loc_2080A4

loc_20809E:
	tst.w	xspeed(a1)
	bmi.s	loc_2080B2

loc_2080A4:
	bclr	#cd_push,cddat(a1)
	bclr	#5,cddat(a0)
	bra.s	loc_2080BE

loc_2080B2:
	bset	#cd_push,cddat(a1)
	bset	#5,cddat(a0)

loc_2080BE:
	cmp.w	d5,d6
	bhs.s	loc_2080C6
	add.w	d6,d6
	sub.w	d6,d5

loc_2080C6:
	sub.w	d5,xposi(a1)
	move.w	#0,mspeed(a1)
	move.w	#0,xspeed(a1)
	moveq	#0,d0
	rts

loc_2080DA:
	bclr	#cd_push,cddat(a1)
	bclr	#5,cddat(a0)
	moveq	#0,d0
	rts