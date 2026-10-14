sub_2080EA:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	ridechk.l

dai_k:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	dai_k_move_tbl(pc,d0.w),d0
	jsr	dai_k_move_tbl(pc,d0.w)
	tst.w	time_stop
	bne.s	loc_208118
	lea	k_daichg.l,a1
	bsr.w	patchg

loc_208118:
	jsr	actionsub.l
	jmp	frameout_s.l

dai_k_move_tbl:
	dc.w	dai_k_init-dai_k_move_tbl
	dc.w	dai_k_move-dai_k_move_tbl

dai_k_init:
	addq.b	#2,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)
	move.l	#k_daipat,patbase(a0)
	moveq	#6,d0
	jsr	pa_set(pc)
	move.b	#$10,sprhsize(a0)
	move.b	#8,sprvsize(a0)

dai_k_move:
	tst.b	actflg(a0)
	bpl.w	locret_2081BC
	lea	playerwk.w,a1
	bsr.s	sub_2080EA
	beq.s	loc_208166
	bsr.s	sub_208172
	bra.s	loc_208168

loc_208166:
	bsr.s	sub_2081A6

loc_208168:
	lea	byte_FFD040.w,a1
	bsr.w	sub_2080EA
	beq.s	sub_2081A6

sub_208172:
	tst.w	time_stop
	bne.s	locret_2081BC
	bset	#0,act2C(a1)
	bne.s	loc_2081A4
	move.b	#$2D,mstno(a1)
	moveq	#0,d0
	move.b	d0,act2B(a1)
	move.w	xposi(a1),d0
	sub.w	xposi(a0),d0
	bhs.s	loc_2081A0
	neg.w	d0
	move.b	#$80,act2B(a1)

loc_2081A0:
	move.b	d0,act39(a1)

loc_2081A4:
	bra.s	loc_2081BE

sub_2081A6:
	moveq	#0,d0
	move.b	act3D(a1),d0
	lsl.w	#6,d0
	addi.l	#actwk&$FFFFFF,d0
	cmpa.w	d0,a0
	bne.s	locret_2081BC
	clr.b	act2C(a1)

locret_2081BC:
	rts

loc_2081BE:
	addq.b	#8,act2B(a1)
	move.b	act2B(a1),d0
	jsr	sinset.l
	moveq	#0,d0
	move.b	act39(a1),d0
	muls.w	d1,d0
	lsr.l	#8,d0
	move.w	xposi(a0),xposi(a1)
	add.w	d0,xposi(a1)
	moveq	#0,d0
	move.b	act2B(a1),d0
	move.b	d0,d1
	andi.b	#$F0,d0
	lsr.b	#4,d0
	move.b	pattbl(pc,d0.w),patcnt(a1)
	andi.b	#$3F,d1
	bne.s	loc_2081FE
	addq.b	#1,act39(a1)

loc_2081FE:
	move.w	swdata1.w,swdata.w
	_cmpi.b	#play00_act,actno(a1)
	beq.s	loc_208212
	move.w	swdata2.w,swdata.w

loc_208212:
	bsr.w	k_move
	bra.w	jumpchk_d
	rts

pattbl:
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	4
	dc.b	5
	dc.b	5
	dc.b	5
	even

k_move:
	move.w	xposi(a1),d0
	sub.w	xposi(a0),d0
	bhs.s	loc_20825A
	btst	#2,swdata.w
	beq.s	loc_208244
	addq.b	#1,act39(a1)
	bra.s	locret_20827C

loc_208244:
	btst	#3,swdata.w
	beq.s	locret_20827C
	subq.b	#1,act39(a1)
	bhs.s	locret_20827C
	move.b	#0,act39(a1)
	bra.s	locret_20827C

loc_20825A:
	btst	#3,swdata.w
	beq.s	loc_208268
	addq.b	#1,act39(a1)
	bra.s	locret_20827C

loc_208268:
	btst	#2,swdata.w
	beq.s	locret_20827C
	subq.b	#1,act39(a1)
	bhs.s	locret_20827C
	move.b	#0,act39(a1)

locret_20827C:
	rts

jumpchk_d:
	move.b	swdata+1.w,d0
	andi.b	#$70,d0
	beq.w	locret_208332
	move.w	#$680,d2
	btst	#cd_underwater,cddat(a0)
	beq.s	loc_20829A
	move.w	#$380,d2

loc_20829A:
	moveq	#0,d0
	move.b	direc(a1),d0
	subi.b	#$40,d0
	jsr	sinset.l
	muls.w	d2,d1
	asr.l	#8,d1
	add.w	d1,xspeed(a1)
	muls.w	d2,d0
	asr.l	#8,d0
	add.w	d0,yspeed(a1)
	bset	#cd_jump,cddat(a1)
	bclr	#cd_push,cddat(a1)
	move.b	#1,jumpflag(a1)
	clr.b	convexflag(a1)
	move.w	#$A0,d0
	jsr	soundset.l
	tst.b	chibi_flag.w
	beq.s	loc_2082EE
	move.b	#chibiheight,sprvsize(a1)
	move.b	#chibiwidth,sprhs(a1)
	bra.s	loc_2082FA

loc_2082EE:
	move.b	#pl_height,sprvsize(a1)
	move.b	#pl_width,sprhs(a1)

loc_2082FA:
	btst	#cd_ball,cddat(a1)
	bne.s	loc_208334
	tst.b	chibi_flag.w
	beq.s	loc_208316
	move.b	#chibiheight,sprvsize(a1)
	move.b	#chibiwidth,sprhs(a1)
	bra.s	loc_208326

loc_208316:
	move.b	#rollheight,sprvsize(a1)
	move.b	#rollwidth,sprhs(a1)
	addq.w	#pl_height-rollheight,yposi(a1)

loc_208326:
	bset	#cd_ball,cddat(a1)
	move.b	#2,mstno(a1)

locret_208332:
	rts

loc_208334:
	bset	#cd_ballj,cddat(a1)
	rts

k_daichg:
	dc.w	k_daichg0-k_daichg
k_daichg0:
	dc.b	1
	dc.b	0,1,2
	dc.b	$FF
	even

k_daipat:
	dc.w	k_daipat0-k_daipat
	dc.w	k_daipat1-k_daipat
	dc.w	k_daipat2-k_daipat
k_daipat0:
	dc.b	2
	dc.b	-8,5,0,0,$F0
	dc.b	-8,5,8,0,0
	even
k_daipat1:
	dc.b	2
	dc.b	-8,5,0,0,$F0
	dc.b	-8,5,8,0,0
	even
k_daipat2:
	dc.b	1
	dc.b	-8,$D,0,4,$F0
	even