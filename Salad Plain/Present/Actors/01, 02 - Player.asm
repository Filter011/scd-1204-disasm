sub_2035B0:
	move.w	swdata2.w,d0
	moveq	#objid_02,d1
	lea	byecnt1.w,a4
	lea	playerwk.w,a5
	lea	byte_FFD040.w,a6
	tst.b	main_play
	beq.s	loc_2035DC
	move.w	swdata1.w,d0
	moveq	#play00_act,d1
	lea	byecnt0.w,a4
	lea	byte_FFD040.w,a5
	lea	playerwk.w,a6

loc_2035DC:
	_tst.b	actno(a6)
	bne.s	locret_203614
	andi.b	#$F0,d0
	beq.s	locret_203614
	_move.b	d1,actno(a6)
	move.b	cddat(a5),cddat(a6)
	move.l	yposi(a5),yposi(a6)
	move.l	xposi(a5),xposi(a6)
	move.w	yspeed(a5),yspeed(a6)
	move.w	xspeed(a5),xspeed(a6)
	move.w	mspeed(a5),mspeed(a6)
	move.w	#0,(a4)

locret_203614:
	rts

play00:
	move.b	act2A(a0),d0
	beq.s	loc_20362C
	addq.b	#1,d0
	cmpi.b	#60,d0
	blo.s	loc_203628
	move.b	#60,d0

loc_203628:
	move.b	d0,act2A(a0)

loc_20362C:
	bsr.s	sub_2035B0
	clr.b	mainplayflag(a0)
	moveq	#0,d0
	_move.b	actno(a0),d0
	subq.b	#1,d0
	cmp.b	main_play,d0
	bne.s	loc_203648
	move.b	#1,mainplayflag(a0)

loc_203648:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	play00_move_tbl(pc,d0.w),d1
	jmp	play00_move_tbl(pc,d1.w)

play00_move_tbl:
	dc.w	play00init-play00_move_tbl
	dc.w	play00move-play00_move_tbl
	dc.w	play00damage-play00_move_tbl
	dc.w	play00die-play00_move_tbl
	dc.w	play00erase-play00_move_tbl

baria_set:
	tst.b	mainplayflag(a0)
	beq.s	.end
	move.b	#1,plpower_b
	move.b	#baria_act,bariawk.w

.end:
	rts

muteki_set:
	tst.b	mutekiawk.w
	bne.s	.end
	tst.b	mainplayflag(a0)
	beq.s	.end
	move.b	#1,plpower_a
	move.b	#baria_act,mutekiawk.w
	move.b	#5,mutekiawk+mstno.w
	move.b	#baria_act,mutekia2wk.w
	move.b	#6,mutekia2wk+mstno.w
	move.b	#baria_act,mutekia3wk.w
	move.b	#7,mutekia3wk+mstno.w
	move.b	#baria_act,mutekia4wk.w
	move.b	#8,mutekia4wk+mstno.w

.end:
	rts

test_mapwrt:
	rts

play00init:
	addq.b	#word,r_no0(a0)
	move.b	#walkheight,sprvsize(a0)
	move.b	#walkwidth,sprhs(a0)
	tst.b	chibi_flag.w
	beq.s	loc_2036E0
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)

loc_2036E0:
	move.l	#playpat,patbase(a0)
	move.w	#$780,sproffset(a0)
	_cmpi.b	#play00_act,actno(a0)
	beq.s	loc_2036FC
	move.w	#$797,sproffset(a0)

loc_2036FC:
	move.b	#2,sprpri(a0)
	move.b	#$18,sprhsize(a0)
	move.b	#4,actflg(a0)
	move.w	#$600,plmaxspdwk.w
	move.w	#$C,pladdspdwk.w
	move.w	#$80,plretspdwk.w

mizuki_set:
	tst.b	stageno
	bne.s	locret_203786
	move.b	gametimer+1,d0
	andi.b	#3,d0
	bne.s	locret_203786
	move.b	sprvsize(a0),d2
	ext.w	d2
	add.w	yposi(a0),d2
	move.w	xposi(a0),d3
	bsr.w	mapno_chk
	cmpi.b	#$2F,d1
	bne.s	locret_203788
	cmpi.w	#$15C0,xposi(a0)
	bhs.s	locret_203786
	tst.b	act2C(a0)
	beq.s	locret_203786
	jsr	actwkchk.l
	bne.s	locret_203786
	_move.b	#mizuki_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	moveq	#1,d0
	tst.w	xspeed(a0)
	bmi.s	loc_20377E
	moveq	#0,d0

loc_20377E:
	move.b	d0,actflg(a1)
	move.b	d0,cddat(a1)

locret_203786:
	rts

locret_203788:
	rts

	move.b	sprvsize(a0),d2
	ext.w	d2
	add.w	yposi(a0),d2
	cmpi.b	#$10,d1
	bne.s	loc_2037A8
	cmpi.w	#$210,d2
	bhs.s	locret_203786
	cmpi.w	#$208,d2
	blo.s	locret_203786
	bra.s	loc_2037BA

loc_2037A8:
	cmpi.b	#$21,d1
	bne.s	locret_203786
	cmpi.w	#$2A0,d2
	bhs.s	locret_203786
	cmpi.w	#$298,d2
	blo.s	locret_203786

loc_2037BA:
	tst.w	mspeed(a0)
	beq.s	locret_203786
	jsr	actwkchk.l
	bne.s	locret_203786
	_move.b	#exit2_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	andi.w	#$FFF8,d2
	move.w	d2,yposi(a1)
	move.b	#1,userflag(a1)
	move.w	mspeed(a0),d0
	bpl.s	loc_2037EA
	neg.w	d0

loc_2037EA:
	cmpi.w	#$600,d0
	bhs.s	loc_2037F6
	move.b	#2,userflag(a1)

loc_2037F6:
	move.w	#$A1,d0
	jmp	soundset.l

mapno_chk:
	move.w	d2,d0
	lsr.w	#1,d0
	andi.w	#$380,d0
	move.w	d3,d1
	lsr.w	#8,d1
	andi.w	#$7F,d1
	add.w	d1,d0
	move.l	#mapwk,d1
	lea	mapwka.w,a1
	move.b	(a1,d0.w),d1
	andi.b	#$7F,d1
	rts

sub_203826:
	cmpi.b	#stage_mz,stageno
	beq.s	loc_203832
	rts

loc_203832:
	move.w	xspeed(a0),d1
	move.w	yspeed(a0),d2
	jsr	atan.l
	subi.b	#$20,d0
	andi.b	#$C0,d0
	cmpi.b	#$40,d0
	beq.w	loc_203916
	cmpi.b	#$80,d0
	beq.w	loc_20389C
	cmpi.b	#$C0,d0
	beq.w	loc_2038D8
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	bsr.w	sub_203954
	bne.s	locret_20389A
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	bra.w	sub_203954

locret_20389A:
	rts

loc_20389C:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	bsr.w	sub_203954
	bne.s	locret_2038D6
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	bra.w	sub_203954

locret_2038D6:
	rts

loc_2038D8:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	move.b	sprvsize(a0),d0
	subq.b	#6,d0
	ext.w	d0
	sub.w	d0,d2
	bsr.w	sub_203954
	bne.s	locret_203914
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	bra.w	sub_203954

locret_203914:
	rts

loc_203916:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	move.b	sprvsize(a0),d0
	subq.b	#6,d0
	ext.w	d0
	sub.w	d0,d2
	bsr.w	sub_203954
	bne.s	locret_203952
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	bra.w	sub_203954

locret_203952:
	rts

sub_203954:
	jsr	scramapad.l
	move.w	(a1),d0
	move.w	d0,d4
	andi.w	#$7FF,d0
	beq.s	loc_203994
	moveq	#0,d1
	move.b	time_flag,d1
	cmpi.b	#2,d1
	bne.s	loc_203978
	add.b	generate_flag,d1

loc_203978:
	add.w	d1,d1
	move.w	off_203998(pc,d1.w),d1
	lea	off_203998(pc,d1.w),a1
	moveq	#0,d6
	move.w	(a1)+,d6
	moveq	#0,d1

loc_203988:
	cmp.w	(a1,d1.w),d0
	beq.s	loc_203A0C
	addq.w	#2,d1
	dbf	d6,loc_203988

loc_203994:
	moveq	#0,d0
	rts

off_203998:
	dc.w	word_2039C2-off_203998
	dc.w	word_2039A0-off_203998
	dc.w	word_2039EA-off_203998
	dc.w	word_2039C8-off_203998
word_2039A0:
	dc.w	16-1
	dc.w	$13C
	dc.w	$146
	dc.w	$19B
	dc.w	$1AE
	dc.w	$83
	dc.w	$84
	dc.w	$89
	dc.w	$8A
	dc.w	$77
	dc.w	$76
	dc.w	$80
	dc.w	$7F
	dc.w	$7E
	dc.w	$7D
	dc.w	$7C
	dc.w	$82
word_2039C2:
	dc.w	2-1
	dc.w	$145
	dc.w	$146
word_2039C8:
	dc.w	16-1
	dc.w	$13C
	dc.w	$146
	dc.w	0
	dc.w	0
	dc.w	$83
	dc.w	$84
	dc.w	$89
	dc.w	$8A
	dc.w	$77
	dc.w	$76
	dc.w	$80
	dc.w	$7F
	dc.w	$7E
	dc.w	$7D
	dc.w	$7C
	dc.w	$82
word_2039EA:
	dc.w	16-1
	dc.w	$13C
	dc.w	$146
	dc.w	$165
	dc.w	0
	dc.w	$83
	dc.w	$84
	dc.w	$89
	dc.w	$8A
	dc.w	$77
	dc.w	$76
	dc.w	$80
	dc.w	$7F
	dc.w	$7E
	dc.w	$7D
	dc.w	$7C
	dc.w	$82

loc_203A0C:
	move.b	#0,byte_FF1886
	move.w	off_203A2C(pc,d1.w),d0
	jsr	off_203A2C(pc,d0.w)
	tst.b	byte_FF1886
	beq.s	loc_203A28
	moveq	#0,d0
	rts

loc_203A28:
	moveq	#1,d0
	rts

off_203A2C:
	dc.w	loc_203A4C-off_203A2C
	dc.w	loc_203A4C-off_203A2C
	dc.w	loc_203ADA-off_203A2C
	dc.w	loc_203ADA-off_203A2C
	dc.w	loc_203C70-off_203A2C
	dc.w	sub_203B2C-off_203A2C
	dc.w	sub_203B3E-off_203A2C
	dc.w	sub_203B3E-off_203A2C
	dc.w	loc_203C4C-off_203A2C
	dc.w	sub_203BA4-off_203A2C
	dc.w	sub_203BA4-off_203A2C
	dc.w	sub_203BA4-off_203A2C
	dc.w	sub_203B88-off_203A2C
	dc.w	sub_203B2C-off_203A2C
	dc.w	sub_203B2C-off_203A2C
	dc.w	sub_203B50-off_203A2C

