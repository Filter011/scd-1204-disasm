hashi:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	hashi_move_tbl(pc,d0.w),d0
	jmp	hashi_move_tbl(pc,d0.w)

hashi_move_tbl:
	dc.w	hashi_init-hashi_move_tbl
	dc.w	sub_20BDC6-hashi_move_tbl
	dc.w	loc_20BE6A-hashi_move_tbl
	dc.w	loc_20BED8-hashi_move_tbl
	dc.w	loc_20C14C-hashi_move_tbl
	dc.w	loc_20C18C-hashi_move_tbl
	dc.w	loc_20C0FE-hashi_move_tbl
	dc.w	loc_20C2A2-hashi_move_tbl
	dc.w	loc_20C346-hashi_move_tbl
	dc.w	loc_20C3B0-hashi_move_tbl
	dc.w	loc_20C278-hashi_move_tbl
	dc.w	loc_20C212-hashi_move_tbl
	dc.w	loc_20C19E-hashi_move_tbl
	dc.w	loc_20C40A-hashi_move_tbl
	dc.w	locret_20C5FC-hashi_move_tbl
	dc.w	loc_20C5E8-hashi_move_tbl
	dc.w	loc_20C5D4-hashi_move_tbl

hashi_init:
	move.b	#$C,r_no0(a0)
	move.l	#hashipat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#9,d0
	jsr	pa_set(pc)
	move.b	#1,mstno(a0)
	move.b	#0,act30(a0)
	move.b	#0,act31(a0)
	moveq	#0,d7

loc_20BD0E:
	jsr	actwkchk.l
	bne.w	loc_20BDB6
	_move.b	#hashi_act,actno(a1)
	move.b	#2,r_no0(a1)
	move.w	a0,act3E(a1)
	move.b	d7,act3C(a1)
	addq.w	#1,d7
	cmpi.w	#8,d7
	bne.s	loc_20BD0E
	jsr	actwkchk.l
	bne.w	loc_20BDB6
	_move.b	#hashi_act,actno(a1)
	move.b	#4,r_no0(a1)
	move.w	a0,act3E(a1)
	move.b	#$FF,act3C(a1)
	move.b	#2,mstno(a1)
	move.l	xposi(a0),d0
	subi.l	#$100000,d0
	move.l	d0,xposi(a1)
	move.l	yposi(a0),d0
	subi.l	#$100000,d0
	move.l	d0,yposi(a1)
	bsr.w	actwkchk
	bne.w	loc_20BDB6
	_move.b	#hashi_act,actno(a1)
	move.b	#4,r_no0(a1)
	move.w	a0,act3E(a1)
	move.b	#$FE,act3C(a1)
	move.b	#2,mstno(a1)
	move.l	xposi(a0),d0
	addi.l	#$800000,d0
	move.l	d0,xposi(a1)
	move.l	yposi(a0),d0
	subi.l	#$100000,d0
	move.l	d0,yposi(a1)

loc_20BDB6:
	tst.b	userflag(a0)
	beq.w	locret_20BDC4
	move.b	#$1C,r_no0(a0)

locret_20BDC4:
	rts

sub_20BDC6:
	move.b	#6,r_no0(a0)
	move.l	#hashipat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#9,d0
	jsr	pa_set(pc)
	move.b	#1,mstno(a0)
	movea.w	act3E(a0),a2
	tst.b	userflag(a2)
	beq.w	loc_20BE04
	move.b	#$1A,r_no0(a0)

