dodai:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	dodai_acttbl(pc,d0.w),d0
	jsr	dodai_acttbl(pc,d0.w)
	jsr	actionsub.l
	rts

dodai_acttbl:
	dc.w	dodai_init-dodai_acttbl
	dc.w	dodai_move-dodai_acttbl

ridechk:
	lea	playerwk.w,a1
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	subq.w	#4,d4
	jmp	ride_on_chk.l

dodai_init:
	ori.b	#4,actflg(a0)
	move.w	#$4000,sproffset(a0)
	move.b	#3,sprpri(a0)
	move.w	xposi(a0),act38(a0)
	move.w	yposi(a0),act3A(a0)
	move.w	yposi(a0),act36(a0)
	move.l	#dai11a_pattbl,d0
	cmpi.w	#(stage_SPZ<<8)+act_1,stageno
	beq.s	loc_20D6EE
	move.l	#dai12a_pattbl,d0
	cmpi.w	#(stage_SPZ<<8)+act_2,stageno
	beq.s	loc_20D6EE
	move.l	#dai12a_pattbl,d0

loc_20D6EE:
	move.l	d0,patbase(a0)
	move.b	userflag(a0),d0
	move.b	d0,d1
	andi.w	#%0011,d0
	move.b	d0,patno(a0)
	move.b	dai_hstbl(pc,d0.w),sprhsize(a0)
	move.b	#4,sprvsize(a0)
	lsr.b	#2,d1
	andi.w	#3,d1
	move.b	dai_mcnttbl(pc,d1.w),act2D(a0)
	move.b	act29(a0),d0
	beq.s	loc_20D768
	jsr	actwkchk.l
	beq.s	loc_20D72C
	jmp	frameout.l

loc_20D72C:
	_move.b	#spring_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	subi.w	#$10,yposi(a1)
	move.b	#$F0,act39(a1)
	move.w	a0,act34(a1)
	move.b	act29(a0),d0
	move.b	d0,d1
	andi.b	#%0010,d1
	move.b	d1,userflag(a1)
	andi.b	#%11111000,d0
	move.b	d0,act38(a1)
	add.w	d0,xposi(a1)

loc_20D768:
	addq.b	#word,r_no0(a0)
	rts

dai_hstbl:
	dc.b	$10
	dc.b	$20
	dc.b	$30
	dc.b	0
	even

dai_mcnttbl:
	dc.b	$20
	dc.b	$30
	dc.b	$40
	dc.b	$60
	even

dodai_move:
	tst.w	time_stop
	beq.s	loc_20D782
	bra.w	ridechk

loc_20D782:
	move.b	userflag(a0),d0
	lsr.b	#4,d0
	andi.w	#$F,d0
	add.w	d0,d0
	move.w	dodai_mtype(pc,d0.w),d0
	jsr	dodai_mtype(pc,d0.w)
	move.w	act38(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bls.s	locret_20D7B8
	jmp	frameout.l

locret_20D7B8:
	rts

dodai_mtype:
	dc.w	dodai_ud-dodai_mtype
	dc.w	dodai_lr-dodai_mtype
	dc.w	dodai_nA-dodai_mtype
	dc.w	dodai_nB-dodai_mtype
	dc.w	dodai_fix-dodai_mtype
	dc.w	dodai_fal-dodai_mtype
	dc.w	dodai_up-dodai_mtype
	dc.w	dodai_upx-dodai_mtype
	dc.w	dodai_rm-dodai_mtype
	dc.w	dodai_lm-dodai_mtype

dodai_ud:
	addq.b	#1,act2A(a0)
	jsr	dodai_sub(pc)
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	jmp	ridechk.l

dodai_lr:
	move.l	xposi(a0),-(sp)
	jsr	dodai_sub(pc)
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	addq.b	#1,act2A(a0)
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)

dodai_ride1:
	move.l	(sp)+,d0
	move.l	xposi(a0),d1
	sub.l	d0,d1
	asr.l	#8,d1
	move.w	d1,xspeed(a0)

dodai_ride2:
	jsr	ridechk(pc)
	beq.s	loc_20D82E
	move.b	act2C(a0),d0
	cmpi.b	#8,d0
	bhs.s	loc_20D82A
	addq.b	#1,act2C(a0)

loc_20D82A:
	moveq	#1,d0
	rts

loc_20D82E:
	moveq	#0,d0
	move.b	act2C(a0),d0
	beq.s	loc_20D83A
	subq.b	#1,act2C(a0)

loc_20D83A:
	moveq	#0,d0
	rts

