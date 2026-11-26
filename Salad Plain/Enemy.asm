ene_ka:
	move.b	userflag(a0),d0
	bmi.w	b_ka
	bra.w	e_ka

ene_chou:
	move.b	userflag(a0),d0
	bmi.w	b_chou
	bra.w	e_chou

ene_ari:
	move.b	userflag(a0),d0
	bmi.w	b_ari
	bra.w	e_ari

ene_tagame_a:
	move.b	userflag(a0),d0
	bmi.w	b_tagame
	bra.w	e_tagame

ene_kamemusi:
	move.b	userflag(a0),d0
	bmi.w	b_kamem
	bra.w	e_kamem

	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_209BA4(pc,d0.w),d0
	jmp	off_209BA4(pc,d0.w)

off_209BA4:
	dc.w	loc_209BA8-off_209BA4
	dc.w	loc_209BFC-off_209BA4

loc_209BA8:
	addq.b	#word,r_no0(a0)
	move.l	#off_20B4C8,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	move.w	#$400|tile_xflip,sproffset(a0)
	move.w	#$400|tile_yflip,sproffset(a0)
	move.w	#$4FC|tile_col2,sproffset(a0)
	move.l	playerwk+xposi,d0
	addi.l	#$A0000,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi,d0
	subi.l	#$320000,d0
	move.l	d0,yposi(a0)
	rts

loc_209BFC:
	move.l	playerwk+xposi,d0
	addi.l	#$A0000,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi,d0
	subi.l	#$320000,d0
	move.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	lea	off_20B4B6.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

e_ka:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_209C4C
	tst.b	actflg(a0)
	bmi.s	loc_209C4C
	jsr	actionsub.l
	jmp	frameout_s.l

loc_209C4C:
	move.w	e_ka_move_tbl(pc,d0.w),d0
	jsr	e_ka_move_tbl(pc,d0.w)
	jmp	frameout_s.l

e_ka_move_tbl:
	dc.w	e_ka_init-e_ka_move_tbl
	dc.w	e_ka_move_right-e_ka_move_tbl
	dc.w	e_ka_move_left-e_ka_move_tbl
	dc.w	loc_209D5C-e_ka_move_tbl
	dc.w	loc_209D8A-e_ka_move_tbl
	dc.w	loc_209DC0-e_ka_move_tbl

e_ka_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_ka_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#0,d0
	jsr	pa_set.l
	move.b	#1,mstno(a0)
	move.l	xposi(a0),d0
	move.l	d0,off2C(a0)
	rts

e_ka_move_right:
	bra.w	e_ka_move_left

	move.w	#$400|tile_col2|tile_xflip,sproffset(a0)
	move.l	xposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	off2C(a0),d1
	addi.w	#$6E,d1
	cmp.w	d0,d1
	bpl.w	loc_209CD2
	move.b	#4,r_no0(a0)

loc_209CD2:
	bsr.w	loc_209D2A
	lea	pchg_e.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

e_ka_move_left:
	moveq	#0,d0
	jsr	pa_set.l
	move.l	xposi(a0),d0
	subi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	off2C(a0),d1
	subi.w	#$6E,d1
	cmp.w	d0,d1
	bmi.w	loc_209D12

loc_209D12:
	bsr.w	loc_209D2A
	lea	pchg_e.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209D2A:
	move.w	playerwk+xposi,d1
	move.w	xposi(a0),d0
	move.w	d1,d2
	addi.w	#$32,d1
	subi.w	#$32,d2
	cmp.w	d1,d0
	bpl.w	locret_209D5A
	cmp.w	d2,d0
	bmi.w	locret_209D5A
	move.b	#6,r_no0(a0)
	move.b	#2,mstno(a0)
	move.w	#50,off2A(a0)

locret_209D5A:
	rts

loc_209D5C:
	move.w	off2A(a0),d0
	subq.w	#1,d0
	move.w	d0,off2A(a0)
	bne.w	loc_209D76
	move.b	#8,r_no0(a0)
	move.b	#3,mstno(a0)

loc_209D76:
	lea	pchg_e.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209D8A:
	move.l	yposi(a0),d0
	addi.l	#$60000,d0
	move.l	d0,yposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_209DB8
	lea	pchg_e.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209DB8:
	move.b	#$A,r_no0(a0)
	rts

loc_209DC0:
	lea	pchg_e.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

b_ka:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_209DEE
	tst.b	actflg(a0)
	bmi.s	loc_209DEE
	jsr	actionsub.l
	jmp	frameout_s.l

loc_209DEE:
	move.w	b_ka_move_tbl(pc,d0.w),d0
	jsr	b_ka_move_tbl(pc,d0.w)
	jmp	frameout_s.l

b_ka_move_tbl:
	dc.w	b_ka_init-b_ka_move_tbl
	dc.w	b_ka_move_right-b_ka_move_tbl
	dc.w	b_ka_move_left-b_ka_move_tbl
	dc.w	loc_209F04-b_ka_move_tbl
	dc.w	loc_209F32-b_ka_move_tbl
	dc.w	loc_209F68-b_ka_move_tbl

b_ka_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#b_ka_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	moveq	#0,d0
	jsr	pa_set.l
	move.b	#1,mstno(a0)
	move.l	xposi(a0),d0
	move.l	d0,off2C(a0)
	rts