loc_20BE04:
	movea.w	act3E(a0),a1
	moveq	#0,d1
	move.b	act3C(a0),d1
	mulu.w	#$10,d1
	swap	d1
	move.l	xposi(a1),d0
	add.l	d1,d0
	move.l	d0,xposi(a0)
	move.l	yposi(a1),d0
	move.l	d0,yposi(a0)
	swap	d0
	move.w	d0,act38(a0)
	move.w	d0,act34(a0)
	moveq	#0,d1
	move.b	act3C(a0),d1
	mulu.w	#8,d1
	sub.w	d1,d0
	addi.w	#$60,d0
	move.w	d0,act36(a0)
	movea.w	act3E(a0),a2
	moveq	#0,d1
	move.w	xposi(a2),d0
	move.w	xposi(a0),d1
	move.w	#$58,d2
	sub.w	d0,d1
	sub.w	d2,d1
	muls.w	d1,d1
	mulu.w	#10,d1
	muls.w	d2,d2
	divu.w	d2,d1
	move.w	d1,act3A(a0)
	rts

loc_20BE6A:
	move.b	#8,r_no0(a0)
	move.l	#hashipat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#9,d0
	jsr	pa_set(pc)
	movea.w	act3E(a0),a2
	tst.b	userflag(a2)
	beq.w	loc_20BEC0
	move.b	#$1E,r_no0(a0)
	move.b	act3C(a0),d0
	cmpi.b	#$FE,d0
	beq.w	loc_20BEC0
	move.w	yposi(a0),d1
	addi.w	#$70,d1
	move.w	d1,yposi(a0)
	ori.w	#$800,sproffset(a0)

loc_20BEC0:
	move.w	yposi(a0),d0
	move.w	d0,act38(a0)
	move.w	d0,act34(a0)
	moveq	#0,d1
	addi.w	#$60,d0
	move.w	d0,act36(a0)
	rts

loc_20BED8:
	movea.w	act3E(a0),a2
	move.b	r_no0(a2),d0
	cmpi.b	#$18,d0
	bne.w	loc_20BEEE
	move.b	#$E,r_no0(a0)

loc_20BEEE:
	moveq	#$13,d0
	bsr.w	loc_20B6EC
	tst.b	d1
	beq.w	loc_20BF42
	moveq	#$B,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BF42
	movea.w	act3E(a0),a2
	move.b	act3C(a0),d0
	addq.w	#1,d0
	move.b	d0,act31(a2)
	lea	playerwk.w,a1
	bset	#cd_ride,cddat(a1)
	bset	#3,cddat(a0)
	bclr	#cd_walk,cddat(a1)
	move.l	yposi(a0),d0
	subi.l	#$80000,d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)

loc_20BF42:
	bsr.w	sub_20C042
	bsr.w	sub_20BFCE
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

	moveq	#0,d2
	movea.w	act3E(a0),a2
	move.b	act3D(a2),d2
	lea	unk_20BF8E.l,a3
	andi.w	#$3F,d2
	move.b	(a3,d2.w),d2
	move.w	act38(a0),d0
	move.w	act3A(a0),d1
	muls.w	d2,d1
	divs.w	#10,d1
	sub.w	d2,d1
	sub.w	d1,d0
	move.w	d0,yposi(a0)
	rts

unk_20BF8E:
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	4
	dc.b	5
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	7
	dc.b	7
	dc.b	8
	dc.b	8
	dc.b	7
	dc.b	7
	dc.b	6
	dc.b	6
	dc.b	5
	dc.b	5
	dc.b	4
	dc.b	4
	dc.b	3
	dc.b	3
	dc.b	2
	dc.b	2
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	5
	dc.b	6
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	$B
	dc.b	$C
	dc.b	$D
	dc.b	$E
	dc.b	$F
	dc.b	$10
	dc.b	$F
	dc.b	$E
	dc.b	$D
	dc.b	$C
	dc.b	$B
	dc.b	$A
	dc.b	9
	dc.b	8
	dc.b	7
	dc.b	6
	dc.b	5
	dc.b	4
	dc.b	3
	dc.b	2
	dc.b	1
	even

