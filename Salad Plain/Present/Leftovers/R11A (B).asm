	dc.w	word_20FCEA-$20FCAC
	dc.w	$2408
	dc.w	$2452
	dc.w	$23F2
	dc.w	$2428
	dc.w	$2486
	dc.w	$2000
	dc.w	$31E
	dc.w	$32A
	dc.w	$4000
	dc.w	$4000
	dc.w	$3B7
	dc.w	$3C6
	dc.w	$8399
	dc.w	$4C1
	dc.w	$391
word_20FCEA:
	dc.w	$36B

	moveq	#0,d0
	move.b	userflag(a0),d0
	add.w	d0,d0
	move.w	off_20FD02(pc,d0.w),d0
	jsr	off_20FD02(pc,d0.w)
	jmp	$208EEA.l

off_20FD02:
	dc.w	loc_20FD06-off_20FD02
	dc.w	loc_20FE00-off_20FD02

loc_20FD06:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20FD14(pc,d0.w),d0
	jmp	off_20FD14(pc,d0.w)

off_20FD14:
	dc.w	loc_20FD1A-off_20FD14
	dc.w	loc_20FD58-off_20FD14
	dc.w	loc_20FDA8-off_20FD14

loc_20FD1A:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#8,sprhs(a0)
	move.b	#8,sprvsize(a0)
	move.w	#$3DA,sproffset(a0)
	move.l	#off_20FDF0,patbase(a0)
	move.l	xposi(a0),act2A(a0)
	move.l	yposi(a0),act2E(a0)
	move.b	#1,act32(a0)
	rts

loc_20FD58:
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
	move.w	#$BDA,sproffset(a0)
	addq.b	#1,act32(a0)
	cmpi.b	#$7F,act32(a0)
	bpl.w	loc_20FDA2

loc_20FD8E:
	lea	off_20FDEA.l,a1
	jsr	$2073C2.l
	jmp	$20519E.l
	rts

loc_20FDA2:
	addq.b	#word,r_no0(a0)
	bra.s	loc_20FD8E

loc_20FDA8:
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
	move.w	#$3DA,sproffset(a0)
	addi.b	#-1,act32(a0)
	cmpi.b	#1,act32(a0)
	bmi.w	loc_20FDE2
	bra.s	loc_20FD8E

loc_20FDE2:
	addi.b	#-word,r_no0(a0)
	bra.s	loc_20FD8E

off_20FDEA:
	dc.w	unk_20FDEC-off_20FDEA
unk_20FDEC:
	dc.b	$13
	dc.b	0,1
	dc.b	$FF
	even

off_20FDF0:
	dc.w	byte_20FDF4-off_20FDF0
	dc.w	byte_20FDFA-off_20FDF0
byte_20FDF4:
	dc.b	1
	dc.b	-8,5,0,0,-8
byte_20FDFA:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even

loc_20FE00:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20FE0E(pc,d0.w),d0
	jmp	off_20FE0E(pc,d0.w)

off_20FE0E:
	dc.w	loc_20FE14-off_20FE0E
	dc.w	loc_20FE48-off_20FE0E
	dc.w	loc_20FEA4-off_20FE0E

loc_20FE14:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#8,sprhs(a0)
	move.b	#8,sprvsize(a0)
	move.w	#$3DA,sproffset(a0)
	move.l	#off_20FEFC,patbase(a0)
	move.l	#-$40000,act2A(a0)
	rts

loc_20FE48:
	move.w	#$3DA,sproffset(a0)
	addi.l	#$10000,xposi(a0)
	move.l	act2A(a0),d0
	add.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	addi.l	#$2000,act2A(a0)
	bmi.w	loc_20FE76
	move.b	#1,mstno(a0)

loc_20FE76:
	jsr	$20807E.l
	tst.w	d1
	bmi.w	loc_20FE96

loc_20FE82:
	lea	off_20FEF0.l,a1
	jsr	$2073C2.l
	jmp	$20519E.l
	rts

