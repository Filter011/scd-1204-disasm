baria:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	baria_move_tbl(pc,d0.w),d1
	jmp	baria_move_tbl(pc,d1.w)

baria_move_tbl:
	dc.w	bariainit-baria_move_tbl
	dc.w	bariamove-baria_move_tbl
	dc.w	mutekimove-baria_move_tbl
	dc.w	backtomove-baria_move_tbl

bariainit:
	addq.b	#word,r_no0(a0)
	move.l	#bariapat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$544,sproffset(a0)
	tst.b	mstno(a0)
	beq.s	locret_2058C8
	addq.b	#word,r_no0(a0)
	cmpi.b	#5,mstno(a0)
	blo.s	locret_2058C8
	addq.b	#word,r_no0(a0)

locret_2058C8:
	rts

bariamove:
	tst.b	plpower_b
	beq.s	loc_20590C
	tst.b	plpower_a
	bne.s	locret_20590A
	tst.b	plpower_m
	bne.s	locret_20590A
	jsr	main_chk.l
	move.w	xposi(a6),xposi(a0)
	move.w	yposi(a6),yposi(a0)
	move.b	cddat(a6),cddat(a0)
	lea	bariachg.l,a1
	jsr	patchg.l
	bra.w	actionsub0

locret_20590A:
	rts

loc_20590C:
	jmp	frameout.l

mutekimove:
	tst.b	plpower_a
	beq.s	loc_20591C
	rts

loc_20591C:
	tst.b	plpower_m
	bne.s	muteki_sub
	jmp	frameout.l

backtomove:
	tst.b	plpower_a
	bne.s	muteki_sub
	jmp	frameout.l

muteki_sub:
	move.w	plposiwkadr.w,d0
	move.b	mstno(a0),d1
	subq.b	#1,d1
	cmpi.b	#4,d1
	blo.s	loc_20594A
	subq.b	#4,d1

loc_20594A:
	lsl.b	#3,d1
	move.b	d1,d2
	add.b	d1,d1
	add.b	d2,d1
	addq.b	#4,d1
	sub.b	d1,d0
	move.b	act30(a0),d1
	sub.b	d1,d0
	addq.b	#4,d1
	cmpi.b	#$18,d1
	blo.s	loc_205966
	moveq	#0,d1

loc_205966:
	move.b	d1,act30(a0)
	lea	playposiwk.w,a1
	lea	(a1,d0.w),a1
	move.w	(a1)+,xposi(a0)
	move.w	(a1)+,yposi(a0)
	jsr	main_chk.l
	move.b	cddat(a6),cddat(a0)
	lea	bariachg.l,a1
	jsr	patchg.l

actionsub0:
	move.b	plsubchg_flag,d0
	andi.b	#7,d0
	cmp.b	r_no0(a0),d0
	beq.s	loc_2059B2
	move.b	r_no0(a0),plsubchg_flag
	bset	#7,plsubchg_flag

loc_2059B2:
	jmp	actionsub.l

sub_2059B8:
	bclr	#7,plsubchg_flag
	beq.s	locret_205A06
	moveq	#0,d0
	move.b	plsubchg_flag,d0
	subq.b	#2,d0
	add.w	d0,d0
	movea.l	off_205A08(pc,d0.w),a1
	lea	powerupwrtwk.l,a2
	move.w	#(powerupwrtwk_end-powerupwrtwk)/4-1,d0

loc_2059DC:
	move.l	(a1)+,(a2)+
	dbf	d0,loc_2059DC

	dma68k	powerupwrtwk,(powerupwrtwk_dma_end-powerupwrtwk),4,$544*tile_size

locret_205A06:
	rts

off_205A08:
	dc.l	cg_shield
	dc.l	cg_stars
	dc.l	cg_timetravel

bariachg:
	dc.w	unk_205A26-bariachg
	dc.w	unk_205A2E-bariachg
	dc.w	unk_205A34-bariachg
	dc.w	unk_205A4E-bariachg
	dc.w	unk_205A68-bariachg
	dc.w	unk_205A82-bariachg
	dc.w	unk_205A8E-bariachg
	dc.w	unk_205AC8-bariachg
	dc.w	unk_205B02-bariachg
unk_205A26:
	dc.b	1
	dc.b	1,0
	dc.b	2,0
	dc.b	3,0
	dc.b	$FF
	even
unk_205A2E:
	dc.b	5
	dc.b	4,5,6,7
	dc.b	$FF
	even
unk_205A34:
	dc.b	0
	dc.b	4,4,0,4,4,0
	dc.b	5,5,0,5,5,0
	dc.b	6,6,0,6,6,0
	dc.b	7,7,0,7,7,0
	dc.b	$FF
	even
unk_205A4E:
	dc.b	0
	dc.b	4,4,0,4,0,0
	dc.b	5,5,0,5,0,0
	dc.b	6,6,0,6,0,0
	dc.b	7,7,0,7,0,0
	dc.b	$FF
	even
unk_205A68:
	dc.b	0
	dc.b	4,0,0,4,0,0
	dc.b	5,0,0,5,0,0
	dc.b	6,0,0,6,0,0
	dc.b	7,0,0,7,0,0
	dc.b	$FF
	even