dodai_nA:
	move.l	xposi(a0),-(sp)
	addq.b	#1,act2A(a0)
	jsr	dodai_sub(pc)
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	jsr	dodai_sub(pc)
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	bra.w	dodai_ride1

dodai_nB:
	move.l	xposi(a0),-(sp)
	addq.b	#1,act2A(a0)
	jsr	dodai_sub(pc)
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	jsr	dodai_sub(pc)
	neg.w	d0
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	bra.w	dodai_ride1

dodai_fix:
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	bra.w	dodai_ride2

dodai_fal:
	move.b	act2B(a0),d0
	bne.s	loc_20D8B4
	jsr	dodai_fix(pc)
	bne.s	loc_20D8AA
	rts

loc_20D8AA:
	move.b	#30,act2E(a0)
	addq.b	#word,act2B(a0)

loc_20D8B4:
	move.b	act2E(a0),d0
	beq.s	loc_20D8C2
	subq.b	#1,act2E(a0)
	bra.w	dodai_fix

loc_20D8C2:
	jsr	ridechk(pc)
	move.l	yposi(a0),d1
	move.w	yspeed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d1
	move.l	d1,yposi(a0)
	move.w	yspeed(a0),d0
	cmpi.w	#$400,d0
	bhs.s	loc_20D8E8
	addi.w	#$40,yspeed(a0)

loc_20D8E8:
	jsr	emycol_d.l
	tst.w	d1
	bpl.s	loc_20D8FC
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)

loc_20D8FC:
	move.w	scra_v_posit.w,d0
	addi.w	#224,d0
	cmp.w	yposi(a0),d0
	bhs.s	locret_20D910
	jmp	frameout.l

locret_20D910:
	rts

dodai_up:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20D922(pc,d0.w),d0
	jmp	off_20D922(pc,d0.w)

off_20D922:
	dc.w	loc_20D928-off_20D922
	dc.w	loc_20D934-off_20D922
	dc.w	loc_20D962-off_20D922

loc_20D928:
	jsr	dodai_fix(pc)
	bne.s	loc_20D930
	rts

loc_20D930:
	addq.b	#word,act2B(a0)

loc_20D934:
	move.b	act2A(a0),d0
	cmpi.b	#$40,d0
	bhs.w	loc_20D958
	jsr	dodai_sub(pc)
	neg.w	d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	addq.b	#2,act2A(a0)
	jmp	ridechk.l

loc_20D958:
	move.w	yposi(a0),act3A(a0)
	addq.b	#word,act2B(a0)

loc_20D962:
	bra.w	dodai_fix

dodai_upx:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20D976(pc,d0.w),d0
	jmp	off_20D976(pc,d0.w)

off_20D976:
	dc.w	loc_20D97C-off_20D976
	dc.w	loc_20D98E-off_20D976
	dc.w	loc_20D9C2-off_20D976

loc_20D97C:
	jsr	dodai_fix(pc)
	bne.s	loc_20D984
	rts

loc_20D984:
	addq.b	#word,act2B(a0)
	move.b	#60,act2E(a0)

loc_20D98E:
	move.b	act2E(a0),d0
	beq.s	loc_20D99C
	subq.b	#1,act2E(a0)
	bra.w	dodai_fix

loc_20D99C:
	jsr	speedset2.l
	subq.w	#8,yspeed(a0)
	jsr	emycol_u.l
	tst.w	d1
	bmi.s	loc_20D9B4
	bra.w	dodai_ride2

loc_20D9B4:
	sub.w	d1,yposi(a0)
	move.w	yposi(a0),act3A(a0)
	addq.b	#word,act2B(a0)

loc_20D9C2:
	bra.w	dodai_fix

dodai_rm:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20D9D6(pc,d0.w),d0
	jmp	off_20D9D6(pc,d0.w)

off_20D9D6:
	dc.w	loc_20D9DC-off_20D9D6
	dc.w	loc_20D9EE-off_20D9D6
	dc.w	loc_20DA3A-off_20D9D6

loc_20D9DC:
	jsr	dodai_fix(pc)
	bne.s	loc_20D9E4
	rts

loc_20D9E4:
	addq.b	#word,act2B(a0)
	move.b	#60,act2E(a0)

loc_20D9EE:
	move.b	act2E(a0),d0
	beq.s	loc_20D9FC
	subq.b	#1,act2E(a0)
	bra.w	dodai_fix

loc_20D9FC:
	move.b	act2A(a0),d0
	cmpi.b	#$40,d0
	bhs.w	loc_20DA30
	move.l	xposi(a0),-(sp)
	jsr	dodai_sub(pc)
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	addq.b	#1,act2A(a0)
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	bra.w	dodai_ride1

