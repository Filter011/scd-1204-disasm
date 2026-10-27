bitdevr:
	movem.l d0-a1/a3-a5,-(sp)
	lea	write_pixels.l,a3
	lea	vdp_dat,a4
	bra.s	bitdevr_sub

bitdevr_work:
	movem.l d0-a1/a3-a5,-(sp)
	lea	loc_201FC6.l,a3

bitdevr_sub:
	lea	bitdevwk.w,a1
	move.w	(a0)+,d2
	lsl.w	#1,d2
	bhs.s	loc_201F18
	adda.w	#write_xor_pixels-write_pixels,a3

loc_201F18:
	lsl.w	#2,d2
	movea.w d2,a5
	moveq	#8,d3
	moveq	#0,d2
	moveq	#0,d4
	bsr.w	build_codetable
	move.b	(a0)+,d5
	asl.w	#8,d5
	move.b	(a0)+,d5
	move.w	#16,d6
	bsr.s	sub_201F38
	movem.l (sp)+,d0-a1/a3-a5
	rts

sub_201F38:
	move.w	d6,d7
	subq.w	#8,d7
	move.w	d5,d1
	lsr.w	d7,d1
	cmpi.b	#%11111100,d1
	bhs.s	process_inline_data
	andi.w	#$FF,d1
	add.w	d1,d1
	move.b	(a1,d1.w),d0
	ext.w	d0
	sub.w	d0,d6
	cmpi.w	#9,d6
	bhs.s	loc_201F60
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5

loc_201F60:
	move.b	1(a1,d1.w),d1
	move.w	d1,d0
	andi.w	#%00001111,d1
	andi.w	#%11110000,d0

loc_201F6E:
	lsr.w	#4,d0

loc_201F70:
	lsl.l	#4,d4
	or.b	d1,d4
	subq.w	#1,d3
	bne.s	loc_201F7E
	jmp	(a3)

sub_201F7A:
	moveq	#0,d4
	moveq	#8,d3

loc_201F7E:
	dbf	d0,loc_201F70

	bra.s	sub_201F38

process_inline_data:
	subq.w	#6,d6
	cmpi.w	#9,d6
	bhs.s	loc_201F92
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5

loc_201F92:
	subq.w	#7,d6
	move.w	d5,d1
	lsr.w	d6,d1
	move.w	d1,d0
	andi.w	#%00001111,d1
	andi.w	#%01110000,d0
	cmpi.w	#9,d6
	bhs.s	loc_201F6E
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5
	bra.s	loc_201F6E

write_pixels:
	move.l	d4,(a4)
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	sub_201F7A
	rts

write_xor_pixels:
	eor.l	d4,d2
	move.l	d2,(a4)
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	sub_201F7A
	rts

loc_201FC6:
	move.l	d4,(a4)+
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	sub_201F7A
	rts

loc_201FD0:
	eor.l	d4,d2
	move.l	d2,(a4)+
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	sub_201F7A
	rts

build_codetable:
	move.b	(a0)+,d0

loc_201FDE:
	cmpi.b	#$FF,d0
	bne.s	loc_201FE6
	rts

loc_201FE6:
	move.w	d0,d7

loc_201FE8:
	move.b	(a0)+,d0
	cmpi.b	#%10000000,d0
	bhs.s	loc_201FDE
	move.b	d0,d1
	andi.w	#%00001111,d7
	andi.w	#%01110000,d1
	or.w	d1,d7
	andi.w	#%00001111,d0
	move.b	d0,d1
	lsl.w	#8,d1
	or.w	d1,d7
	moveq	#8,d1
	sub.w	d0,d1
	bne.s	loc_202016
	move.b	(a0)+,d0
	add.w	d0,d0
	move.w	d7,(a1,d0.w)
	bra.s	loc_201FE8

loc_202016:
	move.b	(a0)+,d0
	lsl.w	d1,d0
	add.w	d0,d0
	moveq	#1,d5
	lsl.w	d1,d5
	subq.w	#1,d5

.loop:
	move.w	d7,(a1,d0.w)
	addq.w	#2,d0
	dbf	d5,.loop

	bra.s	loc_201FE8

divdevset:
	movem.l a1-a2,-(sp)
	lea	divdevtbl.l,a1
	add.w	d0,d0
	move.w	(a1,d0.w),d0
	lea	(a1,d0.w),a1
	lea	divdevwk.w,a2

.jump:
	tst.l	(a2)
	beq.s	.jump1
	addq.w	#6,a2
	bra.s	.jump