b_ka_move_right:
	bra.w	b_ka_move_left

	move.w	#$400|tile_col2|tile_xflip,sproffset(a0)
	move.l	xposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	off2C(a0),d1
	addi.w	#$6E,d1
	cmp.w	d0,d1
	bpl.w	loc_209E7A
	move.b	#4,r_no0(a0)

loc_209E7A:
	bsr.w	sub_209ED2
	lea	pchg_b.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

b_ka_move_left:
	moveq	#0,d0
	jsr	pa_set.l
	move.l	xposi(a0),d0
	subi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	off2C(a0),d1
	subi.w	#$6E,d1
	cmp.w	d0,d1
	bmi.w	loc_209EBA

loc_209EBA:
	bsr.w	sub_209ED2
	lea	pchg_b.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_209ED2:
	move.w	playerwk+xposi,d1
	move.w	xposi(a0),d0
	move.w	d1,d2
	addi.w	#$32,d1
	subi.w	#$32,d2
	cmp.w	d1,d0
	bpl.w	locret_209F02
	cmp.w	d2,d0
	bmi.w	locret_209F02
	move.b	#6,r_no0(a0)
	move.b	#2,mstno(a0)
	move.w	#60,off2A(a0)

locret_209F02:
	rts

loc_209F04:
	move.w	off2A(a0),d0
	subq.w	#1,d0
	move.w	d0,off2A(a0)
	bne.w	loc_209F1E
	move.b	#8,r_no0(a0)
	move.b	#3,mstno(a0)

loc_209F1E:
	lea	pchg_b.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209F32:
	move.l	yposi(a0),d0
	addi.l	#$60000,d0
	move.l	d0,yposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_209F60
	lea	pchg_b.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209F60:
	move.b	#$A,r_no0(a0)
	rts

loc_209F68:
	lea	pchg_b.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

b_chou:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	b_chou_move_tbl(pc,d0.w),d0
	jsr	b_chou_move_tbl(pc,d0.w)
	jmp	frameout_s.l

b_chou_move_tbl:
	dc.w	b_chou_init-b_chou_move_tbl
	dc.w	loc_209FE8-b_chou_move_tbl
	dc.w	loc_20A11C-b_chou_move_tbl
	dc.w	loc_20A072-b_chou_move_tbl
	dc.w	loc_20A11C-b_chou_move_tbl

b_chou_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_chou_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#1,d0
	jsr	pa_set.l
	move.w	#0,off30(a0)
	move.w	#0,off2A(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	move.l	yposi(a0),d0
	move.l	d0,off2C(a0)
	rts

loc_209FE8:
	tst.b	actflg(a0)
	bpl.s	loc_20A06C
	move.b	#0,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	bsr.w	sub_20A0FA
	move.l	xposi(a0),d0
	subi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	off30(a0),d0
	addq.w	#1,d0
	move.w	d0,off30(a0)
	cmpi.w	#$FA,d0
	bne.w	loc_20A040
	move.w	#0,off30(a0)
	move.b	#$60,off32(a0)
	move.b	#4,r_no0(a0)
	rts

loc_20A040:
	move.w	off2A(a0),d0
	addq.w	#1,d0
	move.w	d0,off2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A060
	move.w	#0,off2A(a0)
	move.b	#6,r_no0(a0)
	rts

loc_20A060:
	lea	e_chou_pchg.l,a1
	jsr	patchg.l

loc_20A06C:
	jmp	actionsub.l

loc_20A072:
	tst.b	actflg(a0)
	bpl.s	loc_20A06C
	move.b	#1,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bsr.w	sub_20A0FA
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	move.l	xposi(a0),d0
	addi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	off30(a0),d0
	addq.w	#1,d0
	move.w	d0,off30(a0)
	cmpi.w	#$FA,d0
	bne.w	loc_20A0C8
	move.w	#0,off30(a0)
	move.b	#$60,off32(a0)
	move.b	#8,r_no0(a0)

loc_20A0C8:
	move.w	off2A(a0),d0
	addq.w	#1,d0
	move.w	d0,off2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A0E6
	move.w	#0,off2A(a0)
	move.b	#2,r_no0(a0)

loc_20A0E6:
	lea	e_chou_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_20A0FA:
	move.w	off2A(a0),d0
	mulu.w	#256,d0
	divu.w	#128,d0
	jsr	sinset.l
	muls.w	#$1C00,d0
	move.l	off2C(a0),d1
	add.l	d0,d1
	move.l	d1,yposi(a0)
	rts

loc_20A11C:
	tst.b	actflg(a0)
	bpl.w	loc_20A06C
	move.b	off32(a0),d0
	subq.w	#1,d0
	move.b	d0,off32(a0)
	beq.w	loc_20A168
	move.l	#$4000,d1
	addi.b	#$30,d0
	andi.b	#$3F,d0
	cmpi.b	#$20,d0
	bpl.w	loc_20A14A
	neg.l	d1

loc_20A14A:
	move.l	yposi(a0),d2
	add.l	d1,d2
	move.l	d2,yposi(a0)
	lea	e_chou_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A168:
	move.w	#0,off30(a0)
	move.b	r_no0(a0),d0
	cmpi.b	#4,d0
	beq.w	loc_20A17E
	bra.w	loc_20A186

