fcol:
	btst	#3,cddat(a0)
	beq.s	loc_200AB2
	moveq	#0,d0
	move.b	d0,dirstk.w
	move.b	d0,dirstk2.w
	rts

loc_200AB2:
	moveq	#3,d0
	move.b	d0,dirstk.w
	move.b	d0,dirstk2.w
	move.b	direc(a0),d0
	addi.b	#$20,d0
	bpl.s	loc_200AD4
	move.b	direc(a0),d0
	bpl.s	loc_200ACE
	subq.b	#1,d0

loc_200ACE:
	addi.b	#$20,d0
	bra.s	loc_200AE0

loc_200AD4:
	move.b	direc(a0),d0
	bpl.s	loc_200ADC
	addq.b	#1,d0

loc_200ADC:
	addi.b	#$1F,d0

loc_200AE0:
	andi.b	#$C0,d0
	cmpi.b	#$40,d0
	beq.w	fcol_l
	cmpi.b	#$80,d0
	beq.w	fcol_u
	cmpi.b	#$C0,d0
	beq.w	fcol_r

fcol_d:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	bsr.w	scdchk
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	neg.w	d0
	add.w	d0,d3
	lea	dirstk2.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	bsr.w	scdchk
	move.w	(sp)+,d0
	bsr.w	dirchk
	tst.w	d1
	beq.s	locret_200B6E
	bpl.s	loc_200B70
	cmpi.w	#-$E,d1
	blt.s	locret_200B96
	add.w	d1,yposi(a0)

locret_200B6E:
	rts

loc_200B70:
	cmpi.w	#$E,d1
	bgt.s	loc_200B7C

loc_200B76:
	add.w	d1,yposi(a0)
	rts

loc_200B7C:
	tst.b	act38(a0)
	bne.s	loc_200B76
	bset	#1,cddat(a0)
	bclr	#5,cddat(a0)
	move.b	#1,mstrestart(a0)
	rts

locret_200B96:
	rts

	move.l	xposi(a0),d2
	move.w	xspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	sub.l	d0,d2
	move.l	d2,xposi(a0)
	move.w	#$38,d0
	ext.l	d0
	asl.l	#8,d0
	sub.l	d0,d3
	move.l	d3,yposi(a0)
	rts

locret_200BBA:
	rts

	move.l	yposi(a0),d3
	move.w	yspeed(a0),d0
	subi.w	#$38,d0
	move.w	d0,yspeed(a0)
	ext.l	d0
	asl.l	#8,d0
	sub.l	d0,d3
	move.l	d3,yposi(a0)
	rts

	rts

	move.l	xposi(a0),d2
	move.l	yposi(a0),d3
	move.w	xspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	sub.l	d0,d2
	move.w	yspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	sub.l	d0,d3
	move.l	d2,xposi(a0)
	move.l	d3,yposi(a0)
	rts

dirchk:
	move.b	dirstk2.w,d2
	cmp.w	d0,d1
	ble.s	loc_200C0E
	move.b	dirstk.w,d2
	move.w	d0,d1

loc_200C0E:
	btst	#0,d2
	bne.s	loc_200C1A
	move.b	d2,direc(a0)
	rts

loc_200C1A:
	move.b	direc(a0),d2
	addi.b	#$20,d2
	andi.b	#$C0,d2
	move.b	d2,direc(a0)
	rts

fcol_r:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	neg.w	d0
	add.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	bsr.w	scdchk_r
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk2.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	bsr.w	scdchk_r
	move.w	(sp)+,d0
	bsr.w	dirchk
	tst.w	d1
	beq.s	locret_200CA0
	bpl.s	loc_200CA2
	cmpi.w	#-$E,d1
	blt.w	locret_200BBA
	add.w	d1,xposi(a0)

locret_200CA0:
	rts

loc_200CA2:
	cmpi.w	#$E,d1
	bgt.s	loc_200CAE

loc_200CA8:
	add.w	d1,xposi(a0)
	rts

loc_200CAE:
	tst.b	act38(a0)
	bne.s	loc_200CA8
	bset	#1,cddat(a0)
	bclr	#5,cddat(a0)
	move.b	#1,mstrestart(a0)
	rts

