shooter:
	bsr.w	sub_2023EA
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_207B78(pc,d0.w),d1
	jsr	off_207B78(pc,d1.w)
	cmpi.b	#4,r_no0(a0)
	bhs.s	locret_207B70
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.s	loc_207B72

locret_207B70:
	rts

loc_207B72:
	jmp	frameout.l

off_207B78:
	dc.w	shooterinit-off_207B78
	dc.w	shootermove-off_207B78
	dc.w	shootermove2-off_207B78
	dc.w	shootermove3-off_207B78

shooterinit:
	move.l	#bariapat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$541,sproffset(a0)
	addq.b	#word,r_no0(a0)
	move.b	userflag(a0),d0
	add.w	d0,d0
	andi.w	#$1E,d0
	lea	shooterpositbl(pc),a2
	adda.w	(a2,d0.w),a2
	move.w	(a2)+,act3A(a0)
	move.l	a2,act3C(a0)
	move.w	(a2)+,act36(a0)
	move.w	(a2)+,act38(a0)

shootermove:
	move.w	xposi(a6),d0
	sub.w	xposi(a0),d0
	addi.w	#$10,d0
	cmpi.w	#$20,d0
	bhs.s	locret_207C3C
	move.w	yposi(a6),d1
	sub.w	yposi(a0),d1
	addi.w	#$20,d1
	cmpi.w	#$40,d1
	bhs.s	locret_207C3C
	tst.b	act2C(a6)
	bne.s	locret_207C3C
	addq.b	#word,r_no0(a0)
	move.b	#$81,act2C(a6)
	move.b	#2,mstno(a6)
	bsr.w	mspd_set
	move.w	#0,xspeed(a6)
	move.w	#0,yspeed(a6)
	bclr	#5,cddat(a0)
	bclr	#cd_push,cddat(a6)
	bset	#cd_jump,cddat(a6)
	move.w	xposi(a0),xposi(a6)
	move.w	yposi(a0),yposi(a6)
	clr.b	act32(a0)
	move.w	#$91,d0
	jsr	soundset.l

locret_207C3C:
	rts

shootermove2:
	bsr.w	shooterspdset
	addq.b	#word,r_no0(a0)
	move.w	#$91,d0
	jsr	soundset.l
	rts

shootermove3:
	addq.l	#4,sp
	subq.b	#1,act2E(a0)
	bpl.s	loc_207C90
	move.w	act36(a0),xposi(a6)
	move.w	act38(a0),yposi(a6)
	moveq	#0,d1
	move.b	act3A(a0),d1
	addq.b	#4,d1
	cmp.b	act3B(a0),d1
	blo.s	loc_207C78
	moveq	#0,d1
	bra.s	loc_207CB6

loc_207C78:
	move.b	d1,act3A(a0)
	movea.l	act3C(a0),a2
	move.w	(a2,d1.w),act36(a0)
	move.w	2(a2,d1.w),act38(a0)
	bra.w	shooterspdset

loc_207C90:
	move.l	xposi(a6),d2
	move.l	yposi(a6),d3
	move.w	xspeed(a6),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d2
	move.w	yspeed(a6),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d3
	move.l	d2,xposi(a6)
	move.l	d3,yposi(a6)
	rts

loc_207CB6:
	andi.w	#$7FF,yposi(a6)
	clr.b	r_no0(a0)
	clr.b	act2C(a6)
	move.w	#2,r_no0(a0)
	rts

shooterspdset:
	moveq	#0,d0
	move.w	mspeed(a6),d2
	move.w	mspeed(a6),d3
	move.w	act36(a0),d0
	sub.w	xposi(a6),d0
	bge.s	loc_207CE4
	neg.w	d0
	neg.w	d2

loc_207CE4:
	moveq	#0,d1
	move.w	act38(a0),d1
	sub.w	yposi(a6),d1
	bge.s	loc_207CF4
	neg.w	d1
	neg.w	d3

loc_207CF4:
	cmp.w	d0,d1
	blo.s	loc_207D2A
	moveq	#0,d1
	move.w	act38(a0),d1
	sub.w	yposi(a6),d1
	swap	d1
	divs.w	d3,d1
	moveq	#0,d0
	move.w	act36(a0),d0
	sub.w	xposi(a6),d0
	beq.s	loc_207D16
	swap	d0
	divs.w	d1,d0

loc_207D16:
	move.w	d0,xspeed(a6)
	move.w	d3,yspeed(a6)
	tst.w	d1
	bpl.s	loc_207D24
	neg.w	d1

loc_207D24:
	move.w	d1,act2E(a0)
	rts

loc_207D2A:
	moveq	#0,d0
	move.w	act36(a0),d0
	sub.w	xposi(a6),d0
	swap	d0
	divs.w	d2,d0
	moveq	#0,d1
	move.w	act38(a0),d1
	sub.w	yposi(a6),d1
	beq.s	loc_207D48
	swap	d1
	divs.w	d0,d1