loc_20A17E:
	move.b	#2,r_no0(a0)
	rts

loc_20A186:
	move.b	#6,r_no0(a0)
	rts

e_chou:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	e_chou_move_tbl(pc,d0.w),d0
	jsr	e_chou_move_tbl(pc,d0.w)
	jmp	frameout_s.l

e_chou_move_tbl:
	dc.w	e_chou_init-e_chou_move_tbl
	dc.w	loc_20A1FA-e_chou_move_tbl
	dc.w	loc_20A32E-e_chou_move_tbl
	dc.w	loc_20A286-e_chou_move_tbl
	dc.w	loc_20A32E-e_chou_move_tbl

e_chou_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_chou_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#1,d0
	jsr	pa_set.l
	move.w	#0,off30(a0)
	move.w	#0,off2A(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	move.l	yposi(a0),d0
	move.l	d0,off2C(a0)
	rts

loc_20A1FA:
	tst.b	actflg(a0)
	bpl.w	loc_20A280
	move.b	#0,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bsr.w	sub_20A30C
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	move.l	xposi(a0),d0
	subi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	off30(a0),d0
	addq.w	#1,d0
	move.w	d0,off30(a0)
	cmpi.w	#$1F4,d0
	bne.w	loc_20A254
	move.w	#0,off30(a0)
	move.b	#$60,off32(a0)
	move.b	#4,r_no0(a0)
	rts

loc_20A254:
	move.w	off2A(a0),d0
	addq.w	#1,d0
	move.w	d0,off2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A274
	move.w	#0,off2A(a0)
	move.b	#6,r_no0(a0)
	rts

loc_20A274:
	lea	b_chou_pchg.l,a1
	jsr	patchg.l

loc_20A280:
	jmp	actionsub.l

loc_20A286:
	tst.b	actflg(a0)
	bpl.s	loc_20A280
	move.b	#1,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bsr.w	sub_20A30C
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	move.l	xposi(a0),d0
	addi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	off30(a0),d0
	addq.w	#1,d0
	move.w	d0,off30(a0)
	cmpi.w	#$1F4,d0
	bne.w	loc_20A2DC
	move.w	#0,off30(a0)
	move.b	#$60,off32(a0)
	move.b	#8,r_no0(a0)

loc_20A2DC:
	move.w	off2A(a0),d0
	addq.w	#1,d0
	move.w	d0,off2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A2FA
	move.w	#0,off2A(a0)
	move.b	#2,r_no0(a0)

loc_20A2FA:
	lea	b_chou_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l

sub_20A30C:
	move.w	off2A(a0),d0
	mulu.w	#256,d0
	divu.w	#128,d0
	jsr	sinset.l
	muls.w	#$3800,d0
	move.l	off2C(a0),d1
	add.l	d0,d1
	move.l	d1,yposi(a0)
	rts

loc_20A32E:
	tst.b	actflg(a0)
	bne.w	loc_20A280
	move.b	off32(a0),d0
	subq.w	#1,d0
	move.b	d0,off32(a0)
	beq.w	loc_20A37A
	move.l	#$4000,d1
	addi.b	#$30,d0
	andi.b	#$3F,d0
	cmpi.b	#$20,d0
	bpl.w	loc_20A35C
	neg.l	d1

loc_20A35C:
	move.l	yposi(a0),d2
	add.l	d1,d2
	move.l	d2,yposi(a0)
	lea	b_chou_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A37A:
	move.w	#0,off30(a0)
	move.b	r_no0(a0),d0
	cmpi.b	#4,d0
	beq.w	loc_20A390
	bra.w	loc_20A398

loc_20A390:
	move.b	#2,r_no0(a0)
	rts

loc_20A398:
	move.b	#6,r_no0(a0)
	rts

e_ari:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_20A3BA
	tst.b	actflg(a0)
	bmi.s	loc_20A3BA
	jsr	actionsub.l
	jmp	frameout_s.l

loc_20A3BA:
	move.w	e_ari_move_tbl(pc,d0.w),d0
	jsr	e_ari_move_tbl(pc,d0.w)
	jmp	frameout_s.l

e_ari_move_tbl:
	dc.w	e_ari_init-e_ari_move_tbl
	dc.w	e_ari_fall-e_ari_move_tbl
	dc.w	e_ari_move_left-e_ari_move_tbl
	dc.w	e_ari_move_right-e_ari_move_tbl

e_ari_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#ari_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#2,d0
	jsr	pa_set.l
	move.b	#0,mstno(a0)
	rts

e_ari_fall:
	move.l	yposi(a0),d0
	addi.l	#$20000,d0
	move.l	d0,yposi(a0)
	move.b	#36/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_20A436
	lea	ari_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20A436:
	move.b	#4,r_no0(a0)
	rts

e_ari_move_left:
	move.b	#36/2,sprvsize(a0)
	subi.l	#$10000,xposi(a0)
	moveq	#8,d3
	jsr	emycol_l.l
	tst.b	d1
	bne.w	loc_20A45E
	bra.w	loc_20A498

