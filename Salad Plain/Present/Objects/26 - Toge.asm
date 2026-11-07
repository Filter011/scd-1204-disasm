toge:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20C820(pc,d0.w),d0
	jmp	off_20C820(pc,d0.w)

off_20C820:
	dc.w	loc_20C824-off_20C820
	dc.w	loc_20C88A-off_20C820

loc_20C824:
	addq.b	#word,r_no0(a0)
	move.l	#togepat,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	moveq	#10,d0
	jsr	pa_set(pc)
	move.b	userflag(a0),d0
	andi.b	#7,d0
	move.b	d0,mstno(a0)
	move.b	#$86,colino(a0)
	move.b	#32/2,sprhsize(a0)
	move.b	#24/2,sprvsize(a0)
	cmpi.b	#3,d0
	bne.w	loc_20C874
	move.b	#4/2,sprhsize(a0)
	move.b	#24/2,sprvsize(a0)

loc_20C874:
	cmpi.b	#4,d0
	bmi.w	locret_20C888
	move.b	#32/2,sprhsize(a0)
	move.b	#6/2,sprvsize(a0)

locret_20C888:
	rts

loc_20C88A:
	lea	playerwk,a1
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jsr	ride_on_chk.l
	lea	togechg.l,a1
	jsr	patchg.l
	jsr	actionsub.l
	jmp	frameout_s.l