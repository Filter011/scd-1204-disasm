	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20F35E(pc,d0.w),d0
	jsr	off_20F35E(pc,d0.w)
	jsr	$20517A.l
	rts

off_20F35E:
	dc.w	loc_20F374-off_20F35E
	dc.w	loc_20F446-off_20F35E

sub_20F362:
	lea	playerwk.w,a1
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	$209E14.l

loc_20F374:
	ori.b	#4,actflg(a0)
	move.w	#$4000,sproffset(a0)
	move.b	#3,sprpri(a0)
	move.w	xposi(a0),act38(a0)
	move.w	yposi(a0),act3A(a0)
	move.w	yposi(a0),act36(a0)
	move.l	#off_20F77A,d0
	cmpi.w	#(stage_spz<<8)+act_1,stageno
	beq.s	loc_20F3BE
	move.l	#off_20F7FE,d0
	cmpi.w	#(stage_spz<<8)+act_2,stageno
	beq.s	loc_20F3BE
	move.l	#off_20F7FE,d0

loc_20F3BE:
	move.l	d0,patbase(a0)
	move.b	userflag(a0),d0
	move.b	d0,d1
	andi.w	#%0011,d0
	move.b	d0,patno(a0)
	move.b	byte_20F43E(pc,d0.w),sprhsize(a0)
	move.b	#8,sprvsize(a0)
	lsr.b	#2,d1
	andi.w	#3,d1
	move.b	byte_20F442(pc,d1.w),$2D(a0)
	move.b	act29(a0),d0
	beq.s	loc_20F438
	jsr	$208E64.l
	beq.s	loc_20F3FC
	jmp	$2051FE.l

loc_20F3FC:
	_move.b	#$A,actno(a1)
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

loc_20F438:
	addq.b	#word,r_no0(a0)
	rts

byte_20F43E:
	dc.b	$10
	dc.b	$20
	dc.b	$30
	dc.b	0
byte_20F442:
	dc.b	$20
	dc.b	$30
	dc.b	$40
	dc.b	$60

loc_20F446:
	tst.w	time_stop
	beq.s	loc_20F452
	bra.w	sub_20F362

loc_20F452:
	move.b	userflag(a0),d0
	lsr.b	#4,d0
	andi.w	#$F,d0
	add.w	d0,d0
	move.w	off_20F48A(pc,d0.w),d0
	jsr	off_20F48A(pc,d0.w)
	move.w	act38(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bls.s	locret_20F488
	jmp	$2051FE.l

locret_20F488:
	rts

off_20F48A:
	dc.w	loc_20F49E-off_20F48A
	dc.w	loc_20F4B4-off_20F48A
	dc.w	loc_20F50E-off_20F48A
	dc.w	loc_20F532-off_20F48A
	dc.w	sub_20F558-off_20F48A
	dc.w	loc_20F56C-off_20F48A
	dc.w	loc_20F5BE-off_20F48A
	dc.w	loc_20F612-off_20F48A
	dc.w	loc_20F672-off_20F48A
	dc.w	loc_20F6EA-off_20F48A

loc_20F49E:
	addq.b	#1,act2A(a0)
	jsr	sub_20F762(pc)
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	jmp	sub_20F362.l

loc_20F4B4:
	move.l	xposi(a0),-(sp)
	jsr	sub_20F762(pc)
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	addq.b	#1,act2A(a0)
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)

loc_20F4D8:
	move.l	(sp)+,d0
	move.l	xposi(a0),d1
	sub.l	d0,d1
	asr.l	#8,d1
	move.w	d1,xspeed(a0)

loc_20F4E6:
	jsr	sub_20F362(pc)
	beq.s	loc_20F4FE
	move.b	act2C(a0),d0
	cmpi.b	#8,d0
	bhs.s	loc_20F4FA
	addq.b	#1,act2C(a0)

loc_20F4FA:
	moveq	#1,d0
	rts

loc_20F4FE:
	moveq	#0,d0
	move.b	act2C(a0),d0
	beq.s	loc_20F50A
	subq.b	#1,act2C(a0)

loc_20F50A:
	moveq	#0,d0
	rts

loc_20F50E:
	move.l	xposi(a0),-(sp)
	addq.b	#1,act2A(a0)
	jsr	sub_20F762(pc)
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	jsr	sub_20F762(pc)
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	bra.w	loc_20F4D8

loc_20F532:
	move.l	xposi(a0),-(sp)
	addq.b	#1,act2A(a0)
	jsr	sub_20F762(pc)
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	jsr	sub_20F762(pc)
	neg.w	d0
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	bra.w	loc_20F4D8

sub_20F558:
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	bra.w	loc_20F4E6

loc_20F56C:
	move.b	act2B(a0),d0
	bne.s	loc_20F584
	jsr	sub_20F558(pc)
	bne.s	loc_20F57A
	rts

loc_20F57A:
	move.b	#30,act2E(a0)
	addq.b	#word,act2B(a0)

loc_20F584:
	move.b	act2E(a0),d0
	beq.s	loc_20F592
	subq.b	#1,act2E(a0)
	bra.w	sub_20F558

loc_20F592:
	jsr	$205124.l
	addi.w	#$18,yspeed(a0)
	move.w	scra_v_posit.w,d0
	addi.w	#224,d0
	cmp.w	yposi(a0),d0
	bhs.s	loc_20F5B2
	jmp	$2051FE.l

loc_20F5B2:
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	rts

loc_20F5BE:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20F5CE(pc,d0.w),d0
	jmp	off_20F5CE(pc,d0.w)

