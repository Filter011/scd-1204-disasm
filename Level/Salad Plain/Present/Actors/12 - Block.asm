block:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	block_tbl(pc,d0.w),d0
	jsr	block_tbl(pc,d0.w)
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.w	frameout
	rts

block_tbl:
	dc.w	block_init-block_tbl
	dc.w	block_move-block_tbl
	dc.w	block_move2-block_tbl
	dc.w	block_move3-block_tbl
	dc.w	block_move4-block_tbl
	dc.w	block_move5-block_tbl
	dc.w	block_move6-block_tbl

block_init:
	addq.b	#2,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.l	#blockpat,patbase(a0)
	moveq	#5,d0
	jsr	pa_set.l
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.b	#4,sprvsize(a0)
	move.b	#5,patno(a0)

block_move:
	bsr.w	block_ride
	tst.b	time_flag
	beq.s	loc_208F68
	cmpi.b	#2,time_flag
	bne.s	loc_208F4E
	btst	#3,cddat(a0)
	bne.s	loc_208F6E
	bra.s	loc_208F68

loc_208F4E:
	move.b	#0,patno(a0)
	btst	#3,cddat(a0)
	beq.s	loc_208F68
	move.b	#6,r_no0(a0)
	move.b	#1,mstno(a0)

loc_208F68:
	jmp	actionsub.l

loc_208F6E:
	addq.b	#2,r_no0(a0)

block_move2:
	bsr.w	block_ride
	addq.w	#2,yposi(a0)
	move.w	scra_v_posit.w,d0
	addi.w	#224,d0
	cmp.w	yposi(a0),d0
	bhs.s	loc_208F8E
	jmp	frameout.l

loc_208F8E:
	jmp	actionsub.l

block_move3:
	bsr.w	block_ride
	btst	#3,cddat(a0)
	bne.s	loc_208FA8
	move.b	#2,r_no0(a0)
	rts

loc_208FA8:
	lea	blockchg.l,a1
	bsr.w	patchg
	jmp	actionsub.l

block_move4:
	move.b	#0,mstno(a0)
	bsr.w	block_ride
	btst	#3,cddat(a0)
	bne.s	loc_208FD6
	addq.b	#2,r_no0(a0)
	move.b	#2,mstno(a0)
	rts

loc_208FD6:
	lea	blockchg.l,a1
	bsr.w	patchg
	jmp	actionsub.l

block_move5:
	bsr.w	block_ride
	lea	blockchg.l,a1
	bsr.w	patchg
	jmp	actionsub.l

block_move6:
	move.b	#2,r_no0(a0)
	rts

block_ride:
	lea	playerwk.w,a1
	bsr.w	ride_on_chk_b
	lea	byte_FFD040.w,a1

ride_on_chk_b:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	subq.w	#8,d4
	jmp	ridechk.l

blockchg:
	dc.w	blockchg0-blockchg
	dc.w	blockchg1-blockchg
	dc.w	blockchg2-blockchg
blockchg0:
	dc.b	2
	dc.b	5
	dc.b	$FF
	even
blockchg1:
	dc.b	2
	dc.b	1,5,2,5,3,5,4,5
	dc.b	$FC
	even
blockchg2:
	dc.b	2
	dc.b	1,0,2,0,3,0,4,0
	dc.b	$FC
	even

blockpat:
	dc.w	byte_209048-blockpat
	dc.w	byte_20904A-blockpat
	dc.w	byte_20905A-blockpat
	dc.w	byte_20906A-blockpat
	dc.w	byte_209076-blockpat
	dc.w	byte_209082-blockpat
byte_209048:
	dc.b	0
	even
byte_20904A:
	dc.b	3
	dc.b	$F4,9,0,0,$F4
	dc.b	4,0,0,0,$FC
	dc.b	4,0,0,0,4
	even
byte_20905A:
	dc.b	3
	dc.b	$F4,9,8,0,$F4
	dc.b	4,0,8,0,$F4
	dc.b	4,0,8,0,$FC
byte_20906A:
	dc.b	2
	dc.b	$F4,9,$18,0,$F4
	dc.b	4,0,$18,0,$FC
	even
byte_209076:
	dc.b	2
	dc.b	$F4,9,$10,0,$F4
	dc.b	4,0,$10,0,$FC
	even
byte_209082:
	dc.b	1
	dc.b	$F4,$A,0,6,$F4
	even