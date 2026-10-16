t_item:
	tst.b	ta_flag
	beq.s	loc_209096
	jmp	frameout.l

loc_209096:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	t_item_move_tbl(pc,d0.w),d0
	jsr	t_item_move_tbl(pc,d0.w)
	jsr	actionsub.l
	jmp	frameout_s.l

t_item_move_tbl:
	dc.w	t_item_init-t_item_move_tbl
	dc.w	t_item_move0-t_item_move_tbl
	dc.w	t_item_move1-t_item_move_tbl
	dc.w	t_item_move2-t_item_move_tbl

t_item_init:
	addq.b	#word,r_no0(a0)
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

t_item_move0:
	tst.b	colicnt(a0)
	beq.s	locret_209152
	move.b	#$3C,act2A(a0)
	addq.b	#word,r_no0(a0)
	bsr.w	flagwkadr
	bset	#0,2(a2,d0.w)
	move.b	#-1,time_item.w
	cmpi.b	#8,userflag(a0)
	beq.s	locret_209152
	move.b	#1,time_item.w

locret_209152:
	rts

t_item_move1:
	subq.b	#1,act2A(a0)
	beq.s	loc_209164
	lea	itemchg.l,a1
	bra.w	patchg

loc_209164:
	addq.b	#word,r_no0(a0)
	move.b	#$B,patno(a0)
	cmpi.b	#8,userflag(a0)
	beq.s	t_item_move2
	addq.b	#2,patno(a0)

t_item_move2:
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

ride_on_chk_i:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	move.b	#1,r_no1(a0)
	jmp	ride_on_chk.l

item:
	cmpi.b	#8,userflag(a0)
	bhs.w	t_item
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	item_move_tbl(pc,d0.w),d1
	jmp	item_move_tbl(pc,d1.w)

item_move_tbl:
	dc.w	iteminit-item_move_tbl
	dc.w	itemmove-item_move_tbl
	dc.w	itemget-item_move_tbl
	dc.w	itemmove2-item_move_tbl
	dc.w	itemmove3-item_move_tbl

iteminit:
	addq.b	#word,r_no0(a0)
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
	bsr.w	ride_on_chk_i
	lea	byte_FFD040.w,a1
	bsr.w	ride_on_chk_i

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
	bne.s	.worknai
	_move.b	#item2_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	mstno(a0),mstno(a1)

.worknai:
	bsr.w	actwkchk
	bne.s	.worknai1
	_move.b	#bakuha_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	#1,r_no1(a1)

.worknai1:
	bsr.w	flagwkadr
	bset	#0,2(a2,d0.w)
	move.b	#$11,patno(a0)
	bra.w	actionsub

item2:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	item2_move_tbl(pc,d0.w),d1
	jsr	item2_move_tbl(pc,d1.w)
	bra.w	actionsub

item2_move_tbl:
	dc.w	item2init-item2_move_tbl
	dc.w	item2move-item2_move_tbl
	dc.w	item2die-item2_move_tbl

item2init:
	addq.b	#word,r_no0(a0)
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
	bpl.w	item2move_sub
	bsr.w	speedset2
	addi.w	#$18,yspeed(a0)
	rts

item2move_sub:
	addq.b	#word,r_no0(a0)
	move.w	#29,pattim(a0)
	jsr	main_chk.l
	move.b	mstno(a0),d0
	bne.s	item2_01

item2_00:
	addq.b	#1,pl_suu
	addq.b	#1,pl_suu_f
	move.w	#bgm_suu,d0
	jmp	bgmset.l

item2_01:
	cmpi.b	#1,d0
	bne.s	item2_02
	addi.w	#10,plring
	ori.b	#1,plring_f
	cmpi.w	#100,plring
	blo.s	.jump
	bset	#1,plring_f2
	beq.w	item2_00
	cmpi.w	#200,plring
	blo.s	.jump
	bset	#2,plring_f2
	beq.w	item2_00

.jump:
	move.w	#$B5,d0
	jmp	bgmset.l

item2_02:
	cmpi.b	#2,d0
	bne.s	item2_03

sub_2093D8:
	move.b	#1,plpower_b
	move.b	#baria_act,bariawk.w
	move.w	#$AF,d0
	jmp	bgmset.l

item2_03:
	cmpi.b	#3,d0
	bne.s	item2_04

sub_2093F6:
	move.b	#1,plpower_m
	move.w	#1200,mutekitimer(a6)
	move.b	#baria_act,mutekiwk.w
	move.b	#1,mutekiwk+mstno.w
	move.b	#baria_act,muteki2wk.w
	move.b	#2,muteki2wk+mstno.w
	move.b	#baria_act,muteki3wk.w
	move.b	#3,muteki3wk+mstno.w
	move.b	#baria_act,muteki4wk.w
	move.b	#4,muteki4wk+mstno.w
	tst.b	bossstart.w
	bne.s	locret_20944E
	cmpi.w	#$C,pl_air
	bls.s	locret_20944E
	move.w	#bgm_muteki,d0
	jmp	bgmset.l

locret_20944E:
	rts

