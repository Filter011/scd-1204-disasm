	phase	wkram+$E3FA

	dc.w	6
	beq.w	loc_20E402
	neg.w	d0

loc_20E402:
	add.w	d0,d1
	move.w	d1,8(a0)
	move.w	$32(a0),d0
	addq.w	#1,d0
	move.w	d0,$32(a0)
	cmpi.w	#$26,d0
	bne.w	locret_20E422
	move.b	#$20,$24(a0)
	bsr.s	$20E3B0

locret_20E422:
	rts

	lea	off_20ED1E.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

	lea	off_20ED1E.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

	rts

	dc.b	0,0,$F,$F8,$1F,$F0,$2F,$E8,$3F,$E0,$4F,$D8,$5F,$D0
	dc.b	0,0,$11,$FC,$23,$F8,$34,$F5,$46,$F1,$57,$EE,$69,$EA
	dc.b	0,0,$11,0,$23,$FF,$35,$FE,$47,$FD,$59,$FC,$6B,$FB
	dc.b	0,0,$11,5,$22,$A,$33,$F,$44,$14,$55,$19,$66,$1E
	dc.b	0,0,$F,8,$1F,$11,$2E,$1A,$3E,$22,$4E,$2B,$5D,$34
	dc.b	0,0,$D,$B,$1B,$16,$29,$22,$37,$2D,$44,$39,$52,$44
	dc.b	0,0,$B,$D,$17,$1A,$23,$28,$2F,$35,$3B,$43,$46,$50
	dc.b	0,0,9,$E,$13,$1D,$1D,$2C,$27,$3B,$31,$4A,$3B,$59
	dc.b	0,0,8,$F,$10,$1F,$18,$2F,$21,$3F,$29,$4F,$31,$5F
	dc.b	0,0,6,$10,$D,$21,$14,$31,$1B,$42,$21,$52,$28,$63
	dc.b	0,0,5,$11,$B,$22,$10,$33,$16,$44,$1B,$55,$21,$66
	dc.b	0,0,4,$11,8,$22,$D,$33,$11,$45,$16,$56,$1A,$67
	dc.b	0,0,3,$11,7,$23,$A,$34,$E,$46,$12,$57,$15,$69
	dc.b	0,0,2,$11,5,$23,8,$34,$B,$46,$E,$58,$11,$69
	dc.b	0,0,2,$11,4,$23,6,$35,8,$46,$B,$58,$D,$6A
	dc.b	0,0,1,$11,3,$23,5,$35,6,$47,8,$59,$A,$6A
	dc.b	0,0,1,$11,2,$23,3,$35,5,$47,6,$59,7,$6B
	dc.b	0,0,0,$11,1,$23,2,$35,3,$47,4,$59,5,$6B
	dc.b	0,0,0,$11,1,$23,1,$35,2,$47,3,$59,3,$6B
	dc.b	0,0,$F,7,$1F,$F,$2F,$17,$3F,$1F,$4F,$27,$5F,$2F
	dc.b	0,0,$E,9,$1D,$13,$2C,$1D,$3B,$27,$4A,$31,$59,$3B
	dc.b	0,0,$D,$B,$1B,$17,$28,$22,$36,$2E,$44,$3A,$51,$45
	dc.b	0,0,$C,$D,$18,$1A,$24,$27,$30,$34,$3C,$41,$49,$4E
	dc.b	0,0,$A,$E,$15,$1C,$20,$2B,$2A,$39,$35,$47,$40,$56
	dc.b	0,0,9,$F,$12,$1E,$1B,$2E,$24,$3D,$2D,$4C,$37,$5C
	dc.b	0,0,7,$10,$F,$20,$17,$30,$1F,$40,$26,$50,$2E,$60
	dc.b	0,0,6,$10,$C,$21,$13,$31,$19,$42,$20,$53,$26,$63
	dc.b	0,0,5,$11,$A,$22,$10,$33,$15,$44,$1A,$55,$20,$66
	dc.b	0,0,4,$11,8,$22,$D,$34,$11,$45,$15,$56,$1A,$68
	dc.b	0,0,3,$11,6,$23,$A,$34,$D,$46,$11,$57,$14,$69
	dc.b	0,0,2,$11,5,$23,8,$35,$B,$46,$D,$58,$10,$6A
	dc.b	0,0,2,$11,4,$23,6,$35,8,$47,$A,$58,$C,$6A
	dc.b	0,0,1,$11,3,$23,4,$35,6,$47,8,$59,9,$6A
	dc.b	0,0,1,$11,2,$23,3,$35,4,$47,6,$59,7,$6B
	dc.b	0,0,0,$11,1,$23,2,$35,3,$47,4,$59,5,$6B
	dc.b	0,0,0,$11,1,$23,1,$35,2,$47,3,$59,3,$6B
	dc.b	0,0,0,$11,0,$23,1,$35,1,$47,1,$59,2,$6B
	dc.b	0,0,0,$11,0,$23,0,$35,0,$47,1,$59,1,$6B

	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20E670(pc,d0.w),d0
	jmp	off_20E670(pc,d0.w)

off_20E670:
	dc.w	loc_20E674-off_20E670
	dc.w	loc_20E6DA-off_20E670

loc_20E674:
	addq.b	#2,$24(a0)
	move.l	#off_20EDDE,4(a0)
	move.b	#4,1(a0)
	move.b	#1,$18(a0)
	moveq	#$A,d0
	jsr	sub_20F8C0(pc)
	move.b	$28(a0),d0
	andi.b	#7,d0
	move.b	d0,$1C(a0)
	move.b	#$86,$20(a0)
	move.b	#$10,$19(a0)
	move.b	#$C,$16(a0)
	cmpi.b	#3,d0
	bne.w	loc_20E6C4
	move.b	#2,$19(a0)
	move.b	#$C,$16(a0)

loc_20E6C4:
	cmpi.b	#4,d0
	bmi.w	locret_20E6D8
	move.b	#$10,$19(a0)
	move.b	#3,$16(a0)

locret_20E6D8:
	rts

loc_20E6DA:
	lea	playerwk.w,a1
	move.w	8(a0),d3
	move.w	$C(a0),d4
	jsr	$209E14.l
	lea	off_20ED40.l,a1
	jsr	$20739E.l
	jsr	$20517A.l
	jmp	$208E96.l

	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20E712(pc,d0.w),d0
	jmp	off_20E712(pc,d0.w)

off_20E712:
	dc.w	loc_20E71A-off_20E712
	dc.w	loc_20E7FA-off_20E712
	dc.w	loc_20E9E6-off_20E712
	dc.w	loc_20EA50-off_20E712

loc_20E71A:
	addq.b	#2,$24(a0)
	move.l	#off_20EE4C,4(a0)
	move.b	#4,1(a0)
	move.b	#1,$18(a0)
	move.b	#$10,$19(a0)
	move.w	#$3FE,2(a0)
	move.b	$3D(a0),d0
	bne.s	loc_20E77C
	move.b	$28(a0),d6
	andi.w	#$F,d6
	jsr	sub_20E78A(pc)
	move.b	$3D(a1),d0
	ori.b	#$80,d0
	move.b	d0,$3D(a1)
	movea.w	a2,a4
	subq.w	#1,d6

loc_20E760:
	jsr	sub_20E78A(pc)
	subq.w	#1,d6
	bne.s	loc_20E760
	move.b	$28(a0),d0
	andi.b	#$70,d0
	cmpi.b	#$70,d0
	bne.s	locret_20E77A
	jsr	sub_20E7B4(pc)

locret_20E77A:
	rts

loc_20E77C:
	move.b	$3D(a0),d0
	bpl.s	locret_20E788
	move.b	#4,$24(a0)

locret_20E788:
	rts

sub_20E78A:
	jsr	$208E64.l
	bne.s	locret_20E7B2
	move.b	$28(a0),$28(a1)
	_move.b	#$29,0(a1)
	move.w	a0,$3E(a1)
	move.w	8(a0),8(a1)
	move.w	$C(a0),$C(a1)
	move.b	d6,$3D(a1)

locret_20E7B2:
	rts

sub_20E7B4:
	jsr	$208E64.l
	bne.s	locret_20E7B2
	_move.b	#$13,0(a1)
	move.w	8(a0),8(a1)
	move.w	$C(a0),$C(a1)
	move.w	a4,$3E(a1)
	move.b	#1,$3D(a1)
	rts

unk_20E7DA:
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2

