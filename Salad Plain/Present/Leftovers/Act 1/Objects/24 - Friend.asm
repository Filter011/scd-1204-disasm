	moveq	#0,d0
	move.b	userflag(a0),d0
	add.w	d0,d0
	move.w	off_20F938(pc,d0.w),d0
	jsr	off_20F938(pc,d0.w)
	jmp	$208E96.l

off_20F938:
	dc.w	loc_20F93C-off_20F938
	dc.w	loc_20FA36-off_20F938

loc_20F93C:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20F94A(pc,d0.w),d0
	jmp	off_20F94A(pc,d0.w)

off_20F94A:
	dc.w	loc_20F950-off_20F94A
	dc.w	loc_20F98E-off_20F94A
	dc.w	loc_20F9DE-off_20F94A

loc_20F950:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#8,sprhs(a0)
	move.b	#8,sprvsize(a0)
	move.w	#$4BF,sproffset(a0)
	move.l	#off_20FA26,patbase(a0)
	move.l	xposi(a0),act2A(a0)
	move.l	yposi(a0),act2E(a0)
	move.b	#1,act32(a0)
	rts

loc_20F98E:
	move.b	act32(a0),d0
	jsr	$2006A2.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	act2A(a0),d1
	add.l	act2E(a0),d0
	move.l	d1,xposi(a0)
	move.l	d0,yposi(a0)
	move.w	#$CBF,sproffset(a0)
	addq.b	#1,act32(a0)
	cmpi.b	#$7F,act32(a0)
	bpl.w	loc_20F9D8

loc_20F9C4:
	lea	off_20FA20.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

loc_20F9D8:
	addq.b	#word,r_no0(a0)
	bra.s	loc_20F9C4

loc_20F9DE:
	move.b	act32(a0),d0
	jsr	$2006A2.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	act2A(a0),d1
	add.l	act2E(a0),d0
	move.l	d1,xposi(a0)
	move.l	d0,yposi(a0)
	move.w	#$4BF,sproffset(a0)
	addi.b	#-1,act32(a0)
	cmpi.b	#1,act32(a0)
	bmi.w	loc_20FA18
	bra.s	loc_20F9C4

loc_20FA18:
	addi.b	#-word,r_no0(a0)
	bra.s	loc_20F9C4

off_20FA20:
	dc.w	unk_20FA22-off_20FA20
unk_20FA22:
	dc.b	$13
	dc.b	0,1
	dc.b	$FF
	even

off_20FA26:
	dc.w	byte_20FA2A-off_20FA26
	dc.w	byte_20FA30-off_20FA26
byte_20FA2A:
	dc.b	1
	dc.b	-8,5,0,0,-8
byte_20FA30:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even

loc_20FA36:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20FA44(pc,d0.w),d0
	jmp	off_20FA44(pc,d0.w)

off_20FA44:
	dc.w	loc_20FA4A-off_20FA44
	dc.w	loc_20FA7E-off_20FA44
	dc.w	loc_20FADA-off_20FA44

loc_20FA4A:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#8,sprhs(a0)
	move.b	#8,sprvsize(a0)
	move.w	#$4BF,sproffset(a0)
	move.l	#off_20FB32,patbase(a0)
	move.l	#-$40000,act2A(a0)
	rts

loc_20FA7E:
	move.w	#$4BF,sproffset(a0)
	addi.l	#$10000,xposi(a0)
	move.l	act2A(a0),d0
	add.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	addi.l	#$2000,act2A(a0)
	bmi.w	loc_20FAAC
	move.b	#1,mstno(a0)

loc_20FAAC:
	jsr	$20805A.l
	tst.w	d1
	bmi.w	loc_20FACC

loc_20FAB8:
	lea	off_20FB26.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

loc_20FACC:
	addq.b	#word,r_no0(a0)
	move.l	#-$40000,act2A(a0)
	bra.s	loc_20FAB8

loc_20FADA:
	move.w	#$CBF,sproffset(a0)
	addi.l	#-$10000,xposi(a0)
	move.l	act2A(a0),d0
	add.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	addi.l	#$2000,act2A(a0)
	bmi.w	loc_20FB08
	move.b	#1,mstno(a0)

loc_20FB08:
	jsr	$20805A.l
	tst.w	d1
	bmi.w	loc_20FB16
	bra.s	loc_20FAB8

loc_20FB16:
	addi.b	#-word,r_no0(a0)
	move.l	#-$40000,act2A(a0)
	bra.s	loc_20FAB8

off_20FB26:
	dc.w	unk_20FB2A-off_20FB26
	dc.w	unk_20FB2E-off_20FB26
unk_20FB2A:
	dc.b	$13
	dc.b	1
	dc.b	$FF
	even
unk_20FB2E:
	dc.b	$13
	dc.b	0
	dc.b	$FF
	even

off_20FB32:
	dc.w	byte_20FB36-off_20FB32
	dc.w	byte_20FB3C-off_20FB32
byte_20FB36:
	dc.b	1
	dc.b	-8,9,0,8,$F4
byte_20FB3C:
	dc.b	1
	dc.b	-8,9,0,$E,$F4
	even