item2_04:
	cmpi.b	#4,d0
	bne.s	item2_05

loc_209456:
	move.b	#1,plpower_s
	move.w	#1200,speeduptimer(a6)
	move.w	#$C00,plmaxspdwk.w
	move.w	#$18,pladdspdwk.w
	move.w	#$80,plretspdwk.w
	move.w	#$E2,d0
	jmp	bgmset.l

item2_05:
	cmpi.b	#5,d0
	bne.s	item2_06
	move.w	#300,time_stop
	rts

item2_06:
	cmpi.b	#6,d0
	bne.s	item2_07
	nop

item2_07:
	bsr.w	sub_2093D8
	bsr.w	sub_2093F6
	bra.s	loc_209456

item2die:
	subq.w	#1,pattim(a0)
	bmi.w	frameout
	rts

itemchg:
	dc.w	itemchg0-itemchg
	dc.w	itemchg1-itemchg
	dc.w	itemchg2-itemchg
	dc.w	itemchg3-itemchg
	dc.w	itemchg4-itemchg
	dc.w	itemchg5-itemchg
	dc.w	itemchg6-itemchg
	dc.w	itemchg7-itemchg
	dc.w	itemchg8-itemchg
	dc.w	itemchg9-itemchg
itemchg0:
	dc.b	1
	dc.b	$10,0,0,8,0,0,9,0,0
	dc.b	$FF
	even
itemchg1:
	dc.b	1
	dc.b	$10,1,1,8,1,1,9,1,1
	dc.b	$FF
	even
itemchg2:
	dc.b	1
	dc.b	$10,2,2,8,2,2,9,2,2
	dc.b	$FF
	even
itemchg3:
	dc.b	1
	dc.b	$10,3,3,8,3,3,9,3,3
	dc.b	$FF
	even
itemchg4:
	dc.b	1
	dc.b	$10,4,4,8,4,4,9,4,4
	dc.b	$FF
	even
itemchg5:
	dc.b	1
	dc.b	$10,5,5,8,5,5,9,5,5
	dc.b	$FF
	even
itemchg6:
	dc.b	1
	dc.b	$10,6,6,8,6,6,9,6,6
	dc.b	$FF
	even
itemchg7:
	dc.b	1
	dc.b	$10,7,7,8,7,7,9,7,7
	dc.b	$FF
	even
itemchg8:
	dc.b	1
	dc.b	$A,$E,$F,$E,$B,$E,$F,$E
	dc.b	$FF
	even
itemchg9:
	dc.b	1
	dc.b	$C,$E,$F,$E,$D,$E,$F,$E
	dc.b	$FF
	even

itempat:
	dc.w	itemsp00-itempat
	dc.w	itemsp01-itempat
	dc.w	itemsp02-itempat
	dc.w	itemsp03-itempat
	dc.w	itemsp04-itempat
	dc.w	itemsp05-itempat
	dc.w	itemsp06-itempat
	dc.w	itemsp07-itempat
	dc.w	itemsp08-itempat
	dc.w	itemsp09-itempat
	dc.w	itemsp10-itempat
	dc.w	itemsp11-itempat
	dc.w	itemsp12-itempat
	dc.w	itemsp13-itempat
	dc.w	itemsp14-itempat
	dc.w	itemsp15-itempat
	dc.w	itemsp16-itempat
	dc.w	itemsp17-itempat
itemsp00:
	dc.b	4
	dc.b	$F6,5,0,$12,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp01:
	dc.b	4
	dc.b	$F6,5,0,$16,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp02:
	dc.b	4
	dc.b	$F6,5,0,$1A,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp03:
	dc.b	4
	dc.b	$F6,5,0,$1E,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp04:
	dc.b	4
	dc.b	$F6,5,0,$22,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp05:
	dc.b	4
	dc.b	$F6,5,0,$26,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp06:
	dc.b	4
	dc.b	$F6,5,0,$2A,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp07:
	dc.b	4
	dc.b	$F6,5,0,$2E,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp08:
	dc.b	4
	dc.b	$F6,5,0,$48,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp09:
	dc.b	4
	dc.b	$F6,5,8,$48,-8
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
	even
itemsp10:
	dc.b	5
	dc.b	$D8,$D,0,$32,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
itemsp11:
	dc.b	5
	dc.b	$D8,$D,8,$32,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
itemsp12:
	dc.b	5
	dc.b	$D8,$D,0,$3A,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
itemsp13:
	dc.b	5
	dc.b	$D8,$D,8,$3A,$F0
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
itemsp14:
	dc.b	5
	dc.b	$D8,5,0,$42,-8
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
itemsp15:
	dc.b	5
	dc.b	$D8,1,0,$46,$FC
	dc.b	$E8,3,0,$4C,-8
	dc.b	$E8,3,8,$4C,0
	dc.b	8,1,0,$50,-8
	dc.b	8,1,8,$50,0
itemsp16:
	dc.b	3
	dc.b	$F0,6,0,0,$F0
	dc.b	$F0,6,8,0,0
	dc.b	8,$C,0,6,$F0
itemsp17:
	dc.b	1
	dc.b	0,$D,0,$A,$F0