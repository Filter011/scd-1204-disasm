	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20E712(pc,d0.w),d0
	jmp	off_20E712(pc,d0.w)

off_20E712:
	dc.w	loc_20E71A-off_20E712
	dc.w	loc_20E7FA-off_20E712
	dc.w	loc_20E9E6-off_20E712
	dc.w	loc_20EA50-off_20E712

loc_20E71A:
	addq.b	#word,r_no0(a0)
	move.l	#off_20EE4C,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$3FE,sproffset(a0)
	move.b	act3D(a0),d0
	bne.s	loc_20E77C
	move.b	userflag(a0),d6
	andi.w	#$F,d6
	jsr	sub_20E78A(pc)
	move.b	act3D(a1),d0
	ori.b	#$80,d0
	move.b	d0,act3D(a1)
	movea.w	a2,a4
	subq.w	#1,d6

loc_20E760:
	jsr	sub_20E78A(pc)
	subq.w	#1,d6
	bne.s	loc_20E760
	move.b	userflag(a0),d0
	andi.b	#$70,d0
	cmpi.b	#$70,d0
	bne.s	locret_20E77A
	jsr	sub_20E7B4(pc)

locret_20E77A:
	rts

loc_20E77C:
	move.b	act3D(a0),d0
	bpl.s	locret_20E788
	move.b	#4,r_no0(a0)

locret_20E788:
	rts

sub_20E78A:
	jsr	$208E64.l
	bne.s	locret_20E7B2
	move.b	userflag(a0),userflag(a1)
	_move.b	#$29,actno(a1)
	move.w	a0,act3E(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	d6,act3D(a1)

locret_20E7B2:
	rts

sub_20E7B4:
	jsr	$208E64.l
	bne.s	locret_20E7B2
	_move.b	#$13,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.w	a4,act3E(a1)
	move.b	#1,act3D(a1)
	rts

unk_20E7DA:
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

loc_20E7FA:
	moveq	#0,d0
	move.b	act3D(a0),d0
	lea	unk_20E7DA.l,a3
	move.b	(a3,d0.w),d2
	move.b	d2,mstno(a0)
	tst.b	d0
	beq.s	loc_20E828
	jsr	sub_20E98E(pc)
	lea	off_20EE32.l,a1
	jsr	$20739E.l
	jmp	$20517A.l

loc_20E828:
	moveq	#0,d0
	move.b	userflag(a0),d0
	andi.w	#$F0,d0
	asr.w	#2,d0
	lea	off_20E854.l,a3
	movea.l	(a3,d0.w),a4
	jsr	(a4)
	lea	off_20EE32.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

off_20E854:
	dc.l	loc_20E874
	dc.l	loc_20E880
	dc.l	loc_20E88C
	dc.l	loc_20E8BC
	dc.l	loc_20E8EC
	dc.l	loc_20E922
	dc.l	loc_20E958
	dc.l	loc_20E880

loc_20E874:
	move.b	act3C(a0),d0
	addq.w	#1,d0
	move.b	d0,act3C(a0)
	rts

loc_20E880:
	move.b	act3C(a0),d0
	subq.w	#1,d0
	move.b	d0,act3C(a0)
	rts

loc_20E88C:
	move.w	act32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,act32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20E8A6
	bmi.w	loc_20E8B0

loc_20E8A6:
	addi.w	#$40,d0
	move.b	d0,act3C(a0)
	rts

loc_20E8B0:
	not.w	d0
	addi.w	#$40,d0
	move.b	d0,act3C(a0)
	rts

loc_20E8BC:
	move.w	act32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,act32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20E8D6
	bmi.w	loc_20E8E0

loc_20E8D6:
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20E8E0:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20E8EC:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$300,d0
	bmi.w	loc_20E8FC
	moveq	#0,d0

loc_20E8FC:
	move.w	d0,act32(a0)
	cmpi.w	#$180,d0
	bpl.w	loc_20E90C
	bmi.w	loc_20E916

loc_20E90C:
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20E916:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20E922:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$200,d0
	bmi.w	loc_20E932
	moveq	#0,d0

loc_20E932:
	move.w	d0,act32(a0)
	cmpi.w	#$100,d0
	bpl.w	loc_20E942
	bmi.w	loc_20E94C

loc_20E942:
	addi.w	#$80,d0
	move.b	d0,act3C(a0)
	rts

loc_20E94C:
	addi.w	#$80,d0
	not.w	d0
	move.b	d0,act3C(a0)
	rts

loc_20E958:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$80,d0
	bmi.w	loc_20E968
	moveq	#0,d0

loc_20E968:
	move.w	d0,act32(a0)
	cmpi.w	#$40,d0
	bpl.w	loc_20E978
	bmi.w	loc_20E982

loc_20E978:
	addi.w	#$A0,d0
	move.b	d0,act3C(a0)
	rts

loc_20E982:
	addi.w	#$E0,d0
	not.w	d0
	move.b	d0,act3C(a0)
	rts

sub_20E98E:
	move.l	xposi(a0),act38(a0)
	move.l	yposi(a0),act34(a0)
	movea.w	act3E(a0),a2
	moveq	#0,d0
	move.b	act3C(a2),d0
	jsr	$2006A2.l
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

loc_20E9E6:
	move.b	#3,mstno(a0)
	bsr.s	sub_20E98E
	move.b	#$18,sprhsize(a0)
	move.b	#8,sprvsize(a0)
	move.b	#8,sprvsize(a0)
	lea	playerwk.w,a1
	bsr.w	$20D4D4
	beq.w	loc_20EA3C
	bsr.w	sub_20EA9A
	bne.w	loc_20EA3C
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

loc_20EA3C:
	lea	off_20EE32.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

loc_20EA50:
	move.b	#3,mstno(a0)
	bsr.w	sub_20E98E
	lea	playerwk.w,a1
	moveq	#$10,d0
	bsr.w	$20D4D4
	tst.b	d1
	beq.w	loc_20EA8C
	move.l	xposi(a0),d0
	sub.l	act38(a0),d0
	add.l	xposi(a1),d0
	move.l	d0,xposi(a1)
	move.l	yposi(a0),d0
	sub.l	act34(a0),d0
	add.l	yposi(a1),d0
	move.l	d0,yposi(a1)
	bra.s	loc_20EA3C

loc_20EA8C:
	bclr	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	bra.s	loc_20EA3C

sub_20EA9A:
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
	bpl.w	loc_20EAC0
	bmi.w	loc_20EAC4

loc_20EAC0:
	moveq	#-1,d1
	rts

loc_20EAC4:
	moveq	#0,d1
	rts