actsetchk:
	moveq	#0,d0
	move.b	actset_rno.w,d0
	move.w	actset_tbl(pc,d0.w),d0
	jmp	actset_tbl(pc,d0.w)

actset_tbl:
	dc.w	actsetinit-actset_tbl
	dc.w	actset-actset_tbl

actsetinit:
	addq.b	#word,actset_rno.w
	lea	asettbl.l,a0
	movea.l	a0,a1
	adda.w	(a0),a0
	move.l	a0,asetadr.w
	move.l	a0,asetadr2.w
	adda.w	2(a1),a1
	move.l	a1,asetadrz.w
	move.l	a1,asetadrz2.w
	lea	flagwork,a2
	move.w	#$101,(a2)+
	move.w	#(flagwork_end-flagwork-2)/4-1,d0

loc_206DF2:
	clr.l	(a2)+
	dbf	d0,loc_206DF2

	lea	flagwork,a2
	moveq	#0,d2
	move.w	scra_h_posit.w,d6
	subi.w	#$80,d6
	bhs.s	loc_206E0C
	moveq	#0,d6

loc_206E0C:
	andi.w	#$FF80,d6
	movea.l	asetadr.w,a0

loc_206E14:
	cmp.w	(a0),d6
	bls.s	loc_206E26
	tst.b	4(a0)
	bpl.s	loc_206E22
	move.b	(a2),d2
	addq.b	#1,(a2)

loc_206E22:
	addq.w	#8,a0
	bra.s	loc_206E14

loc_206E26:
	move.l	a0,asetadr.w
	movea.l	asetadr2.w,a0
	subi.w	#$80,d6
	blo.s	loc_206E46

loc_206E34:
	cmp.w	(a0),d6
	bls.s	loc_206E46
	tst.b	4(a0)
	bpl.s	loc_206E42
	addq.b	#1,1(a2)

loc_206E42:
	addq.w	#8,a0
	bra.s	loc_206E34

loc_206E46:
	move.l	a0,asetadr2.w
	move.w	#-1,asetposi.w

actset:
	lea	flagwork,a2
	moveq	#0,d2
	move.w	scra_h_posit.w,d6
	andi.w	#$FF80,d6
	cmp.w	asetposi.w,d6
	beq.w	locret_206F0C
	bge.s	loc_206EC8
	move.w	d6,asetposi.w
	movea.l	asetadr2.w,a0
	subi.w	#$80,d6
	blo.s	loc_206EA4

loc_206E78:
	cmp.w	-8(a0),d6
	bge.s	loc_206EA4
	subq.w	#8,a0
	tst.b	4(a0)
	bpl.s	loc_206E8E
	subq.b	#1,1(a2)
	move.b	1(a2),d2

loc_206E8E:
	bsr.w	actnoset
	bne.s	loc_206E98
	subq.w	#8,a0
	bra.s	loc_206E78

loc_206E98:
	tst.b	4(a0)
	bpl.s	loc_206EA2
	addq.b	#1,1(a2)

loc_206EA2:
	addq.w	#8,a0

loc_206EA4:
	move.l	a0,asetadr2.w
	movea.l	asetadr.w,a0
	addi.w	#$300,d6

loc_206EB0:
	cmp.w	-8(a0),d6
	bgt.s	loc_206EC2
	tst.b	-4(a0)
	bpl.s	loc_206EBE
	subq.b	#1,(a2)

loc_206EBE:
	subq.w	#8,a0
	bra.s	loc_206EB0

loc_206EC2:
	move.l	a0,asetadr.w
	rts

loc_206EC8:
	move.w	d6,asetposi.w
	movea.l	asetadr.w,a0
	addi.w	#$280,d6

loc_206ED4:
	cmp.w	(a0),d6
	bls.s	loc_206EE8
	tst.b	4(a0)
	bpl.s	loc_206EE2
	move.b	(a2),d2
	addq.b	#1,(a2)

loc_206EE2:
	bsr.w	actnoset
	beq.s	loc_206ED4

loc_206EE8:
	move.l	a0,asetadr.w
	movea.l	asetadr2.w,a0
	subi.w	#$300,d6
	blo.s	loc_206F08

loc_206EF6:
	cmp.w	(a0),d6
	bls.s	loc_206F08
	tst.b	4(a0)
	bpl.s	loc_206F04
	addq.b	#1,1(a2)

loc_206F04:
	addq.w	#8,a0
	bra.s	loc_206EF6

loc_206F08:
	move.l	a0,asetadr2.w

locret_206F0C:
	rts

tm_setchk:
	moveq	#0,d0
	move.b	time_flag,d0
	move.w	d2,d3
	add.w	d3,d3
	add.w	d2,d3
	add.w	d0,d3
	move.b	6(a0),d1
	rol.b	#3,d1
	andi.b	#7,d1
	btst	d0,d1
	rts

actnoset:
	bsr.s	tm_setchk
	beq.s	loc_206F3E
	tst.b	4(a0)
	bpl.s	loc_206F44
	bset	#7,2(a2,d3.w)
	beq.s	loc_206F44

loc_206F3E:
	addq.w	#8,a0
	moveq	#0,d0
	rts

loc_206F44:
	bsr.w	actwkchk
	bne.s	locret_206F84
	move.w	(a0)+,xposi(a1)
	move.w	(a0)+,d0
	move.w	d0,d1
	andi.w	#$FFF,d0
	move.w	d0,yposi(a1)
	rol.w	#2,d1
	andi.b	#3,d1
	move.b	d1,actflg(a1)
	move.b	d1,cddat(a1)
	move.b	(a0)+,d0
	bpl.s	loc_206F74
	andi.b	#$7F,d0
	move.b	d2,cdsts(a1)

loc_206F74:
	_move.b	d0,actno(a1)
	move.b	(a0)+,userflag(a1)
	move.b	(a0)+,d0
	move.b	(a0)+,act29(a1)
	moveq	#0,d0

locret_206F84:
	rts

actwkchk:
	lea	byte_FFD800.w,a1
	move.w	#(byte_FFD800_end-byte_FFD800)/actfree-1,d0

loc_206F8E:
	tst.b	actno(a1)
	beq.s	locret_206F9A
	lea	actfree(a1),a1
	dbf	d0,loc_206F8E

locret_206F9A:
	rts

actwkchk2:
	movea.l	a0,a1
	move.w	#byte_FFD800_end&$FFFF,d0
	sub.w	a0,d0
	lsr.w	#6,d0
	subq.w	#1,d0
	blo.s	locret_206FB6

loc_206FAA:
	tst.b	actno(a1)
	beq.s	locret_206FB6
	lea	actfree(a1),a1
	dbf	d0,loc_206FAA

locret_206FB6:
	rts

frameout_s:
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bls.s	locret_206FFE
	moveq	#0,d0
	move.b	cdsts(a0),d0
	beq.s	loc_206FF8
	lea	flagwork,a1
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	bclr	#7,2(a1,d0.w)

loc_206FF8:
	jmp	frameout.l

locret_206FFE:
	rts

asettbl:
	dc.w	asettbl10-asettbl
	dc.w	asettbl10z-asettbl
	dc.w	$FFFF,0,0,0

asettbl10:
	incbin	"Actor Positions/ActPos.bin"
	even

asettbl10z:
	dc.w	$FFFF,0,0