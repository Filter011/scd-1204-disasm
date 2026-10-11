ring:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_2089E4(pc,d0.w),d1
	jmp	off_2089E4(pc,d1.w)

off_2089E4:
	dc.w	loc_208A0E-off_2089E4
	dc.w	loc_208AFE-off_2089E4
	dc.w	loc_208B30-off_2089E4
	dc.w	loc_208B6A-off_2089E4
	dc.w	loc_208B78-off_2089E4

ringtbl:
	dc.b	$10,0
	dc.b	$18,0
	dc.b	$20,0
	dc.b	0,$10
	dc.b	0,$18
	dc.b	0,$20
	dc.b	$10,$10
	dc.b	$18,$18
	dc.b	$20,$20
	dc.b	-$10,$10
	dc.b	-$18,$18
	dc.b	-$20,$20
	dc.b	$10,8
	dc.b	$18,$10
	dc.b	-$10,8
	dc.b	-$18,$10

loc_208A0E:
	lea	unk_FF1400,a2
	moveq	#0,d0
	move.b	obj.field_23(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	lea	2(a2,d0.w),a2
	move.b	(a2),d4
	move.b	obj.subtype(a0),d1
	moveq	#0,d0
	move.b	d1,d0
	andi.w	#7,d1
	cmpi.w	#7,d1
	bne.s	loc_208A44
	moveq	#6,d1
loc_208A44:
	swap	d1
	move.w	#1,d1
	lsr.b	#4,d0
	add.w	d0,d0
	move.b	ringtbl(pc,d0.w),d5
	ext.w	d5
	move.b	ringtbl+1(pc,d0.w),d6
	ext.w	d6
	movea.l a0,a1
	move.w	obj.xpos(a0),d2
	move.w	obj.ypos(a0),d3
	lea	1(a2),a3
	moveq	#0,d0
	move.b	time_flag,d0
loc_208A70:
	move.b	-(a3),d4
	lsr.b	d1,d4
	blo.s	loc_208AEA
	dbf	d0,loc_208A70
	bclr	#7,(a2)
	bra.s	loc_208AA2

loc_208A80:
	swap	d1
	lea	1(a2),a3
	moveq	#0,d0
	move.b	time_flag,d0
loc_208A8E:
	move.b	-(a3),d4
	lsr.b	d1,d4
	blo.s	loc_208AEA
	dbf	d0,loc_208A8E
	bclr	#7,(a2)
	bsr.w	findfreeobj
	bne.s	loc_208AF6
loc_208AA2:
	_move.b	#objid_10,obj.id(a1)
	addq.b	#2,obj.routine(a1)
	move.w	d2,obj.xpos(a1)
	move.w	obj.xpos(a0),obj.field_32(a1)
	move.w	d3,obj.ypos(a1)
	move.l	#ring_map,obj.mappings(a1)
	move.w	#$A7AE,obj.vram(a1)
	move.b	#4,obj.render(a1)
	move.b	#2,obj.priority(a1)
	move.b	#$47,obj.colflag(a1)
	move.b	#8,obj.field_19(a1)
	move.b	obj.field_23(a0),obj.field_23(a1)
	move.b	d1,obj.field_34(a1)
loc_208AEA:
	addq.w	#1,d1
	add.w	d5,d2
	add.w	d6,d3
	swap	d1
	dbf	d1,loc_208A80
loc_208AF6:
	btst	#0,(a2)
	bne.w	deleteobj
loc_208AFE:
	move.w	obj.field_32(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.w	loc_208B78
	tst.w	word_FF1278
	bne.s	loc_208B2C
	move.b	ring_frame,obj.frame(a0)
loc_208B2C:
	bra.w	displaysprite

loc_208B30:
	addq.b	#2,obj.routine(a0)
	move.b	#0,obj.colflag(a0)
	move.b	#1,obj.priority(a0)
	bsr.w	sub_208B7C
	lea	unk_FF1400,a2
	moveq	#0,d0
	move.b	obj.field_23(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	move.b	obj.field_34(a0),d1
	subq.b	#1,d1
	bset	d1,2(a2,d0.w)
loc_208B6A:
	lea	ring_ani.l,a1
	bsr.w	animateobj
	bra.w	displaysprite

loc_208B78:
	bra.w	deleteobj

sub_208B7C:
	addq.w	#1,plring
	ori.b	#1,plring_f
	move.w	#$95,d0
	cmpi.w	#100,plring
	blo.s	loc_208BC6
	bset	#1,plring_f2
	beq.s	loc_208BB6
	cmpi.w	#200,plring
	blo.s	loc_208BC6
	bset	#2,plring_f2
	bne.s	loc_208BC6
loc_208BB6:
	addq.b	#1,pl_suu
	addq.b	#1,pl_suu_f
	move.w	#$88,d0
loc_208BC6:
	jmp	queuesound2.l

flyring:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_208BDA(pc,d0.w),d1
	jmp	off_208BDA(pc,d1.w)

off_208BDA:
	dc.w	loc_208BE4-off_208BDA
	dc.w	loc_208CB0-off_208BDA
	dc.w	loc_208D08-off_208BDA
	dc.w	loc_208D1C-off_208BDA
	dc.w	loc_208D2A-off_208BDA

loc_208BE4:
	movea.l a0,a1
	moveq	#0,d5
	move.w	plring,d5
	moveq	#$20,d0
	cmp.w	d0,d5
	blo.s	loc_208BF6
	move.w	d0,d5
loc_208BF6:
	subq.w	#1,d5
	move.w	#$288,d4
	bra.s	loc_208C06

loc_208BFE:
	bsr.w	findfreeobj
	bne.w	loc_208C8E
loc_208C06:
	_move.b	#objid_11,obj.id(a1)
	addq.b	#2,obj.routine(a1)
	move.b	#8,obj.height(a1)
	move.b	#8,obj.width(a1)
	move.w	obj.xpos(a0),obj.xpos(a1)
	move.w	obj.ypos(a0),obj.ypos(a1)
	move.l	#ring_map,obj.mappings(a1)
	move.w	#$A7AE,obj.vram(a1)
	move.b	#4,obj.render(a1)
	move.b	#3,obj.priority(a1)
	move.b	#$47,obj.colflag(a1)
	move.b	#8,obj.field_19(a1)
	move.b	#-1,byte_FF12C6
	tst.w	d4
	bmi.s	loc_208C7E
	move.w	d4,d0
	jsr	calcsine.l
	move.w	d4,d2
	lsr.w	#8,d2
	asl.w	d2,d0
	asl.w	d2,d1
	move.w	d0,d2
	move.w	d1,d3
	addi.b	#$10,d4
	bhs.s	loc_208C7E
	subi.w	#$80,d4
	bhs.s	loc_208C7E
	move.w	#$288,d4
loc_208C7E:
	move.w	d2,obj.xvel(a1)
	move.w	d3,obj.yvel(a1)
	neg.w	d2
	neg.w	d4
	dbf	d5,loc_208BFE
loc_208C8E:
	move.w	#0,plring
	move.b	#$80,plring_f
	move.b	#0,plring_f2
	move.w	#$94,d0
	jsr	queuesound2.l
loc_208CB0:
	move.b	byte_FF12C7,obj.frame(a0)
	bsr.w	speedset2
	addi.w	#$18,obj.yvel(a0)
	bmi.s	loc_208CEE
	move.b	dword_FF120C+3,d0
	add.b	d7,d0
	andi.b	#3,d0
	bne.s	loc_208CEE
	jsr	sub_20611C.l
	tst.w	d1
	bpl.s	loc_208CEE
	add.w	d1,obj.ypos(a0)
	move.w	obj.yvel(a0),d0
	asr.w	#2,d0
	sub.w	d0,obj.yvel(a0)
	neg.w	obj.yvel(a0)
loc_208CEE:
	tst.b	byte_FF12C6
	beq.s	loc_208D2A
	move.w	scralim_down.w,d0
	addi.w	#224,d0
	cmp.w	obj.ypos(a0),d0
	blo.s	loc_208D2A
	bra.w	displaysprite

loc_208D08:
	addq.b	#2,obj.routine(a0)
	move.b	#0,obj.colflag(a0)
	move.b	#1,obj.priority(a0)
	bsr.w	sub_208B7C
loc_208D1C:
	lea	ring_ani.l,a1
	bsr.w	animateobj
	bra.w	displaysprite

loc_208D2A:
	bra.w	deleteobj

ring_ani:
	dc.w	unk_208D30-ring_ani

unk_208D30:
	dc.b	5
	dc.b	4,5,6,7
	dc.b	$FC
	even

ring_map:
	dc.w	byte_208D48-ring_map
	dc.w	byte_208D4E-ring_map
	dc.w	byte_208D54-ring_map
	dc.w	byte_208D5A-ring_map
	dc.w	byte_208D60-ring_map
	dc.w	byte_208D66-ring_map
	dc.w	byte_208D6C-ring_map
	dc.w	byte_208D72-ring_map
	dc.w	byte_208D78-ring_map
byte_208D48:
	dc.b	1
	dc.b	-8,5,0,0,-8
	even
byte_208D4E:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even
byte_208D54:
	dc.b	1
	dc.b	-8,1,0,8,-4
	even
byte_208D5A:
	dc.b	1
	dc.b	-8,5,8,4,-8
	even
byte_208D60:
	dc.b	1
	dc.b	-8,5,0,$A,-8
	even
byte_208D66:
	dc.b	1
	dc.b	-8,5,$18,$A,-8
	even
byte_208D6C:
	dc.b	1
	dc.b	-8,5,$10,$A,-8
	even
byte_208D72:
	dc.b	1
	dc.b	-8,5,8,$A,-8
	even
byte_208D78:
	dc.b	0
	even