sub_20BFCE:
	lea	playerwk.w,a1
	lea	unk_20C04E.l,a3
	movea.w	act3E(a0),a2
	move.w	xposi(a2),d0
	subi.w	#$10,d0
	move.w	xposi(a1),d1
	sub.w	d0,d1
	move.b	act30(a2),d0
	bne.w	loc_20C014
	bra.w	loc_20C038

	move.w	xposi(a2),d0
	subi.w	#$10,d0
	move.w	xposi(a1),d1
	sub.w	d0,d1
	bpl.w	loc_20C00A
	moveq	#0,d1

loc_20C00A:
	cmpi.w	#$C0,d1
	bmi.w	loc_20C014
	moveq	#0,d1

loc_20C014:
	asr.w	#3,d1
	mulu.w	#8,d1
	lea	(a3,d1.w),a3
	moveq	#0,d0
	move.b	act3C(a0),d0
	moveq	#0,d2
	move.b	(a3,d0.w),d2
	asr.b	#1,d2
	move.w	act38(a0),d3
	add.w	d2,d3
	move.w	d3,yposi(a0)
	rts

loc_20C038:
	move.w	act38(a0),d3
	move.w	d3,yposi(a0)
	rts

sub_20C042:
	btst	#0,byte_FFF7DC.w
	beq.w	locret_20C04C

locret_20C04C:
	rts

unk_20C04E:
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	8
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	8
	dc.b	8
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	8
	dc.b	8
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	8
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	even

loc_20C0FE:
	move.b	act31(a0),act30(a0)
	move.b	#0,act31(a0)
	btst	#0,byte_FFF7DC.w
	beq.w	loc_20C11A
	move.b	#$18,r_no0(a0)

loc_20C11A:
	move.b	act3D(a0),d0
	addq.w	#1,d0
	move.b	d0,act3D(a0)
	lea	playerwk.w,a1
	move.w	xposi(a0),d0
	move.w	xposi(a1),d1
	move.w	d0,d2
	addi.w	#$80,d2
	subi.w	#$10,d0
	cmp.w	d0,d1
	bmi.w	locret_20C14A
	cmp.w	d2,d1
	bpl.w	locret_20C14A
	bra.w	locret_20C14A

locret_20C14A:
	rts

loc_20C14C:
	movea.w	act3E(a0),a2
	move.b	r_no0(a2),d0
	cmpi.b	#$18,d0
	bne.w	loc_20C162
	move.b	#$16,r_no0(a0)

loc_20C162:
	moveq	#$F,d0
	bsr.w	loc_20B6EC
	tst.b	d1
	beq.w	loc_20C178
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)

loc_20C178:
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20C18C:
	lea	obj26_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20C19E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	move.w	d0,act32(a0)
	cmpi.w	#$64,d0
	bne.w	loc_20C1B8
	nop
	move.b	#$12,r_no0(a0)

loc_20C1B8:
	move.b	act3D(a0),d0
	addq.w	#1,d0
	move.b	d0,act3D(a0)
	lea	playerwk.w,a1
	move.w	xposi(a0),d0
	move.w	xposi(a1),d1
	move.w	d0,d2
	addi.w	#$C0,d2
	subi.w	#$10,d0
	cmp.w	d0,d1
	bmi.w	loc_20C1FA
	cmp.w	d2,d1
	bpl.w	loc_20C1FA
	bset	#cd_ride,cddat(a1)
	bset	#3,cddat(a0)
	move.b	#0,direc(a1)
	bra.w	locret_20C210

loc_20C1FA:
	btst	#3,cddat(a0)
	beq.w	locret_20C14A
	bclr	#cd_ride,cddat(a1)
	bclr	#3,cddat(a0)

locret_20C210:
	rts

loc_20C212:
	movea.w	act3E(a0),a2
	move.b	r_no0(a2),d0
	cmpi.b	#$18,d0
	beq.w	loc_20C228
	move.b	#$14,r_no0(a0)