loc_20FE96:
	addq.b	#word,r_no0(a0)
	move.l	#-$40000,act2A(a0)
	bra.s	loc_20FE82

loc_20FEA4:
	move.w	#$BDA,sproffset(a0)
	addi.l	#-$10000,xposi(a0)
	move.l	act2A(a0),d0
	add.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	addi.l	#$2000,act2A(a0)
	bmi.w	loc_20FED2
	move.b	#1,mstno(a0)

loc_20FED2:
	jsr	$20807E.l
	tst.w	d1
	bmi.w	loc_20FEE0
	bra.s	loc_20FE82

loc_20FEE0:
	addi.b	#-word,r_no0(a0)
	move.l	#-$40000,act2A(a0)
	bra.s	loc_20FE82

off_20FEF0:
	dc.w	unk_20FEF4-off_20FEF0
	dc.w	unk_20FEF8-off_20FEF0
unk_20FEF4:
	dc.b	$13
	dc.b	1
	dc.b	$FF
	even
unk_20FEF8:
	dc.b	$13
	dc.b	0
	dc.b	$FF
	even

off_20FEFC:
	dc.w	byte_20FF00-off_20FEFC
	dc.w	byte_20FF06-off_20FEFC
byte_20FF00:
	dc.b	1
	dc.b	-8,9,0,8,$F4
byte_20FF06:
	dc.b	1
	dc.b	-8,9,0,$E,$F4
	even

	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20FF1C(pc,d0.w),d0
	jsr	off_20FF1C(pc,d0.w)
	rts

off_20FF1C:
	dc.w	loc_20FF26-off_20FF1C
	dc.w	loc_20FF36-off_20FF1C
	dc.w	loc_20FF64-off_20FF1C
	dc.w	loc_20FF6E-off_20FF1C
	dc.w	loc_20FF8A-off_20FF1C

loc_20FF26:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)

loc_20FF36:
	jsr	$2043A4.l
	move.w	xposi(a0),d0
	cmp.w	xposi(a6),d0
	bhs.s	locret_20FF62
	move.w	scralim_right.w,scralim_left.w
	move.b	#60,act2A(a0)
	move.b	#180,act2B(a0)
	move.b	#240,act2B(a0)
	addq.b	#word,r_no0(a0)

locret_20FF62:
	rts

loc_20FF64:
	subq.b	#1,act2A(a0)
	bne.s	loc_20FF6E
	addq.b	#word,r_no0(a0)

loc_20FF6E:
	subq.b	#1,act2B(a0)
	bne.s	loc_20FF8A
	bset	#0,plautoflag.w
	move.b	#0,mstno(a0)
	move.w	#$808,swdata.w
	addq.b	#word,r_no0(a0)

loc_20FF8A:
	subq.b	#1,act2B(a0)
	bne.s	locret_20FF98
	move.w	#2,gameflag

locret_20FF98:
	rts

	jmp	$20792C.l

	dc.l	3<<24+$237DBA
	dc.l	2<<24+$236D82
	dc.l	$23A476
	dc.w	bgm_zone1
	dc.b	4,4

off_20FFB0:
	dc.w	word_20FFC0-off_20FFB0
	dc.w	word_20FFC8-off_20FFB0
	dc.w	word_20FFFA-off_20FFB0
	dc.w	word_20FFC0-off_20FFB0
	dc.w	$210050-off_20FFB0
	dc.w	$21005E-off_20FFB0
	dc.w	$210066-off_20FFB0
	dc.w	$210074-off_20FFB0

word_20FFC0:	ddev_header
	ddev_entry	$237DBA,0
word_20FFC0_end:

word_20FFC8:	ddev_header
	ddev_entry	$231B28,$4FE
	ddev_entry	$231C36,$511
	ddev_entry	$23051E,$520
	ddev_entry	$231832,$568
	ddev_entry	$230740,$5A8
	ddev_entry	$230CD6,$680
	ddev_entry	$23195E,$6D6
	ddev_entry	$2311BE,$7AE
word_20FFC8_end:

word_20FFFA:
	dc.w	13
	dc.l	$233AAA

	dephase