loc_203A4C:
	andi.w	#$FFF0,d2
	tst.b	d1
	bne.s	loc_203A58
	addi.w	#$10,d2

loc_203A58:
	andi.w	#$FFF0,d3
	btst	#$B,d4
	bne.s	loc_203A66
	addi.w	#$10,d3

loc_203A66:
	move.w	d3,d1
	movem.l	d1-d2,-(sp)
	sub.w	xposi(a0),d1
	sub.w	yposi(a0),d2
	jsr	atan.l
	jsr	sinset.l
	muls.w	#-$700,d1
	asr.l	#8,d1
	move.w	d1,xspeed(a0)
	muls.w	#-$700,d0
	asr.l	#8,d0
	move.w	d0,yspeed(a0)
	bset	#cd_walk,cddat(a0)
	bclr	#cd_ballj,cddat(a0)
	bclr	#cd_push,cddat(a0)
	clr.b	jumpflag(a0)
	movem.l	(sp)+,d1-d2
	move.w	d2,d4
	move.w	d1,d5
	move.w	#0,d3
	jsr	block_wrt.l
	subi.w	#16,d5
	jsr	block_wrt.l
	subi.w	#16,d4
	jsr	block_wrt.l
	addi.w	#16,d5
	jmp	block_wrt.l

loc_203ADA:
	andi.w	#$FFF0,d2
	addq.w	#8,d2
	andi.w	#$FFF0,d3
	addq.w	#8,d3
	move.w	d3,d1
	sub.w	xposi(a0),d1
	sub.w	yposi(a0),d2
	jsr	atan.l
	jsr	sinset.l
	muls.w	#-$700,d1
	asr.l	#8,d1
	asr.l	#1,d1
	move.w	d1,xspeed(a0)
	muls.w	#-$700,d0
	asr.l	#8,d0
	asr.l	#1,d0
	move.w	d0,yspeed(a0)

loc_203B14:
	bset	#cd_walk,cddat(a0)
	bclr	#cd_ballj,cddat(a0)
	bclr	#cd_push,cddat(a0)
	clr.b	jumpflag(a0)
	rts

sub_203B2C:
	move.w	#$700,d0
	tst.w	yspeed(a0)
	bmi.s	loc_203B38
	neg.w	d0
loc_203B38:
	move.w	d0,yspeed(a0)
	bra.s	loc_203B14

sub_203B3E:
	move.w	#$700,d0
	tst.w	xspeed(a0)
	bmi.s	loc_203B4A
	neg.w	d0
loc_203B4A:
	move.w	d0,xspeed(a0)
	bra.s	loc_203B14

sub_203B50:
	andi.w	#$FFF0,d2
	addq.w	#8,d2
	andi.w	#$FFF0,d3
	addq.w	#8,d3
	move.w	d3,d1
	sub.w	xposi(a0),d1
	sub.w	yposi(a0),d2
	jsr	atan.l
	jsr	sinset.l
	muls.w	#-$700,d1
	asr.l	#8,d1
	move.w	d1,xspeed(a0)
	muls.w	#-$700,d0
	asr.l	#8,d0
	move.w	d0,yspeed(a0)
	bra.s	loc_203B14

sub_203B88:
	move.w	d3,d1
	andi.w	#$F,d1
	cmpi.b	#8,d1
	bhs.s	loc_203B9C
	btst	#$B,d4
	bne.s	sub_203B3E
	bra.s	sub_203B2C

loc_203B9C:
	btst	#$B,d4
	bne.s	sub_203B2C
	bra.s	sub_203B3E

sub_203BA4:
	subi.w	#$12,d1
	bmi.s	loc_203BD6
	move.w	off_203C16(pc,d1.w),d0
	lea	off_203C16(pc,d0.w),a1
	andi.w	#$F,d2
	andi.w	#$F,d3
	btst	#$B,d4
	bne.s	loc_203BC6
	neg.b	d3
	addi.b	#$F,d3

loc_203BC6:
	cmp.b	(a1,d3.w),d2
	bhs.s	loc_203BD6
	move.b	#1,byte_FF1886
	rts

loc_203BD6:
	move.w	xspeed(a0),d1
	move.w	yspeed(a0),d2
	jsr	atan.l
	addi.b	#$80,d0
	neg.b	d0
	subi.b	#$20,d0
	btst	#$B,d4
	beq.s	loc_203BF8
	addi.b	#$40,d0

loc_203BF8:
	jsr	sinset.l
	muls.w	#-$700,d1
	asr.l	#8,d1
	move.w	d1,xspeed(a0)
	muls.w	#-$700,d0
	asr.l	#8,d0
	move.w	d0,yspeed(a0)
	bra.w	loc_203B14

off_203C16:
	dc.w	unk_203C1C-off_203C16
	dc.w	unk_203C2C-off_203C16
	dc.w	unk_203C3C-off_203C16
unk_203C1C:
	dc.b	1
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
	dc.b	4
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	6
	even

unk_203C2C:
	dc.b	6
	dc.b	6
	dc.b	7
	dc.b	7
	dc.b	7
	dc.b	8
	dc.b	8
	dc.b	8
	dc.b	9
	dc.b	9
	dc.b	9
	dc.b	$A
	dc.b	$A
	dc.b	$A
	dc.b	$B
	dc.b	$B
	even

unk_203C3C:
	dc.b	$B
	dc.b	$C
	dc.b	$C
	dc.b	$C
	dc.b	$D
	dc.b	$D
	dc.b	$D
	dc.b	$E
	dc.b	$E
	dc.b	$E
	dc.b	$F
	dc.b	$F
	dc.b	$F
	dc.b	$10
	dc.b	$10
	dc.b	$10
	even

loc_203C4C:
	move.w	d3,d1
	andi.w	#$F,d1
	cmpi.b	#8,d1
	bhs.s	loc_203C64
	btst	#$B,d4
	bne.w	sub_203B3E
	bra.w	sub_203BA4

loc_203C64:
	btst	#$B,d4
	bne.w	sub_203B2C
	bra.w	sub_203BA4

loc_203C70:
	move.w	d3,d1
	andi.w	#$F,d1
	cmpi.b	#8,d1
	bhs.s	loc_203C88
	btst	#$B,d4
	bne.w	sub_203B2C
	bra.w	sub_203B50

loc_203C88:
	btst	#$B,d4
	bne.w	sub_203B50
	bra.w	sub_203B2C

	move.w	d2,d1
	andi.w	#$F,d1
	cmpi.b	#8,d1
	bhs.s	loc_203CAC
	btst	#$C,d4
	bne.w	sub_203B3E
	bra.w	sub_203B50

loc_203CAC:
	btst	#$C,d4
	bne.w	sub_203B50
	bra.w	sub_203B3E

play00move:
	bsr.w	mizuki_set
	tst.w	debugflag
	beq.s	loc_203CD6
	btst	#4,swdata1+1.w
	beq.s	loc_203CD6
	move.b	#1,editmode
	rts

loc_203CD6:
	tst.b	plautoflag.w
	bne.s	loc_203CF0
	move.w	swdata1.w,swdata.w
	_cmpi.b	#play00_act,actno(a0)
	beq.s	loc_203CF0
	move.w	swdata2.w,swdata.w

loc_203CF0:
	btst	#0,act2C(a0)
	bne.s	loc_203D0E
	moveq	#0,d0
	move.b	cddat(a0),d0
	andi.w	#%0110,d0
	move.w	off_203D52(pc,d0.w),d1
	jsr	off_203D52(pc,d1.w)
	bsr.w	sub_203826

loc_203D0E:
	bsr.s	playpowercnt
	tst.b	mainplayflag(a0)
	beq.s	loc_203D1A
	bsr.w	playposiwkset

loc_203D1A:
	move.b	dirstk.w,footdir(a0)
	move.b	dirstk2.w,act37(a0)
	tst.b	watercoliflag.w
	beq.s	loc_203D38
	tst.b	mstno(a0)
	bne.s	loc_203D38
	move.b	mstrestart(a0),mstno(a0)

loc_203D38:
	bsr.w	patchgmain
	tst.b	act2C(a0)
	bmi.s	loc_203D48
	jsr	pcol.l

loc_203D48:
	bsr.w	loopchk
	bsr.w	sub_203E16
	rts

off_203D52:
	dc.w	play00walk-off_203D52
	dc.w	play00jump-off_203D52
	dc.w	ball00walk-off_203D52
	dc.w	ball00jump-off_203D52

unk_203D5A:
	dc.b	bgm_zone1
	dc.b	bgm_zone2
	dc.b	bgm_zone3
	dc.b	bgm_zone4
	dc.b	bgm_zone5
	dc.b	bgm_zone6
	even

playpowercnt:
	cmpi.w	#$D2,backto_cnt.w
	bhs.s	loc_203D8C
	move.w	invulnerabilitytimer(a0),d0
	beq.s	loc_203D76
	subq.w	#1,invulnerabilitytimer(a0)
	lsr.w	#3,d0
	bhs.s	loc_203D8C

loc_203D76:
	tst.b	mainplayflag(a0)
	bne.s	loc_203D86
	btst	#0,systemtimer+3
	beq.s	loc_203D8C

loc_203D86:
	jsr	actionsub.l

loc_203D8C:
	tst.b	plpower_m
	beq.s	loc_203DDC
	tst.w	mutekitimer(a0)
	beq.s	loc_203DDC
	subq.w	#1,mutekitimer(a0)
	bne.s	loc_203DDC
	tst.b	bossstart.w
	bne.s	loc_203DD4
	cmpi.w	#$C,pl_air
	blo.s	loc_203DD4
	moveq	#0,d0
	move.b	stageno,d0
	cmpi.w	#(stage_lz<<8)+act_4,stageno
	bne.s	loc_203DC4
	moveq	#5,d0

loc_203DC4:
	lea	unk_203D5A.l,a1
	move.b	(a1,d0.w),d0
	jsr	bgmset.l

loc_203DD4:
	move.b	#0,plpower_m

loc_203DDC:
	tst.b	plpower_s
	beq.s	locret_203E14
	tst.w	speeduptimer(a0)
	beq.s	locret_203E14
	subq.w	#1,speeduptimer(a0)
	bne.s	locret_203E14
	move.w	#$600,plmaxspdwk.w
	move.w	#$C,pladdspdwk.w
	move.w	#$80,plretspdwk.w
	move.b	#0,plpower_s
	move.w	#$E3,d0
	jmp	bgmset.l

