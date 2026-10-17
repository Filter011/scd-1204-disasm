action:
	lea	actwk.w,a0
	moveq	#(actwk_end-actwk)/actfree-1,d7
	moveq	#0,d0

action0:
	move.b	actno(a0),d0
	beq.s	.jump
	add.w	d0,d0
	add.w	d0,d0
	lea	act_tbl.l,a1
	movea.l	-4(a1,d0.w),a1
	jsr	(a1)
	moveq	#0,d0

.jump:
	lea	actfree(a0),a0
	dbf	d7,action0
	rts

	moveq	#(byte_FFD800-actwk)/actfree-1,d7
	bsr.s	action0
	moveq	#(byte_FFD800_end-byte_FFD800)/actfree-1,d7

loc_203120:
	moveq	#0,d0
	move.b	actno(a0),d0
	beq.s	.jump
	tst.b	actflg(a0)
	bpl.s	.jump
	bsr.w	actionsub

.jump:
	lea	actfree(a0),a0
	dbf	d7,loc_203120
	rts

speedset:
	move.l	xposi(a0),d2
	move.l	yposi(a0),d3
	move.w	xspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d2
	move.w	yspeed(a0),d0
	addi.w	#$38,yspeed(a0)
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d3
	move.l	d2,xposi(a0)
	move.l	d3,yposi(a0)
	rts

speedset2:
	move.l	xposi(a0),d2
	move.l	yposi(a0),d3
	move.w	xspeed(a0),d0
	btst	#3,cddat(a0)
	beq.s	loc_2031A2
	moveq	#0,d1
	move.b	act3D(a0),d1
	lsl.w	#6,d1
	addi.l	#actwk&$FFFFFF,d1
	movea.l	d1,a1
	_cmpi.b	#objid_1E,actno(a1)
	bne.s	loc_2031A2
	move.w	#-$100,d1
	btst	#0,cddat(a1)
	beq.s	loc_2031A0
	neg.w	d1

loc_2031A0:
	add.w	d1,d0

loc_2031A2:
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d2
	move.w	yspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d3
	move.l	d2,xposi(a0)
	move.l	d3,yposi(a0)
	rts

actionsub:
	bclr	#7,actflg(a0)
	move.b	actflg(a0),d0
	andi.w	#%1100,d0
	beq.s	loc_203204
	move.b	sprhsize(a0),d0
	move.w	xposi(a0),d3
	sub.w	scra_h_posit.w,d3
	move.w	d3,d1
	add.w	d0,d1
	bmi.s	locret_203220
	move.w	d3,d1
	sub.w	d0,d1
	cmpi.w	#320,d1
	bge.s	locret_203220
	move.b	sprvsize(a0),d0
	move.w	yposi(a0),d3
	sub.w	scra_v_posit.w,d3
	move.w	d3,d1
	add.w	d0,d1
	bmi.s	locret_203220
	move.w	d3,d1
	sub.w	d0,d1
	cmpi.w	#224,d1
	bge.s	locret_203220

loc_203204:
	lea	pbuffer.w,a1
	move.w	sprpri(a0),d0
	lsr.w	#1,d0
	andi.w	#$380,d0
	adda.w	d0,a1
	cmpi.w	#$7E,(a1)
	bhs.s	locret_203220
	addq.w	#2,(a1)
	adda.w	(a1),a1
	move.w	a0,(a1)

locret_203220:
	rts

	lea	pbuffer.w,a2
	move.w	sprpri(a1),d0
	lsr.w	#1,d0
	andi.w	#$380,d0
	adda.w	d0,a2
	cmpi.w	#$7E,(a2)
	bhs.s	locret_20323E
	addq.w	#2,(a2)
	adda.w	(a2),a2
	move.w	a1,(a2)

locret_20323E:
	rts

frameout:
	movea.l	a0,a1
	moveq	#0,d1
	moveq	#actfree/4-1,d0

.loop:
	move.l	d1,(a1)+
	dbf	d0,.loop
	rts

patsettbl:
	dc.l	0
	dc.l	scra_h_posit&$FFFFFF
	dc.l	scrb_h_posit&$FFFFFF
	dc.l	scrz_h_posit&$FFFFFF

patset:
	lea	sprdat.w,a2
	moveq	#0,d5
	lea	pbuffer.w,a4
	moveq	#8-1,d7

loc_20326A:
	tst.w	(a4)
	beq.w	loc_203302
	moveq	#2,d6

loc_203272:
	movea.w	(a4,d6.w),a0
	tst.b	actno(a0)
	beq.w	loc_2032FA
	move.b	actflg(a0),d0
	move.b	d0,d4
	andi.w	#%1100,d0
	beq.s	loc_2032B0
	movea.l	patsettbl(pc,d0.w),a1
	moveq	#0,d0
	move.b	sprhsize(a0),d0
	move.w	xposi(a0),d3
	sub.w	(a1),d3
	addi.w	#128,d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	move.w	yposi(a0),d2
	sub.w	4(a1),d2
	addi.w	#128,d2
	bra.s	loc_2032D2

loc_2032B0:
	move.w	$A(a0),d2
	move.w	xposi(a0),d3
	bra.s	loc_2032D2

	move.w	yposi(a0),d2
	sub.w	4(a1),d2
	addi.w	#128,d2
	cmpi.w	#$60,d2
	blo.s	loc_2032FA
	cmpi.w	#$180,d2
	bhs.s	loc_2032FA

loc_2032D2:
	movea.l	patbase(a0),a1
	moveq	#0,d1
	btst	#5,d4
	bne.s	loc_2032F0
	move.b	patno(a0),d1
	add.w	d1,d1
	adda.w	(a1,d1.w),a1
	moveq	#0,d1
	move.b	(a1)+,d1
	subq.b	#1,d1
	bmi.s	loc_2032F4

loc_2032F0:
	bsr.w	spatset

loc_2032F4:
	bset	#7,actflg(a0)

loc_2032FA:
	addq.w	#2,d6
	subq.w	#2,(a4)
	bne.w	loc_203272

loc_203302:
	lea	$80(a4),a4
	dbf	d7,loc_20326A

	move.b	d5,linkdata.w
	cmpi.b	#80,d5
	beq.s	loc_20331C
	move.l	#0,(a2)
	rts

loc_20331C:
	move.b	#0,-5(a2)
	rts

spatset:
	movea.w	sproffset(a0),a3
	btst	#0,d4
	bne.s	loc_20336A
	btst	#1,d4
	bne.w	loc_2033B8

loc_203336:
	cmpi.b	#80,d5
	beq.s	locret_203368
	move.b	(a1)+,d0
	ext.w	d0
	add.w	d2,d0
	move.w	d0,(a2)+
	move.b	(a1)+,(a2)+
	addq.b	#1,d5
	move.b	d5,(a2)+
	move.b	(a1)+,d0
	lsl.w	#8,d0
	move.b	(a1)+,d0
	add.w	a3,d0
	move.w	d0,(a2)+
	move.b	(a1)+,d0
	ext.w	d0
	add.w	d3,d0
	andi.w	#$1FF,d0
	bne.s	loc_203362
	addq.w	#1,d0

loc_203362:
	move.w	d0,(a2)+
	dbf	d1,loc_203336

locret_203368:
	rts

loc_20336A:
	btst	#1,d4
	bne.w	loc_2033FE

loc_203372:
	cmpi.b	#80,d5
	beq.s	locret_2033B6
	move.b	(a1)+,d0
	ext.w	d0
	add.w	d2,d0
	move.w	d0,(a2)+
	move.b	(a1)+,d4
	move.b	d4,(a2)+
	addq.b	#1,d5
	move.b	d5,(a2)+
	move.b	(a1)+,d0
	lsl.w	#8,d0
	move.b	(a1)+,d0
	add.w	a3,d0
	eori.w	#$800,d0
	move.w	d0,(a2)+
	move.b	(a1)+,d0
	ext.w	d0
	neg.w	d0
	add.b	d4,d4
	andi.w	#$18,d4
	addq.w	#8,d4
	sub.w	d4,d0
	add.w	d3,d0
	andi.w	#$1FF,d0
	bne.s	loc_2033B0
	addq.w	#1,d0

loc_2033B0:
	move.w	d0,(a2)+
	dbf	d1,loc_203372

locret_2033B6:
	rts

loc_2033B8:
	cmpi.b	#80,d5
	beq.s	locret_2033FC
	move.b	(a1)+,d0
	move.b	(a1),d4
	ext.w	d0
	neg.w	d0
	lsl.b	#3,d4
	andi.w	#$18,d4
	addq.w	#8,d4
	sub.w	d4,d0
	add.w	d2,d0
	move.w	d0,(a2)+
	move.b	(a1)+,(a2)+
	addq.b	#1,d5
	move.b	d5,(a2)+
	move.b	(a1)+,d0
	lsl.w	#8,d0
	move.b	(a1)+,d0
	add.w	a3,d0
	eori.w	#$1000,d0
	move.w	d0,(a2)+
	move.b	(a1)+,d0
	ext.w	d0
	add.w	d3,d0
	andi.w	#$1FF,d0
	bne.s	loc_2033F6
	addq.w	#1,d0

loc_2033F6:
	move.w	d0,(a2)+
	dbf	d1,loc_2033B8

locret_2033FC:
	rts

loc_2033FE:
	cmpi.b	#80,d5
	beq.s	locret_203450
	move.b	(a1)+,d0
	move.b	(a1),d4
	ext.w	d0
	neg.w	d0
	lsl.b	#3,d4
	andi.w	#$18,d4
	addq.w	#8,d4
	sub.w	d4,d0
	add.w	d2,d0
	move.w	d0,(a2)+
	move.b	(a1)+,d4
	move.b	d4,(a2)+
	addq.b	#1,d5
	move.b	d5,(a2)+
	move.b	(a1)+,d0
	lsl.w	#8,d0
	move.b	(a1)+,d0
	add.w	a3,d0
	eori.w	#$1800,d0
	move.w	d0,(a2)+
	move.b	(a1)+,d0
	ext.w	d0
	neg.w	d0
	add.b	d4,d4
	andi.w	#$18,d4
	addq.w	#8,d4
	sub.w	d4,d0
	add.w	d3,d0
	andi.w	#$1FF,d0
	bne.s	loc_20344A
	addq.w	#1,d0

loc_20344A:
	move.w	d0,(a2)+
	dbf	d1,loc_2033FE

locret_203450:
	rts

scronchk:
	move.w	xposi(a0),d0
	sub.w	scra_h_posit.w,d0
	bmi.s	loc_203476
	cmpi.w	#320,d0
	bge.s	loc_203476
	move.w	yposi(a0),d1
	sub.w	scra_v_posit.w,d1
	bmi.s	loc_203476
	cmpi.w	#224,d1
	bge.s	loc_203476
	moveq	#0,d0
	rts

loc_203476:
	moveq	#1,d0
	rts

scronchk2:
	moveq	#0,d1
	move.b	sprhsize(a0),d1
	move.w	xposi(a0),d0
	sub.w	scra_h_posit.w,d0
	add.w	d1,d0
	bmi.s	loc_2034AA
	add.w	d1,d1
	sub.w	d1,d0
	cmpi.w	#320,d0
	bge.s	loc_2034AA
	move.w	yposi(a0),d1
	sub.w	scra_v_posit.w,d1
	bmi.s	loc_2034AA
	cmpi.w	#224,d1
	bge.s	loc_2034AA
	moveq	#0,d0
	rts

loc_2034AA:
	moveq	#1,d0
	rts

act_tbl:

act_ptr	macro	ptr,{INTLABEL}
__LABEL__:	label	(*-act_tbl+4)/4
	dc.l	ptr
	endm

objid_00:	equ	0
play00_act:	act_ptr	play00
objid_02:	act_ptr	play00
baria_act:	act_ptr	baria
taki_act:	act_ptr	taki
jisin_act:	act_ptr	jisin
objid_06:	act_ptr	test_act
shooter_act:	act_ptr	shooter
jisin_set_act:	act_ptr	jisin_set
dai_k_act:	act_ptr	dai_k
spring_act:	act_ptr	spring
exit2_act:	act_ptr	exit2
exit2_set_act:	act_ptr	exit2_set
futa_act:	act_ptr	futa
mizuki_act:	act_ptr	mizukiri
koma_act:	act_ptr	koma
ring_act:	act_ptr	ring
flyring_act:	act_ptr	flyring
block_act:	act_ptr	block
marker_act:	act_ptr	marker
objid_14:	act_ptr	obj14
objid_15:	act_ptr	obj15
objid_16:	act_ptr	obj16
goal_act:	act_ptr	goal
bakuha_act:	act_ptr	bakuha
item_act:	act_ptr	item
item2_act:	act_ptr	item2
iwa_act:	act_ptr	iwa
score_act:	act_ptr	score
objid_1D:	act_ptr	noact
objid_1E:	act_ptr	noact
flower_act:	act_ptr	flower
kuzure_act:	act_ptr	kuzureru_tikei
dodai_act:	act_ptr	dodai
objid_22:	act_ptr	obj22
objid_23:	act_ptr	obj23
friend_act:	act_ptr	friend
objid_25:	act_ptr	noact
objid_26:	act_ptr	obj26
objid_27:	act_ptr	obj27
objid_28:	act_ptr	obj28
objid_29:	act_ptr	obj29

noact:
	move.b	#objid_00,(a0)
	rts