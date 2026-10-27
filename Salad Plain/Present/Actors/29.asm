obj29:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20C8C2(pc,d0.w),d0
	jmp	off_20C8C2(pc,d0.w)

off_20C8C2:
	dc.w	loc_20C8CA-off_20C8C2
	dc.w	loc_20C9AC-off_20C8C2
	dc.w	loc_20CB98-off_20C8C2
	dc.w	loc_20CC02-off_20C8C2

loc_20C8CA:
	addq.b	#word,r_no0(a0)
	move.l	#obj29_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#16,sprhsize(a0)
	moveq	#17,d0
	jsr	pa_set.l
	move.b	act3D(a0),d0
	bne.s	loc_20C92E
	move.b	userflag(a0),d6
	andi.w	#%1111,d6
	jsr	sub_20C93C(pc)
	move.b	act3D(a1),d0
	ori.b	#%10000000,d0
	move.b	d0,act3D(a1)
	movea.w	a2,a4
	subq.w	#1,d6

loc_20C912:
	jsr	sub_20C93C(pc)
	subq.w	#1,d6
	bne.s	loc_20C912
	move.b	userflag(a0),d0
	andi.b	#%01110000,d0
	cmpi.b	#%01110000,d0
	bne.s	locret_20C92C
	jsr	sub_20C966(pc)

locret_20C92C:
	rts

loc_20C92E:
	move.b	act3D(a0),d0
	bpl.s	locret_20C93A
	move.b	#4,r_no0(a0)

locret_20C93A:
	rts

sub_20C93C:
	jsr	actwkchk.l
	bne.s	locret_20C964
	move.b	userflag(a0),userflag(a1)
	_move.b	#objid_29,actno(a1)
	move.w	a0,act3E(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	d6,act3D(a1)

locret_20C964:
	rts

sub_20C966:
	jsr	actwkchk.l
	bne.s	locret_20C964
	_move.b	#marker_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.w	a4,act3E(a1)
	move.b	#1,act3D(a1)
	rts

unk_20C98C:
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	even

loc_20C9AC:
	moveq	#0,d0
	move.b	act3D(a0),d0
	lea	unk_20C98C.l,a3
	move.b	(a3,d0.w),d2
	move.b	d2,mstno(a0)
	tst.b	d0
	beq.s	loc_20C9DA
	jsr	sub_20CB40(pc)
	lea	obj29_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20C9DA:
	moveq	#0,d0
	move.b	userflag(a0),d0
	andi.w	#$F0,d0
	asr.w	#2,d0
	lea	off_20CA06.l,a3
	movea.l	(a3,d0.w),a4
	jsr	(a4)
	lea	obj29_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

off_20CA06:
	dc.l	loc_20CA26
	dc.l	loc_20CA32
	dc.l	loc_20CA3E
	dc.l	loc_20CA6E
	dc.l	loc_20CA9E
	dc.l	loc_20CAD4
	dc.l	loc_20CB0A
	dc.l	loc_20CA32

loc_20CA26:
	move.b	act3C(a0),d0
	addq.w	#1,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA32:
	move.b	act3C(a0),d0
	subq.w	#1,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA3E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,act32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20CA58
	bmi.w	loc_20CA62

loc_20CA58:
	addi.w	#$40,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA62:
	not.w	d0
	addi.w	#$40,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA6E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,act32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20CA88
	bmi.w	loc_20CA92

loc_20CA88:
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA92:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA9E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$300,d0
	bmi.w	loc_20CAAE
	moveq	#0,d0

loc_20CAAE:
	move.w	d0,act32(a0)
	cmpi.w	#$180,d0
	bpl.w	loc_20CABE
	bmi.w	loc_20CAC8

loc_20CABE:
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CAC8:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CAD4:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$200,d0
	bmi.w	loc_20CAE4
	moveq	#0,d0

loc_20CAE4:
	move.w	d0,act32(a0)
	cmpi.w	#$100,d0
	bpl.w	loc_20CAF4
	bmi.w	loc_20CAFE

loc_20CAF4:
	addi.w	#$80,d0
	move.b	d0,act3C(a0)
	rts

loc_20CAFE:
	addi.w	#$80,d0
	not.w	d0
	move.b	d0,act3C(a0)
	rts

loc_20CB0A:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$80,d0
	bmi.w	loc_20CB1A
	moveq	#0,d0

loc_20CB1A:
	move.w	d0,act32(a0)
	cmpi.w	#$40,d0
	bpl.w	loc_20CB2A
	bmi.w	loc_20CB34

loc_20CB2A:
	addi.w	#$A0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CB34:
	addi.w	#$E0,d0
	not.w	d0
	move.b	d0,act3C(a0)
	rts

sub_20CB40:
	move.l	xposi(a0),act38(a0)
	move.l	yposi(a0),act34(a0)
	movea.w	act3E(a0),a2
	moveq	#0,d0
	move.b	act3C(a2),d0
	jsr	sinset.l
	moveq	#0,d3
	move.b	act3D(a0),d3
	andi.w	#$F,d3
	mulu.w	#$100,d3
	muls.w	d3,d0
	asl.l	#4,d0
	move.l	d0,d4
	move.l	xposi(a2),d2
	add.l	d0,d2
	move.l	d2,xposi(a0)
	muls.w	d3,d1
	asl.l	#4,d1
	move.l	d1,d5
	move.l	yposi(a2),d2
	add.l	d1,d2
	move.l	d2,yposi(a0)
	asr.l	#8,d4
	asr.l	#8,d5
	move.w	d4,xspeed(a2)
	move.w	d5,yspeed(a2)
	rts

loc_20CB98:
	move.b	#3,mstno(a0)
	bsr.s	sub_20CB40
	move.b	#$18,sprhsize(a0)
	move.b	#8,sprvsize(a0)
	move.b	#8,sprvsize(a0)
	lea	playerwk.w,a1
	bsr.w	sub_20B684
	beq.w	loc_20CBEE
	bsr.w	sub_20CC4C
	bne.w	loc_20CBEE
	move.w	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	sub.w	d1,d0
	move.b	sprvsize(a0),d1
	sub.w	d1,d0
	move.w	d0,yposi(a1)
	bset	#cd_ride,cddat(a1)
	bclr	#cd_jump,cddat(a1)
	move.b	#6,r_no0(a0)

loc_20CBEE:
	lea	obj29_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20CC02:
	move.b	#3,mstno(a0)
	bsr.w	sub_20CB40
	lea	playerwk.w,a1
	moveq	#$10,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20CC3E
	move.l	xposi(a0),d0
	sub.l	act38(a0),d0
	add.l	xposi(a1),d0
	move.l	d0,xposi(a1)
	move.l	yposi(a0),d0
	sub.l	act34(a0),d0
	add.l	yposi(a1),d0
	move.l	d0,yposi(a1)
	bra.s	loc_20CBEE

loc_20CC3E:
	bclr	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	bra.s	loc_20CBEE

sub_20CC4C:
	lea	playerwk.w,a1
	moveq	#0,d2
	moveq	#0,d3
	move.b	sprvsize(a0),d2
	move.b	sprvsize(a1),d3
	move.w	yposi(a0),d0
	move.w	yposi(a1),d1
	add.w	d2,d0
	add.w	d3,d1
	cmp.w	d0,d1
	bpl.w	loc_20CC72
	bmi.w	loc_20CC76

loc_20CC72:
	moveq	#-1,d1
	rts

loc_20CC76:
	moveq	#0,d1
	rts