locret_203E14:
	rts

sub_203E16:
	tst.b	mainplayflag(a0)
	bne.s	locret_203E58
	move.w	scra_h_posit.w,d0
	subi.w	#$80,d0
	blo.s	loc_203E2E
	cmp.w	xposi(a0),d0
	bhi.w	frameout

loc_203E2E:
	addi.w	#$240,d0
	cmp.w	xposi(a0),d0
	blt.w	frameout
	move.w	scra_v_posit.w,d0
	subi.w	#$60,d0
	blo.s	loc_203E4C
	cmp.w	yposi(a0),d0
	bhi.w	frameout

loc_203E4C:
	addi.w	#$180,d0
	cmp.w	yposi(a0),d0
	blt.w	frameout

locret_203E58:
	rts

playposiwkset:
	move.w	plposiwkadr.w,d0
	lea	playposiwk.w,a1
	lea	(a1,d0.w),a1
	move.w	xposi(a0),(a1)+
	move.w	yposi(a0),(a1)+
	addq.b	#4,plposiwkadr+1.w
	rts

playsave:
	move.b	plflag,plflag_sb
	move.w	xposi(a0),plxposi_sb
	move.w	yposi(a0),plyposi_sb
	move.b	zone_flag.w,zone_flag_sb
	move.b	water_flag.w,water_flag_sb
	move.w	scralim_down.w,scralim_down_sb
	move.w	scra_h_posit.w,scra_h_posit_sb
	move.w	scra_v_posit.w,scra_v_posit_sb
	move.w	scrb_h_posit.w,scrb_h_posit_sb
	move.w	scrb_v_posit.w,scrb_v_posit_sb
	move.w	scrc_h_posit.w,scrc_h_posit_sb
	move.w	scrc_v_posit.w,scrc_v_posit_sb
	move.w	scrz_h_posit.w,scrz_h_posit_sb
	move.w	scrz_v_posit.w,scrz_v_posit_sb
	move.w	waterposi_m.w,waterposi_m_sb
	move.b	water_flag.w,water_flag_sb
	move.b	waterflag.w,waterflag_sb
	rts

backto_chk:
	tst.b	act2A(a0)
	bne.w	locret_203FB0
	tst.b	time_item.w
	beq.w	locret_203FB0
	move.w	plmaxspdwk.w,d2
	moveq	#0,d0
	move.w	mspeed(a0),d0
	bpl.s	loc_203F1E
	neg.w	d0

loc_203F1E:
	tst.w	backto_cnt.w
	bne.s	loc_203F2A
	move.w	#1,backto_cnt.w

loc_203F2A:
	move.w	backto_cnt.w,d1
	cmpi.w	#$E6,d1
	blo.s	loc_203F40
	move.b	#1,gameflag
	bra.w	loc_205400

loc_203F40:
	cmpi.w	#$D2,d1
	blo.s	loc_203F86
	cmpi.b	#2,plflag
	beq.s	locret_203F84
	move.b	#1,scroll_start.w
	move.b	time_flag,d0
	add.b	time_item.w,d0
	bpl.s	loc_203F66
	moveq	#0,d0
	bra.s	loc_203F6E

loc_203F66:
	cmpi.b	#3,d0
	blo.s	loc_203F6E
	moveq	#2,d0

loc_203F6E:
	bset	#7,d0
	move.b	d0,time_flag
	bsr.w	playsave
	move.b	#2,plflag

locret_203F84:
	rts

loc_203F86:
	cmpi.w	#$5A,d1
	bhs.s	loc_203F9E
	cmp.w	d2,d0
	bhs.w	muteki_set
	clr.w	backto_cnt.w
	clr.b	plpower_a
	rts

loc_203F9E:
	cmp.w	d2,d0
	bhs.s	locret_203FB0
	clr.w	backto_cnt.w
	clr.b	time_item.w
	clr.b	plpower_a

locret_203FB0:
	rts

play00walk:
	tst.b	kusya_flag.w
	beq.s	loc_203FC4
	cmpi.b	#5,mstno(a0)
	bne.s	locret_204018
	clr.b	kusya_flag.w

loc_203FC4:
	bsr.w	bye_chk
	cmpi.b	#$2B,mstno(a0)
	bne.s	loc_203FF2
	tst.b	chibi_flag.w
	beq.s	loc_203FE0
	cmpi.b	#playframe.chibihurt,patno(a0)
	bne.s	locret_204018
	bra.s	loc_203FE8

loc_203FE0:
	cmpi.b	#playframe.outofhere7,patno(a0)
	bne.s	locret_204018

loc_203FE8:
	bsr.w	limitchk
	jmp	speedset.l

loc_203FF2:
	bsr.w	backto_chk
	bsr.w	jumpchk
	bsr.w	keispd
	bsr.w	levermove
	bsr.w	ballchk
	bsr.w	limitchk
	jsr	speedset2.l
	bsr.w	fcol
	bsr.w	fallchk

locret_204018:
	rts

play00jump:
	bsr.w	backto_chk
	bsr.w	jumpchk2
	bsr.w	jumpmove
	bsr.w	limitchk
	jsr	speedset.l
	btst	#cd_underwater,cddat(a0)
	beq.s	loc_20403E
	subi.w	#$28,yspeed(a0)

loc_20403E:
	bsr.w	direcchg
	bsr.w	jumpcolchk
	rts

ball00walk:
	bsr.w	backto_chk
	bsr.w	jumpchk
	bsr.w	keispd2
	bsr.w	ballmove
	bsr.w	limitchk
	jsr	speedset2.l
	bsr.w	fcol
	bsr.w	fallchk
	rts

ball00jump:
	bsr.w	backto_chk
	bsr.w	jumpchk2
	bsr.w	jumpmove
	bsr.w	limitchk
	jsr	speedset.l
	btst	#cd_underwater,cddat(a0)
	beq.s	loc_204090
	subi.w	#$28,yspeed(a0)

loc_204090:
	bsr.w	direcchg
	bsr.w	jumpcolchk
	rts

levermove:
	move.w	plmaxspdwk.w,d6
	move.w	pladdspdwk.w,d5
	move.w	plretspdwk.w,d4
	tst.b	mizuflag.w
	bne.w	loc_204380
	tst.w	hlocktimer(a0)
	bne.w	loc_204330
	btst	#2,swdata.w
	beq.s	loc_2040C2
	bsr.w	plwalk_l

loc_2040C2:
	btst	#3,swdata.w
	beq.s	loc_2040CE
	bsr.w	plwalk_r

loc_2040CE:
	move.b	direc(a0),d0
	addi.b	#$20,d0
	andi.b	#$C0,d0
	bne.w	loc_204330
	tst.w	mspeed(a0)
	beq.s	loc_2040EC
	tst.b	act2A(a0)
	beq.w	loc_204330

loc_2040EC:
	bclr	#cd_push,cddat(a0)
	move.b	#5,mstno(a0)
	btst	#cd_ride,cddat(a0)
	beq.s	loc_204148
	moveq	#0,d0
	move.b	act3D(a0),d0
	lsl.w	#6,d0
	lea	playerwk.w,a1
	lea	(a1,d0.w),a1
	tst.b	cddat(a1)
	bmi.s	loc_20417C
	_cmpi.b	#objid_1E,actno(a1)
	bne.s	loc_204128
	move.b	#0,mstno(a0)
	bra.w	loc_204330

loc_204128:
	moveq	#0,d1
	move.b	sprhsize(a1),d1
	move.w	d1,d2
	add.w	d2,d2
	subq.w	#4,d2
	add.w	xposi(a0),d1
	sub.w	xposi(a1),d1
	cmpi.w	#4,d1
	blt.s	loc_20416C
	cmp.w	d2,d1
	bge.s	loc_20415C
	bra.s	loc_20417C

loc_204148:
	jsr	emycol_d.l
	cmpi.w	#$C,d1
	blt.s	loc_20417C
	cmpi.b	#3,footdir(a0)
	bne.s	loc_204164

loc_20415C:
	bclr	#cd_left,cddat(a0)
	bra.s	loc_204172

loc_204164:
	cmpi.b	#3,act37(a0)
	bne.s	loc_20417C

loc_20416C:
	bset	#cd_left,cddat(a0)

loc_204172:
	move.b	#6,mstno(a0)
	bra.w	loc_204330

loc_20417C:
	tst.b	mainplayflag(a0)
	beq.w	loc_2041E4
	move.b	scr_cnt.w,d0
	andi.b	#$F,d0
	beq.s	loc_204198
	addq.b	#1,scr_cnt.w
	andi.b	#$CF,scr_cnt.w

loc_204198:
	btst	#7,scr_cnt.w
	bne.w	loc_204264
	btst	#6,scr_cnt.w
	bne.w	loc_20428C
	btst	#1,swdata.w
	bne.w	loc_20428C
	andi.b	#$F,scr_cnt.w
	beq.s	loc_2041D0
	btst	#0,swdata+1.w
	beq.s	loc_2041E4
	bset	#7,scr_cnt.w
	bra.w	loc_204354

loc_2041D0:
	btst	#0,swdata+1.w
	beq.w	loc_2041E4
	move.b	#1,scr_cnt.w
	bra.w	loc_204354

loc_2041E4:
	btst	#0,swdata.w
	beq.s	loc_204224
	move.b	#7,mstno(a0)
	tst.b	act2A(a0)
	beq.s	loc_204210
	move.b	#0,mstno(a0)
	moveq	#$19,d0
	btst	#cd_left,cddat(a0)
	beq.s	loc_20420A
	neg.w	d0

loc_20420A:
	add.w	d0,mspeed(a0)
	rts

loc_204210:
	move.b	swdata+1.w,d0
	andi.b	#$70,d0
	beq.s	loc_204220
	move.b	#1,act2A(a0)

loc_204220:
	bra.w	loc_204354

loc_204224:
	cmpi.b	#60,act2A(a0)
	beq.s	loc_20423A
	move.b	#0,act2A(a0)
	move.w	#0,mspeed(a0)
	bra.s	loc_20428C

loc_20423A:
	move.b	#61,act2A(a0)
	move.w	plmaxspdwk.w,d6
	move.w	pladdspdwk.w,d5
	move.w	plretspdwk.w,d4
	btst	#cd_left,cddat(a0)
	bne.s	loc_20425C
	bsr.w	plwalk_r
	bra.w	loc_204330

loc_20425C:
	bsr.w	plwalk_l
	bra.w	loc_204330