loc_207D48:
	move.w	d1,yspeed(a6)
	move.w	d2,xspeed(a6)
	tst.w	d0
	bpl.s	loc_207D56
	neg.w	d0

loc_207D56:
	move.w	d0,act2E(a0)
	rts

mspd_set:
	moveq	#0,d0
	move.b	userflag(a0),d0
	add.w	d0,d0
	move.w	mspdtbl(pc,d0.w),d0
	cmp.w	mspeed(a6),d0
	ble.s	locret_207D72
	move.w	d0,mspeed(a6)

locret_207D72:
	rts

mspdtbl:
	dc.w	$1000
	dc.w	$C00
	dc.w	$C00
	dc.w	$800

shooterpositbl:
	dc.w	shooterposi_0-shooterpositbl
	dc.w	shooterposi_1-shooterpositbl
	dc.w	shooterposi_2-shooterpositbl
	dc.w	shooterposi_3-shooterpositbl
	dc.w	shooterposi_3-shooterpositbl
	dc.w	shooterposi_3-shooterpositbl
	dc.w	shooterposi_3-shooterpositbl
	dc.w	shooterposi_3-shooterpositbl
shooterposi_0:
	dc.w	$88
	dc.w	$1440
	dc.w	$F0
	dc.w	$1478
	dc.w	$108
	dc.w	$1490
	dc.w	$140
	dc.w	$1490
	dc.w	$1E0
	dc.w	$1440
	dc.w	$1F8
	dc.w	$1400
	dc.w	$1E0
	dc.w	$13F0
	dc.w	$1C0
	dc.w	$13F0
	dc.w	$180
	dc.w	$1400
	dc.w	$170
	dc.w	$1420
	dc.w	$168
	dc.w	$1440
	dc.w	$170
	dc.w	$1468
	dc.w	$1A8
	dc.w	$1660
	dc.w	$218
	dc.w	$16A0
	dc.w	$210
	dc.w	$16C0
	dc.w	$1F8
	dc.w	$16D0
	dc.w	$1C8
	dc.w	$16C0
	dc.w	$1A8
	dc.w	$1680
	dc.w	$198
	dc.w	$1658
	dc.w	$1A0
	dc.w	$1640
	dc.w	$1C8
	dc.w	$1650
	dc.w	$1F0
	dc.w	$1680
	dc.w	$200
	dc.w	$16C0
	dc.w	$200
	dc.w	$16D0
	dc.w	$210
	dc.w	$16D0
	dc.w	$288
	dc.w	$16C0
	dc.w	$2C0
	dc.w	$1680
	dc.w	$2D8
	dc.w	$1650
	dc.w	$2C0
	dc.w	$1650
	dc.w	$2A0
	dc.w	$1680
	dc.w	$290
	dc.w	$1700
	dc.w	$290
	dc.w	$1728
	dc.w	$2A0
	dc.w	$1728
	dc.w	$2E0
	dc.w	$1700
	dc.w	$2F0

shooterposi_1:
	dc.w	$44
	dc.w	$F08
	dc.w	$1A0
	dc.w	$F90
	dc.w	$1A0
	dc.w	$FC8
	dc.w	$1B8
	dc.w	$FE0
	dc.w	$1F0
	dc.w	$FE0
	dc.w	$260
	dc.w	$1000
	dc.w	$290
	dc.w	$1030
	dc.w	$2A0
	dc.w	$1068
	dc.w	$288
	dc.w	$1080
	dc.w	$250
	dc.w	$1068
	dc.w	$218
	dc.w	$1030
	dc.w	$200
	dc.w	$FF0
	dc.w	$220
	dc.w	$FE0
	dc.w	$260
	dc.w	$1000
	dc.w	$290
	dc.w	$1030
	dc.w	$2A0
	dc.w	$1068
	dc.w	$288
	dc.w	$1130
	dc.w	$1C8

shooterposi_2:
	dc.w	$44
	dc.w	$1630
	dc.w	$290
	dc.w	$1630
	dc.w	$318
	dc.w	$1638
	dc.w	$338
	dc.w	$16D0
	dc.w	$3D0
	dc.w	$1700
	dc.w	$3E0
	dc.w	$1738
	dc.w	$3C8
	dc.w	$1758
	dc.w	$390
	dc.w	$1738
	dc.w	$358
	dc.w	$16F8
	dc.w	$340
	dc.w	$16C0
	dc.w	$360
	dc.w	$16A8
	dc.w	$390
	dc.w	$16D0
	dc.w	$3D0
	dc.w	$1700
	dc.w	$3E0
	dc.w	$1738
	dc.w	$3C8
	dc.w	$17B8
	dc.w	$348
	dc.w	$17D0
	dc.w	$320
	dc.w	$17D0
	dc.w	$278

shooterposi_3: