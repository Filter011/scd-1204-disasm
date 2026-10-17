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
	dc.b	0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,7,7,6,6,5,5,4,4,3,3,2,2,1,1
	dc.b	0,1,2,3,4,5,6,7,8,9,$A,$B,$C,$D,$E,$F,$10,$F,$E,$D,$C,$B,$A,9,8,7,6,5,4,3,2,1
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
	dc.b	0,0,$F,$F8,$1F,$F0,$2F,$E8,$3F,$E0,$4F,$D8,$5F,$D0
	dc.b	0,0,$11,$FC,$23,$F8,$34,$F5,$46,$F1,$57,$EE,$69,$EA
	dc.b	0,0,$11,0,$23,$FF,$35,$FE,$47,$FD,$59,$FC,$6B,$FB
	dc.b	0,0,$11,5,$22,$A,$33,$F,$44,$14,$55,$19,$66,$1E
	dc.b	0,0,$F,8,$1F,$11,$2E,$1A,$3E,$22,$4E,$2B,$5D,$34
	dc.b	0,0,$D,$B,$1B,$16,$29,$22,$37,$2D,$44,$39,$52,$44
	dc.b	0,0,$B,$D,$17,$1A,$23,$28,$2F,$35,$3B,$43,$46,$50
	dc.b	0,0,9,$E,$13,$1D,$1D,$2C,$27,$3B,$31,$4A,$3B,$59
	dc.b	0,0,8,$F,$10,$1F,$18,$2F,$21,$3F,$29,$4F,$31,$5F
	dc.b	0,0,6,$10,$D,$21,$14,$31,$1B,$42,$21,$52,$28,$63
	dc.b	0,0,5,$11,$B,$22,$10,$33,$16,$44,$1B,$55,$21,$66
	dc.b	0,0,4,$11,8,$22,$D,$33,$11,$45,$16,$56,$1A,$67
	dc.b	0,0,3,$11,7,$23,$A,$34,$E,$46,$12,$57,$15,$69
	dc.b	0,0,2,$11,5,$23,8,$34,$B,$46,$E,$58,$11,$69
	dc.b	0,0,2,$11,4,$23,6,$35,8,$46,$B,$58,$D,$6A
	dc.b	0,0,1,$11,3,$23,5,$35,6,$47,8,$59,$A,$6A
	dc.b	0,0,1,$11,2,$23,3,$35,5,$47,6,$59,7,$6B
	dc.b	0,0,0,$11,1,$23,2,$35,3,$47,4,$59,5,$6B
	dc.b	0,0,0,$11,1,$23,1,$35,2,$47,3,$59,3,$6B
unk_20C708:
	dc.b	0,0,$F,7,$1F,$F,$2F,$17,$3F,$1F,$4F,$27,$5F,$2F
	dc.b	0,0,$E,9,$1D,$13,$2C,$1D,$3B,$27,$4A,$31,$59,$3B
	dc.b	0,0,$D,$B,$1B,$17,$28,$22,$36,$2E,$44,$3A,$51,$45
	dc.b	0,0,$C,$D,$18,$1A,$24,$27,$30,$34,$3C,$41,$49,$4E
	dc.b	0,0,$A,$E,$15,$1C,$20,$2B,$2A,$39,$35,$47,$40,$56
	dc.b	0,0,9,$F,$12,$1E,$1B,$2E,$24,$3D,$2D,$4C,$37,$5C
	dc.b	0,0,7,$10,$F,$20,$17,$30,$1F,$40,$26,$50,$2E,$60
	dc.b	0,0,6,$10,$C,$21,$13,$31,$19,$42,$20,$53,$26,$63
	dc.b	0,0,5,$11,$A,$22,$10,$33,$15,$44,$1A,$55,$20,$66
	dc.b	0,0,4,$11,8,$22,$D,$34,$11,$45,$15,$56,$1A,$68
	dc.b	0,0,3,$11,6,$23,$A,$34,$D,$46,$11,$57,$14,$69
	dc.b	0,0,2,$11,5,$23,8,$35,$B,$46,$D,$58,$10,$6A
	dc.b	0,0,2,$11,4,$23,6,$35,8,$47,$A,$58,$C,$6A
	dc.b	0,0,1,$11,3,$23,4,$35,6,$47,8,$59,9,$6A
	dc.b	0,0,1,$11,2,$23,3,$35,4,$47,6,$59,7,$6B
	dc.b	0,0,0,$11,1,$23,2,$35,3,$47,4,$59,5,$6B
	dc.b	0,0,0,$11,1,$23,1,$35,2,$47,3,$59,3,$6B
	dc.b	0,0,0,$11,0,$23,1,$35,1,$47,1,$59,2,$6B
	dc.b	0,0,0,$11,0,$23,0,$35,0,$47,1,$59,1,$6B
	even