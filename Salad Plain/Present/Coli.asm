pcol:
	nop
	move.w	xposi(a0),d2
	move.w	yposi(a0),d3
	subq.w	#8,d2
	moveq	#0,d5
	move.b	sprvsize(a0),d5
	subq.b	#3,d5
	sub.w	d5,d3
	cmpi.b	#$39,patno(a0)
	bne.s	.jump0
	addi.w	#$C,d3
	moveq	#$A,d5

.jump0:
	move.w	#$10,d4
	add.w	d5,d5
	lea	byte_FFD800.w,a1
	move.w	#(byte_FFD800_end-byte_FFD800)/actfree-1,d6

.loop:
	tst.b	actflg(a1)
	bpl.s	.jump
	move.b	colino(a1),d0
	bne.s	.jump2

.jump:
	lea	actfree(a1),a1
	dbf	d6,.loop

	moveq	#0,d0
	rts

.colitbl:
	dc.b	20,20
	dc.b	12,20
	dc.b	20,12
	dc.b	4,16
	dc.b	12,18
	dc.b	16,16
	dc.b	6,6
	dc.b	24,12
	dc.b	12,16
	dc.b	16,12
	dc.b	8,8
	dc.b	20,16
	dc.b	20,8
	dc.b	14,14
	dc.b	24,24
	dc.b	40,16
	dc.b	16,24
	dc.b	8,16
	dc.b	32,112
	dc.b	64,32
	dc.b	128,32
	dc.b	32,32
	dc.b	8,8
	dc.b	4,4
	dc.b	32,8
	dc.b	12,12
	dc.b	8,4
	dc.b	24,4
	dc.b	40,4
	dc.b	4,8
	dc.b	4,24
	dc.b	4,40
	dc.b	4,32
	dc.b	24,24
	dc.b	12,24
	dc.b	72,8

.jump2:
	andi.w	#$3F,d0
	add.w	d0,d0
	lea	.colitbl-2(pc,d0.w),a2
	moveq	#0,d1
	move.b	(a2)+,d1
	move.w	xposi(a1),d0
	sub.w	d1,d0
	sub.w	d2,d0
	bhs.s	.jump3
	add.w	d1,d1
	add.w	d1,d0
	blo.s	.jump4
	bra.w	.jump

.jump3:
	cmp.w	d4,d0
	bhi.w	.jump

.jump4:
	moveq	#0,d1
	move.b	(a2)+,d1
	move.w	yposi(a1),d0
	sub.w	d1,d0
	sub.w	d3,d0
	bhs.s	.jump5
	add.w	d1,d1
	add.w	d0,d1
	blo.s	.atari
	bra.w	.jump

.jump5:
	cmp.w	d5,d0
	bhi.w	.jump

.atari:
	move.b	colino(a1),d1
	andi.b	#$C0,d1
	beq.w	pcolnomal
	cmpi.b	#$C0,d1
	beq.w	pcolspecial
	tst.b	d1
	bmi.w	pcolplay

pcolitem:
	move.b	colino(a1),d0
	andi.b	#$3F,d0
	cmpi.b	#6,d0
	beq.s	.item

.ring:
	cmpi.w	#90,invulnerabilitytimer(a0)
	bhs.w	.ringe
	addq.b	#2,r_no0(a1)

.ringe:
	rts

.item:
	tst.w	yspeed(a0)
	bpl.s	.item2
	move.w	yposi(a0),d0
	subi.w	#$10,d0
	cmp.w	yposi(a1),d0
	blo.s	.iteme
	neg.w	yspeed(a0)
	move.w	#-$180,yspeed(a1)
	tst.b	r_no1(a1)
	bne.s	.iteme
	addq.b	#4,r_no1(a1)
	rts

.item2:
	cmpi.b	#2,mstno(a0)
	bne.s	.iteme
	neg.w	yspeed(a0)
	addq.b	#2,r_no0(a1)

.iteme:
	rts

pcolnomal:
	tst.b	plpower_m
	bne.s	.jump
	cmpi.b	#2,mstno(a0)
	bne.w	pcolplay

.jump:
	tst.b	colicnt(a1)
	beq.s	.jump0
	neg.w	xspeed(a0)
	neg.w	yspeed(a0)
	asr.w	xspeed(a0)
	asr.w	yspeed(a0)
	move.b	#0,colino(a1)
	subq.b	#1,colicnt(a1)
	bne.s	.jump4
	bset	#7,cddat(a1)

.jump4:
	rts