loc_20C228:
	move.b	act3C(a0),d0
	cmpi.b	#$FE,d0
	beq.w	loc_20C24E
	move.w	act32(a2),d0
	move.w	#$64,d1
	move.w	#$60,d2
	mulu.w	d2,d0
	divu.w	d1,d0
	move.w	act34(a0),d1
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20C24E:
	moveq	#$F,d0
	bsr.w	loc_20B6EC
	tst.b	d1
	beq.w	loc_20C264
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)

loc_20C264:
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20C278:
	moveq	#$F,d0
	bsr.w	loc_20B6EC
	tst.b	d1
	beq.w	loc_20C28E
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)

loc_20C28E:
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20C2A2:
	movea.w	act3E(a0),a2
	move.b	r_no0(a2),d0
	cmpi.b	#$18,d0
	beq.w	loc_20C2C2
	move.b	#$10,r_no0(a0)
	move.w	act36(a0),act38(a0)
	bra.w	loc_20C32E

loc_20C2C2:
	move.w	act36(a0),d2
	move.w	act34(a0),d3
	sub.w	d3,d2
	move.w	act32(a2),d0
	move.w	#$64,d1
	mulu.w	d2,d0
	divu.w	d1,d0
	move.w	act34(a0),d1
	add.w	d1,d0
	move.w	d0,yposi(a0)
	move.w	act32(a2),d1
	add.b	act3C(a0),d1
	andi.w	#1,d1
	add.w	d1,d0
	move.w	d0,yposi(a0)
	moveq	#$B,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20C32E
	lea	playerwk.w,a1
	bset	#cd_ride,cddat(a1)
	bset	#3,cddat(a0)
	bclr	#cd_walk,cddat(a1)
	move.l	yposi(a0),d0
	subi.l	#$80000,d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)

loc_20C32E:
	bsr.w	sub_20C042
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20C346:
	btst	#1,byte_FFF7DC.w
	beq.w	loc_20C35A
	move.b	act3C(a0),d0
	move.b	#$1A,r_no0(a0)

loc_20C35A:
	moveq	#$B,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20C394
	lea	playerwk.w,a1
	bset	#cd_ride,cddat(a1)
	bset	#3,cddat(a0)
	bclr	#cd_jump,cddat(a1)
	move.l	yposi(a0),d0
	subi.l	#$80000,d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)

loc_20C394:
	bsr.w	sub_20C042
	bsr.w	sub_20BFCE
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20C3B0:
	move.b	act3D(a0),d0
	addq.w	#1,d0
	move.b	d0,act3D(a0)
	lea	playerwk.w,a1
	move.w	xposi(a0),d0
	move.w	xposi(a1),d1
	move.w	d0,d2
	addi.w	#$C0,d2
	subi.w	#$10,d0
	cmp.w	d0,d1
	bmi.w	locret_20C14A
	cmp.w	d2,d1
	bpl.w	loc_20C3F2
	bset	#cd_ride,cddat(a1)
	bset	#3,cddat(a0)
	move.b	#0,direc(a1)
	bra.w	locret_20C408

loc_20C3F2:
	btst	#3,cddat(a0)
	beq.w	locret_20C14A
	bclr	#cd_ride,cddat(a1)
	bclr	#3,cddat(a0)

locret_20C408:
	rts

loc_20C40A:
	bsr.w	sub_20C45C
	moveq	#$B,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20C448
	lea	playerwk.w,a1
	bset	#cd_ride,cddat(a1)
	bset	#3,cddat(a0)
	bclr	#cd_jump,cddat(a1)
	move.l	yposi(a0),d0
	subi.l	#$80000,d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)

loc_20C448:
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_20C45C:
	move.b	act3C(a0),d0
	cmpi.b	#7,d0
	bpl.w	loc_20C4FC
	cmpi.b	#5,d0
	bpl.w	loc_20C582
	bra.w	loc_20C478

	dc.b	$12,$34,$56,$78