loc_204264:
	btst	#0,swdata.w
	beq.s	loc_20428C
	move.b	#7,mstno(a0)
	tst.b	mainplayflag(a0)
	beq.w	loc_20430E
	cmpi.w	#200,scra_vline.w
	beq.w	loc_204354
	addq.w	#2,scra_vline.w
	bra.w	loc_204354

loc_20428C:
	tst.b	mainplayflag(a0)
	beq.s	loc_2042C8
	btst	#6,scr_cnt.w
	bne.w	loc_20430E
	andi.b	#$F,scr_cnt.w
	beq.s	loc_2042B6
	btst	#1,swdata+1.w
	beq.s	loc_2042C8
	bset	#6,scr_cnt.w
	bra.w	loc_204354

loc_2042B6:
	btst	#1,swdata+1.w
	beq.s	loc_2042C8
	move.b	#1,scr_cnt.w
	bra.w	loc_204354

loc_2042C8:
	btst	#1,swdata.w
	beq.s	loc_204330
	move.b	#8,mstno(a0)
	tst.b	act2A(a0)
	bne.s	loc_20430C
	move.b	swdata+1.w,d0
	andi.b	#$70,d0
	beq.s	loc_20430C
	move.b	#1,act2A(a0)
	move.w	#$16,mspeed(a0)
	btst	#cd_left,cddat(a0)
	beq.s	loc_2042FE
	neg.w	mspeed(a0)

loc_2042FE:
	move.w	#$9C,d0
	jsr	soundset.l
	bsr.w	ballset

loc_20430C:
	bra.s	loc_204354

loc_20430E:
	btst	#1,swdata.w
	beq.s	loc_204330
	move.b	#8,mstno(a0)
	tst.b	mainplayflag(a0)
	beq.s	loc_204354
	cmpi.w	#8,scra_vline.w
	beq.s	loc_204354
	subq.w	#2,scra_vline.w
	bra.s	loc_204354

loc_204330:
	cmpi.w	#$60,scra_vline.w
	bne.s	loc_20434A
	move.b	scr_cnt.w,d0
	andi.b	#$F,d0
	bne.s	loc_204354
	move.b	#0,scr_cnt.w
	bra.s	loc_204354

loc_20434A:
	bhs.s	loc_204350
	addq.w	#4,scra_vline.w

loc_204350:
	subq.w	#2,scra_vline.w

loc_204354:
	move.b	swdata.w,d0
	andi.b	#$C,d0
	bne.s	loc_204380
	move.w	mspeed(a0),d0
	beq.s	loc_204380
	bmi.s	loc_204374
	sub.w	d5,d0
	bhs.s	loc_20436E
	move.w	#0,d0
loc_20436E:
	move.w	d0,mspeed(a0)
	bra.s	loc_204380

loc_204374:
	add.w	d5,d0
	bhs.s	loc_20437C
	move.w	#0,d0

loc_20437C:
	move.w	d0,mspeed(a0)

loc_204380:
	move.b	direc(a0),d0
	jsr	sinset.l
	muls.w	mspeed(a0),d1
	asr.l	#8,d1
	move.w	d1,xspeed(a0)
	muls.w	mspeed(a0),d0
	asr.l	#8,d0
	move.w	d0,yspeed(a0)

lmovecol:
	move.b	direc(a0),d0
	addi.b	#$40,d0
	bmi.s	locret_20440E
	move.b	#$40,d1
	tst.w	mspeed(a0)
	beq.s	locret_20440E
	bmi.s	loc_2043B6
	neg.w	d1

loc_2043B6:
	move.b	direc(a0),d0
	add.b	d1,d0
	move.w	d0,-(sp)
	bsr.w	dircol
	move.w	(sp)+,d0
	tst.w	d1
	bpl.s	locret_20440E
	asl.w	#8,d1
	addi.b	#$20,d0
	andi.b	#$C0,d0
	beq.s	loc_20440A
	cmpi.b	#$40,d0
	beq.s	loc_2043F8
	cmpi.b	#$80,d0
	beq.s	loc_2043F2
	add.w	d1,xspeed(a0)
	bset	#cd_push,cddat(a0)
	move.w	#0,mspeed(a0)
	rts

loc_2043F2:
	sub.w	d1,yspeed(a0)
	rts

loc_2043F8:
	sub.w	d1,xspeed(a0)
	bset	#cd_push,cddat(a0)
	move.w	#0,mspeed(a0)
	rts

loc_20440A:
	add.w	d1,yspeed(a0)

locret_20440E:
	rts

plwalk_l:
	move.w	mspeed(a0),d0
	beq.s	loc_204418
	bpl.s	loc_204460

loc_204418:
	tst.b	act2A(a0)
	beq.s	loc_204434
	cmpi.b	#61,act2A(a0)
	bne.s	locret_204496
	bset	#2,swdata.w
	lsl.w	#7,d5
	move.b	#0,act2A(a0)

loc_204434:
	bset	#cd_left,cddat(a0)
	bne.s	loc_204448
	bclr	#cd_push,cddat(a0)
	move.b	#1,mstrestart(a0)

loc_204448:
	sub.w	d5,d0
	move.w	d6,d1
	neg.w	d1
	cmp.w	d1,d0
	bgt.s	loc_204454
	move.w	d1,d0

loc_204454:
	move.w	d0,mspeed(a0)
	move.b	#0,mstno(a0)
	rts

loc_204460:
	sub.w	d4,d0
	bhs.s	loc_204468
	move.w	#-$80,d0

loc_204468:
	move.w	d0,mspeed(a0)
	move.b	direc(a0),d0
	addi.b	#$20,d0
	andi.b	#$C0,d0
	bne.s	locret_204496
	cmpi.w	#$400,d0
	blt.s	locret_204496
	move.b	#$D,mstno(a0)
	bclr	#cd_left,cddat(a0)
	move.w	#$90,d0
	jsr	soundset.l

locret_204496:
	rts

plwalk_r:
	move.w	mspeed(a0),d0
	bmi.s	loc_2044E2
	tst.b	act2A(a0)
	beq.s	loc_2044BA
	cmpi.b	#61,act2A(a0)
	bne.s	locret_204518
	bset	#3,swdata.w
	lsl.w	#7,d5
	move.b	#0,act2A(a0)

loc_2044BA:
	bclr	#cd_left,cddat(a0)
	beq.s	loc_2044CE
	bclr	#cd_push,cddat(a0)
	move.b	#1,mstrestart(a0)

loc_2044CE:
	add.w	d5,d0
	cmp.w	d6,d0
	blt.s	loc_2044D6
	move.w	d6,d0

loc_2044D6:
	move.w	d0,mspeed(a0)
	move.b	#0,mstno(a0)
	rts

loc_2044E2:
	add.w	d4,d0
	bhs.s	loc_2044EA
	move.w	#$80,d0

loc_2044EA:
	move.w	d0,mspeed(a0)
	move.b	direc(a0),d0
	addi.b	#$20,d0
	andi.b	#$C0,d0
	bne.s	locret_204518
	cmpi.w	#-$400,d0
	bgt.s	locret_204518
	move.b	#$D,mstno(a0)
	bset	#cd_left,cddat(a0)
	move.w	#$90,d0
	jsr	soundset.l

locret_204518:
	rts

ballmove:
	move.w	plmaxspdwk.w,d6
	asl.w	#1,d6
	move.w	pladdspdwk.w,d5
	asr.w	#1,d5
	move.w	plretspdwk.w,d4
	asr.w	#2,d4
	tst.b	mizuflag.w
	bne.w	loc_204640
	tst.w	hlocktimer(a0)
	bne.s	loc_204552
	btst	#2,swdata.w
	beq.s	loc_204546
	bsr.w	ballwalk_l

loc_204546:
	btst	#3,swdata.w
	beq.s	loc_204552
	bsr.w	ballwalk_r

loc_204552:
	tst.b	act2A(a0)
	beq.w	loc_2045E8
	move.w	#$19,d0
	move.w	plmaxspdwk.w,d1
	asl.w	#1,d1
	btst	#cd_left,cddat(a0)
	beq.s	loc_204570
	neg.w	d0
	neg.w	d1

loc_204570:
	add.w	d0,mspeed(a0)
	move.w	mspeed(a0),d0
	cmp.w	d1,d0
	bgt.s	loc_20457E
	move.w	d1,d0

loc_20457E:
	move.w	d0,mspeed(a0)
	btst	#1,swdata.w
	beq.s	loc_2045BA
	move.b	swdata+1.w,d0
	andi.b	#$70,d0
	beq.s	locret_2045E6

loc_204594:
	move.w	#$AB,d0
	jsr	soundset.l
	move.b	#0,act2A(a0)
	move.w	#0,mspeed(a0)
	move.w	#0,xspeed(a0)
	move.w	#0,yspeed(a0)
	bra.w	loc_204610

loc_2045BA:
	cmpi.b	#60,act2A(a0)
	bne.s	loc_204594
	move.b	#0,act2A(a0)
	move.w	#$91,d0
	jsr	soundset.l
	btst	#cd_left,cddat(a0)
	bne.s	loc_2045E0
	bsr.w	ballwalk_r
	bra.s	loc_2045E8

loc_2045E0:
	bsr.w	ballwalk_l
	bra.s	loc_2045E8

locret_2045E6:
	rts

loc_2045E8:
	move.w	mspeed(a0),d0
	beq.s	loc_20460A
	bmi.s	loc_2045FE
	sub.w	d5,d0
	bhs.s	loc_2045F8
	move.w	#0,d0

loc_2045F8:
	move.w	d0,mspeed(a0)
	bra.s	loc_20460A

loc_2045FE:
	add.w	d5,d0
	bhs.s	loc_204606
	move.w	#0,d0

loc_204606:
	move.w	d0,mspeed(a0)

loc_20460A:
	tst.w	mspeed(a0)
	bne.s	loc_204640

loc_204610:
	bclr	#cd_ball,cddat(a0)
	tst.b	chibi_flag.w
	beq.s	loc_20462A
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)
	bra.s	loc_20463A

loc_20462A:
	move.b	#walkheight,sprvsize(a0)
	move.b	#walkwidth,sprhs(a0)
	subq.w	#walkheight-rollheight,yposi(a0)

loc_20463A:
	move.b	#5,mstno(a0)

loc_204640:
	move.b	direc(a0),d0
	jsr	sinset.l
	muls.w	mspeed(a0),d0
	asr.l	#8,d0
	move.w	d0,yspeed(a0)
	muls.w	mspeed(a0),d1
	asr.l	#8,d1
	cmpi.w	#$1000,d1
	ble.s	loc_204664
	move.w	#$1000,d1

loc_204664:
	cmpi.w	#-$1000,d1
	bge.s	loc_20466E
	move.w	#-$1000,d1