loc_20E7FA:
	moveq	#0,d0
	move.b	$3D(a0),d0
	lea	unk_20E7DA.l,a3
	move.b	(a3,d0.w),d2
	move.b	d2,$1C(a0)
	tst.b	d0
	beq.s	loc_20E828
	jsr	sub_20E98E(pc)
	lea	off_20EE32.l,a1
	jsr	$20739E.l
	jmp	$20517A.l

loc_20E828:
	moveq	#0,d0
	move.b	$28(a0),d0
	andi.w	#$F0,d0
	asr.w	#2,d0
	lea	off_20E854.l,a3
	movea.l	(a3,d0.w),a4
	jsr	(a4)
	lea	off_20EE32.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

off_20E854:
	dc.l	loc_20E874
	dc.l	loc_20E880
	dc.l	loc_20E88C
	dc.l	loc_20E8BC
	dc.l	loc_20E8EC
	dc.l	loc_20E922
	dc.l	loc_20E958
	dc.l	loc_20E880

loc_20E874:
	move.b	$3C(a0),d0
	addq.w	#1,d0
	move.b	d0,$3C(a0)
	rts

loc_20E880:
	move.b	$3C(a0),d0
	subq.w	#1,d0
	move.b	d0,$3C(a0)
	rts

loc_20E88C:
	move.w	$32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,$32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20E8A6
	bmi.w	loc_20E8B0

loc_20E8A6:
	addi.w	#$40,d0
	move.b	d0,$3C(a0)
	rts

loc_20E8B0:
	not.w	d0
	addi.w	#$40,d0
	move.b	d0,$3C(a0)
	rts

loc_20E8BC:
	move.w	$32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,$32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20E8D6
	bmi.w	loc_20E8E0

loc_20E8D6:
	addi.w	#$C0,d0
	move.b	d0,$3C(a0)
	rts

loc_20E8E0:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,$3C(a0)
	rts

loc_20E8EC:
	move.w	$32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$300,d0
	bmi.w	loc_20E8FC
	moveq	#0,d0

loc_20E8FC:
	move.w	d0,$32(a0)
	cmpi.w	#$180,d0
	bpl.w	loc_20E90C
	bmi.w	loc_20E916

loc_20E90C:
	addi.w	#$C0,d0
	move.b	d0,$3C(a0)
	rts

loc_20E916:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,$3C(a0)
	rts

loc_20E922:
	move.w	$32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$200,d0
	bmi.w	loc_20E932
	moveq	#0,d0

loc_20E932:
	move.w	d0,$32(a0)
	cmpi.w	#$100,d0
	bpl.w	loc_20E942
	bmi.w	loc_20E94C

loc_20E942:
	addi.w	#$80,d0
	move.b	d0,$3C(a0)
	rts

loc_20E94C:
	addi.w	#$80,d0
	not.w	d0
	move.b	d0,$3C(a0)
	rts

loc_20E958:
	move.w	$32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$80,d0
	bmi.w	loc_20E968
	moveq	#0,d0

loc_20E968:
	move.w	d0,$32(a0)
	cmpi.w	#$40,d0
	bpl.w	loc_20E978
	bmi.w	loc_20E982

loc_20E978:
	addi.w	#$A0,d0
	move.b	d0,$3C(a0)
	rts

loc_20E982:
	addi.w	#$E0,d0
	not.w	d0
	move.b	d0,$3C(a0)
	rts

sub_20E98E:
	move.l	8(a0),$38(a0)
	move.l	$C(a0),$34(a0)
	movea.w	$3E(a0),a2
	moveq	#0,d0
	move.b	$3C(a2),d0
	jsr	$2006A2.l
	moveq	#0,d3
	move.b	$3D(a0),d3
	andi.w	#$F,d3
	mulu.w	#$100,d3
	muls.w	d3,d0
	asl.l	#4,d0
	move.l	d0,d4
	move.l	8(a2),d2
	add.l	d0,d2
	move.l	d2,8(a0)
	muls.w	d3,d1
	asl.l	#4,d1
	move.l	d1,d5
	move.l	$C(a2),d2
	add.l	d1,d2
	move.l	d2,$C(a0)
	asr.l	#8,d4
	asr.l	#8,d5
	move.w	d4,$10(a2)
	move.w	d5,$12(a2)
	rts

loc_20E9E6:
	move.b	#3,$1C(a0)
	bsr.s	sub_20E98E
	move.b	#$18,$19(a0)
	move.b	#8,$16(a0)
	move.b	#8,$16(a0)
	lea	playerwk.w,a1
	bsr.w	$20D4D4
	beq.w	loc_20EA3C
	bsr.w	sub_20EA9A
	bne.w	loc_20EA3C
	move.w	$C(a0),d0
	moveq	#0,d1
	move.b	$16(a1),d1
	sub.w	d1,d0
	move.b	$16(a0),d1
	sub.w	d1,d0
	move.w	d0,$C(a1)
	bset	#3,$22(a1)
	bclr	#1,$22(a1)
	move.b	#6,$24(a0)

loc_20EA3C:
	lea	off_20EE32.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

loc_20EA50:
	move.b	#3,$1C(a0)
	bsr.w	sub_20E98E
	lea	playerwk.w,a1
	moveq	#$10,d0
	bsr.w	$20D4D4
	tst.b	d1
	beq.w	loc_20EA8C
	move.l	8(a0),d0
	sub.l	$38(a0),d0
	add.l	8(a1),d0
	move.l	d0,8(a1)
	move.l	$C(a0),d0
	sub.l	$34(a0),d0
	add.l	$C(a1),d0
	move.l	d0,$C(a1)
	bra.s	loc_20EA3C

loc_20EA8C:
	bclr	#3,$22(a1)
	move.b	#4,$24(a0)
	bra.s	loc_20EA3C

sub_20EA9A:
	lea	playerwk.w,a1
	moveq	#0,d2
	moveq	#0,d3
	move.b	$16(a0),d2
	move.b	$16(a1),d3
	move.w	$C(a0),d0
	move.w	$C(a1),d1
	add.w	d2,d0
	add.w	d3,d1
	cmp.w	d0,d1
	bpl.w	loc_20EAC0
	bmi.w	loc_20EAC4

loc_20EAC0:
	moveq	#-1,d1
	rts

loc_20EAC4:
	moveq	#0,d1
	rts

	dc.b	1
	dc.b	$F8,5,0,0,$F8
	dc.b	1
	dc.b	$F8,$D,0,4,$F0
	dc.b	1
	dc.b	$FC,0,0,$C,$FC
	dc.b	1
	dc.b	$F0,3,0,$D,$FC
	dc.b	1
	dc.b	$F0,3,0,$11,$FC
	dc.b	1
	dc.b	$F8,5,8,0,$F8
	dc.b	1
	dc.b	$F8,$D,8,4,$F0
	dc.b	1
	dc.b	$FC,0,8,$C,$FC
	dc.b	1
	dc.b	$F0,3,8,$D,$FC
	dc.b	1
	dc.b	$F0,3,8,$11,$FC

off_20EB04:
	dc.w	unk_20EB0E-off_20EB04
	dc.w	unk_20EB1E-off_20EB04
	dc.w	unk_20EB28-off_20EB04
	dc.w	unk_20EB32-off_20EB04
	dc.w	unk_20EB36-off_20EB04
unk_20EB0E:
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	5
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	$FF
unk_20EB1E:
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	$FF
	even
unk_20EB28:
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	5
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	$FF
	even
unk_20EB32:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20EB36:
	dc.b	0
	dc.b	3
	dc.b	$FF
	even

off_20EB3A:
	dc.w	byte_20EB46-off_20EB3A
	dc.w	byte_20EB52-off_20EB3A
	dc.w	byte_20EB5E-off_20EB3A
	dc.w	byte_20EB6A-off_20EB3A
	dc.w	byte_20EB76-off_20EB3A
	dc.w	byte_20EB82-off_20EB3A
byte_20EB46:
	dc.b	2
	dc.b	$FC,1,0,0,$F8
	dc.b	$FC,8,0,2,0
	even
byte_20EB52:
	dc.b	2
	dc.b	$FC,5,0,5,$F8
	dc.b	0,5,0,9,8
	even
byte_20EB5E:
	dc.b	2
	dc.b	$FC,5,0,$D,$F8
	dc.b	$F0,5,0,$11,8
	even
byte_20EB6A:
	dc.b	2
	dc.b	$FC,1,8,0,0
	dc.b	$FC,8,8,2,$E8
	even
byte_20EB76:
	dc.b	2
	dc.b	$FC,5,8,5,$F8
	dc.b	0,5,8,9,$E8
	even
byte_20EB82:
	dc.b	2
	dc.b	$FC,5,8,$D,$F8
	dc.b	$F0,5,8,$11,$E8
	even