loc_20DA30:
	move.w	xposi(a0),act38(a0)
	addq.b	#word,act2B(a0)

loc_20DA3A:
	bra.w	dodai_fix

dodai_lm:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20DA4E(pc,d0.w),d0
	jmp	off_20DA4E(pc,d0.w)

off_20DA4E:
	dc.w	loc_20DA54-off_20DA4E
	dc.w	loc_20DA66-off_20DA4E
	dc.w	loc_20DAB2-off_20DA4E

loc_20DA54:
	jsr	dodai_fix(pc)
	bne.s	loc_20DA5C
	rts

loc_20DA5C:
	addq.b	#word,act2B(a0)
	move.b	#60,act2E(a0)

loc_20DA66:
	move.b	act2E(a0),d0
	beq.s	loc_20DA74
	subq.b	#1,act2E(a0)
	bra.w	dodai_fix

loc_20DA74:
	move.b	act2A(a0),d0
	cmpi.b	#$40,d0
	bhs.s	loc_20DAA8
	move.l	xposi(a0),-(sp)
	jsr	dodai_sub(pc)
	neg.w	d0
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	addq.b	#1,act2A(a0)
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	bra.w	dodai_ride1

loc_20DAA8:
	move.w	xposi(a0),act38(a0)
	addq.b	#word,act2B(a0)

loc_20DAB2:
	bra.w	dodai_fix

dodai_sub:
	moveq	#0,d0
	move.b	act2A(a0),d0
	jsr	sinset.l
	moveq	#0,d2
	move.b	act2D(a0),d2
	muls.w	d2,d0
	lsr.l	#8,d0
	rts

dai11a_pattbl:
	dc.w	dai11a_pat1-dai11a_pattbl
	dc.w	dai11a_pat2-dai11a_pattbl
	dc.w	dai11a_pat3-dai11a_pattbl
dai11a_pat1:
	dc.b	4
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,8,1,0
	dc.b	0,5,0,5,$F0
	dc.b	0,5,8,5,0
	even
dai11a_pat2:
	dc.b	8
	dc.b	$F0,5,0,1,$E0
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,0,1,0
	dc.b	$F0,5,0,1,$10
	dc.b	0,5,0,5,$E0
	dc.b	0,5,0,9,$F0
	dc.b	0,5,0,9,0
	dc.b	0,5,8,5,$10
	even
dai11a_pat3:
	dc.b	12
	dc.b	$F0,5,0,1,$D0
	dc.b	$F0,5,0,1,$E0
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,0,1,0
	dc.b	$F0,5,0,1,$10
	dc.b	$F0,5,0,1,$20
	dc.b	0,5,0,5,$D0
	dc.b	0,5,0,9,$E0
	dc.b	0,5,0,9,$F0
	dc.b	0,5,0,9,0
	dc.b	0,5,0,9,$10
	dc.b	0,5,8,5,$20
	even

dai12a_pattbl:
	dc.w	byte_20DB58-dai12a_pattbl
	dc.w	byte_20DB6E-dai12a_pattbl
	dc.w	byte_20DB98-dai12a_pattbl
byte_20DB58:
	dc.b	4
	dc.b	$F0,5,0,$31,$F0
	dc.b	$F0,5,8,$31,0
	dc.b	0,5,0,$35,$F0
	dc.b	0,5,8,$35,0
	even
byte_20DB6E:
	dc.b	8
	dc.b	$F0,5,0,$31,$E0
	dc.b	$F0,5,8,$31,$F0
	dc.b	0,5,0,$35,$E0
	dc.b	0,5,8,$35,$F0
	dc.b	$F0,5,0,$31,0
	dc.b	$F0,5,8,$31,$10
	dc.b	0,5,0,$35,0
	dc.b	0,5,8,$35,$10
	even
byte_20DB98:
	dc.b	12
	dc.b	$F0,5,0,$31,$D0
	dc.b	$F0,5,8,$31,$E0
	dc.b	0,5,0,$35,$D0
	dc.b	0,5,8,$35,$E0
	dc.b	$F0,5,0,$31,$F0
	dc.b	$F0,5,8,$31,0
	dc.b	0,5,0,$35,$F0
	dc.b	0,5,8,$35,0
	dc.b	$F0,5,0,$31,$10
	dc.b	$F0,5,8,$31,$20
	dc.b	0,5,0,$35,$10
	dc.b	0,5,8,$35,$20
	even