loc_20466E:
	move.w	d1,xspeed(a0)
	bra.w	lmovecol

ballwalk_l:
	move.w	mspeed(a0),d0
	beq.s	loc_20467E
	bpl.s	loc_20468C

loc_20467E:
	bset	#cd_left,cddat(a0)
	move.b	#2,mstno(a0)
	rts

loc_20468C:
	sub.w	d4,d0
	bhs.s	loc_204694
	move.w	#-$80,d0

loc_204694:
	move.w	d0,mspeed(a0)
	rts

ballwalk_r:
	move.w	mspeed(a0),d0
	bmi.s	loc_2046AE
	bclr	#cd_left,cddat(a0)
	move.b	#2,mstno(a0)
	rts

loc_2046AE:
	add.w	d4,d0
	bhs.s	loc_2046B6
	move.w	#$80,d0

loc_2046B6:
	move.w	d0,mspeed(a0)
	rts

jumpmove:
	move.w	plmaxspdwk.w,d6
	move.w	pladdspdwk.w,d5
	asl.w	#1,d5
	btst	#cd_ballj,cddat(a0)
	bne.s	loc_204706
	move.w	xspeed(a0),d0
	btst	#2,swdata.w
	beq.s	loc_2046EC
	bset	#cd_left,cddat(a0)
	sub.w	d5,d0
	move.w	d6,d1
	neg.w	d1
	cmp.w	d1,d0
	bgt.s	loc_2046EC
	move.w	d1,d0

loc_2046EC:
	btst	#3,swdata.w
	beq.s	loc_204702
	bclr	#cd_left,cddat(a0)
	add.w	d5,d0
	cmp.w	d6,d0
	blt.s	loc_204702
	move.w	d6,d0

loc_204702:
	move.w	d0,xspeed(a0)

loc_204706:
	tst.b	mainplayflag(a0)
	beq.s	loc_20471E
	cmpi.w	#$60,scra_vline.w
	beq.s	loc_20471E
	bhs.s	loc_20471A
	addq.w	#4,scra_vline.w

loc_20471A:
	subq.w	#2,scra_vline.w

loc_20471E:
	cmpi.w	#-$400,yspeed(a0)
	blo.s	locret_20474C
	move.w	xspeed(a0),d0
	move.w	d0,d1
	asr.w	#5,d1
	beq.s	locret_20474C
	bmi.s	loc_204740
	sub.w	d1,d0
	bhs.s	loc_20473A
	move.w	#0,d0

loc_20473A:
	move.w	d0,xspeed(a0)
	rts

loc_204740:
	sub.w	d1,d0
	blo.s	loc_204748
	move.w	#0,d0

loc_204748:
	move.w	d0,xspeed(a0)

locret_20474C:
	rts

hedcolchk:
	move.b	direc(a0),d0
	addi.b	#$20,d0
	andi.b	#$C0,d0
	bne.s	locret_20477C
	bsr.w	dircol_u
	tst.w	d1
	bpl.s	locret_20477C
	move.w	#0,mspeed(a0)
	move.w	#0,xspeed(a0)
	move.w	#0,yspeed(a0)
	move.b	#$B,mstno(a0)

locret_20477C:
	rts

limitchk:
	move.l	xposi(a0),d1
	move.w	xspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d1
	swap	d1
	move.w	scralim_left.w,d0
	addi.w	#$10,d0
	cmp.w	d1,d0
	bhi.s	loc_2047C4
	move.w	scralim_right.w,d0
	addi.w	#$128,d0
	tst.b	bossstart.w
	bne.s	loc_2047AC
	addi.w	#$40,d0

loc_2047AC:
	cmp.w	d1,d0
	bls.s	loc_2047C4

loc_2047B0:
	move.w	scralim_down.w,d0
	addi.w	#224,d0
	cmp.w	yposi(a0),d0
	blt.s	loc_2047C0
	rts

loc_2047C0:
	bra.w	playdieset

loc_2047C4:
	move.w	d0,xposi(a0)
	move.w	#0,xposi+2(a0)
	move.w	#0,xspeed(a0)
	move.w	#0,mspeed(a0)
	bra.s	loc_2047B0

ballchk:
	tst.b	mizuflag.w
	bne.s	locret_204802
	move.w	mspeed(a0),d0
	bpl.s	loc_2047EA
	neg.w	d0

loc_2047EA:
	cmpi.w	#$80,d0
	blo.s	locret_204802
	move.b	swdata.w,d0
	andi.b	#$C,d0
	bne.s	locret_204802
	btst	#1,swdata.w
	bne.s	ballset

locret_204802:
	rts

ballset:
	btst	#cd_ball,cddat(a0)
	beq.s	loc_20480E
	rts

loc_20480E:
	bset	#cd_ball,cddat(a0)
	tst.b	chibi_flag.w
	beq.s	loc_204828
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)
	bra.s	loc_204838

loc_204828:
	move.b	#rollheight,sprvsize(a0)
	move.b	#rollwidth,sprhs(a0)
	addq.w	#walkheight-rollheight,yposi(a0)

loc_204838:
	move.b	#2,mstno(a0)
	tst.w	mspeed(a0)
	bne.s	locret_20484A
	move.w	#$200,mspeed(a0)

locret_20484A:
	rts

jumpchk:
	tst.b	act2A(a0)
	beq.s	loc_204876
	move.b	swdata+1.w,d0
	andi.b	#$70,d0
	beq.s	loc_204876
	move.b	#0,act2A(a0)
	move.w	#0,mspeed(a0)
	move.w	#0,xspeed(a0)
	move.w	#0,yspeed(a0)
	bra.s	loc_204888

loc_204876:
	move.b	swdata.w,d0
	andi.b	#3,d0
	beq.s	loc_204888
	tst.w	mspeed(a0)
	beq.w	locret_204964

loc_204888:
	move.b	swdata+1.w,d0
	andi.b	#$70,d0
	beq.w	locret_204964
	btst	#cd_ride,cddat(a0)
	beq.s	loc_2048A4
	jsr	frip_spd.l
	beq.s	loc_2048D4

loc_2048A4:
	moveq	#0,d0
	move.b	direc(a0),d0
	addi.b	#$80,d0
	bsr.w	dircol2
	cmpi.w	#6,d1
	blt.w	locret_204964
	move.w	#$680,d2
	btst	#cd_underwater,cddat(a0)
	beq.s	loc_2048CA
	move.w	#$380,d2

loc_2048CA:
	moveq	#0,d0
	move.b	direc(a0),d0
	subi.b	#$40,d0

loc_2048D4:
	jsr	sinset.l
	muls.w	d2,d1
	asr.l	#8,d1
	add.w	d1,xspeed(a0)
	muls.w	d2,d0
	asr.l	#8,d0
	add.w	d0,yspeed(a0)
	bset	#cd_jump,cddat(a0)
	bclr	#cd_push,cddat(a0)
	addq.l	#4,sp
	move.b	#1,jumpflag(a0)
	clr.b	convexflag(a0)
	move.w	#$92,d0
	jsr	soundset.l
	tst.b	chibi_flag.w
	beq.s	loc_204920
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)
	bra.s	loc_20492C

loc_204920:
	move.b	#walkheight,sprvsize(a0)
	move.b	#walkwidth,sprhs(a0)

loc_20492C:
	btst	#cd_ball,cddat(a0)
	bne.s	loc_204966
	tst.b	chibi_flag.w
	beq.s	loc_204948
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)
	bra.s	loc_204958

loc_204948:
	move.b	#rollheight,sprvsize(a0)
	move.b	#rollwidth,sprhs(a0)
	addq.w	#walkheight-rollheight,yposi(a0)

loc_204958:
	bset	#cd_ball,cddat(a0)
	move.b	#2,mstno(a0)

locret_204964:
	rts

loc_204966:
	bset	#cd_ballj,cddat(a0)
	rts

jumpchk2:
	tst.b	jumpflag(a0)
	beq.s	loc_2049A0
	move.w	#-$400,d1
	btst	#cd_underwater,cddat(a0)
	beq.s	loc_204984
	move.w	#-$200,d1

loc_204984:
	cmp.w	yspeed(a0),d1
	ble.s	locret_20499E
	move.b	swdata.w,d0
	andi.b	#$70,d0
	bne.s	locret_20499E
	move.b	#0,act2A(a0)
	move.w	d1,yspeed(a0)

locret_20499E:
	rts

loc_2049A0:
	cmpi.w	#-$FC0,yspeed(a0)
	bge.s	locret_2049AE
	move.w	#-$FC0,yspeed(a0)

locret_2049AE:
	rts

keispd:
	tst.b	act2A(a0)
	bne.s	locret_2049EA
	move.b	direc(a0),d0
	addi.b	#$60,d0
	cmpi.b	#$C0,d0
	bhs.s	locret_2049EA
	move.b	direc(a0),d0
	jsr	sinset.l
	muls.w	#$20,d0
	asr.l	#8,d0
	tst.w	mspeed(a0)
	beq.s	locret_2049EA
	bmi.s	loc_2049E6
	tst.w	d0
	beq.s	locret_2049E4
	add.w	d0,mspeed(a0)

locret_2049E4:
	rts

loc_2049E6:
	add.w	d0,mspeed(a0)

locret_2049EA:
	rts

keispd2:
	tst.b	act2A(a0)
	bne.s	locret_204A2C
	move.b	direc(a0),d0
	addi.b	#$60,d0
	cmpi.b	#$C0,d0
	bhs.s	locret_204A2C
	move.b	direc(a0),d0
	jsr	sinset.l
	muls.w	#$50,d0
	asr.l	#8,d0
	tst.w	mspeed(a0)
	bmi.s	loc_204A22
	tst.w	d0
	bpl.s	loc_204A1C
	asr.l	#2,d0

loc_204A1C:
	add.w	d0,mspeed(a0)
	rts

loc_204A22:
	tst.w	d0
	bmi.s	loc_204A28
	asr.l	#2,d0

loc_204A28:
	add.w	d0,mspeed(a0)

locret_204A2C:
	rts

fallchk:
	nop
	tst.b	convexflag(a0)
	bne.s	locret_204A68
	tst.w	hlocktimer(a0)
	bne.s	loc_204A6A
	move.b	direc(a0),d0
	addi.b	#$20,d0
	andi.b	#$C0,d0
	beq.s	locret_204A68
	move.w	mspeed(a0),d0
	bpl.s	loc_204A52
	neg.w	d0

loc_204A52:
	cmpi.w	#$280,d0
	bhs.s	locret_204A68
	clr.w	mspeed(a0)
	bset	#cd_walk,cddat(a0)
	move.w	#30,hlocktimer(a0)