unk_205A82:
	dc.b	0
	dc.b	8,9,$A,$B,$C,$B,$A,9,8
	dc.b	0
	dc.b	$FF
	even
unk_205A8E:
	dc.b	0
	dc.b	8,8,0,8,8,0
	dc.b	9,9,0,9,9,0
	dc.b	$A,$A,0,$A,$A,0
	dc.b	$B,$B,0,$B,$B,0
	dc.b	$C,$C,0,$C,$C,0
	dc.b	$B,$B,0,$B,$B,0
	dc.b	$A,$A,0,$A,$A,0
	dc.b	9,9,0,9,9,0
	dc.b	8,8,0,8,8,0
	dc.b	0
	dc.b	$FF
	even
unk_205AC8:
	dc.b	0
	dc.b	8,8,0,8,0,0
	dc.b	9,9,0,9,0,0
	dc.b	$A,$A,0,$A,0,0
	dc.b	$B,$B,0,$B,0,0
	dc.b	$C,$C,0,$C,0,0
	dc.b	$B,$B,0,$B,0,0
	dc.b	$A,$A,0,$A,0,0
	dc.b	9,9,0,9,0,0
	dc.b	8,8,0,8,0,0
	dc.b	0
	dc.b	$FF
	even
unk_205B02:
	dc.b	0
	dc.b	8,0,0,8,0,0
	dc.b	9,0,0,9,0,0
	dc.b	$A,0,0,$A,0,0
	dc.b	$B,0,0,$B,0,0
	dc.b	$C,0,0,$C,0,0
	dc.b	$B,0,0,$B,0,0
	dc.b	$A,0,0,$A,0,0
	dc.b	9,0,0,9,0,0
	dc.b	8,0,0,8,0,0
	dc.b	0
	dc.b	$FF
	even

bariapat:
	dc.w	byte_205B56+$B-bariapat
	dc.w	byte_205B56-bariapat
	dc.w	byte_205B6B-bariapat
	dc.w	byte_205B80-bariapat
	dc.w	byte_205B95-bariapat
	dc.w	byte_205BAA-bariapat
	dc.w	byte_205BBF-bariapat
	dc.w	byte_205BD4-bariapat
	dc.w	byte_205BEA-bariapat
	dc.w	byte_205C00-bariapat
	dc.w	byte_205C16-bariapat
	dc.w	byte_205C2C-bariapat
	dc.w	byte_205C42-bariapat
byte_205B56:
	dc.b	4
	dc.b	$E8,$A,0,0,$E8
	dc.b	$E8,$A,0,9,0
	dc.b	0,$A,$10,0,$E8
	dc.b	0,$A,$10,9,0
byte_205B6B:
	dc.b	4
	dc.b	$E8,$A,0,$12,$E8
	dc.b	$E8,$A,0,$1B,0
	dc.b	0,$A,$10,$12,$E8
	dc.b	0,$A,$10,$1B,0
byte_205B80:
	dc.b	4
	dc.b	$E8,$A,8,9,$E8
	dc.b	$E8,$A,8,0,0
	dc.b	0,$A,$18,9,$E8
	dc.b	0,$A,$18,0,0
byte_205B95:
	dc.b	4
	dc.b	$E8,$A,0,0,$E8
	dc.b	$E8,$A,0,9,0
	dc.b	0,$A,$18,9,$E8
	dc.b	0,$A,$18,0,0
byte_205BAA:
	dc.b	4
	dc.b	$E8,$A,8,9,$E8
	dc.b	$E8,$A,8,0,0
	dc.b	0,$A,$10,0,$E8
	dc.b	0,$A,$10,9,0
byte_205BBF:
	dc.b	4
	dc.b	$E8,$A,0,$12,$E8
	dc.b	$E8,$A,0,$1B,0
	dc.b	0,$A,$18,$1B,$E8
	dc.b	0,$A,$18,$12,0
byte_205BD4:
	dc.b	4
	dc.b	$E8,$A,8,$1B,$E8
	dc.b	$E8,$A,8,$12,0
	dc.b	0,$A,$10,$12,$E8
	dc.b	0,$A,$10,$1B,0
	even
byte_205BEA:
	dc.b	4
	dc.b	$F0,5,0,0,$F0
	dc.b	$F0,5,8,0,0
	dc.b	0,5,$10,0,$F0
	dc.b	0,5,$18,0,0
	even
byte_205C00:
	dc.b	4
	dc.b	$F0,5,0,4,$F0
	dc.b	$F0,5,8,4,0
	dc.b	0,5,$10,4,$F0
	dc.b	0,5,$18,4,0
	even
byte_205C16:
	dc.b	4
	dc.b	$E8,$A,0,8,$E8
	dc.b	$E8,$A,8,8,0
	dc.b	0,$A,$10,8,$E8
	dc.b	0,$A,$18,8,0
	even
byte_205C2C:
	dc.b	4
	dc.b	$F0,5,0,$11,$F0
	dc.b	$F0,5,0,$15,0
	dc.b	0,5,$18,$15,$F0
	dc.b	0,5,$18,$11,0
	even
byte_205C42:
	dc.b	2
	dc.b	$F4,6,0,$19,$F0
	dc.b	$F4,6,8,$19,0
	even