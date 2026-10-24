	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20E670(pc,d0.w),d0
	jmp	off_20E670(pc,d0.w)

off_20E670:
	dc.w	loc_20E674-off_20E670
	dc.w	loc_20E6DA-off_20E670

loc_20E674:
	addq.b	#word,r_no0(a0)
	move.l	#off_20EDDE,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	moveq	#$A,d0
	jsr	sub_20F8C0(pc)
	move.b	userflag(a0),d0
	andi.b	#7,d0
	move.b	d0,mstno(a0)
	move.b	#$86,colino(a0)
	move.b	#$10,sprhsize(a0)
	move.b	#$C,sprvsize(a0)
	cmpi.b	#3,d0
	bne.w	loc_20E6C4
	move.b	#2,sprhsize(a0)
	move.b	#$C,sprvsize(a0)

loc_20E6C4:
	cmpi.b	#4,d0
	bmi.w	locret_20E6D8
	move.b	#$10,sprhsize(a0)
	move.b	#3,sprvsize(a0)

locret_20E6D8:
	rts

loc_20E6DA:
	lea	playerwk.w,a1
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jsr	$209E14.l
	lea	off_20ED40.l,a1
	jsr	$20739E.l
	jsr	$20517A.l
	jmp	$208E96.l