locret_204A68:
	rts

loc_204A6A:
	subq.w	#1,hlocktimer(a0)
	rts

direcchg:
	move.b	direc(a0),d0
	beq.s	locret_204A8A
	bpl.s	loc_204A80
	addq.b	#2,d0
	bhs.s	loc_204A7E
	moveq	#0,d0

loc_204A7E:
	bra.s	loc_204A86

loc_204A80:
	subq.b	#2,d0
	bhs.s	loc_204A86
	moveq	#0,d0

loc_204A86:
	move.b	d0,direc(a0)

locret_204A8A:
	rts

jumpcolchk:
	move.w	xspeed(a0),d1
	move.w	yspeed(a0),d2
	jsr	atan.l
	move.b	d0,debugwork
	subi.b	#$20,d0
	move.b	d0,debugwork2
	andi.b	#$C0,d0
	move.b	d0,debugwork3
	cmpi.b	#$40,d0
	beq.w	loc_204B70
	cmpi.b	#$80,d0
	beq.w	loc_204BD2
	cmpi.b	#$C0,d0
	beq.w	loc_204C2E
	bsr.w	dircol_l2
	tst.w	d1
	bpl.s	loc_204ADE
	sub.w	d1,xposi(a0)
	move.w	#0,xspeed(a0)

loc_204ADE:
	bsr.w	dircol_r2
	tst.w	d1
	bpl.s	loc_204AF0
	add.w	d1,xposi(a0)
	move.w	#0,xspeed(a0)

loc_204AF0:
	bsr.w	dircol_d
	move.b	d1,debugwork4
	tst.w	d1
	bpl.s	locret_204B6E
	move.b	yspeed(a0),d2
	addq.b	#8,d2
	neg.b	d2
	cmp.b	d2,d1
	bge.s	loc_204B0E
	cmp.b	d2,d0
	blt.s	locret_204B6E

loc_204B0E:
	add.w	d1,yposi(a0)
	move.b	d3,direc(a0)
	bsr.w	jumpcolsub
	move.b	#0,mstno(a0)
	move.b	d3,d0
	addi.b	#$20,d0
	andi.b	#$40,d0
	bne.s	loc_204B4C
	move.b	d3,d0
	addi.b	#$10,d0
	andi.b	#$20,d0
	beq.s	loc_204B3E
	asr.w	yspeed(a0)
	bra.s	loc_204B60

loc_204B3E:
	move.w	#0,yspeed(a0)
	move.w	xspeed(a0),mspeed(a0)
	rts

loc_204B4C:
	move.w	#0,xspeed(a0)
	cmpi.w	#$FC0,yspeed(a0)
	ble.s	loc_204B60
	move.w	#$FC0,yspeed(a0)

loc_204B60:
	move.w	yspeed(a0),mspeed(a0)
	tst.b	d3
	bpl.s	locret_204B6E
	neg.w	mspeed(a0)

locret_204B6E:
	rts

loc_204B70:
	bsr.w	dircol_l2
	tst.w	d1
	bpl.s	loc_204B8A
	sub.w	d1,xposi(a0)
	move.w	#0,xspeed(a0)
	move.w	yspeed(a0),mspeed(a0)
	rts

loc_204B8A:
	bsr.w	dircol_u
	tst.w	d1
	bpl.s	loc_204BA4
	sub.w	d1,yposi(a0)
	tst.w	yspeed(a0)
	bpl.s	locret_204BA2
	move.w	#0,yspeed(a0)

locret_204BA2:
	rts

loc_204BA4:
	tst.w	yspeed(a0)
	bmi.s	locret_204BD0
	bsr.w	dircol_d
	tst.w	d1
	bpl.s	locret_204BD0
	add.w	d1,yposi(a0)
	move.b	d3,direc(a0)
	bsr.w	jumpcolsub
	move.b	#0,mstno(a0)
	move.w	#0,yspeed(a0)
	move.w	xspeed(a0),mspeed(a0)

locret_204BD0:
	rts

loc_204BD2:
	bsr.w	dircol_l2
	tst.w	d1
	bpl.s	loc_204BE4
	sub.w	d1,xposi(a0)
	move.w	#0,xspeed(a0)

loc_204BE4:
	bsr.w	dircol_r2
	tst.w	d1
	bpl.s	loc_204BF6
	add.w	d1,xposi(a0)
	move.w	#0,xspeed(a0)

loc_204BF6:
	bsr.w	dircol_u
	tst.w	d1
	bpl.s	locret_204C2C
	sub.w	d1,yposi(a0)
	move.b	d3,d0
	addi.b	#$20,d0
	andi.b	#$40,d0
	bne.s	loc_204C16
	move.w	#0,yspeed(a0)
	rts

loc_204C16:
	move.b	d3,direc(a0)
	bsr.w	jumpcolsub
	move.w	yspeed(a0),mspeed(a0)
	tst.b	d3
	bpl.s	locret_204C2C
	neg.w	mspeed(a0)

locret_204C2C:
	rts

loc_204C2E:
	bsr.w	dircol_r2
	tst.w	d1
	bpl.s	loc_204C48
	add.w	d1,xposi(a0)
	move.w	#0,xspeed(a0)
	move.w	yspeed(a0),mspeed(a0)
	rts

loc_204C48:
	bsr.w	dircol_u
	tst.w	d1
	bpl.s	loc_204C62
	sub.w	d1,yposi(a0)
	tst.w	yspeed(a0)
	bpl.s	locret_204C60
	move.w	#0,yspeed(a0)

locret_204C60:
	rts

loc_204C62:
	tst.w	yspeed(a0)
	bmi.s	locret_204C8E
	bsr.w	dircol_d
	tst.w	d1
	bpl.s	locret_204C8E
	add.w	d1,yposi(a0)
	move.b	d3,direc(a0)
	bsr.w	jumpcolsub
	move.b	#0,mstno(a0)
	move.w	#0,yspeed(a0)
	move.w	xspeed(a0),mspeed(a0)

locret_204C8E:
	rts

jumpcolsub:
	btst	#cd_ballj,cddat(a0)
	beq.s	loc_204C9A
	nop

loc_204C9A:
	bclr	#cd_push,cddat(a0)
	bclr	#cd_jump,cddat(a0)
	bclr	#cd_ballj,cddat(a0)
	btst	#cd_ball,cddat(a0)
	beq.s	loc_204CE4
	bclr	#cd_ball,cddat(a0)
	tst.b	chibi_flag.w
	beq.s	loc_204CCE
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)
	bra.s	loc_204CDE

loc_204CCE:
	move.b	#walkheight,sprvsize(a0)
	move.b	#walkwidth,sprhs(a0)
	subq.w	#walkheight-rollheight,yposi(a0)

loc_204CDE:
	move.b	#0,mstno(a0)

loc_204CE4:
	move.b	#0,jumpflag(a0)
	move.w	#0,emyscorecnt.w
	rts

play00damage:
	jsr	speedset2.l
	addi.w	#$30,yspeed(a0)
	btst	#cd_underwater,cddat(a0)
	beq.s	loc_204D0C
	subi.w	#$20,yspeed(a0)

loc_204D0C:
	bsr.w	play00damage_sub
	bsr.w	limitchk
	bsr.w	playposiwkset
	bsr.w	patchgmain
	jmp	actionsub.l

play00damage_sub:
	move.w	scralim_down.w,d0
	addi.w	#224,d0
	cmp.w	yposi(a0),d0
	blo.w	playdieset
	bsr.w	jumpcolchk
	btst	#cd_jump,cddat(a0)
	bne.s	locret_204D5C
	moveq	#0,d0
	move.w	d0,yspeed(a0)
	move.w	d0,xspeed(a0)
	move.w	d0,mspeed(a0)
	move.b	#0,mstno(a0)
	subq.b	#word,r_no0(a0)
	move.w	#120,invulnerabilitytimer(a0)

locret_204D5C:
	rts

play00die:
	bsr.w	play00die_sub
	jsr	speedset.l
	bsr.w	playposiwkset
	bsr.w	patchgmain
	jmp	actionsub.l

play00die_sub:
	move.w	scralim_down.w,d0
	addi.w	#$100,d0
	cmp.w	yposi(a0),d0
	bhs.w	locret_204DB8
	move.w	#-$38,yspeed(a0)
	addq.b	#word,r_no0(a0)
	clr.b	pltime_f
	addq.b	#1,pl_suu_f
	subq.b	#1,pl_suu

loc_204DA2:
	move.w	#60,act3A(a0)
	tst.b	pltimeover_f
	beq.s	locret_204DB8
	move.w	#0,act3A(a0)
	bra.s	loc_204DA2

locret_204DB8:
	rts

play00erase:
	tst.w	act3A(a0)
	beq.s	locret_204E16
	subq.w	#1,act3A(a0)
	bne.s	locret_204E16
	move.w	#1,gameflag
	lea	byte_FFD040.w,a5
	_cmpi.b	#play00_act,actno(a0)
	beq.s	loc_204DDE
	lea	actwk.w,a5

loc_204DDE:
	_tst.b	actno(a5)
	beq.w	loc_204DFA
	move.w	#0,gameflag
	eori.b	#1,main_play
	bra.w	frameout

loc_204DFA:
	clr.l	flowerwk
	move.w	#scpu_fadeCDA,d0
	tst.b	pl_suu
	beq.s	loc_204E12
	clr.w	word_FF12F4

loc_204E12:
	bra.w	sub_sync

locret_204E16:
	rts

loopchk:
	cmpi.b	#stage_slz,stageno
	beq.s	loc_204E2C
	tst.b	stageno
	bne.w	locret_204EE2

loc_204E2C:
	move.w	yposi(a0),d0
	lsr.w	#1,d0
	andi.w	#$380,d0
	move.b	xposi(a0),d1
	andi.w	#$7F,d1
	add.w	d1,d0
	lea	mapwka.w,a1
	move.b	(a1,d0.w),d1
	cmp.b	ballmapno.w,d1
	bne.s	loc_204E6A
	tst.b	stageno
	bne.w	loc_204EE4
	move.w	yposi(a0),d0
	andi.w	#$FF,d0
	cmpi.w	#$90,d0
	bhs.w	loc_204EE4
	bra.s	loc_204E72

loc_204E6A:
	cmp.b	ballmapno2.w,d1
	beq.w	loc_204EE4

loc_204E72:
	cmp.b	loopmapno.w,d1
	beq.s	loc_204E96
	cmp.b	loopmapno2.w,d1
	beq.s	loc_204E86
	bclr	#6,actflg(a0)
	rts