fcol_u:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$1000,d6
	moveq	#$D,d5
	bsr.w	scdchk
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	lea	dirstk2.w,a4
	movea.w	#-$10,a3
	move.w	#$1000,d6
	moveq	#$D,d5
	bsr.w	scdchk
	move.w	(sp)+,d0
	bsr.w	dirchk
	tst.w	d1
	beq.s	locret_200D42
	bpl.s	loc_200D44
	cmpi.w	#-$E,d1
	blt.w	locret_200B96
	sub.w	d1,yposi(a0)

locret_200D42:
	rts

loc_200D44:
	cmpi.w	#$E,d1
	bgt.s	loc_200D50

loc_200D4A:
	sub.w	d1,yposi(a0)
	rts

loc_200D50:
	tst.b	act38(a0)
	bne.s	loc_200D4A
	bset	#1,cddat(a0)
	bclr	#5,cddat(a0)
	move.b	#1,mstrestart(a0)
	rts

fcol_l:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d3
	eori.w	#$F,d3
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	moveq	#$D,d5
	bsr.w	scdchk_r
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d3
	eori.w	#$F,d3
	lea	dirstk2.w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	moveq	#$D,d5
	bsr.w	scdchk_r
	move.w	(sp)+,d0
	bsr.w	dirchk
	tst.w	d1
	beq.s	locret_200DE4
	bpl.s	loc_200DE6
	cmpi.w	#-$E,d1
	blt.w	locret_200BBA
	sub.w	d1,xposi(a0)

locret_200DE4:
	rts

loc_200DE6:
	cmpi.w	#$E,d1
	bgt.s	loc_200DF2

loc_200DEC:
	sub.w	d1,xposi(a0)
	rts

loc_200DF2:
	tst.b	act38(a0)
	bne.s	loc_200DEC
	bset	#1,cddat(a0)
	bclr	#5,cddat(a0)
	move.b	#1,mstrestart(a0)
	rts

scramapad:
	move.w	d2,d0
	lsr.w	#1,d0
	andi.w	#$380,d0
	move.w	d3,d1
	lsr.w	#8,d1
	andi.w	#$7F,d1
	add.w	d1,d0
	move.l	#mapwk,d1
	lea	mapwka.w,a1
	move.b	(a1,d0.w),d1
	beq.s	loc_200E4A
	bmi.s	loc_200E4E
	subq.b	#1,d1
	ext.w	d1
	ror.w	#7,d1
	move.w	d2,d0
	add.w	d0,d0
	andi.w	#$1E0,d0
	add.w	d0,d1
	move.w	d3,d0
	lsr.w	#3,d0
	andi.w	#$1E,d0
	add.w	d0,d1

loc_200E4A:
	movea.l	d1,a1
	rts

loc_200E4E:
	andi.w	#$7F,d1
	btst	#6,actflg(a0)
	beq.s	loc_200E66
	addq.w	#1,d1
	cmpi.w	#$29,d1
	bne.s	loc_200E66
	move.w	#$51,d1

loc_200E66:
	subq.b	#1,d1
	ror.w	#7,d1
	move.w	d2,d0
	add.w	d0,d0
	andi.w	#$1E0,d0
	add.w	d0,d1
	move.w	d3,d0
	lsr.w	#3,d0
	andi.w	#$1E,d0
	add.w	d0,d1
	movea.l	d1,a1
	rts

scdchk:
	bsr.w	scramapad
	cmpi.l	#mapwk,d1
	beq.s	loc_200E9C
	move.w	(a1),d0
	move.w	d0,d4
	andi.w	#$7FF,d0
	beq.s	loc_200E9C
	btst	d5,d4
	bne.s	loc_200EAA

loc_200E9C:
	add.w	a3,d2
	bsr.w	scdchk2
	sub.w	a3,d2
	addi.w	#$10,d1
	rts

loc_200EAA:
	movea.l	scdadr.w,a2
	move.b	(a2,d0.w),d0
	andi.w	#$FF,d0
	beq.s	loc_200E9C
	lea	scddirtbl.l,a2
	move.b	(a2,d0.w),(a4)
	lsl.w	#4,d0
	move.w	d3,d1
	btst	#$B,d4
	beq.s	loc_200ED0
	not.w	d1
	neg.b	(a4)

loc_200ED0:
	btst	#$C,d4
	beq.s	loc_200EE0
	addi.b	#$40,(a4)
	neg.b	(a4)
	subi.b	#$40,(a4)