.jump0:
	bset	#7,cddat(a1)
	moveq	#0,d0
	move.w	emyscorecnt.w,d0
	addq.w	#2,emyscorecnt.w
	cmpi.w	#6,d0
	blo.s	.jump5
	moveq	#6,d0

.jump5:
	move.w	d0,act3E(a1)
	move.w	escoretbl(pc,d0.w),d0
	cmpi.w	#$20,emyscorecnt.w
	blo.s	.jump6
	move.w	#1000,d0
	move.w	#$A,act3E(a1)

.jump6:
	bsr.w	scoreup
	move.w	#$9E,d0
	jsr	soundset.l
	_move.b	#bakuha_act,actno(a1)
	move.b	#0,r_no0(a1)

.jump3:
	tst.w	yspeed(a0)
	bmi.s	.jump1
	move.w	yposi(a0),d0
	cmp.w	yposi(a1),d0
	bhs.s	.jump2
	neg.w	yspeed(a0)
	rts

.jump1:
	addi.w	#$100,yspeed(a0)
	rts

.jump2:
	subi.w	#$100,yspeed(a0)
	rts

escoretbl:
	dc.w	10,20,50,100

pcolplay2:
	bset	#7,cddat(a1)

pcolplay:
	tst.b	plpower_m
	beq.s	pcole

pcolend:
	moveq	#-1,d0
	rts

pcole:
	nop
	tst.w	invulnerabilitytimer(a0)
	bne.s	pcolend
	movea.l	a1,a2

playdamageset:
	tst.b	plpower_b
	bne.s	.damage
	tst.w	plring
	beq.w	.die
	jsr	actwkchk.l
	bne.s	.worknai
	_move.b	#flyring_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)

.damage:
.worknai:
	move.b	#0,plpower_b
	move.b	#4,r_no0(a0)
	bsr.w	jumpcolsub
	bset	#cd_jump,cddat(a0)
	move.w	#-$400,yspeed(a0)
	move.w	#-$200,xspeed(a0)
	btst	#cd_underwater,cddat(a0)
	beq.s	.jump0
	move.w	#-$200,yspeed(a0)
	move.w	#-$100,xspeed(a0)

.jump0:
	move.w	xposi(a0),d0
	cmp.w	xposi(a2),d0
	blo.s	.jump
	neg.w	xspeed(a0)

.jump:
	move.w	#0,mspeed(a0)
	move.b	#$1A,mstno(a0)
	move.w	#120,invulnerabilitytimer(a0)
	moveq	#-1,d0
	rts

.die:
	tst.w	debugflag
	bne.w	.damage

playdieset:
	tst.w	editmode
	bne.s	.end
	tst.b	act29(a0)
	beq.w	frameout
	move.b	#0,plpower_m
	move.b	#6,r_no0(a0)
	bsr.w	jumpcolsub
	bset	#cd_walk,cddat(a0)
	move.w	#-$700,yspeed(a0)
	move.w	#0,xspeed(a0)
	move.w	#0,mspeed(a0)
	move.w	yposi(a0),act38(a0)
	move.b	#$18,mstno(a0)
	bset	#7,sproffset(a0)
	move.w	#$93,d0
	jsr	soundset.l

.end:
	moveq	#-1,d0
	rts

pcolspecial:
	move.b	colino(a1),d1
	andi.b	#$3F,d1
	cmpi.b	#$1F,d1
	beq.s	loc_206720
	cmpi.b	#$B,d1
	beq.s	.imo
	cmpi.b	#$C,d1
	beq.s	.yago
	cmpi.b	#$17,d1
	beq.s	loc_206720
	cmpi.b	#$21,d1
	beq.s	loc_206720
	rts

.imo:
	bra.w	pcolplay2

.yago:
	sub.w	d0,d5
	cmpi.w	#8,d5
	bhs.s	.yago4
	move.w	xposi(a1),d0
	subq.w	#4,d0
	btst	#cd_left,cddat(a1)
	beq.s	.yago1
	subi.w	#$10,d0

.yago1:
	sub.w	d2,d0
	bhs.s	.yago2
	addi.w	#$18,d0
	blo.s	.yago3
	bra.s	.yago4

.yago2:
	cmp.w	d4,d0
	bhi.s	.yago4

.yago3:
	bra.w	pcolplay

.yago4:
	bra.w	pcolnomal

loc_206720:
	addq.b	#1,colicnt(a1)
	cmpa.w	#playerwk,a0
	beq.s	locret_20672E
	addq.b	#1,colicnt(a1)

locret_20672E:
	rts