loc_204E86:
	btst	#cd_jump,cddat(a0)
	beq.s	loc_204E96
	bclr	#6,actflg(a0)
	rts

loc_204E96:
	move.w	xposi(a0),d2
	cmpi.b	#$2C,d2
	bhs.s	loc_204EA8
	bclr	#6,actflg(a0)
	rts

loc_204EA8:
	cmpi.b	#$E0,d2
	blo.s	loc_204EB6
	bset	#6,actflg(a0)
	rts

loc_204EB6:
	btst	#6,actflg(a0)
	bne.s	loc_204ED2
	move.b	direc(a0),d1
	beq.s	locret_204EE2
	cmpi.b	#$80,d1
	bhi.s	locret_204EE2
	bset	#6,actflg(a0)
	rts

loc_204ED2:
	move.b	direc(a0),d1
	cmpi.b	#$80,d1
	bls.s	locret_204EE2
	bclr	#6,actflg(a0)

locret_204EE2:
	rts

loc_204EE4:
	move.w	#$9C,d0
	jsr	soundset.l
	jmp	ballset.l

patchgmain:
	lea	playchg.l,a1
	moveq	#0,d0
	move.b	mstno(a0),d0
	cmp.b	mstrestart(a0),d0
	beq.s	loc_204F16
	move.b	d0,mstrestart(a0)
	move.b	#0,patcnt(a0)
	move.b	#0,pattim(a0)

loc_204F16:
	bsr.w	little_patchg
	add.w	d0,d0
	adda.w	(a1,d0.w),a1
	move.b	(a1),d0
	bmi.s	playrunchg
	move.b	cddat(a0),d1
	andi.b	#1,d1
	andi.b	#%11111100,actflg(a0)
	or.b	d1,actflg(a0)
	subq.b	#1,pattim(a0)
	bpl.s	locret_204F5C
	move.b	d0,pattim(a0)

patchgmain2:
	moveq	#0,d1
	move.b	patcnt(a0),d1
	move.b	1(a1,d1.w),d0
	beq.s	loc_204F54
	bpl.s	loc_204F54
	cmpi.b	#$FD,d0
	bge.s	loc_204F5E

loc_204F54:
	move.b	d0,patno(a0)
	addq.b	#1,patcnt(a0)

locret_204F5C:
	rts

loc_204F5E:
	addq.b	#1,d0
	bne.s	loc_204F6E
	move.b	#0,patcnt(a0)
	move.b	1(a1),d0
	bra.s	loc_204F54

loc_204F6E:
	addq.b	#1,d0
	bne.s	loc_204F82
	move.b	2(a1,d1.w),d0
	sub.b	d0,patcnt(a0)
	sub.b	d0,d1
	move.b	1(a1,d1.w),d0
	bra.s	loc_204F54

loc_204F82:
	addq.b	#1,d0
	bne.s	locret_204F8C
	move.b	2(a1,d1.w),mstno(a0)

locret_204F8C:
	rts

playrunchg:
	subq.b	#1,pattim(a0)
	bpl.s	locret_204F5C
	addq.b	#1,d0
	bne.w	playrunchg2
	tst.b	chibi_flag.w
	bne.w	little_runchg
	moveq	#0,d1
	move.b	direc(a0),d0
	move.b	cddat(a0),d2
	andi.b	#1,d2
	bne.s	loc_204FB4
	not.b	d0

loc_204FB4:
	addi.b	#$10,d0
	bpl.s	loc_204FBC
	moveq	#3,d1

loc_204FBC:
	andi.b	#%11111100,actflg(a0)
	eor.b	d1,d2
	or.b	d2,actflg(a0)
	btst	#cd_push,cddat(a0)
	bne.w	loc_20506A
	lsr.b	#4,d0
	andi.b	#6,d0
	move.w	mspeed(a0),d2
	bpl.s	loc_204FE0
	neg.w	d2

loc_204FE0:
	lea	plchg01.l,a1
	cmpi.w	#$600,d2
	bhs.s	loc_204FF8
	lea	plchg00.l,a1
	move.b	d0,d1
	lsr.b	#1,d1
	add.b	d1,d0

loc_204FF8:
	add.b	d0,d0
	move.b	d0,d3
	neg.w	d2
	addi.w	#$800,d2
	bpl.s	loc_205006
	moveq	#0,d2

loc_205006:
	lsr.w	#8,d2
	move.b	d2,pattim(a0)
	bsr.w	patchgmain2
	add.b	d3,patno(a0)
	rts

playrunchg2:
	addq.b	#1,d0
	bne.s	playrunchg3
	move.w	mspeed(a0),d2
	bpl.s	loc_205022
	neg.w	d2

loc_205022:
	lea	plchg35.l,a1
	tst.b	chibi_flag.w
	bne.s	loc_205040
	lea	plchg03.l,a1
	cmpi.w	#$600,d2
	bhs.s	loc_205040
	lea	plchg02.l,a1

loc_205040:
	neg.w	d2
	addi.w	#$400,d2
	bpl.s	loc_20504A
	moveq	#0,d2

loc_20504A:
	lsr.w	#8,d2
	move.b	d2,pattim(a0)
	move.b	cddat(a0),d1
	andi.b	#1,d1
	andi.b	#%11111100,actflg(a0)
	or.b	d1,actflg(a0)
	bra.w	patchgmain2

playrunchg3:
	addq.b	#1,d0
	bne.s	playetc_chg

loc_20506A:
	move.w	mspeed(a0),d2
	bmi.s	loc_205072
	neg.w	d2

loc_205072:
	addi.w	#$800,d2
	bpl.s	loc_20507A
	moveq	#0,d2

loc_20507A:
	lsr.w	#6,d2
	move.b	d2,pattim(a0)
	lea	plchg39.l,a1
	tst.b	chibi_flag.w
	bne.s	loc_205092
	lea	plchg04.l,a1

loc_205092:
	move.b	cddat(a0),d1
	andi.b	#1,d1
	andi.b	#%11111100,actflg(a0)
	or.b	d1,actflg(a0)
	bra.w	patchgmain2

playetc_chg:
	moveq	#0,d1
	move.b	patcnt(a0),d1
	move.b	1(a1,d1.w),patno(a0)
	move.b	#0,pattim(a0)
	rts

little_runchg:
	moveq	#0,d1
	move.b	direc(a0),d0
	move.b	cddat(a0),d2
	andi.b	#1,d2
	bne.s	loc_2050CE
	not.b	d0

loc_2050CE:
	addi.b	#$10,d0
	bpl.s	loc_2050D6
	moveq	#0,d1

loc_2050D6:
	andi.b	#%11111100,actflg(a0)
	or.b	d2,actflg(a0)
	addi.b	#$30,d0
	cmpi.b	#$60,d0
	blo.s	loc_205104
	bset	#cd_ball,cddat(a0)
	move.b	#chibiheight,sprvsize(a0)
	move.b	#chibiwidth,sprhs(a0)
	move.b	#$FF,d0
	bra.w	playrunchg2

loc_205104:
	move.w	mspeed(a0),d2
	bpl.s	loc_20510C
	neg.w	d2

loc_20510C:
	lea	plchg34.l,a1
	cmpi.w	#$600,d2
	bhs.s	loc_20511E
	lea	plchg33.l,a1

loc_20511E:
	neg.w	d2
	addi.w	#$800,d2
	bpl.s	loc_205128
	moveq	#0,d2

loc_205128:
	lsr.w	#8,d2
	move.b	d2,pattim(a0)
	bra.w	patchgmain2

little_patchg:
	tst.b	chibi_flag.w
	beq.s	locret_20513C
	move.b	byte_20513E(pc,d0.w),d0

locret_20513C:
	rts

byte_20513E:
	dc.b	33,24,35,35,39,31,38,40,32,9
	dc.b	10,11,12,36,14,15,40,17,18,19
	dc.b	20,21,22,23,24,25,37,37,28,29
	dc.b	30,31,32,33,34,35,36,37,38,39
	dc.b	40,41,42,48,44,45,46,47
	even

playchg:
	dc.w	plchg00-playchg
	dc.w	plchg01-playchg
	dc.w	plchg02-playchg
	dc.w	plchg03-playchg
	dc.w	plchg04-playchg
	dc.w	plchg05-playchg
	dc.w	plchg06-playchg
	dc.w	plchg07-playchg
	dc.w	plchg08-playchg
	dc.w	plchg09-playchg
	dc.w	plchg10-playchg
	dc.w	plchg11-playchg
	dc.w	plchg12-playchg
	dc.w	plchg13-playchg
	dc.w	plchg14-playchg
	dc.w	plchg15-playchg
	dc.w	plchg16-playchg
	dc.w	plchg17-playchg
	dc.w	plchg18-playchg
	dc.w	plchg19-playchg
	dc.w	plchg20-playchg
	dc.w	plchg21-playchg
	dc.w	plchg22-playchg
	dc.w	plchg23-playchg
	dc.w	plchg24-playchg
	dc.w	plchg25-playchg
	dc.w	plchg26-playchg
	dc.w	plchg27-playchg
	dc.w	plchg28-playchg
	dc.w	plchg29-playchg
	dc.w	plchg30-playchg
	dc.w	plchg31-playchg
	dc.w	plchg32-playchg
	dc.w	plchg33-playchg
	dc.w	plchg34-playchg
	dc.w	plchg35-playchg
	dc.w	plchg36-playchg
	dc.w	plchg37-playchg
	dc.w	plchg38-playchg
	dc.w	plchg39-playchg
	dc.w	plchg40-playchg
	dc.w	plchg41-playchg
	dc.w	plchg42-playchg
	dc.w	plchg43-playchg
	dc.w	plchg44-playchg
	dc.w	plchg45-playchg
	dc.w	plchg46-playchg
	dc.w	plchg47-playchg
	dc.w	plchg48-playchg
	dc.w	plchg45-playchg
	dc.w	plchg46-playchg
	dc.w	plchg47-playchg
plchg00:
	dc.b	$FF
	dc.b	playframe.walk3
	dc.b	playframe.walk4
	dc.b	playframe.walk5
	dc.b	playframe.walk6
	dc.b	playframe.walk1
	dc.b	playframe.walk2
	dc.b	$FF
	even
plchg01:
	dc.b	$FF
	dc.b	playframe.run1
	dc.b	playframe.run2
	dc.b	playframe.run3
	dc.b	playframe.run4
	dc.b	$FF
	dc.b	$FF
	dc.b	$FF
	even
plchg02:
	dc.b	$FE
	dc.b	playframe.roll1
	dc.b	playframe.roll2
	dc.b	playframe.roll3
	dc.b	playframe.roll4
	dc.b	playframe.rollball2
	dc.b	$FF
	dc.b	$FF
	even