off_20EB8E:
	dc.w	unk_20EBAA-off_20EB8E
	dc.w	unk_20EBBA-off_20EB8E
	dc.w	unk_20EBBE-off_20EB8E
	dc.w	unk_20EBC2-off_20EB8E
	dc.w	unk_20EBC6-off_20EB8E
	dc.w	unk_20EBCA-off_20EB8E
	dc.w	unk_20EBCE-off_20EB8E
	dc.w	unk_20EBD2-off_20EB8E
	dc.w	unk_20EBD6-off_20EB8E
	dc.w	unk_20EBDA-off_20EB8E
	dc.w	unk_20EBDE-off_20EB8E
	dc.w	unk_20EBE2-off_20EB8E
	dc.w	unk_20EBE6-off_20EB8E
	dc.w	unk_20EBEA-off_20EB8E
unk_20EBAA:
	dc.b	9
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	5
	dc.b	6
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	$B
	dc.b	$C
	dc.b	$FF
	even
unk_20EBBA:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20EBBE:
	dc.b	0
	dc.b	1
	dc.b	$FF
	even
unk_20EBC2:
	dc.b	0
	dc.b	2
	dc.b	$FF
	even
unk_20EBC6:
	dc.b	0
	dc.b	3
	dc.b	$FF
	even
unk_20EBCA:
	dc.b	0
	dc.b	4
	dc.b	$FF
	even
unk_20EBCE:
	dc.b	0
	dc.b	5
	dc.b	$FF
	even
unk_20EBD2:
	dc.b	0
	dc.b	6
	dc.b	$FF
	even
unk_20EBD6:
	dc.b	0
	dc.b	7
	dc.b	$FF
	even
unk_20EBDA:
	dc.b	0
	dc.b	8
	dc.b	$FF
	even
unk_20EBDE:
	dc.b	0
	dc.b	9
	dc.b	$FF
	even
unk_20EBE2:
	dc.b	0
	dc.b	$A
	dc.b	$FF
	even
unk_20EBE6:
	dc.b	0
	dc.b	$B
	dc.b	$FF
	even
unk_20EBEA:
	dc.b	0
	dc.b	$C
	dc.b	$FF
	even

off_20EBEE:
	dc.w	byte_20EC08-off_20EBEE
	dc.w	byte_20EC18-off_20EBEE
	dc.w	byte_20EC32-off_20EBEE
	dc.w	byte_20EC42-off_20EBEE
	dc.w	byte_20EC66-off_20EBEE
	dc.w	byte_20EC80-off_20EBEE
	dc.w	byte_20EC90-off_20EBEE
	dc.w	byte_20ECA0-off_20EBEE
	dc.w	byte_20ECBA-off_20EBEE
	dc.w	byte_20ECCA-off_20EBEE
	dc.w	byte_20ECEE-off_20EBEE
	dc.w	byte_20ED08-off_20EBEE
	dc.w	byte_20ED18-off_20EBEE
byte_20EC08:
	dc.b	3
	dc.b	$F0,$C,0,0,0
	dc.b	8,$C,$18,0,$E0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20EC18:
	dc.b	5
	dc.b	$F0,$C,0,4,0
	dc.b	$E8,0,0,8,$18
	dc.b	8,$C,$18,4,$E0
	dc.b	$10,0,$18,8,$E0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20EC32:
	dc.b	3
	dc.b	$E8,$D,0,9,0
	dc.b	8,$D,$18,9,$E0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20EC42:
	dc.b	7
	dc.b	$E8,$D,0,$11,0
	dc.b	$E0,0,0,$19,$10
	dc.b	$F0,0,0,$1A,$F8
	dc.b	8,$D,$18,$11,$E0
	dc.b	$18,0,$18,$19,$E8
	dc.b	8,0,$18,$1A,0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20EC66:
	dc.b	5
	dc.b	$E0,$E,0,$1B,0
	dc.b	$F0,0,0,$27,$F8
	dc.b	8,$E,$18,$1B,$E0
	dc.b	8,0,$18,$27,0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20EC80:
	dc.b	3
	dc.b	$E0,6,0,$28,$F8
	dc.b	8,6,$10,$28,$F8
	dc.b	$FC,0,$C0,$2E,$FC
byte_20EC90:
	dc.b	3
	dc.b	$F0,$C,8,0,$E0
	dc.b	8,$C,$10,0,0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20ECA0:
	dc.b	5
	dc.b	$F0,$C,8,4,$E0
	dc.b	$E8,0,8,8,$E0
	dc.b	8,$C,$10,4,0
	dc.b	$10,0,$10,8,$18
	dc.b	$FC,0,$C0,$2E,$FC
byte_20ECBA:
	dc.b	3
	dc.b	$E8,$D,8,9,$E0
	dc.b	8,$D,$10,9,0
	dc.b	$FC,0,$C0,$2E,$FC
byte_20ECCA:
	dc.b	7
	dc.b	$E8,$D,8,$11,$E0
	dc.b	$E0,0,8,$19,$E8
	dc.b	$F0,0,8,$1A,0
	dc.b	8,$D,$10,$11,0
	dc.b	$18,0,$10,$19,$10
	dc.b	8,0,$10,$1A,$F8
	dc.b	$FC,0,$C0,$2E,$FC
byte_20ECEE:
	dc.b	5
	dc.b	$E0,$E,8,$1B,$E0
	dc.b	$F0,0,8,$27,0
	dc.b	8,$E,$10,$1B,0
	dc.b	8,0,$10,$27,$F8
	dc.b	$FC,0,$C0,$2E,$FC
byte_20ED08:
	dc.b	3
	dc.b	$E0,6,8,$28,$F8
	dc.b	8,6,$18,$28,$F8
	dc.b	$FC,0,$C0,$2E,$FC
byte_20ED18:
	dc.b	1
	dc.b	$FC,0,$C0,$2E,$FC

off_20ED1E:
	dc.w	unk_20ED24-off_20ED1E
	dc.w	unk_20ED28-off_20ED1E
	dc.w	unk_20ED2C-off_20ED1E
unk_20ED24:
	dc.b	$1D
	dc.b	0
	dc.b	1
	dc.b	$FF
unk_20ED28:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20ED2C:
	dc.b	0
	dc.b	1
	dc.b	$FF
	even

off_20ED30:
	dc.w	byte_20ED34-off_20ED30
	dc.w	byte_20ED3A-off_20ED30
byte_20ED34:
	dc.b	1
	dc.b	$F8,5,0,0,$F8
byte_20ED3A:
	dc.b	1
	dc.b	$F8,5,0,4,$F8

off_20ED40:
	dc.w	unk_20ED4C-off_20ED40
	dc.w	unk_20ED50-off_20ED40
	dc.w	unk_20ED54-off_20ED40
	dc.w	unk_20ED58-off_20ED40
	dc.w	unk_20ED5C-off_20ED40
	dc.w	unk_20ED60-off_20ED40
unk_20ED4C:
	dc.b	$1D
	dc.b	0
	dc.b	$FF
	even
unk_20ED50:
	dc.b	$1D
	dc.b	1
	dc.b	$FF
	even
unk_20ED54:
	dc.b	$1D
	dc.b	2
	dc.b	$FF
	even
unk_20ED58:
	dc.b	$1D
	dc.b	3
	dc.b	$FF
	even
unk_20ED5C:
	dc.b	$1D
	dc.b	4
	dc.b	$FF
	even
unk_20ED60:
	dc.b	$1D
	dc.b	5
	dc.b	$FF
	even

off_20ED64:
	dc.w	byte_20ED6A-off_20ED64
	dc.w	byte_20ED75-off_20ED64
	dc.w	byte_20ED80-off_20ED64
byte_20ED6A:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20ED75:
	dc.b	2
	dc.b	$F0,$D,0,8,$F0
	dc.b	0,$D,0,8,$F0
byte_20ED80:
	dc.b	2
	dc.b	$F0,$D,8,8,$F0
	dc.b	0,$D,8,8,$F0
	even

off_20ED8C:
	dc.w	byte_20ED94-off_20ED8C
	dc.w	byte_20EDA9-off_20ED8C
	dc.w	byte_20EDBE-off_20ED8C
	dc.w	byte_20EDD3-off_20ED8C
byte_20ED94:
	dc.b	4
	dc.b	$F0,3,0,0,$F0
	dc.b	$F1,3,0,0,$F8
	dc.b	$F2,3,0,0,0
	dc.b	$F3,3,0,0,8