loc_20C478:
	movea.w	act3E(a0),a2
	lea	unk_20C5FE.l,a3
	move.w	act32(a0),d0
	moveq	#0,d1
	move.b	act3C(a0),d1
	move.w	#$E,d2
	asl.w	#1,d1
	lsr.w	#1,d0
	mulu.w	d0,d2
	add.w	d1,d2
	moveq	#0,d6
	moveq	#0,d3
	move.b	(a3,d2.w),d6
	move.b	1(a3,d2.w),d3
	ext.w	d3
	move.w	xposi(a2),d4
	move.w	yposi(a2),d5
	add.w	d6,d4
	add.w	d3,d5
	addi.w	#$60,d5
	move.w	d4,xposi(a0)
	move.w	d5,yposi(a0)
	move.w	act32(a0),d0
	addq.w	#1,d0
	move.w	d0,act32(a0)
	cmpi.w	#$26,d0
	bne.w	locret_20C4DA
	move.b	#$20,r_no0(a0)
	bsr.w	sub_20C4DC

locret_20C4DA:
	rts

sub_20C4DC:
	move.b	act3C(a0),d0
	move.w	yposi(a2),d1
	move.w	xposi(a2),d2
	mulu.w	#$10,d0
	add.w	d0,d1
	addi.w	#$60,d1
	move.w	d1,yposi(a0)
	move.w	d2,xposi(a0)
	rts

loc_20C4FC:
	movea.w	act3E(a0),a2
	lea	unk_20C708.l,a3
	move.w	act32(a0),d0
	moveq	#0,d1
	move.b	act3C(a0),d1
	move.w	#$E,d2
	subq.b	#6,d1
	asl.w	#1,d1
	lsr.w	#1,d0
	mulu.w	d0,d2
	add.w	d1,d2
	moveq	#0,d6
	moveq	#0,d3
	move.b	(a3,d2.w),d6
	move.b	1(a3,d2.w),d3
	move.w	xposi(a2),d4
	move.w	yposi(a2),d5
	sub.w	d6,d4
	add.w	d3,d5
	addi.w	#$B0,d4
	move.w	d4,xposi(a0)
	move.w	d5,yposi(a0)
	move.w	act32(a0),d0
	addq.w	#1,d0
	move.w	d0,act32(a0)
	cmpi.w	#$26,d0
	bne.w	locret_20C55E
	move.b	#$20,r_no0(a0)
	bsr.w	sub_20C560

locret_20C55E:
	rts

sub_20C560:
	move.b	act3C(a0),d0
	move.w	yposi(a2),d1
	move.w	xposi(a2),d2
	subq.w	#6,d0
	mulu.w	#$10,d0
	add.w	d0,d1
	addi.w	#$B0,d2
	move.w	d1,yposi(a0)
	move.w	d2,xposi(a0)
	rts

loc_20C582:
	movea.w	act3E(a0),a2
	move.w	act32(a0),d0
	mulu.w	#$C,d0
	move.w	yposi(a2),d1
	add.w	d0,d1
	addi.w	#$28,d1
	move.w	d1,yposi(a0)
	move.w	act32(a0),d0
	move.w	xposi(a0),d1
	move.b	act3C(a0),d2
	cmpi.b	#6,d2
	beq.w	loc_20C5B2
	neg.w	d0

loc_20C5B2:
	add.w	d0,d1
	move.w	d1,xposi(a0)
	move.w	act32(a0),d0
	addq.w	#1,d0
	move.w	d0,act32(a0)
	cmpi.w	#$26,d0
	bne.w	locret_20C5D2
	move.b	#$20,r_no0(a0)
	bsr.s	sub_20C560

locret_20C5D2:
	rts

loc_20C5D4:
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20C5E8:
	lea	off_20CED0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

locret_20C5FC:
	rts