loc_20A45E:
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A484
	cmpi.w	#7,d1
	bpl.w	loc_20A498
	cmpi.w	#-8,d1
	bmi.w	loc_20A498
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A484:
	lea	ari_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A498:
	move.b	#6,r_no0(a0)
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	rts
	rts

e_ari_move_right:
	move.b	#36/2,sprvsize(a0)
	addi.l	#$10000,xposi(a0)
	moveq	#8,d3
	jsr	emycol_r.l
	tst.b	d1
	bne.w	loc_20A4CE
	bra.w	loc_20A508

loc_20A4CE:
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A4F4
	cmpi.w	#7,d1
	bpl.w	loc_20A508
	cmpi.w	#-8,d1
	bmi.w	loc_20A508
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A4F4:
	lea	ari_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A508:
	move.b	#4,r_no0(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	rts
	rts

b_ari:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_20A538
	tst.b	actflg(a0)
	bmi.s	loc_20A538
	jsr	actionsub.l
	jmp	frameout_s.l

loc_20A538:
	move.w	b_ari_move_tbl(pc,d0.w),d0
	jsr	b_ari_move_tbl(pc,d0.w)
	jmp	frameout_s.l

b_ari_move_tbl:
	dc.w	b_ari_init-b_ari_move_tbl
	dc.w	b_ari_fall-b_ari_move_tbl
	dc.w	b_ari_move_left-b_ari_move_tbl
	dc.w	loc_20A642-b_ari_move_tbl
	dc.w	b_ari_move_right-b_ari_move_tbl
	dc.w	loc_20A664-b_ari_move_tbl

b_ari_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#ari_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#2,d0
	jsr	pa_set.l
	move.b	#1,mstno(a0)
	move.w	#0,off3E(a0)
	rts

b_ari_fall:
	move.l	yposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,yposi(a0)
	move.b	#36/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_20A5BE
	lea	ari_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20A5BE:
	move.b	#4,r_no0(a0)
	rts

b_ari_move_left:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$F0,d0
	beq.w	loc_20A634
	move.b	#36/2,sprvsize(a0)
	subi.l	#$C000,xposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A60C
	cmpi.w	#7,d1
	bpl.w	loc_20A620
	cmpi.w	#-7,d1
	bmi.w	loc_20A620
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A60C:
	lea	ari_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A620:
	move.b	#8,r_no0(a0)
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	rts

loc_20A634:
	move.w	#0,off3E(a0)
	move.b	#6,r_no0(a0)
	bra.s	loc_20A60C

loc_20A642:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$3C,d0
	beq.w	loc_20A656
	bra.s	loc_20A60C

loc_20A656:
	move.w	#0,off3E(a0)
	move.b	#4,r_no0(a0)
	bra.s	loc_20A60C

loc_20A664:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$3C,d0
	beq.w	loc_20A678
	bra.s	loc_20A60C

loc_20A678:
	move.w	#0,off3E(a0)
	move.b	#8,r_no0(a0)
	bra.s	loc_20A60C

b_ari_move_right:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$F0,d0
	beq.w	loc_20A6F4
	move.b	#36/2,sprvsize(a0)
	addi.l	#$C000,xposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A6CC
	cmpi.w	#7,d1
	bpl.w	loc_20A6E0
	cmpi.w	#-7,d1
	bmi.w	loc_20A6E0
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A6CC:
	lea	ari_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A6E0:
	move.b	#4,r_no0(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	rts

loc_20A6F4:
	move.w	#0,off3E(a0)
	move.b	#$A,r_no0(a0)
	bra.s	loc_20A6CC

e_tagame:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	e_tagame_move_tbl(pc,d0.w),d0
	jsr	e_tagame_move_tbl(pc,d0.w)
	jmp	frameout_s.l

e_tagame_move_tbl:
	dc.w	e_tagame_init-e_tagame_move_tbl
	dc.w	loc_20A75A-e_tagame_move_tbl
	dc.w	loc_20A7AA-e_tagame_move_tbl
	dc.w	loc_20A802-e_tagame_move_tbl

e_tagame_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_tagame_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#3,d0
	jsr	pa_set.l
	move.l	#-$40000,off2A(a0)
	move.b	#0,mstno(a0)
	rts

loc_20A75A:
	addi.l	#$1000,off2A(a0)
	move.l	yposi(a0),d0
	move.l	off2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	tst.l	d1
	bpl.w	loc_20A79C
	cmpi.l	#-$6000,d1
	bpl.w	loc_20A794

loc_20A780:
	lea	e_tagame_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A794:
	move.b	#2,mstno(a0)
	bra.s	loc_20A780

loc_20A79C:
	move.b	#4,r_no0(a0)
	move.b	#3,mstno(a0)
	bra.s	loc_20A780

loc_20A7AA:
	addi.l	#$1000,off2A(a0)
	move.l	yposi(a0),d0
	move.l	off2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	move.l	#-$40000,d2
	neg.l	d2
	cmp.l	d2,d1
	bpl.w	loc_20A7EC
	cmpi.l	#$10000,d1
	bpl.w	loc_20A7FA

loc_20A7D8:
	lea	e_tagame_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A7EC:
	move.b	#6,r_no0(a0)
	move.w	#200,off2E(a0)
	rts

loc_20A7FA:
	move.b	#1,mstno(a0)
	bra.s	loc_20A7D8