byte_20EDA9:
	dc.b	4
	dc.b	$F0,$C,0,4,$F0
	dc.b	$F8,$C,0,4,$F1
	dc.b	0,$C,0,4,$F2
	dc.b	8,$C,0,4,$F3
byte_20EDBE:
	dc.b	4
	dc.b	$F0,$C,8,4,$F3
	dc.b	$F8,$C,8,4,$F2
	dc.b	0,$C,8,4,$F1
	dc.b	8,$C,8,4,$F0
byte_20EDD3:
	dc.b	2
	dc.b	$F0,3,0,0,$F4
	dc.b	$F0,3,0,0,4

off_20EDDE:
	dc.w	byte_20EDEA-off_20EDDE
	dc.w	byte_20EDF5-off_20EDDE
	dc.w	byte_20EE0A-off_20EDDE
	dc.w	byte_20EE1F-off_20EDDE
	dc.w	byte_20EE26-off_20EDDE
	dc.w	byte_20EE2C-off_20EDDE
byte_20EDEA:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20EDF5:
	dc.b	4
	dc.b	$F0,$C,0,8,$F0
	dc.b	$F8,$C,0,8,$F0
	dc.b	0,$C,0,8,$F0
	dc.b	8,$C,0,8,$F0
byte_20EE0A:
	dc.b	4
	dc.b	$F0,$C,8,8,$F0
	dc.b	$F8,$C,8,8,$F0
	dc.b	0,$C,8,8,$F0
	dc.b	8,$C,8,8,$F0
byte_20EE1F:
	dc.b	1
	dc.b	$F0,3,0,0,$FC
	even
byte_20EE26:
	dc.b	1
	dc.b	$FC,$C,0,8,$F0
byte_20EE2C:
	dc.b	1
	dc.b	$FC,$C,8,8,$F0

off_20EE32:
	dc.w	unk_20EE3A-off_20EE32
	dc.w	unk_20EE40-off_20EE32
	dc.w	unk_20EE44-off_20EE32
	dc.w	unk_20EE48-off_20EE32
unk_20EE3A:
	dc.b	$1D
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	$FF
	even
unk_20EE40:
	dc.b	$1D
	dc.b	0
	dc.b	$FF
	even
unk_20EE44:
	dc.b	$1D
	dc.b	1
	dc.b	$FF
	even
unk_20EE48:
	dc.b	$1D
	dc.b	2
	dc.b	$FF
	even

off_20EE4C:
	dc.w	byte_20EE52-off_20EE4C
	dc.w	byte_20EE58-off_20EE4C
	dc.w	byte_20EE5E-off_20EE4C
byte_20EE52:
	dc.b	1
	dc.b	$F8,5,0,0,$F8
byte_20EE58:
	dc.b	1
	dc.b	$F8,5,0,4,$F8
byte_20EE5E:
	dc.b	2
	dc.b	$F8,9,0,8,$E8
	dc.b	$F8,9,8,8,0
	even

	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20EE7E(pc,d0.w),d0
	jsr	off_20EE7E(pc,d0.w)
	jmp	$20517A.l

off_20EE7E:
	dc.w	loc_20EE86-off_20EE7E
	dc.w	loc_20EEFA-off_20EE7E
	dc.w	loc_20EF40-off_20EE7E
	dc.w	loc_20EF84-off_20EE7E

loc_20EE86:
	addq.b	#2,$24(a0)
	ori.b	#4,1(a0)
	move.b	#3,$18(a0)
	move.w	#$4000,2(a0)
	lea	off_20F19A(pc),a1
	lea	unk_20F210(pc),a2
	move.b	$28(a0),d0
	bpl.w	loc_20EEB4
	lea	off_20F266(pc),a1
	lea	off_20F32A(pc),a2

loc_20EEB4:
	move.l	a1,4(a0)
	btst	#4,d0
	beq.w	loc_20EECC
	bset	#0,1(a0)
	bset	#0,$22(a0)

loc_20EECC:
	andi.w	#$F,d0
	move.b	d0,$1A(a0)
	add.w	d0,d0
	move.w	(a2,d0.w),d0
	move.b	(a2,d0.w),d1
	addq.b	#1,d1
	asl.b	#3,d1
	move.b	d1,$19(a0)
	move.b	1(a2,d0.w),d1
	bpl.w	loc_20EEF0
	neg.b	d1

loc_20EEF0:
	addq.b	#1,d1
	asl.b	#3,d1
	addq.b	#2,d1
	move.b	d1,$16(a0)

loc_20EEFA:
	tst.b	1(a0)
	bpl.s	locret_20EF2E
	move.w	8(a0),d3
	move.w	$C(a0),d4
	lea	playerwk.w,a3
	lea	byte_FFD040.w,a1
	move.b	main_play,d0
	beq.w	loc_20EF1C
	exg.l	a1,a3

loc_20EF1C:
	jsr	$209E14.l
	exg.l	a1,a3
	jsr	$209E14.l
	bne.w	loc_20EF30

locret_20EF2E:
	rts

loc_20EF30:
	addq.b	#2,$24(a0)
	move.b	$28(a0),d0
	bpl.w	loc_20EFBE
	bra.w	loc_20F0B0

loc_20EF40:
	lea	$2A(a0),a3
	addi.w	#-1,(a3)
	bne.w	loc_20EF50
	addq.b	#2,$24(a0)

loc_20EF50:
	move.b	$3E(a0),d0
	beq.w	locret_20EF82
	move.w	8(a0),d3
	move.w	$C(a0),d4
	lea	playerwk.w,a1
	bsr.w	sub_20EF6C
	lea	byte_FFD040.w,a1

sub_20EF6C:
	jsr	$209E14.l
	beq.w	locret_20EF82
	tst.w	(a3)
	bne.w	locret_20EF82
	bclr	#3,$22(a1)

locret_20EF82:
	rts

loc_20EF84:
	move.l	$2C(a0),d0
	add.l	d0,$C(a0)
	addi.l	#$4000,$2C(a0)
	move.w	$C(a0),d0
	lea	playerwk.w,a1
	move.b	main_play,d1
	beq.w	loc_20EFAA
	lea	byte_FFD040.w,a1

loc_20EFAA:
	sub.w	$C(a1),d0
	cmpi.w	#$200,d0
	bgt.w	loc_20EFB8
	rts

loc_20EFB8:
	jmp	$2051FE.l

loc_20EFBE:
	move.b	$28(a0),d0
	suba.l	a4,a4
	btst	#4,d0
	beq.w	loc_20EFD0
	lea	loc_20EFBE(pc),a4

loc_20EFD0:
	lea	unk_20F210(pc),a6
	andi.w	#$F,d0
	add.w	d0,d0
	move.w	(a6,d0.w),d0
	lea	(a6,d0.w),a6
	moveq	#0,d0
	move.b	(a6)+,d0
	movea.w	d0,a5
	asl.w	#3,d0
	move.w	#-$10,d1
	cmpa.w	#0,a4
	bne.w	loc_20EFFA
	neg.w	d0
	neg.w	d1

loc_20EFFA:
	add.w	8(a0),d0
	movea.w	d0,a2
	movea.w	d1,a3
	moveq	#0,d6
	move.b	(a6)+,d6
	move.w	d6,d4
	asl.w	#3,d4
	add.w	$C(a0),d4
	move.w	#9,d2
	_move.b	0(a0),$3F(a0)
	_clr.b	0(a0)

loc_20F01C:
	move.w	a5,d5
	move.w	a2,d3
	move.w	d2,d1

loc_20F022:
	jsr	$208E7A.l
	bne.w	locret_20F0AE
	move.b	(a6)+,d0
	bmi.w	loc_20F09A
	move.b	d0,$1A(a1)
	ori.b	#4,1(a1)
	move.b	#3,$18(a1)
	move.w	#$4000,2(a1)
	move.l	#off_20F228,4(a1)
	move.l	#$20000,$2C(a1)
	_move.b	$3F(a0),0(a1)
	move.b	$24(a0),$24(a1)
	cmpa.w	#0,a4
	beq.w	loc_20F078
	bset	#0,1(a1)
	bset	#0,$22(a1)

loc_20F078:
	tst.w	d6
	bne.w	loc_20F08E
	st	$3E(a1)
	move.b	#8,$19(a1)
	move.b	#9,$16(a1)

loc_20F08E:
	move.w	d4,$C(a1)
	move.w	d3,8(a1)
	move.w	d1,$2A(a1)

loc_20F09A:
	add.w	a3,d3
	addi.w	#$C,d1
	dbf	d5,loc_20F022
	addi.w	#-$10,d4
	addq.w	#5,d2
	dbf	d6,loc_20F01C