off_20F5CE:
	dc.w	loc_20F5D4-off_20F5CE
	dc.w	loc_20F5E0-off_20F5CE
	dc.w	loc_20F60E-off_20F5CE

loc_20F5D4:
	jsr	sub_20F558(pc)
	bne.s	loc_20F5DC
	rts

loc_20F5DC:
	addq.b	#word,act2B(a0)

loc_20F5E0:
	move.b	act2A(a0),d0
	cmpi.b	#$40,d0
	bhs.w	loc_20F604
	jsr	sub_20F762(pc)
	neg.w	d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	addq.b	#2,act2A(a0)
	jmp	sub_20F362.l

loc_20F604:
	move.w	yposi(a0),act3A(a0)
	addq.b	#word,act2B(a0)

loc_20F60E:
	bra.w	sub_20F558

loc_20F612:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20F622(pc,d0.w),d0
	jmp	off_20F622(pc,d0.w)

off_20F622:
	dc.w	loc_20F628-off_20F622
	dc.w	loc_20F63A-off_20F622
	dc.w	loc_20F66E-off_20F622

loc_20F628:
	jsr	sub_20F558(pc)
	bne.s	loc_20F630
	rts

loc_20F630:
	addq.b	#word,act2B(a0)
	move.b	#60,act2E(a0)

loc_20F63A:
	move.b	act2E(a0),d0
	beq.s	loc_20F648
	subq.b	#1,act2E(a0)
	bra.w	sub_20F558

loc_20F648:
	jsr	$205124.l
	subq.w	#8,yspeed(a0)
	jsr	$2081F0.l
	tst.w	d1
	bmi.s	loc_20F660
	bra.w	loc_20F4E6

loc_20F660:
	sub.w	d1,yposi(a0)
	move.w	yposi(a0),act3A(a0)
	addq.b	#word,act2B(a0)

loc_20F66E:
	bra.w	sub_20F558

loc_20F672:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20F682(pc,d0.w),d0
	jmp	off_20F682(pc,d0.w)

off_20F682:
	dc.w	loc_20F688-off_20F682
	dc.w	loc_20F69A-off_20F682
	dc.w	loc_20F6E6-off_20F682

loc_20F688:
	jsr	sub_20F558(pc)
	bne.s	loc_20F690
	rts

loc_20F690:
	addq.b	#word,act2B(a0)
	move.b	#60,act2E(a0)

loc_20F69A:
	move.b	act2E(a0),d0
	beq.s	loc_20F6A8
	subq.b	#1,act2E(a0)
	bra.w	sub_20F558

loc_20F6A8:
	move.b	act2A(a0),d0
	cmpi.b	#$40,d0
	bhs.w	loc_20F6DC
	move.l	xposi(a0),-(sp)
	jsr	sub_20F762(pc)
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	addq.b	#1,act2A(a0)
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	bra.w	loc_20F4D8

loc_20F6DC:
	move.w	xposi(a0),act38(a0)
	addq.b	#word,act2B(a0)

loc_20F6E6:
	bra.w	sub_20F558

loc_20F6EA:
	move.b	act2B(a0),d0
	andi.w	#$FF,d0
	move.w	off_20F6FA(pc,d0.w),d0
	jmp	off_20F6FA(pc,d0.w)

off_20F6FA:
	dc.w	loc_20F700-off_20F6FA
	dc.w	loc_20F712-off_20F6FA
	dc.w	loc_20F75E-off_20F6FA

loc_20F700:
	jsr	sub_20F558(pc)
	bne.s	loc_20F708
	rts

loc_20F708:
	addq.b	#word,act2B(a0)
	move.b	#60,act2E(a0)

loc_20F712:
	move.b	act2E(a0),d0
	beq.s	loc_20F720
	subq.b	#1,act2E(a0)
	bra.w	sub_20F558

loc_20F720:
	move.b	act2A(a0),d0
	cmpi.b	#$40,d0
	bhs.s	loc_20F754
	move.l	xposi(a0),-(sp)
	jsr	sub_20F762(pc)
	neg.w	d0
	add.w	act38(a0),d0
	move.w	d0,xposi(a0)
	addq.b	#1,act2A(a0)
	moveq	#0,d0
	move.b	act2C(a0),d0
	asr.b	#1,d0
	add.w	act3A(a0),d0
	move.w	d0,yposi(a0)
	bra.w	loc_20F4D8

loc_20F754:
	move.w	xposi(a0),act38(a0)
	addq.b	#word,act2B(a0)

loc_20F75E:
	bra.w	sub_20F558

sub_20F762:
	moveq	#0,d0
	move.b	act2A(a0),d0
	jsr	$2006A2.l
	moveq	#0,d2
	move.b	act2D(a0),d2
	muls.w	d2,d0
	lsr.l	#8,d0
	rts

off_20F77A:
	dc.w	byte_20F780-off_20F77A
	dc.w	byte_20F796-off_20F77A
	dc.w	byte_20F7C0-off_20F77A
byte_20F780:
	dc.b	4
	dc.b	$F0,5,0,1,$F0
	dc.b	$F0,5,8,1,0
	dc.b	0,5,0,5,$F0
	dc.b	0,5,8,5,0
	even
byte_20F796:
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
byte_20F7C0:
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

off_20F7FE:
	dc.w	byte_20F804-off_20F7FE
	dc.w	byte_20F81A-off_20F7FE
	dc.w	byte_20F844-off_20F7FE
byte_20F804:
	dc.b	4
	dc.b	$F0,5,0,$31,$F0
	dc.b	$F0,5,8,$31,0
	dc.b	0,5,0,$35,$F0
	dc.b	0,5,8,$35,0
	even
byte_20F81A:
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
byte_20F844:
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