loc_20A802:
	subq.w	#1,off2E(a0)
	beq.w	loc_20A80C
	rts

loc_20A80C:
	move.b	#0,r_no0(a0)
	rts

b_tagame:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	b_tagame_move_tbl(pc,d0.w),d0
	jsr	b_tagame_move_tbl(pc,d0.w)
	jmp	frameout_s.l

b_tagame_move_tbl:
	dc.w	loc_20A830-b_tagame_move_tbl
	dc.w	loc_20A86C-b_tagame_move_tbl
	dc.w	loc_20A8BC-b_tagame_move_tbl
	dc.w	loc_20A914-b_tagame_move_tbl

loc_20A830:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_tagame_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	moveq	#3,d0
	jsr	pa_set.l
	move.l	#-$60000,off2A(a0)
	move.b	#4,mstno(a0)
	rts

loc_20A86C:
	addi.l	#$2000,off2A(a0)
	move.l	yposi(a0),d0
	move.l	off2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	tst.l	d1
	bpl.w	loc_20A8AE
	cmpi.l	#-$10000,d1
	bpl.w	loc_20A8A6

loc_20A892:
	lea	e_tagame_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A8A6:
	move.b	#6,mstno(a0)
	bra.s	loc_20A892

loc_20A8AE:
	move.b	#4,r_no0(a0)
	move.b	#7,mstno(a0)
	bra.s	loc_20A892

loc_20A8BC:
	addi.l	#$2000,off2A(a0)
	move.l	yposi(a0),d0
	move.l	off2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	move.l	#-$60000,d2
	neg.l	d2
	cmp.l	d2,d1
	bpl.w	loc_20A8FE
	cmpi.l	#$10000,d1
	bpl.w	loc_20A90C

loc_20A8EA:
	lea	e_tagame_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A8FE:
	move.b	#6,r_no0(a0)
	move.w	#200,off2E(a0)
	rts

loc_20A90C:
	move.b	#5,mstno(a0)
	bra.s	loc_20A8EA

loc_20A914:
	subq.w	#1,off2E(a0)
	beq.w	loc_20A91E
	rts

loc_20A91E:
	move.b	#0,r_no0(a0)
	rts

e_kamem:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	e_kamem_move_tbl(pc,d0.w),d0
	jsr	e_kamem_move_tbl(pc,d0.w)
	jmp	frameout_s.l

e_kamem_move_tbl:
	dc.w	e_kamem_init-e_kamem_move_tbl
	dc.w	loc_20A992-e_kamem_move_tbl
	dc.w	loc_20A9EA-e_kamem_move_tbl
	dc.w	loc_20AA90-e_kamem_move_tbl
	dc.w	loc_20ABA4-e_kamem_move_tbl
	dc.w	loc_20AB36-e_kamem_move_tbl

e_kamem_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_kamem_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	move.w	#$400|tile_xflip,sproffset(a0)
	move.w	#$400|tile_yflip,sproffset(a0)
	move.w	#$4C1|tile_col2,sproffset(a0)
	moveq	#4,d0
	jsr	pa_set.l
	move.w	#0,off3E(a0)
	rts