unk_20C5FE:
	dc.b	0
	dc.b	0
	dc.b	$F
	dc.b	$F8
	dc.b	$1F
	dc.b	$F0
	dc.b	$2F
	dc.b	$E8
	dc.b	$3F
	dc.b	$E0
	dc.b	$4F
	dc.b	$D8
	dc.b	$5F
	dc.b	$D0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	$FC
	dc.b	$23
	dc.b	$F8
	dc.b	$34
	dc.b	$F5
	dc.b	$46
	dc.b	$F1
	dc.b	$57
	dc.b	$EE
	dc.b	$69
	dc.b	$EA
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	0
	dc.b	$23
	dc.b	$FF
	dc.b	$35
	dc.b	$FE
	dc.b	$47
	dc.b	$FD
	dc.b	$59
	dc.b	$FC
	dc.b	$6B
	dc.b	$FB
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	5
	dc.b	$22
	dc.b	$A
	dc.b	$33
	dc.b	$F
	dc.b	$44
	dc.b	$14
	dc.b	$55
	dc.b	$19
	dc.b	$66
	dc.b	$1E
	dc.b	0
	dc.b	0
	dc.b	$F
	dc.b	8
	dc.b	$1F
	dc.b	$11
	dc.b	$2E
	dc.b	$1A
	dc.b	$3E
	dc.b	$22
	dc.b	$4E
	dc.b	$2B
	dc.b	$5D
	dc.b	$34
	dc.b	0
	dc.b	0
	dc.b	$D
	dc.b	$B
	dc.b	$1B
	dc.b	$16
	dc.b	$29
	dc.b	$22
	dc.b	$37
	dc.b	$2D
	dc.b	$44
	dc.b	$39
	dc.b	$52
	dc.b	$44
	dc.b	0
	dc.b	0
	dc.b	$B
	dc.b	$D
	dc.b	$17
	dc.b	$1A
	dc.b	$23
	dc.b	$28
	dc.b	$2F
	dc.b	$35
	dc.b	$3B
	dc.b	$43
	dc.b	$46
	dc.b	$50
	dc.b	0
	dc.b	0
	dc.b	9
	dc.b	$E
	dc.b	$13
	dc.b	$1D
	dc.b	$1D
	dc.b	$2C
	dc.b	$27
	dc.b	$3B
	dc.b	$31
	dc.b	$4A
	dc.b	$3B
	dc.b	$59
	dc.b	0
	dc.b	0
	dc.b	8
	dc.b	$F
	dc.b	$10
	dc.b	$1F
	dc.b	$18
	dc.b	$2F
	dc.b	$21
	dc.b	$3F
	dc.b	$29
	dc.b	$4F
	dc.b	$31
	dc.b	$5F
	dc.b	0
	dc.b	0
	dc.b	6
	dc.b	$10
	dc.b	$D
	dc.b	$21
	dc.b	$14
	dc.b	$31
	dc.b	$1B
	dc.b	$42
	dc.b	$21
	dc.b	$52
	dc.b	$28
	dc.b	$63
	dc.b	0
	dc.b	0
	dc.b	5
	dc.b	$11
	dc.b	$B
	dc.b	$22
	dc.b	$10
	dc.b	$33
	dc.b	$16
	dc.b	$44
	dc.b	$1B
	dc.b	$55
	dc.b	$21
	dc.b	$66
	dc.b	0
	dc.b	0
	dc.b	4
	dc.b	$11
	dc.b	8
	dc.b	$22
	dc.b	$D
	dc.b	$33
	dc.b	$11
	dc.b	$45
	dc.b	$16
	dc.b	$56
	dc.b	$1A
	dc.b	$67
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$11
	dc.b	7
	dc.b	$23
	dc.b	$A
	dc.b	$34
	dc.b	$E
	dc.b	$46
	dc.b	$12
	dc.b	$57
	dc.b	$15
	dc.b	$69
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	$11
	dc.b	5
	dc.b	$23
	dc.b	8
	dc.b	$34
	dc.b	$B
	dc.b	$46
	dc.b	$E
	dc.b	$58
	dc.b	$11
	dc.b	$69
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	$11
	dc.b	4
	dc.b	$23
	dc.b	6
	dc.b	$35
	dc.b	8
	dc.b	$46
	dc.b	$B
	dc.b	$58
	dc.b	$D
	dc.b	$6A
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	$11
	dc.b	3
	dc.b	$23
	dc.b	5
	dc.b	$35
	dc.b	6
	dc.b	$47
	dc.b	8
	dc.b	$59
	dc.b	$A
	dc.b	$6A
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	$11
	dc.b	2
	dc.b	$23
	dc.b	3
	dc.b	$35
	dc.b	5
	dc.b	$47
	dc.b	6
	dc.b	$59
	dc.b	7
	dc.b	$6B
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	1
	dc.b	$23
	dc.b	2
	dc.b	$35
	dc.b	3
	dc.b	$47
	dc.b	4
	dc.b	$59
	dc.b	5
	dc.b	$6B
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	1
	dc.b	$23
	dc.b	1
	dc.b	$35
	dc.b	2
	dc.b	$47
	dc.b	3
	dc.b	$59
	dc.b	3
	dc.b	$6B