loc_200EE0:
	andi.w	#$F,d1
	add.w	d0,d1
	lea	scdtblwk.l,a2
	move.b	(a2,d1.w),d0
	ext.w	d0
	eor.w	d6,d4
	btst	#$C,d4
	beq.s	loc_200EFC
	neg.w	d0

loc_200EFC:
	tst.w	d0
	beq.s	loc_200E9C
	bmi.s	loc_200F18
	cmpi.b	#$10,d0
	beq.s	loc_200F34

loc_200F08:
	move.w	d2,d1
	andi.w	#$F,d1
	add.w	d1,d0
	move.w	#$F,d1
	sub.w	d0,d1
	rts

loc_200F18:
	cmpa.w	#$10,a3
	bne.s	loc_200F28
	move.w	#$10,d0
	move.b	#0,(a4)
	bra.s	loc_200F08

loc_200F28:
	move.w	d2,d1
	andi.w	#$F,d1
	add.w	d1,d0
	bpl.w	loc_200E9C

loc_200F34:
	sub.w	a3,d2
	bsr.w	scdchk2
	add.w	a3,d2
	subi.w	#$10,d1
	rts

scdchk2:
	bsr.w	scramapad
	cmpi.l	#mapwk,d1
	beq.s	loc_200F5C
	move.w	(a1),d0
	move.w	d0,d4
	andi.w	#$7FF,d0
	beq.s	loc_200F5C
	btst	d5,d4
	bne.s	loc_200F6A

loc_200F5C:
	move.w	#$F,d1
	move.w	d2,d0
	andi.w	#$F,d0
	sub.w	d0,d1
	rts

loc_200F6A:
	movea.l	scdadr.w,a2
	move.b	(a2,d0.w),d0
	andi.w	#$FF,d0
	beq.s	loc_200F5C
	lea	scddirtbl.l,a2
	move.b	(a2,d0.w),(a4)
	lsl.w	#4,d0
	move.w	d3,d1
	btst	#$B,d4
	beq.s	loc_200F90
	not.w	d1
	neg.b	(a4)

loc_200F90:
	btst	#$C,d4
	beq.s	loc_200FA0
	addi.b	#$40,(a4)
	neg.b	(a4)
	subi.b	#$40,(a4)

loc_200FA0:
	andi.w	#$F,d1
	add.w	d0,d1
	lea	scdtblwk.l,a2
	move.b	(a2,d1.w),d0
	ext.w	d0
	eor.w	d6,d4
	btst	#$C,d4
	beq.s	loc_200FBC
	neg.w	d0

loc_200FBC:
	tst.w	d0
	beq.s	loc_200F5C
	bmi.s	loc_200FD2

loc_200FC2:
	move.w	d2,d1
	andi.w	#$F,d1
	add.w	d1,d0
	move.w	#$F,d1
	sub.w	d0,d1
	rts

loc_200FD2:
	cmpa.w	#$10,a3
	bne.s	loc_200FE2
	move.w	#$10,d0
	move.b	#0,(a4)
	bra.s	loc_200FC2

loc_200FE2:
	move.w	d2,d1
	andi.w	#$F,d1
	add.w	d1,d0
	bpl.w	loc_200F5C
	not.w	d1
	rts

scdchk_r:
	bsr.w	scramapad
	cmpi.l	#mapwk,d1
	beq.s	loc_20100C
	move.w	(a1),d0
	move.w	d0,d4
	andi.w	#$7FF,d0
	beq.s	loc_20100C
	btst	d5,d4
	bne.s	loc_20101A

loc_20100C:
	add.w	a3,d3
	bsr.w	scdchk2_r
	sub.w	a3,d3
	addi.w	#$10,d1
	rts

loc_20101A:
	movea.l	scdadr.w,a2
	move.b	(a2,d0.w),d0
	andi.w	#$FF,d0
	beq.s	loc_20100C
	lea	scddirtbl.l,a2
	move.b	(a2,d0.w),(a4)
	lsl.w	#4,d0
	move.w	d2,d1
	btst	#$C,d4
	beq.s	loc_201048
	not.w	d1
	addi.b	#$40,(a4)
	neg.b	(a4)
	subi.b	#$40,(a4)

loc_201048:
	btst	#$B,d4
	beq.s	loc_201050
	neg.b	(a4)

