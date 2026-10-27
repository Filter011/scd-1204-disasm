taki:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	taki_move_tbl(pc,d0.w),d0
	jsr	taki_move_tbl(pc,d0.w)
	lea	shibukichg.l,a1
	jsr	patchg.l
	jmp	actionsub.l

taki_move_tbl:
	dc.w	taki_init-taki_move_tbl
	dc.w	taki_move-taki_move_tbl

taki_init:
	addq.b	#word,r_no0(a0)
	move.l	#shibukipat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#16,sprhsize(a0)
	move.w	#$3BA,sproffset(a0)
	andi.w	#$FFF0,yposi(a0)
	move.w	yposi(a0),act2A(a0)
	addi.w	#$180,act2A(a0)
	rts

taki_move:
	move.w	yposi(a0),d0
	addq.w	#4,d0
	cmp.w	act2A(a0),d0
	blo.s	loc_20679E
	jmp	frameout.l

loc_20679E:
	move.w	d0,yposi(a0)
	moveq	#2,d3
	bset	#$D,d3
	move.w	yposi(a0),d4
	move.w	xposi(a0),d5
	subi.w	#$60,d5
	move.w	d4,d6
	andi.w	#$F,d6
	bne.s	locret_2067CC
	moveq	#$B,d6

loc_2067BE:
	jsr	block_wrt.l
	addi.w	#$10,d5
	dbf	d6,loc_2067BE

locret_2067CC:
	rts

jisin_set:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	jisin_set_move_tbl(pc,d0.w),d0
	jsr	jisin_set_move_tbl(pc,d0.w)
	lea	bariachg.l,a1
	bsr.w	patchg
	jsr	actionsub.l
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.s	loc_20680A
	rts

loc_20680A:
	lea	flagwork,a2
	moveq	#0,d0
	move.b	cdsts(a0),d0
	beq.s	loc_20681E
	bclr	#7,2(a2,d0.w)

loc_20681E:
	jmp	frameout.l

jisin_set_move_tbl:
	dc.w	jisin_set_init-jisin_set_move_tbl
	dc.w	jisin_set_move-jisin_set_move_tbl

jisin_set_init:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.l	#bariapat,patbase(a0)
	move.w	#$541,sproffset(a0)

jisin_set_move:
	lea	playerwk.w,a1
	bsr.w	sub_206886
	blo.s	loc_20685A
	lea	player2wk.w,a1
	bsr.w	sub_206886
	bhs.s	locret_206884

loc_20685A:
	move.b	#0,r_no0(a0)
	_move.b	#jisin_act,actno(a0)
	move.w	#$1940,xposi(a0)
	move.w	#$2D0,yposi(a0)
	move.b	#9,act2E(a0)
	move.b	#$17,act2C(a0)
	move.b	#$2B,act2A(a0)

locret_206884:
	rts

sub_206886:
	moveq	#0,d0
	move.w	xposi(a1),d0
	sub.w	xposi(a0),d0
	addi.w	#$10,d0
	cmpi.w	#$20,d0
	bhs.s	locret_2068AA
	move.w	yposi(a1),d0
	sub.w	yposi(a0),d0
	addi.w	#$10,d0
	cmpi.w	#$20,d0

locret_2068AA:
	rts

jisin:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	jisin_move_tbl(pc,d0.w),d0
	jmp	jisin_move_tbl(pc,d0.w)

jisin_move_tbl:
	dc.w	jisin_init-jisin_move_tbl
	dc.w	jisin_move-jisin_move_tbl

jisin_init:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)

jisin_move:
	move.b	systemtimer+3,d0
	andi.b	#$F,d0
	bne.s	locret_206930
	subq.b	#1,act2E(a0)
	bne.s	loc_2068E0
	jmp	frameout.l

loc_2068E0:
	lea	mapwka.w,a4
	move.w	yposi(a0),d4
	moveq	#0,d0
	move.b	act2A(a0),d0

loc_2068EE:
	movem.l	d0/a0,-(sp)
	move.w	xposi(a0),d5
	moveq	#0,d6
	move.b	act2C(a0),d6

loc_2068FC:
	movem.l	d4-d5,-(sp)
	subi.w	#$10,d4
	jsr	mapadrset2.l
	bne.s	loc_206910
	moveq	#0,d3
	bra.s	loc_206912

loc_206910:
	move.w	(a0),d3

loc_206912:
	movem.l	(sp)+,d4-d5
	jsr	block_wrt.l
	addi.w	#$10,d5
	dbf	d6,loc_2068FC

	movem.l	(sp)+,d0/a0
	subi.w	#$10,d4
	dbf	d0,loc_2068EE

locret_206930:
	rts

	movem.l	(sp)+,d4-d5
	movem.l	(sp)+,d0/a0
	rts

shibukichg:
	dc.w	shibukichg0-shibukichg
shibukichg0:
	dc.b	4
	dc.b	0,1
	dc.b	$FF
	even

shibukipat:
	dc.w	shibuki0-shibukipat
	dc.w	shibuki1-shibukipat
shibuki0:
	dc.b	6
	dc.b	$F0,$F,0,0,$A0
	dc.b	$F0,$F,0,0,$C0
	dc.b	$F0,$F,0,0,$E0
	dc.b	$F0,$F,0,0,0
	dc.b	$F0,$F,0,0,$20
	dc.b	$F0,$F,0,0,$40
	even
shibuki1:
	dc.b	6
	dc.b	$F0,$F,0,$10,$A0
	dc.b	$F0,$F,0,$10,$C0
	dc.b	$F0,$F,0,$10,$E0
	dc.b	$F0,$F,0,$10,0
	dc.b	$F0,$F,0,$10,$20
	dc.b	$F0,$F,0,$10,$40
	even