locret_20F0AE:
	rts

loc_20F0B0:
	move.b	$28(a0),d2
	lea	off_20F32A(pc),a6
	move.b	d2,d0
	andi.w	#$1F,d0
	add.w	d0,d0
	move.w	(a6,d0.w),d0
	lea	(a6,d0.w),a6
	move.b	(a6)+,d5
	move.b	(a6)+,d1
	addq.b	#1,d1
	asl.b	#3,d1
	addq.b	#2,d1
	andi.w	#$FF,d5
	move.w	d5,d4
	lsl.w	#3,d4
	neg.w	d4
	move.w	#$10,d3
	moveq	#1,d6
	btst	#6,d2
	bne.w	loc_20F0F0
	lsl.b	#2,d2
	bra.w	loc_20F112

loc_20F0F0:
	lea	playerwk.w,a1
	move.b	main_play,d0
	beq.w	loc_20F102
	lea	byte_FFD040.w,a1

loc_20F102:
	move.w	$10(a1),d0
	btst	#5,d2
	beq.w	loc_20F110
	neg.w	d0

loc_20F110:
	tst.w	d0

loc_20F112:
	bpl.w	loc_20F120
	lea	(a6,d5.w),a6
	neg.w	d4
	neg.w	d3
	neg.w	d6

loc_20F120:
	add.w	8(a0),d4
	move.w	#9,d2
	_move.b	0(a0),$3F(a0)
	_clr.b	0(a0)

loc_20F132:
	jsr	$208E7A.l
	bne.w	locret_20F198
	move.b	#3,$18(a1)
	move.w	#$4000,2(a1)
	ori.b	#4,1(a1)
	move.l	#off_20F336,4(a1)
	move.l	#$20000,$2C(a1)
	_move.b	$3F(a0),0(a1)
	move.b	$24(a0),$24(a1)
	move.w	$C(a0),$C(a1)
	st	$3E(a1)
	move.b	#8,$19(a1)
	move.b	d1,$16(a1)
	move.b	(a6),$1A(a1)
	lea	(a6,d6.w),a6
	move.w	d4,8(a1)
	add.w	d3,d4
	move.w	d2,$2A(a1)
	addi.w	#$C,d2
	dbf	d5,loc_20F132

locret_20F198:
	rts

off_20F19A:
	dc.w	byte_20F19C-off_20F19A
byte_20F19C:
	dc.b	23
	dc.b	$D0,5,8,$D,$D8
	dc.b	$D0,5,8,$D,$E8
	dc.b	$D0,5,8,$D,$F8
	dc.b	$D0,5,8,$D,8
	dc.b	$D0,5,8,$D,$18
	dc.b	$E0,5,8,$11,$D8
	dc.b	$E0,5,8,$11,$E8
	dc.b	$E0,5,8,$11,$F8
	dc.b	$E0,5,8,$11,8
	dc.b	$E0,5,8,$11,$18
	dc.b	$F0,5,0,$19,$D8
	dc.b	$F0,5,8,$15,$E8
	dc.b	$F0,5,8,$15,$F8
	dc.b	$F0,5,8,$15,8
	dc.b	$F0,5,8,$15,$18
	dc.b	0,5,8,$25,$D8
	dc.b	0,5,0,$1D,$E8
	dc.b	0,5,0,$21,$F8
	dc.b	0,5,0,$21,8
	dc.b	0,5,8,$1D,$18
	dc.b	$10,5,0,$19,$F8
	dc.b	$10,5,0,$19,8
	dc.b	$10,5,0,$19,$18

unk_20F210:
	dc.b	0
	dc.b	2
	dc.b	4
	dc.b	3
	dc.b	$FF
	dc.b	$FF
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	0
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6

off_20F228:
	dc.w	byte_20F236-off_20F228
	dc.w	byte_20F23C-off_20F228
	dc.w	byte_20F242-off_20F228
	dc.w	byte_20F248-off_20F228
	dc.w	byte_20F24E-off_20F228
	dc.w	byte_20F254-off_20F228
	dc.w	byte_20F25A-off_20F228
byte_20F236:
	dc.b	1
	dc.b	$F8,5,0,$19,$F8
byte_20F23C:
	dc.b	1
	dc.b	$F8,5,8,$25,$F8
byte_20F242:
	dc.b	1
	dc.b	$F8,5,0,$1D,$F8
byte_20F248:
	dc.b	1
	dc.b	$F8,5,0,$21,$F8
byte_20F24E:
	dc.b	1
	dc.b	$F8,5,8,$1D,$F8
byte_20F254:
	dc.b	1
	dc.b	$F8,5,8,$15,$F8
byte_20F25A:
	dc.b	2
	dc.b	$E8,5,8,$D,$F8
	dc.b	$F8,5,8,$11,$F8
	even

off_20F266:
	dc.w	byte_20F26A-off_20F266
	dc.w	byte_20F26A-off_20F266
byte_20F26A:
	dc.b	18
	dc.b	$E0,5,0,$D,$D0
	dc.b	$E0,5,0,$D,$E0
	dc.b	$E0,5,0,$D,$F0
	dc.b	$E0,5,0,$D,0
	dc.b	$E0,5,0,$D,$10
	dc.b	$E0,5,0,$D,$20
	dc.b	$F0,5,0,$11,$D0
	dc.b	$F0,5,0,$11,$E0
	dc.b	$F0,5,0,$11,$F0
	dc.b	$F0,5,0,$11,0
	dc.b	$F0,5,0,$11,$10
	dc.b	$F0,5,0,$11,$20
	dc.b	0,5,0,$15,$D0
	dc.b	0,5,0,$15,$E0
	dc.b	0,5,0,$15,$F0
	dc.b	0,5,0,$15,0
	dc.b	0,5,0,$15,$10
	dc.b	0,5,0,$15,$20

	dc.b	20
	dc.b	$D0,5,0,$D,$E0
	dc.b	$D0,5,0,$D,$F0
	dc.b	$D0,5,0,$D,0
	dc.b	$D0,5,0,$D,$10
	dc.b	$E0,5,0,$11,$E0
	dc.b	$E0,5,0,$11,$F0
	dc.b	$E0,5,0,$11,0
	dc.b	$E0,5,0,$11,$10
	dc.b	$F0,5,0,$15,$E0
	dc.b	$F0,5,0,$15,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	$F0,5,0,$15,$10
	dc.b	0,5,0,$29,$E0
	dc.b	0,5,0,$33,$F0
	dc.b	0,5,0,$33,0
	dc.b	0,5,0,$33,$10
	dc.b	$10,5,0,$31,$E0
	dc.b	$10,5,0,$2B,$F0
	dc.b	$10,5,0,$2B,0
	dc.b	$10,5,0,$2B,$10

off_20F32A:
	dc.w	unk_20F32E-off_20F32A
	dc.w	unk_20F32E-off_20F32A
unk_20F32E:
	dc.b	5
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

off_20F336:
	dc.w	byte_20F338-off_20F336
byte_20F338:
	dc.b	3
	dc.b	$E0,5,0,$D,$F8
	dc.b	$F0,5,0,$11,$F8
	dc.b	0,5,0,$15,$F8

	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20F35E(pc,d0.w),d0
	jsr	off_20F35E(pc,d0.w)
	jsr	$20517A.l
	rts

off_20F35E:
	dc.w	loc_20F374-off_20F35E
	dc.w	loc_20F446-off_20F35E

sub_20F362:
	lea	playerwk.w,a1
	move.w	8(a0),d3
	move.w	$C(a0),d4
	jmp	$209E14.l

loc_20F374:
	ori.b	#4,1(a0)
	move.w	#$4000,2(a0)
	move.b	#3,$18(a0)
	move.w	8(a0),$38(a0)
	move.w	$C(a0),$3A(a0)
	move.w	$C(a0),$36(a0)
	move.l	#off_20F77A,d0
	cmpi.w	#0,stageno
	beq.s	loc_20F3BE
	move.l	#off_20F7FE,d0
	cmpi.w	#1,stageno
	beq.s	loc_20F3BE
	move.l	#off_20F7FE,d0

loc_20F3BE:
	move.l	d0,4(a0)
	move.b	$28(a0),d0
	move.b	d0,d1
	andi.w	#3,d0
	move.b	d0,$1A(a0)
	move.b	byte_20F43E(pc,d0.w),$19(a0)
	move.b	#8,$16(a0)
	lsr.b	#2,d1
	andi.w	#3,d1
	move.b	byte_20F442(pc,d1.w),$2D(a0)
	move.b	$29(a0),d0
	beq.s	loc_20F438
	jsr	$208E64.l
	beq.s	loc_20F3FC
	jmp	$2051FE.l