loc_20A992:
	move.b	#1,mstno(a0)
	move.l	yposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,yposi(a0)
	move.b	#28/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A9D0
	bmi.w	loc_20A9D0
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A9D0:
	move.b	#4,r_no0(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A9EA:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$120,d0
	beq.w	loc_20AA5C
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	move.b	#1,mstno(a0)
	move.b	#28/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AA3A
	cmpi.w	#7,d1
	bpl.w	loc_20AA5C
	cmpi.w	#-7,d1
	bmi.w	loc_20AA5C
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AA3A:
	move.l	xposi(a0),d0
	subi.l	#$C000,d0
	move.l	d0,xposi(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AA5C:
	move.l	xposi(a0),d0
	addi.l	#$C000,d0
	move.l	d0,xposi(a0)
	move.w	#0,off3E(a0)
	move.b	#$A,r_no0(a0)
	move.b	#2,mstno(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AA90:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$120,d0
	beq.w	loc_20AB02
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	move.b	#1,mstno(a0)
	move.b	#28/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AAE0
	cmpi.w	#7,d1
	bpl.w	loc_20AB02
	cmpi.w	#-7,d1
	bmi.w	loc_20AB02
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AAE0:
	move.l	xposi(a0),d0
	addi.l	#$C000,d0
	move.l	d0,xposi(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AB02:
	move.w	#0,off3E(a0)
	move.b	#8,r_no0(a0)
	move.b	#2,mstno(a0)
	move.l	xposi(a0),d0
	subi.l	#$C000,d0
	move.l	d0,xposi(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AB36:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$46,d0
	beq.w	loc_20AB82
	cmpi.w	#$5A,d0
	beq.w	loc_20AB9E
	cmpi.w	#$96,d0
	beq.w	loc_20AB8A
	cmpi.w	#$B4,d0
	beq.w	loc_20AB74

loc_20AB60:
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AB74:
	move.w	#0,off3E(a0)
	move.b	#6,r_no0(a0)
	bra.s	loc_20AB60

loc_20AB82:
	move.b	#3,mstno(a0)
	bra.s	loc_20AB60

loc_20AB8A:
	move.b	#2,mstno(a0)
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	bra.s	loc_20AB60

loc_20AB9E:
	bsr.w	sub_20AC12
	bra.s	loc_20AB60

loc_20ABA4:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$46,d0
	beq.w	loc_20ABF0
	cmpi.w	#$5A,d0
	beq.w	loc_20AC0C
	cmpi.w	#$96,d0
	beq.w	loc_20ABF8
	cmpi.w	#$B4,d0
	beq.w	loc_20ABE2

loc_20ABCE:
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20ABE2:
	move.w	#0,off3E(a0)
	move.b	#4,r_no0(a0)
	bra.s	loc_20ABCE

loc_20ABF0:
	move.b	#3,mstno(a0)
	bra.s	loc_20ABCE

loc_20ABF8:
	move.b	#2,mstno(a0)
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	bra.s	loc_20ABCE

loc_20AC0C:
	bsr.w	sub_20AC12
	bra.s	loc_20ABCE

sub_20AC12:
	move.b	#1,d6
	bsr.w	sub_20AC24
	move.b	#2,d6
	bsr.w	sub_20AC24
	rts

sub_20AC24:
	jsr	sub_20B4D8.l
	tst.b	d0
	beq.w	locret_20AC56
	move.b	d6,userflag(a2)
	_move.b	#tama_act,actno(a2)
	move.l	xposi(a0),d1
	addi.l	#0,d1
	move.l	d1,xposi(a2)
	move.l	yposi(a0),d1
	addi.l	#$FFF00000,d1
	move.l	d1,yposi(a2)

locret_20AC56:
	rts

b_kamem:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	b_kamem_move_tbl(pc,d0.w),d0
	jsr	b_kamem_move_tbl(pc,d0.w)
	jmp	frameout_s.l

b_kamem_move_tbl:
	dc.w	b_kamem_init-b_kamem_move_tbl
	dc.w	loc_20ACC4-b_kamem_move_tbl
	dc.w	loc_20AD1C-b_kamem_move_tbl
	dc.w	loc_20ADC2-b_kamem_move_tbl
	dc.w	loc_20AED6-b_kamem_move_tbl
	dc.w	loc_20AE68-b_kamem_move_tbl

b_kamem_init:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#e_kamem_pat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#32/2,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	move.w	#$400|tile_xflip,sproffset(a0)
	move.w	#$400|tile_yflip,sproffset(a0)
	move.w	#$4C1|tile_col2,sproffset(a0)
	moveq	#4,d0
	jsr	pa_set.l
	move.w	#0,off3E(a0)
	rts

loc_20ACC4:
	move.b	#4,mstno(a0)
	move.l	yposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,yposi(a0)
	move.b	#28/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AD02
	bmi.w	loc_20AD02
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AD02:
	move.b	#4,r_no0(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AD1C:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$1B0,d0
	beq.w	loc_20AD8E
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	move.b	#4,mstno(a0)
	move.b	#28/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AD6C
	cmpi.w	#7,d1
	bpl.w	loc_20AD8E
	cmpi.w	#-7,d1
	bmi.w	loc_20AD8E
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AD6C:
	move.l	xposi(a0),d0
	subi.l	#$5000,d0
	move.l	d0,xposi(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AD8E:
	move.l	xposi(a0),d0
	addi.l	#$5000,d0
	move.l	d0,xposi(a0)
	move.w	#0,off3E(a0)
	move.b	#$A,r_no0(a0)
	move.b	#2,mstno(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20ADC2:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$1B0,d0
	beq.w	loc_20AE34
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	move.b	#4,mstno(a0)
	move.b	#28/2,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AE12
	cmpi.w	#7,d1
	bpl.w	loc_20AE34
	cmpi.w	#-7,d1
	bmi.w	loc_20AE34
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AE12:
	move.l	xposi(a0),d0
	addi.l	#$5000,d0
	move.l	d0,xposi(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AE34:
	move.w	#0,off3E(a0)
	move.b	#8,r_no0(a0)
	move.b	#2,mstno(a0)
	move.l	xposi(a0),d0
	subi.l	#$5000,d0
	move.l	d0,xposi(a0)
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AE68:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$50,d0
	beq.w	loc_20AEB4
	cmpi.w	#$96,d0
	beq.w	loc_20AED0
	cmpi.w	#$BE,d0
	beq.w	loc_20AEBC
	cmpi.w	#$F0,d0
	beq.w	loc_20AEA6

loc_20AE92:
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AEA6:
	move.w	#0,off3E(a0)
	move.b	#6,r_no0(a0)
	bra.s	loc_20AE92

loc_20AEB4:
	move.b	#3,mstno(a0)
	bra.s	loc_20AE92

loc_20AEBC:
	move.b	#2,mstno(a0)
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	bra.s	loc_20AE92

loc_20AED0:
	bsr.w	sub_20AF44
	bra.s	loc_20AE92

loc_20AED6:
	move.w	off3E(a0),d0
	addq.w	#1,d0
	move.w	d0,off3E(a0)
	cmpi.w	#$50,d0
	beq.w	loc_20AF22
	cmpi.w	#$96,d0
	beq.w	loc_20AF3E
	cmpi.w	#$BE,d0
	beq.w	loc_20AF2A
	cmpi.w	#$F0,d0
	beq.w	loc_20AF14

loc_20AF00:
	lea	e_kamem_pchg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AF14:
	move.w	#0,off3E(a0)
	move.b	#4,r_no0(a0)
	bra.s	loc_20AF00

loc_20AF22:
	move.b	#3,mstno(a0)
	bra.s	loc_20AF00

loc_20AF2A:
	move.b	#2,mstno(a0)
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	bra.s	loc_20AF00

loc_20AF3E:
	bsr.w	sub_20AF44
	bra.s	loc_20AF00

sub_20AF44:
	move.b	#3,d6
	bsr.w	sub_20AF56
	move.b	#4,d6
	bsr.w	sub_20AF56
	rts

sub_20AF56:
	jsr	sub_20B4D8.l
	tst.b	d0
	beq.w	locret_20AF88
	move.b	d6,userflag(a2)
	_move.b	#tama_act,actno(a2)
	move.l	xposi(a0),d1
	addi.l	#0,d1
	move.l	d1,xposi(a2)
	move.l	yposi(a0),d1
	addi.l	#$FFF00000,d1
	move.l	d1,yposi(a2)

locret_20AF88:
	rts

pchg_e:
	dc.w	unk_20AF92-pchg_e
	dc.w	unk_20AF9A-pchg_e
	dc.w	unk_20AF9E-pchg_e
	dc.w	unk_20AFAE-pchg_e
unk_20AF92:
	dc.b	20-1
	dc.b	0,1,2,3,4
	dc.b	$FF
	even
unk_20AF9A:
	dc.b	2-1
	dc.b	0,1
	dc.b	$FF
	even
unk_20AF9E:
	dc.b	7-1
	dc.b	2,3,4,4,4,4,4,4,4,4,4,4,4
	dc.b	$FF
	even
unk_20AFAE:
	dc.b	1-1
	dc.b	4
	dc.b	$FF
	even

e_ka_pat:
	include	"Patterns/Mosqui (Normal).asm"

pchg_b:
	dc.w	unk_20B00A-pchg_b
	dc.w	unk_20B012-pchg_b
	dc.w	unk_20B016-pchg_b
	dc.w	unk_20B020-pchg_b
unk_20B00A:
	dc.b	20-1
	dc.b	0,1,2,3,4
	dc.b	$FF
	even
unk_20B012:
	dc.b	5-1
	dc.b	0,1
	dc.b	$FF
	even
unk_20B016:
	dc.b	15-1
	dc.b	2,3,4,4,4,4,4
	dc.b	$FF
	even
unk_20B020:
	dc.b	1-1
	dc.b	4
	dc.b	$FF
	even

b_ka_pat:
	include	"Patterns/Mosqui (Damaged).asm"

b_chou_pchg:
	dc.w	unk_20B07A-b_chou_pchg
	dc.w	unk_20B082-b_chou_pchg
	dc.b	20-1
	dc.b	0,1,2,1
	dc.b	$FF
	even
unk_20B07A:
	dc.b	5-1
	dc.b	0,0,1,2,1
	dc.b	$FF
	even
unk_20B082:
	dc.b	5-1
	dc.b	3,3,4,5,4
	dc.b	$FF
	even

e_chou_pat:
	include	"Patterns/Pata-Bata (Normal).asm"

e_chou_pchg:
	dc.w	unk_20B0D0-e_chou_pchg
	dc.w	unk_20B0D8-e_chou_pchg
	dc.b	20-1
	dc.b	0,1,2,1
	dc.b	$FF
	even
unk_20B0D0:
	dc.b	5-1
	dc.b	0,0,1,2,1
	dc.b	$FF
	even
unk_20B0D8:
	dc.b	5-1
	dc.b	3,3,4,5,4
	dc.b	$FF
	even

b_chou_pat:
	include	"Patterns/Pata-Bata (Damaged).asm"

ari_pchg:
	dc.w	unk_20B132-ari_pchg
	dc.w	unk_20B136-ari_pchg
	dc.w	unk_20B12E-ari_pchg
	dc.w	unk_20B124-ari_pchg
unk_20B124:
	dc.b	20-1
	dc.b	0,1,2,3,4,5,6,7
	dc.b	$FF
	even
unk_20B12E:
	dc.b	20-1
	dc.b	0
	dc.b	$FF
	even
unk_20B132:
	dc.b	4-1
	dc.b	6,7
	dc.b	$FF
	even
unk_20B136:
	dc.b	4-1
	dc.b	8,9
	dc.b	$FF
	even

ari_pat:
	include	"Patterns/Anton.asm"

e_tagame_pchg:
	dc.w	unk_20B202-e_tagame_pchg
	dc.w	unk_20B206-e_tagame_pchg
	dc.w	unk_20B20A-e_tagame_pchg
	dc.w	unk_20B20E-e_tagame_pchg
	dc.w	unk_20B212-e_tagame_pchg
	dc.w	unk_20B216-e_tagame_pchg
	dc.w	unk_20B21A-e_tagame_pchg
	dc.w	unk_20B21E-e_tagame_pchg
	dc.w	unk_20B222-e_tagame_pchg
	dc.w	unk_20B22A-e_tagame_pchg
unk_20B202:
	dc.b	10-1
	dc.b	6,7
	dc.b	$FF
	even
unk_20B206:
	dc.b	10-1
	dc.b	8,9
	dc.b	$FF
	even
unk_20B20A:
	dc.b	40-1
	dc.b	10
	dc.b	$FF
	even
unk_20B20E:
	dc.b	40-1
	dc.b	11
	dc.b	$FF
	even
unk_20B212:
	dc.b	10-1
	dc.b	6,7
	dc.b	$FF
	even
unk_20B216:
	dc.b	10-1
	dc.b	12,13
	dc.b	$FF
	even
unk_20B21A:
	dc.b	40-1
	dc.b	10
	dc.b	$FF
	even
unk_20B21E:
	dc.b	40-1
	dc.b	$E
	dc.b	$FF
	even
unk_20B222:
	dc.b	40-1
	dc.b	0,1,2,3,4,5
	dc.b	$FF
	even
unk_20B22A:
	dc.b	10-1
	dc.b	6,7,6,7,6,7,10,10,11,11,8,9,9,8,9,8,9
	dc.b	$FF
	even

e_tagame_pat:
	include	"Patterns/Taga-Taga.asm"

e_kamem_pchg:
	dc.w	unk_20B3F8-e_kamem_pchg
	dc.w	unk_20B434-e_kamem_pchg
	dc.w	unk_20B43A-e_kamem_pchg
	dc.w	unk_20B43E-e_kamem_pchg
	dc.w	unk_20B442-e_kamem_pchg
unk_20B3F8:
	dc.b	20-1
	dc.b	0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,5
	dc.b	7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,5
	dc.b	0,1,2,3,4,5,6,7
	dc.b	$FF
	even
unk_20B434:
	dc.b	20-1
	dc.b	0,1,0,1
	dc.b	$FF
	even
unk_20B43A:
	dc.b	20-1
	dc.b	0,0
	dc.b	$FF
	even
unk_20B43E:
	dc.b	10-1
	dc.b	2,2
	dc.b	$FF
	even
unk_20B442:
	dc.b	6-1
	dc.b	1,7,1,7
	dc.b	$FF
	even

e_kamem_pat:
	include	"Patterns/Tamabboh.asm"

off_20B4B6:
	dc.w	unk_20B4BC-off_20B4B6
	dc.w	unk_20B4C0-off_20B4B6
	dc.w	unk_20B4C4-off_20B4B6
unk_20B4BC:
	dc.b	30-1
	dc.b	0,1
	dc.b	$FF
	even
unk_20B4C0:
	dc.b	1-1
	dc.b	0
	dc.b	$FF
	even
unk_20B4C4:
	dc.b	1-1
	dc.b	1
	dc.b	$FF
	even

off_20B4C8:
	dc.w	byte_20B4CC-off_20B4C8
	dc.w	byte_20B4D2-off_20B4C8
byte_20B4CC:
	dc.b	1
	dc.b	-8,5,0,0,-8
byte_20B4D2:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even

sub_20B4D8:
	lea	unk_FFD400,a2
	moveq	#0,d0

loc_20B4DE:
	_move.b	actno(a2),d1
	beq.w	loc_20B4F6
	addq.w	#1,d0
	lea	actfree(a2),a2
	cmpi.w	#60,d0
	bne.s	loc_20B4DE
	moveq	#0,d0
	rts

loc_20B4F6:
	moveq	#-1,d0
	rts

ene_tama:
	moveq	#0,d0
	move.b	userflag(a0),d0
	andi.w	#$7F,d0
	add.w	d0,d0
	move.w	off_20B510(pc,d0.w),d0
	jmp	off_20B510(pc,d0.w)
	rts

off_20B510:
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	loc_20B526-off_20B510

locret_20B524:
	rts

loc_20B526:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20B534(pc,d0.w),d0
	jmp	off_20B534(pc,d0.w)

off_20B534:
	dc.w	loc_20B538-off_20B534
	dc.w	loc_20B578-off_20B534

loc_20B538:
	addq.b	#word,r_no0(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#8/2,sprhs(a0)
	move.b	#8/2,sprvsize(a0)
	move.w	#$400|tile_col2,sproffset(a0)
	move.l	#obj23pat,patbase(a0)
	move.l	#$10000,off2A(a0)
	move.b	off3F(a0),d0
	bpl.w	locret_20B576
	neg.l	off2A(a0)

locret_20B576:
	rts

loc_20B578:
	move.l	off2A(a0),d0
	add.l	d0,xposi(a0)
	lea	obj23chg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

obj23chg:
	dc.w	byte_20B592-obj23chg

byte_20B592:
	dc.b	2-1
	dc.b	0,1
	dc.b	$FF
	even

obj23pat:
	dc.w	byte_20B59E-obj23pat
	dc.w	byte_20B5B3-obj23pat
byte_20B59E:
	dc.b	4
	dc.b	-8,0,0,$2A,-8
	dc.b	-8,0,8,$2A,0
	dc.b	0,0,$10,$2A,-8
	dc.b	0,0,$18,$2A,0
byte_20B5B3:
	dc.b	4
	dc.b	-8,0,0,$2B,-8
	dc.b	-8,0,8,$2B,0
	dc.b	0,0,$10,$2B,-8
	dc.b	0,0,$18,$2B,0
	even