loc_201050:
	andi.w	#$F,d1
	add.w	d0,d1
	lea	scdtblwk2.l,a2
	move.b	(a2,d1.w),d0
	ext.w	d0
	eor.w	d6,d4
	btst	#$B,d4
	beq.s	loc_20106C
	neg.w	d0

loc_20106C:
	tst.w	d0
	beq.s	loc_20100C
	bmi.s	loc_201088
	cmpi.b	#$10,d0
	beq.s	loc_201094
	move.w	d3,d1
	andi.w	#$F,d1
	add.w	d1,d0
	move.w	#$F,d1
	sub.w	d0,d1
	rts

loc_201088:
	move.w	d3,d1
	andi.w	#$F,d1
	add.w	d1,d0
	bpl.w	loc_20100C

loc_201094:
	sub.w	a3,d3
	bsr.w	scdchk2_r
	add.w	a3,d3
	subi.w	#$10,d1
	rts

scdchk2_r:
	bsr.w	scramapad
	cmpi.l	#mapwk,d1
	beq.s	loc_2010BC
	move.w	(a1),d0
	move.w	d0,d4
	andi.w	#$7FF,d0
	beq.s	loc_2010BC
	btst	d5,d4
	bne.s	loc_2010CA

loc_2010BC:
	move.w	#$F,d1
	move.w	d3,d0
	andi.w	#$F,d0
	sub.w	d0,d1
	rts

loc_2010CA:
	movea.l	scdadr.w,a2
	move.b	(a2,d0.w),d0
	andi.w	#$FF,d0
	beq.s	loc_2010BC
	lea	scddirtbl.l,a2
	move.b	(a2,d0.w),(a4)
	lsl.w	#4,d0
	move.w	d2,d1
	btst	#$C,d4
	beq.s	loc_2010F8
	not.w	d1
	addi.b	#$40,(a4)
	neg.b	(a4)
	subi.b	#$40,(a4)

loc_2010F8:
	btst	#$B,d4
	beq.s	loc_201100
	neg.b	(a4)

loc_201100:
	andi.w	#$F,d1
	add.w	d0,d1
	lea	scdtblwk2.l,a2
	move.b	(a2,d1.w),d0
	ext.w	d0
	eor.w	d6,d4
	btst	#$B,d4
	beq.s	loc_20111C
	neg.w	d0

loc_20111C:
	tst.w	d0
	beq.s	loc_2010BC
	bmi.s	loc_201132
	move.w	d3,d1
	andi.w	#$F,d1
	add.w	d1,d0
	move.w	#$F,d1
	sub.w	d0,d1
	rts

loc_201132:
	move.w	d3,d1
	andi.w	#$F,d1
	add.w	d1,d0
	bpl.w	loc_2010BC
	not.w	d1
	rts

scdcnv:
	rts
	lea	scdtblwk.l,a1
	lea	scdtblwk.l,a2
	move.w	#256-1,d3

.loop:
	moveq	#16,d5
	move.w	#16-1,d2

.loop1:
	moveq	#0,d4
	move.w	#16-1,d1

.loop2:
	move.w	(a1)+,d0
	lsr.l	d5,d0
	addx.w	d4,d4
	dbf	d1,.loop2

	move.w	d4,(a2)+
	suba.w	#32,a1
	subq.w	#1,d5
	dbf	d2,.loop1

	adda.w	#32,a1
	dbf	d3,.loop

	lea	scdtblwk.l,a1
	lea	scdtblwk2.l,a2
	bsr.s	.jump
	lea	scdtblwk.l,a1
	lea	scdtblwk.l,a2

.jump:
	move.w	#4096-1,d3

.loop3:
	moveq	#0,d2
	move.w	#16-1,d1
	move.w	(a1)+,d0
	beq.s	.jump5
	bmi.s	.jump2

.loop4:
	lsr.w	#1,d0
	bhs.s	.jump1
	addq.b	#1,d2

.jump1:
	dbf	d1,.loop4

	bra.s	.jump6

.jump2:
	cmpi.w	#-1,d0
	beq.s	.jump4

.loop5:
	lsl.w	#1,d0
	bhs.s	.jump3
	subq.b	#1,d2

.jump3:
	dbf	d1,.loop5

	bra.s	.jump6

.jump4:
	move.w	#16,d0

.jump5:
	move.w	d0,d2

.jump6:
	move.b	d2,(a2)+
	dbf	d3,.loop3

	rts