loc_20F3FC:
	_move.b	#$A,0(a1)
	move.w	8(a0),8(a1)
	move.w	$C(a0),$C(a1)
	subi.w	#$10,$C(a1)
	move.b	#$F0,$39(a1)
	move.w	a0,$34(a1)
	move.b	$29(a0),d0
	move.b	d0,d1
	andi.b	#2,d1
	move.b	d1,$28(a1)
	andi.b	#$F8,d0
	move.b	d0,$38(a1)
	add.w	d0,8(a1)

loc_20F438:
	addq.b	#2,$24(a0)
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
	move.b	$28(a0),d0
	lsr.b	#4,d0
	andi.w	#$F,d0
	add.w	d0,d0
	move.w	off_20F48A(pc,d0.w),d0
	jsr	off_20F48A(pc,d0.w)
	move.w	$38(a0),d0
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
	addq.b	#1,$2A(a0)
	jsr	sub_20F762(pc)
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	jmp	sub_20F362.l

loc_20F4B4:
	move.l	8(a0),-(sp)
	jsr	sub_20F762(pc)
	add.w	$38(a0),d0
	move.w	d0,8(a0)
	addq.b	#1,$2A(a0)
	moveq	#0,d0
	move.b	$2C(a0),d0
	asr.b	#1,d0
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)

loc_20F4D8:
	move.l	(sp)+,d0
	move.l	8(a0),d1
	sub.l	d0,d1
	asr.l	#8,d1
	move.w	d1,$10(a0)

loc_20F4E6:
	jsr	sub_20F362(pc)
	beq.s	loc_20F4FE
	move.b	$2C(a0),d0
	cmpi.b	#8,d0
	bhs.s	loc_20F4FA
	addq.b	#1,$2C(a0)

loc_20F4FA:
	moveq	#1,d0
	rts

loc_20F4FE:
	moveq	#0,d0
	move.b	$2C(a0),d0
	beq.s	loc_20F50A
	subq.b	#1,$2C(a0)

loc_20F50A:
	moveq	#0,d0
	rts

loc_20F50E:
	move.l	8(a0),-(sp)
	addq.b	#1,$2A(a0)
	jsr	sub_20F762(pc)
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	jsr	sub_20F762(pc)
	add.w	$38(a0),d0
	move.w	d0,8(a0)
	bra.w	loc_20F4D8

loc_20F532:
	move.l	8(a0),-(sp)
	addq.b	#1,$2A(a0)
	jsr	sub_20F762(pc)
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	jsr	sub_20F762(pc)
	neg.w	d0
	add.w	$38(a0),d0
	move.w	d0,8(a0)
	bra.w	loc_20F4D8

sub_20F558:
	moveq	#0,d0
	move.b	$2C(a0),d0
	asr.b	#1,d0
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	bra.w	loc_20F4E6

loc_20F56C:
	move.b	$2B(a0),d0
	bne.s	loc_20F584
	jsr	sub_20F558(pc)
	bne.s	loc_20F57A
	rts

loc_20F57A:
	move.b	#30,$2E(a0)
	addq.b	#2,$2B(a0)

loc_20F584:
	move.b	$2E(a0),d0
	beq.s	loc_20F592
	subq.b	#1,$2E(a0)
	bra.w	sub_20F558

loc_20F592:
	jsr	$205124.l
	addi.w	#$18,$12(a0)
	move.w	scra_v_posit.w,d0
	addi.w	#$E0,d0
	cmp.w	$C(a0),d0
	bhs.s	loc_20F5B2
	jmp	$2051FE.l

loc_20F5B2:
	lea	playerwk.w,a1
	bclr	#3,$22(a1)
	rts

loc_20F5BE:
	move.b	$2B(a0),d0
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
	addq.b	#2,$2B(a0)

loc_20F5E0:
	move.b	$2A(a0),d0
	cmpi.b	#$40,d0
	bhs.w	loc_20F604
	jsr	sub_20F762(pc)
	neg.w	d0
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	addq.b	#2,$2A(a0)
	jmp	sub_20F362.l

loc_20F604:
	move.w	$C(a0),$3A(a0)
	addq.b	#2,$2B(a0)

loc_20F60E:
	bra.w	sub_20F558

loc_20F612:
	move.b	$2B(a0),d0
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
	addq.b	#2,$2B(a0)
	move.b	#60,$2E(a0)

loc_20F63A:
	move.b	$2E(a0),d0
	beq.s	loc_20F648
	subq.b	#1,$2E(a0)
	bra.w	sub_20F558

loc_20F648:
	jsr	$205124.l
	subq.w	#8,$12(a0)
	jsr	$2081F0.l
	tst.w	d1
	bmi.s	loc_20F660
	bra.w	loc_20F4E6

loc_20F660:
	sub.w	d1,$C(a0)
	move.w	$C(a0),$3A(a0)
	addq.b	#2,$2B(a0)

loc_20F66E:
	bra.w	sub_20F558

loc_20F672:
	move.b	$2B(a0),d0
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
	addq.b	#2,$2B(a0)
	move.b	#60,$2E(a0)

loc_20F69A:
	move.b	$2E(a0),d0
	beq.s	loc_20F6A8
	subq.b	#1,$2E(a0)
	bra.w	sub_20F558

loc_20F6A8:
	move.b	$2A(a0),d0
	cmpi.b	#$40,d0
	bhs.w	loc_20F6DC
	move.l	8(a0),-(sp)
	jsr	sub_20F762(pc)
	add.w	$38(a0),d0
	move.w	d0,8(a0)
	addq.b	#1,$2A(a0)
	moveq	#0,d0
	move.b	$2C(a0),d0
	asr.b	#1,d0
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	bra.w	loc_20F4D8

loc_20F6DC:
	move.w	8(a0),$38(a0)
	addq.b	#2,$2B(a0)

loc_20F6E6:
	bra.w	sub_20F558

loc_20F6EA:
	move.b	$2B(a0),d0
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
	addq.b	#2,$2B(a0)
	move.b	#60,$2E(a0)

loc_20F712:
	move.b	$2E(a0),d0
	beq.s	loc_20F720
	subq.b	#1,$2E(a0)
	bra.w	sub_20F558

loc_20F720:
	move.b	$2A(a0),d0
	cmpi.b	#$40,d0
	bhs.s	loc_20F754
	move.l	8(a0),-(sp)
	jsr	sub_20F762(pc)
	neg.w	d0
	add.w	$38(a0),d0
	move.w	d0,8(a0)
	addq.b	#1,$2A(a0)
	moveq	#0,d0
	move.b	$2C(a0),d0
	asr.b	#1,d0
	add.w	$3A(a0),d0
	move.w	d0,$C(a0)
	bra.w	loc_20F4D8

loc_20F754:
	move.w	8(a0),$38(a0)
	addq.b	#2,$2B(a0)

loc_20F75E:
	bra.w	sub_20F558

sub_20F762:
	moveq	#0,d0
	move.b	$2A(a0),d0
	jsr	$2006A2.l
	moveq	#0,d2
	move.b	$2D(a0),d2
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

	lea	word_20F8B0(pc),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	scra_h_posit.w,d0

loc_20F88E:
	cmp.w	(a1)+,d0
	blo.s	loc_20F896
	addq.b	#2,d1
	bra.s	loc_20F88E

loc_20F896:
	cmp.b	enecgpnt,d1
	bne.s	loc_20F8A0
	rts

loc_20F8A0:
	move.b	d1,enecgpnt
	move.w	word_20F8B8(pc,d1.w),d0
	jmp	$20201A.l

word_20F8B0:
	dc.w	$700
	dc.w	$1100
	dc.w	$1A00
	dc.w	$FFFF

word_20F8B8:
	dc.w	4
	dc.w	5
	dc.w	6
	dc.w	7

sub_20F8C0:
	lea	off_20F8E2.l,a1
	add.w	d0,d0
	move.w	off_20F8E2(pc,d0.w),d4
	lea	off_20F8E2(pc,d4.w),a2
	moveq	#0,d1
	move.b	$29(a0),d1
	add.w	d1,d1
	move.w	(a2,d1.w),d5
	move.w	d5,2(a0)
	rts

