toge:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	toge_move_tbl(pc,d0.w),d0
	jmp	toge_move_tbl(pc,d0.w)

toge_move_tbl:
	dc.w	togeinit-toge_move_tbl
	dc.w	togemove-toge_move_tbl

togeinit:
	addq.b	#word,r_no0(a0)
	move.l	#togepat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	moveq	#10,d0
	jsr	pa_set(pc)
	move.b	userflag(a0),d0
	andi.b	#%00000111,d0
	move.b	d0,mstno(a0)
	move.b	#$86,colino(a0)
	move.b	#32/2,sprhsize(a0)
	move.b	#24/2,sprvsize(a0)
	cmpi.b	#%00000011,d0
	bne.w	loc_20C874
	move.b	#4/2,sprhsize(a0)
	move.b	#24/2,sprvsize(a0)

loc_20C874:
	cmpi.b	#%00000100,d0
	bmi.w	locret_20C888
	move.b	#32/2,sprhsize(a0)
	move.b	#6/2,sprvsize(a0)

locret_20C888:
	rts

togemove:
	lea	playerwk,a1
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jsr	ride_on_chk.l
	lea	togechg.l,a1
	jsr	patchg.l
	jsr	actionsub.l
	jmp	frameout_s.l