.jump1:
	move.w	(a1)+,d0
	bmi.s	.end

.loop:
	move.l	(a1)+,(a2)+
	move.w	(a1)+,(a2)+
	dbf	d0,.loop

.end:
	movem.l (sp)+,a1-a2
	rts

divdevset2:
	movem.l a1-a2,-(sp)
	lea	divdevtbl.l,a1
	add.w	d0,d0
	move.w	(a1,d0.w),d0
	lea	(a1,d0.w),a1
	bsr.s	sub_20208C
	lea	divdevwk.w,a2
	move.w	(a1)+,d0
	bmi.s	.end

.loop:
	move.l	(a1)+,(a2)+
	move.w	(a1)+,(a2)+
	dbf	d0,.loop

.end:
	movem.l (sp)+,a1-a2
	rts

sub_20208C:
	lea	divdevwk.w,a2
	moveq	#$80/4-1,d0

.loop:
	clr.l	(a2)+
	dbf	d0,.loop

	rts

sub_20209A:
	tst.l	divdevwk.w
	beq.s	locret_2020EE
	tst.w	bitdevcnt.w
	bne.s	locret_2020EE
	movea.l divdevwk.w,a0
	lea	write_pixels.l,a3
	lea	bitdevwk.w,a1
	move.w	(a0)+,d2
	bpl.s	loc_2020BC
	adda.w	#write_xor_pixels-write_pixels,a3

loc_2020BC:
	andi.w	#$7FFF,d2
	move.w	d2,bitdevcnt.w
	bsr.w	build_codetable
	move.b	(a0)+,d5
	asl.w	#8,d5
	move.b	(a0)+,d5
	moveq	#16,d6
	moveq	#0,d0
	move.l	a0,divdevwk.w
	move.l	a3,bitdevadr.w
	move.l	d0,bitdev_d0.w
	move.l	d0,bitdev_d1.w
	move.l	d0,bitdev_d2.w
	move.l	d5,bitdev_d5.w
	move.l	d6,bitdev_d6.w

locret_2020EE:
	rts

sub_2020F0:
	tst.w	bitdevcnt.w
	beq.w	locret_202188
	move.w	#9,bitdevcnt2.w
	moveq	#0,d0
	move.w	divdevwk+4.w,d0
	addi.w	#$120,divdevwk+4.w
	bra.s	loc_202124

sub_20210C:
	tst.w	bitdevcnt.w
	beq.s	locret_202188
	move.w	#3,bitdevcnt2.w
	moveq	#0,d0
	move.w	divdevwk+4.w,d0
	addi.w	#$60,divdevwk+4.w

loc_202124:
	lea	vdp_cmd,a4
	lsl.l	#2,d0
	lsr.w	#2,d0
	ori.w	#$4000,d0
	swap	d0
	move.l	d0,(a4)
	subq.w	#4,a4
	movea.l divdevwk.w,a0
	movea.l bitdevadr.w,a3
	move.l	bitdev_d0.w,d0
	move.l	bitdev_d1.w,d1
	move.l	bitdev_d2.w,d2
	move.l	bitdev_d5.w,d5
	move.l	bitdev_d6.w,d6
	lea	bitdevwk.w,a1

loc_202158:
	movea.w #8,a5
	bsr.w	sub_201F7A
	subq.w	#1,bitdevcnt.w
	beq.s	loc_20218A
	subq.w	#1,bitdevcnt2.w
	bne.s	loc_202158
	move.l	a0,divdevwk.w
	move.l	a3,bitdevadr.w
	move.l	d0,bitdev_d0.w
	move.l	d1,bitdev_d1.w
	move.l	d2,bitdev_d2.w
	move.l	d5,bitdev_d5.w
	move.l	d6,bitdev_d6.w

locret_202188:
	rts

loc_20218A:
	lea	divdevwk.w,a0
	moveq	#(divdevwk_end-divdevwk-6)/4-1,d0

.loop:
	move.l	6(a0),(a0)+
	dbf	d0,.loop

	rts

loc_20219A:
	lea	divdevtbl.l,a1
	add.w	d0,d0
	move.w	(a1,d0.w),d0
	lea	(a1,d0.w),a1
	move.w	(a1)+,d1

.loop:
	movea.l (a1)+,a0
	moveq	#0,d0
	move.w	(a1)+,d0
	lsl.l	#2,d0
	lsr.w	#2,d0
	ori.w	#$4000,d0
	swap	d0
	move.l	d0,vdp_cmd
	bsr.w	bitdevr
	dbf	d1,.loop

	rts