off_20F8E2:
	dc.w	word_20F902-off_20F8E2
	dc.w	word_20F904-off_20F8E2
	dc.w	word_20F906-off_20F8E2
	dc.w	word_20F908-off_20F8E2
	dc.w	word_20F90A-off_20F8E2
	dc.w	word_20F90C-off_20F8E2
	dc.w	word_20F916-off_20F8E2
	dc.w	word_20F910-off_20F8E2
	dc.w	word_20F914-off_20F8E2
	dc.w	word_20F912-off_20F8E2
	dc.w	word_20F90E-off_20F8E2
	dc.w	word_20F918-off_20F8E2
	dc.w	word_20F91A-off_20F8E2
	dc.w	word_20F91C-off_20F8E2
	dc.w	word_20F91E-off_20F8E2
	dc.w	word_20F920-off_20F8E2
word_20F902:
	dc.w	$2475
word_20F904:
	dc.w	$240B
word_20F906:
	dc.w	$23F5
word_20F908:
	dc.w	$2447
word_20F90A:
	dc.w	$2475
word_20F90C:
	dc.w	$2000
word_20F90E:
	dc.w	$339
word_20F910:
	dc.w	$345
word_20F912:
	dc.w	$443F
word_20F914:
	dc.w	$4447
word_20F916:
	dc.w	$3D2
word_20F918:
	dc.w	$3E1
word_20F91A:
	dc.w	$83B4
word_20F91C:
	dc.w	$46C
word_20F91E:
	dc.w	$3AC
word_20F920:
	dc.w	$386

	moveq	#0,d0
	move.b	$28(a0),d0
	add.w	d0,d0
	move.w	off_20F938(pc,d0.w),d0
	jsr	off_20F938(pc,d0.w)
	jmp	$208E96.l

off_20F938:
	dc.w	loc_20F93C-off_20F938
	dc.w	loc_20FA36-off_20F938

loc_20F93C:
	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20F94A(pc,d0.w),d0
	jmp	off_20F94A(pc,d0.w)

off_20F94A:
	dc.w	loc_20F950-off_20F94A
	dc.w	loc_20F98E-off_20F94A
	dc.w	loc_20F9DE-off_20F94A

loc_20F950:
	addq.b	#2,$24(a0)
	move.b	#4,1(a0)
	move.b	#1,$18(a0)
	move.b	#8,$17(a0)
	move.b	#8,$16(a0)
	move.w	#$4BF,2(a0)
	move.l	#off_20FA26,4(a0)
	move.l	8(a0),$2A(a0)
	move.l	$C(a0),$2E(a0)
	move.b	#1,$32(a0)
	rts

loc_20F98E:
	move.b	$32(a0),d0
	jsr	$2006A2.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	$2A(a0),d1
	add.l	$2E(a0),d0
	move.l	d1,8(a0)
	move.l	d0,$C(a0)
	move.w	#$CBF,2(a0)
	addq.b	#1,$32(a0)
	cmpi.b	#$7F,$32(a0)
	bpl.w	loc_20F9D8

loc_20F9C4:
	lea	off_20FA20.l,a1
	jsr	$20739E.l
	jmp	$20517A.l
	rts

loc_20F9D8:
	addq.b	#2,$24(a0)
	bra.s	loc_20F9C4

loc_20F9DE:
	move.b	$32(a0),d0
	jsr	$2006A2.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	$2A(a0),d1
	add.l	$2E(a0),d0
	move.l	d1,8(a0)
	move.l	d0,$C(a0)
	move.w	#$4BF,2(a0)
	addi.b	#-1,$32(a0)
	cmpi.b	#1,$32(a0)
	bmi.w	loc_20FA18
	bra.s	loc_20F9C4

loc_20FA18:
	addi.b	#-2,$24(a0)
	bra.s	loc_20F9C4

off_20FA20:
	dc.w	unk_20FA22-off_20FA20
unk_20FA22:
	dc.b	$13
	dc.b	0
	dc.b	1
	dc.b	$FF

off_20FA26:
	dc.w	byte_20FA2A-off_20FA26
	dc.w	byte_20FA30-off_20FA26
byte_20FA2A:
	dc.b	1
	dc.b	$F8,5,0,0,$F8
byte_20FA30:
	dc.b	1
	dc.b	$F8,5,0,4,$F8

loc_20FA36:
	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20FA44(pc,d0.w),d0
	jmp	off_20FA44(pc,d0.w)

off_20FA44:
	dc.w	loc_20FA4A-off_20FA44
	dc.w	loc_20FA7E-off_20FA44
	dc.w	loc_20FADA-off_20FA44

loc_20FA4A:
	addq.b	#2,$24(a0)
	move.b	#4,1(a0)
	move.b	#1,$18(a0)
	move.b	#8,$17(a0)
	move.b	#8,$16(a0)
	move.w	#$4BF,2(a0)
	move.l	#off_20FB32,4(a0)
	move.l	#-$40000,$2A(a0)
	rts

loc_20FA7E:
	move.w	#$4BF,2(a0)
	addi.l	#$10000,8(a0)
	move.l	$2A(a0),d0
	add.l	d0,$C(a0)
	move.b	#0,$1C(a0)
	addi.l	#$2000,$2A(a0)
	bmi.w	loc_20FAAC
	move.b	#1,$1C(a0)

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
	addq.b	#2,$24(a0)
	move.l	#-$40000,$2A(a0)
	bra.s	loc_20FAB8

loc_20FADA:
	move.w	#$CBF,2(a0)
	addi.l	#-$10000,8(a0)
	move.l	$2A(a0),d0
	add.l	d0,$C(a0)
	move.b	#0,$1C(a0)
	addi.l	#$2000,$2A(a0)
	bmi.w	loc_20FB08
	move.b	#1,$1C(a0)

loc_20FB08:
	jsr	$20805A.l
	tst.w	d1
	bmi.w	loc_20FB16
	bra.s	loc_20FAB8

loc_20FB16:
	addi.b	#-2,$24(a0)
	move.l	#-$40000,$2A(a0)
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

	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20FB52(pc,d0.w),d0
	jsr	off_20FB52(pc,d0.w)
	rts

off_20FB52:
	dc.w	loc_20FB5C-off_20FB52
	dc.w	loc_20FB6C-off_20FB52
	dc.w	loc_20FB9A-off_20FB52
	dc.w	loc_20FBA4-off_20FB52
	dc.w	loc_20FBC0-off_20FB52

loc_20FB5C:
	addq.b	#2,$24(a0)
	ori.b	#4,1(a0)
	move.b	#4,$18(a0)

loc_20FB6C:
	jsr	$2043A4.l
	move.w	8(a0),d0
	cmp.w	8(a6),d0
	bhs.s	locret_20FB98
	move.w	scralim_right.w,scralim_left.w
	move.b	#60,$2A(a0)
	move.b	#$B4,$2B(a0)
	move.b	#$F0,$2B(a0)
	addq.b	#2,$24(a0)

locret_20FB98:
	rts

loc_20FB9A:
	subq.b	#1,$2A(a0)
	bne.s	loc_20FBA4
	addq.b	#2,$24(a0)

loc_20FBA4:
	subq.b	#1,$2B(a0)
	bne.s	loc_20FBC0
	bset	#0,plautoflag.w
	move.b	#0,$1C(a0)
	move.w	#$808,swdata.w
	addq.b	#2,$24(a0)

loc_20FBC0:
	subq.b	#1,$2B(a0)
	bne.s	locret_20FBCE
	move.w	#2,gameflag

locret_20FBCE:
	rts

	jmp	$207908.l

	dc.l	$3238018
	dc.l	$2236DEE
	dc.l	$23AB36
	dc.w	$81
	dc.b	4,4

off_20FBE6:
	dc.w	word_20FBF6-off_20FBE6
	dc.w	word_20FBFE-off_20FBE6
	dc.w	word_20FC30-off_20FBE6
	dc.w	word_20FBF6-off_20FBE6
	dc.w	word_20FC8C-off_20FBE6
	dc.w	word_20FC94-off_20FBE6
	dc.w	word_20FCAE-off_20FBE6
	dc.w	word_20FCBC-off_20FBE6
word_20FBF6:
	dc.w	0
	dc.l	$238018
	dc.w	0
word_20FBFE:
	dc.w	7
	dc.l	$231B28
	dc.w	$9FC0
	dc.l	$231C36
	dc.w	$A220
	dc.l	$23051E
	dc.w	$A400
	dc.l	$231832
	dc.w	$AD00
	dc.l	$230740
	dc.w	$B500
	dc.l	$230CD6
	dc.w	$D000
	dc.l	$23195E
	dc.w	$DAC0
	dc.l	$2311BE
	dc.w	$F5C0