unk_20C708:
	dc.b	0
	dc.b	0
	dc.b	$F
	dc.b	7
	dc.b	$1F
	dc.b	$F
	dc.b	$2F
	dc.b	$17
	dc.b	$3F
	dc.b	$1F
	dc.b	$4F
	dc.b	$27
	dc.b	$5F
	dc.b	$2F
	dc.b	0
	dc.b	0
	dc.b	$E
	dc.b	9
	dc.b	$1D
	dc.b	$13
	dc.b	$2C
	dc.b	$1D
	dc.b	$3B
	dc.b	$27
	dc.b	$4A
	dc.b	$31
	dc.b	$59
	dc.b	$3B
	dc.b	0
	dc.b	0
	dc.b	$D
	dc.b	$B
	dc.b	$1B
	dc.b	$17
	dc.b	$28
	dc.b	$22
	dc.b	$36
	dc.b	$2E
	dc.b	$44
	dc.b	$3A
	dc.b	$51
	dc.b	$45
	dc.b	0
	dc.b	0
	dc.b	$C
	dc.b	$D
	dc.b	$18
	dc.b	$1A
	dc.b	$24
	dc.b	$27
	dc.b	$30
	dc.b	$34
	dc.b	$3C
	dc.b	$41
	dc.b	$49
	dc.b	$4E
	dc.b	0
	dc.b	0
	dc.b	$A
	dc.b	$E
	dc.b	$15
	dc.b	$1C
	dc.b	$20
	dc.b	$2B
	dc.b	$2A
	dc.b	$39
	dc.b	$35
	dc.b	$47
	dc.b	$40
	dc.b	$56
	dc.b	0
	dc.b	0
	dc.b	9
	dc.b	$F
	dc.b	$12
	dc.b	$1E
	dc.b	$1B
	dc.b	$2E
	dc.b	$24
	dc.b	$3D
	dc.b	$2D
	dc.b	$4C
	dc.b	$37
	dc.b	$5C
	dc.b	0
	dc.b	0
	dc.b	7
	dc.b	$10
	dc.b	$F
	dc.b	$20
	dc.b	$17
	dc.b	$30
	dc.b	$1F
	dc.b	$40
	dc.b	$26
	dc.b	$50
	dc.b	$2E
	dc.b	$60
	dc.b	0
	dc.b	0
	dc.b	6
	dc.b	$10
	dc.b	$C
	dc.b	$21
	dc.b	$13
	dc.b	$31
	dc.b	$19
	dc.b	$42
	dc.b	$20
	dc.b	$53
	dc.b	$26
	dc.b	$63
	dc.b	0
	dc.b	0
	dc.b	5
	dc.b	$11
	dc.b	$A
	dc.b	$22
	dc.b	$10
	dc.b	$33
	dc.b	$15
	dc.b	$44
	dc.b	$1A
	dc.b	$55
	dc.b	$20
	dc.b	$66
	dc.b	0
	dc.b	0
	dc.b	4
	dc.b	$11
	dc.b	8
	dc.b	$22
	dc.b	$D
	dc.b	$34
	dc.b	$11
	dc.b	$45
	dc.b	$15
	dc.b	$56
	dc.b	$1A
	dc.b	$68
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$11
	dc.b	6
	dc.b	$23
	dc.b	$A
	dc.b	$34
	dc.b	$D
	dc.b	$46
	dc.b	$11
	dc.b	$57
	dc.b	$14
	dc.b	$69
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	$11
	dc.b	5
	dc.b	$23
	dc.b	8
	dc.b	$35
	dc.b	$B
	dc.b	$46
	dc.b	$D
	dc.b	$58
	dc.b	$10
	dc.b	$6A
	dc.b	0
	dc.b	0
	dc.b	2
	dc.b	$11
	dc.b	4
	dc.b	$23
	dc.b	6
	dc.b	$35
	dc.b	8
	dc.b	$47
	dc.b	$A
	dc.b	$58
	dc.b	$C
	dc.b	$6A
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	$11
	dc.b	3
	dc.b	$23
	dc.b	4
	dc.b	$35
	dc.b	6
	dc.b	$47
	dc.b	8
	dc.b	$59
	dc.b	9
	dc.b	$6A
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	$11
	dc.b	2
	dc.b	$23
	dc.b	3
	dc.b	$35
	dc.b	4
	dc.b	$47
	dc.b	6
	dc.b	$59
	dc.b	7
	dc.b	$6B
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	1
	dc.b	$23
	dc.b	2
	dc.b	$35
	dc.b	3
	dc.b	$47
	dc.b	4
	dc.b	$59
	dc.b	5
	dc.b	$6B
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	1
	dc.b	$23
	dc.b	1
	dc.b	$35
	dc.b	2
	dc.b	$47
	dc.b	3
	dc.b	$59
	dc.b	3
	dc.b	$6B
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	0
	dc.b	$23
	dc.b	1
	dc.b	$35
	dc.b	1
	dc.b	$47
	dc.b	1
	dc.b	$59
	dc.b	2
	dc.b	$6B
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	$11
	dc.b	0
	dc.b	$23
	dc.b	0
	dc.b	$35
	dc.b	0
	dc.b	$47
	dc.b	1
	dc.b	$59
	dc.b	1
	dc.b	$6B
	even

obj26:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20C820(pc,d0.w),d0
	jmp	off_20C820(pc,d0.w)

off_20C820:
	dc.w	loc_20C824-off_20C820
	dc.w	loc_20C88A-off_20C820

loc_20C824:
	addq.b	#word,r_no0(a0)
	move.l	#act26pat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	moveq	#$A,d0
	jsr	pa_set(pc)
	move.b	userflag(a0),d0
	andi.b	#7,d0
	move.b	d0,mstno(a0)
	move.b	#$86,colino(a0)
	move.b	#$10,sprhsize(a0)
	move.b	#$C,sprvsize(a0)
	cmpi.b	#3,d0
	bne.w	loc_20C874
	move.b	#2,sprhsize(a0)
	move.b	#$C,sprvsize(a0)

loc_20C874:
	cmpi.b	#4,d0
	bmi.w	locret_20C888
	move.b	#$10,sprhsize(a0)
	move.b	#3,sprvsize(a0)

locret_20C888:
	rts

loc_20C88A:
	lea	playerwk.w,a1
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jsr	ride_on_chk.l
	lea	obj26_ani.l,a1
	jsr	patchg.l
	jsr	actionsub.l
	jmp	frameout_s.l