plchg03:
	dc.b	$FE
	dc.b	playframe.roll1
	dc.b	playframe.roll2
	dc.b	playframe.rollball2
	dc.b	playframe.roll3
	dc.b	playframe.roll4
	dc.b	playframe.rollball2
	dc.b	$FF
	even
plchg04:
	dc.b	$FD
	dc.b	playframe.push1
	dc.b	playframe.push2
	dc.b	playframe.push3
	dc.b	playframe.push4
	dc.b	$FF
	dc.b	$FF
	dc.b	$FF
	even
plchg05:
	dc.b	$17
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.stand
	dc.b	playframe.wait2
	dc.b	playframe.wait1
	dc.b	playframe.wait1
	dc.b	playframe.wait1
	dc.b	playframe.wait2
	dc.b	playframe.wait3
	dc.b	$FE,2
	even
plchg06:
	dc.b	$1F
	dc.b	playframe.balance1
	dc.b	playframe.balance2
	dc.b	$FF
	even
plchg07:
	dc.b	$3F
	dc.b	playframe.lookup
	dc.b	$FF
	even
plchg08:
	dc.b	$3F
	dc.b	playframe.duck
	dc.b	$FF
	even
plchg09:
	dc.b	$3F
	dc.b	$33
	dc.b	$FF
	even
plchg10:
	dc.b	$3F
	dc.b	$34
	dc.b	$FF
	even
plchg11:
	dc.b	$3F
	dc.b	$35
	dc.b	$FF
	even
plchg12:
	dc.b	$3F
	dc.b	$36
	dc.b	$FF
	even
plchg13:
	dc.b	7
	dc.b	playframe.skid1
	dc.b	playframe.skid2
	dc.b	$FF
	even
plchg14:
	dc.b	7
	dc.b	$3C
	dc.b	$3F
	dc.b	$FF
	even
plchg15:
	dc.b	7
	dc.b	$3C
	dc.b	$3D
	dc.b	$53
	dc.b	$3E
	dc.b	$54
	dc.b	$FF
	even
plchg16:
	dc.b	$2F
	dc.b	playframe.spring
	dc.b	$FD,0
	even
plchg17:
	dc.b	4
	dc.b	playframe.polehang1
	dc.b	playframe.polehang2
	dc.b	$FF
	even
plchg18:
	dc.b	$F
	dc.b	$43
	dc.b	$43
	dc.b	$43
	dc.b	$FE,1
	even
plchg19:
	dc.b	$F
	dc.b	$43
	dc.b	$44
	dc.b	$FE,1
	even
plchg20:
	dc.b	$3F
	dc.b	$49
	dc.b	$FF
	even
plchg21:
	dc.b	$B
	dc.b	playframe.getair
	dc.b	playframe.getair
	dc.b	playframe.walk5
	dc.b	playframe.walk6
	dc.b	$FD,0
	even
plchg22:
	dc.b	$20
	dc.b	playframe.burnt
	dc.b	$FF
	even
plchg23:
	dc.b	$2F
	dc.b	playframe.drown
	dc.b	$FF
	even
plchg24:
	dc.b	3
	dc.b	playframe.death
	dc.b	$FF
	even
plchg25:
	dc.b	3
	dc.b	$4E
	dc.b	$4F
	dc.b	$50
	dc.b	$51
	dc.b	$52
	dc.b	0
	dc.b	$FE,1
	even
plchg26:
	dc.b	3
	dc.b	playframe.hurt
	dc.b	$FF
	even
plchg27:
	dc.b	7
	dc.b	playframe.hurt
	dc.b	playframe.waterfall
	dc.b	$FF
	even
plchg28:
	dc.b	$77
	dc.b	playframe.empty
	dc.b	$FD,0
	even
plchg29:
	dc.b	3
	dc.b	$3C
	dc.b	$3D
	dc.b	$53
	dc.b	$3E
	dc.b	$54
	dc.b	$FF
	even
plchg30:
	dc.b	3
	dc.b	$3C
	dc.b	$FD,0
	even
plchg31:
	dc.b	$17
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibistand
	dc.b	playframe.chibiwait1
	dc.b	playframe.chibiwait1
	dc.b	playframe.chibiwait1
	dc.b	playframe.chibiwait2
	dc.b	playframe.chibiwait1
	dc.b	playframe.chibiwait2
	dc.b	$FE,2
	even
plchg32:
	dc.b	$3F
	dc.b	playframe.chibiduck
	dc.b	$FF
	even
plchg33:
	dc.b	$FF
	dc.b	playframe.chibiwalk1
	dc.b	playframe.chibiwalk2
	dc.b	playframe.chibiwalk3
	dc.b	playframe.chibiwalk2
	dc.b	$FF
	even
plchg34:
	dc.b	$FF
	dc.b	playframe.chibirun1
	dc.b	playframe.chibirun2
	dc.b	$FF
	dc.b	$FF
	dc.b	$FF
	even
plchg35:
	dc.b	$FE
	dc.b	playframe.chibirollball
	dc.b	playframe.chibiroll1
	dc.b	playframe.chibiroll2
	dc.b	$FF
	dc.b	$FF
	even
plchg36:
	dc.b	7
	dc.b	playframe.chibiskid
	dc.b	playframe.chibiskid
	dc.b	$FF
	even
plchg37:
	dc.b	3
	dc.b	playframe.chibihurt
	dc.b	$FF
	even
plchg38:
	dc.b	$1F
	dc.b	playframe.chibibalance1
	dc.b	playframe.chibibalance2
	dc.b	$FF
	even
plchg39:
	dc.b	$FD
	dc.b	playframe.chibiwalk1
	dc.b	playframe.chibiwalk2
	dc.b	playframe.chibiwalk3
	dc.b	$FF
	dc.b	$FF
	dc.b	$FF
	even
plchg40:
	dc.b	$3F
	dc.b	playframe.chibistand
	dc.b	$FF
	even
plchg41:
	dc.b	$3F
	dc.b	playframe.lookback
	dc.b	$FF
	even
plchg42:
	dc.b	3
	dc.b	playframe.sneeze1
	dc.b	playframe.sneeze1
	dc.b	playframe.sneeze1
	dc.b	playframe.sneeze1
	dc.b	playframe.sneeze1
	dc.b	playframe.sneeze3
	dc.b	playframe.sneeze3
	dc.b	playframe.sneeze2
	dc.b	playframe.sneeze2
	dc.b	playframe.sneeze2
	dc.b	playframe.stand
	dc.b	playframe.sneeze4
	dc.b	playframe.sneeze4
	dc.b	$FD,5
	even
plchg43:
	dc.b	9
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere1
	dc.b	playframe.outofhere2
	dc.b	playframe.outofhere2
	dc.b	playframe.outofhere2
	dc.b	playframe.outofhere2
	dc.b	playframe.outofhere3
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere4
	dc.b	playframe.outofhere5
	dc.b	playframe.outofhere5
	dc.b	playframe.outofhere5
	dc.b	playframe.outofhere5
	dc.b	playframe.outofhere6
	dc.b	playframe.outofhere6
	dc.b	playframe.outofhere6
	dc.b	playframe.outofhere6
	dc.b	playframe.outofhere7
	dc.b	$FE,1
	even
plchg44:
	dc.b	4
	dc.b	playframe.hang1
	dc.b	playframe.hang2
	dc.b	$FF
	even
plchg45:
	dc.b	$FC
	dc.b	playframe.spin1
	dc.b	playframe.spin2
	dc.b	playframe.spin3
	dc.b	playframe.spin6
	dc.b	playframe.spin4
	dc.b	playframe.spin5
	dc.b	$FF
	even
plchg46:
	dc.b	$FF
	dc.b	playframe.walkwater3
	dc.b	playframe.walkwater4
	dc.b	playframe.walkwater5
	dc.b	playframe.walkwater6
	dc.b	playframe.walkwater1
	dc.b	playframe.walkwater2
	dc.b	$FF
	even
plchg47:
	dc.b	$FF
	dc.b	playframe.watertunnel1
	dc.b	playframe.watertunnel2
	dc.b	playframe.watertunnel3
	dc.b	$FF
	even
plchg48:
	dc.b	$13
	dc.b	$70
	dc.b	$6F
	dc.b	$70
	dc.b	$79
	dc.b	$FE,1
	even

playwrt:
	lea	playpatno.w,a2
	_cmpi.b	#play00_act,actno(a0)
	beq.s	loc_20533E
	lea	playpatno1.w,a2

loc_20533E:
	moveq	#0,d0
	move.b	patno(a0),d0
	cmp.b	(a2),d0
	beq.s	locret_205392
	move.b	d0,(a2)
	lea	playwrtpat.l,a2
	add.w	d0,d0
	adda.w	(a2,d0.w),a2
	moveq	#0,d1
	move.b	(a2)+,d1
	subq.b	#1,d1
	bmi.s	locret_205392
	lea	playwrtwk.w,a3
	move.b	#1,playwrtflag.w

.loop:
	moveq	#0,d2
	move.b	(a2)+,d2
	move.w	d2,d0
	lsr.b	#4,d0
	lsl.w	#8,d2
	move.b	(a2)+,d2
	lsl.w	#5,d2
	lea	playcg.l,a1
	adda.l	d2,a1

.loop1:
	movem.l	(a1)+,d2-d6/a4-a6
	movem.l	d2-d6/a4-a6,(a3)
	lea	tile_size(a3),a3
	dbf	d0,.loop1

	dbf	d1,.loop

locret_205392:
	rts

frip_spd:
	moveq	#0,d0
	move.b	act3D(a0),d0
	lsl.w	#6,d0
	addi.l	#actwk&$FFFFFF,d0
	movea.l	d0,a1
	_cmpi.b	#objid_1E,actno(a1)
	bne.s	locret_2053FE
	move.b	#1,mstno(a1)
	move.w	xposi(a1),d1
	move.w	yposi(a1),d2
	addi.w	#$18,d2
	sub.w	xposi(a0),d1
	sub.w	yposi(a0),d2
	jsr	atan.l
	moveq	#0,d2
	move.b	sprhsize(a1),d2
	move.w	xposi(a0),d3
	sub.w	xposi(a1),d3
	add.w	d2,d3
	btst	#cd_left,cddat(a1)
	bne.s	loc_2053EC
	move.w	#$40,d1
	sub.w	d3,d1
	move.w	d1,d3

loc_2053EC:
	move.w	#-$A00,d2
	move.w	d2,d1
	ext.l	d1
	muls.w	d3,d1
	divs.w	#$40,d1
	add.w	d1,d2
	moveq	#0,d1

locret_2053FE:
	rts