word_20FC30:
	dc.w	14
	dc.l	$233AAA
	dc.w	$6720
	dc.l	$2335AE
	dc.w	$68A0
	dc.l	$23051E
	dc.w	$6B40
	dc.l	$230256
	dc.w	$70C0
	dc.l	$231D1C
	dc.w	$7580
	dc.l	$2321AC
	dc.w	$7680
	dc.l	$231C36
	dc.w	$7800
	dc.l	$231DD2
	dc.w	$7A40
	dc.l	$231B28
	dc.w	$7C20
	dc.l	$232C1C
	dc.w	$7EA0
	dc.l	$23290E
	dc.w	$8160
	dc.l	$2338E2
	dc.w	$87E0
	dc.l	$232E00
	dc.w	$88E0
	dc.l	$2324F4
	dc.w	$8EA0
	dc.l	$233C5A
	dc.w	$97E0
word_20FC8C:
	dc.w	0
	dc.l	$2324F4
	dc.w	$8EA0
word_20FC94:
	dc.w	3
	dc.l	$2338E2
	dc.w	$87E0
	dc.l	$232E00
	dc.w	$88E0
	dc.l	$233154
	dc.w	$8EA0
	dc.l	$233C5A
	dc.w	$97E0
word_20FCAE:
	dc.w	1
	dc.l	$2336E6
	dc.w	$88E0
	dc.l	$231EC0
	dc.w	$9000
word_20FCBC:
	dc.w	1
	dc.l	$232E00
	dc.w	$88E0
	dc.l	$2324F4
	dc.w	$8EA0

	dc.w	$3E
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
	dc.w	$36B

	moveq	#0,d0
	move.b	$28(a0),d0
	add.w	d0,d0
	move.w	off_20FD02(pc,d0.w),d0
	jsr	off_20FD02(pc,d0.w)
	jmp	$208EEA.l

off_20FD02:
	dc.w	loc_20FD06-off_20FD02
	dc.w	loc_20FE00-off_20FD02

loc_20FD06:
	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20FD14(pc,d0.w),d0
	jmp	off_20FD14(pc,d0.w)

off_20FD14:
	dc.w	loc_20FD1A-off_20FD14
	dc.w	loc_20FD58-off_20FD14
	dc.w	loc_20FDA8-off_20FD14

loc_20FD1A:
	addq.b	#2,$24(a0)
	move.b	#4,1(a0)
	move.b	#1,$18(a0)
	move.b	#8,$17(a0)
	move.b	#8,$16(a0)
	move.w	#$3DA,2(a0)
	move.l	#off_20FDF0,4(a0)
	move.l	8(a0),$2A(a0)
	move.l	$C(a0),$2E(a0)
	move.b	#1,$32(a0)
	rts

loc_20FD58:
	move.b	$32(a0),d0
	jsr	$2006A2.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	$2A(a0),d1
	add.l	$2E(a0),d0
	move.l	d1,8(a0)
	move.l	d0,$C(a0)
	move.w	#$BDA,2(a0)
	addq.b	#1,$32(a0)
	cmpi.b	#$7F,$32(a0)
	bpl.w	loc_20FDA2

loc_20FD8E:
	lea	off_20FDEA.l,a1
	jsr	$2073C2.l
	jmp	$20519E.l
	rts

loc_20FDA2:
	addq.b	#2,$24(a0)
	bra.s	loc_20FD8E

loc_20FDA8:
	move.b	$32(a0),d0
	jsr	$2006A2.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	$2A(a0),d1
	add.l	$2E(a0),d0
	move.l	d1,8(a0)
	move.l	d0,$C(a0)
	move.w	#$3DA,2(a0)
	addi.b	#-1,$32(a0)
	cmpi.b	#1,$32(a0)
	bmi.w	loc_20FDE2
	bra.s	loc_20FD8E

loc_20FDE2:
	addi.b	#-2,$24(a0)
	bra.s	loc_20FD8E

off_20FDEA:
	dc.w	unk_20FDEC-off_20FDEA
unk_20FDEC:
	dc.b	$13
	dc.b	0
	dc.b	1
	dc.b	$FF

off_20FDF0:
	dc.w	byte_20FDF4-off_20FDF0
	dc.w	byte_20FDFA-off_20FDF0
byte_20FDF4:
	dc.b	1
	dc.b	$F8,5,0,0,$F8
byte_20FDFA:
	dc.b	1
	dc.b	$F8,5,0,4,$F8

loc_20FE00:
	moveq	#0,d0
	move.b	$24(a0),d0
	move.w	off_20FE0E(pc,d0.w),d0
	jmp	off_20FE0E(pc,d0.w)

off_20FE0E:
	dc.w	loc_20FE14-off_20FE0E
	dc.w	loc_20FE48-off_20FE0E
	dc.w	loc_20FEA4-off_20FE0E

loc_20FE14:
	addq.b	#2,$24(a0)
	move.b	#4,1(a0)
	move.b	#1,$18(a0)
	move.b	#8,$17(a0)
	move.b	#8,$16(a0)
	move.w	#$3DA,2(a0)
	move.l	#off_20FEFC,4(a0)
	move.l	#-$40000,$2A(a0)
	rts

loc_20FE48:
	move.w	#$3DA,2(a0)
	addi.l	#$10000,8(a0)
	move.l	$2A(a0),d0
	add.l	d0,$C(a0)
	move.b	#0,$1C(a0)
	addi.l	#$2000,$2A(a0)
	bmi.w	loc_20FE76
	move.b	#1,$1C(a0)

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
	addq.b	#2,$24(a0)
	move.l	#-$40000,$2A(a0)
	bra.s	loc_20FE82

loc_20FEA4:
	move.w	#$BDA,2(a0)
	addi.l	#-$10000,8(a0)
	move.l	$2A(a0),d0
	add.l	d0,$C(a0)
	move.b	#0,$1C(a0)
	addi.l	#$2000,$2A(a0)
	bmi.w	loc_20FED2
	move.b	#1,$1C(a0)

loc_20FED2:
	jsr	$20807E.l
	tst.w	d1
	bmi.w	loc_20FEE0
	bra.s	loc_20FE82

loc_20FEE0:
	addi.b	#-2,$24(a0)
	move.l	#-$40000,$2A(a0)
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
	dc.b	$F8,9,0,8,$F4
byte_20FF06:
	dc.b	1
	dc.b	$F8,9,0,$E,$F4

	moveq	#0,d0
	move.b	$24(a0),d0
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
	addq.b	#2,$24(a0)
	ori.b	#4,1(a0)
	move.b	#4,$18(a0)

loc_20FF36:
	jsr	$2043A4.l
	move.w	8(a0),d0
	cmp.w	8(a6),d0
	bhs.s	locret_20FF62
	move.w	scralim_right.w,scralim_left.w
	move.b	#60,$2A(a0)
	move.b	#$B4,$2B(a0)
	move.b	#$F0,$2B(a0)
	addq.b	#2,$24(a0)

locret_20FF62:
	rts

loc_20FF64:
	subq.b	#1,$2A(a0)
	bne.s	loc_20FF6E
	addq.b	#2,$24(a0)

loc_20FF6E:
	subq.b	#1,$2B(a0)
	bne.s	loc_20FF8A
	bset	#0,plautoflag.w
	move.b	#0,$1C(a0)
	move.w	#$808,swdata.w
	addq.b	#2,$24(a0)

loc_20FF8A:
	subq.b	#1,$2B(a0)
	bne.s	locret_20FF98
	move.w	#2,gameflag

locret_20FF98:
	rts

	jmp	$20792C.l

	dc.l	$3237DBA
	dc.l	$2236D82
	dc.l	$23A476
	dc.w	$81
	dc.b	4,4

off_20FFB0:
	dc.w	word_20FFC0-off_20FFB0
	dc.w	word_20FFC8-off_20FFB0
	dc.w	word_20FFFA-off_20FFB0
	dc.w	word_20FFC0-off_20FFB0
	dc.w	$A0
	dc.w	$AE
	dc.w	$B6
	dc.w	$C4
word_20FFC0:
	dc.w	0
	dc.l	$237DBA
	dc.w	0
word_20FFC8:
	dc.w	7
	dc.l	$231B28
	dc.w	$9FC0
	dc.l	$231C36
	dc.w	$A220
	dc.l	$23051E
	dc.w	$A400
	dc.l	$231832
	dc.w	$AD00
	dc.l	$230740
	dc.w	$B500
	dc.l	$230CD6
	dc.w	$D000
	dc.l	$23195E
	dc.w	$DAC0
	dc.l	$2311BE
	dc.w	$F5C0
word_20FFFA:
	dc.w	13
	dc.l	$233AAA

	dephase