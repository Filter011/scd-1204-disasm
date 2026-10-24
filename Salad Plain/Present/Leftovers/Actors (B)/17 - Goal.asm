	moveq	#0,d0
	move.b	r_no0(a0),d0
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
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)

loc_20FF36:
	jsr	$2043A4.l
	move.w	xposi(a0),d0
	cmp.w	xposi(a6),d0
	bhs.s	locret_20FF62
	move.w	scralim_right.w,scralim_left.w
	move.b	#60,act2A(a0)
	move.b	#180,act2B(a0)
	move.b	#240,act2B(a0)
	addq.b	#word,r_no0(a0)

locret_20FF62:
	rts

loc_20FF64:
	subq.b	#1,act2A(a0)
	bne.s	loc_20FF6E
	addq.b	#word,r_no0(a0)

loc_20FF6E:
	subq.b	#1,act2B(a0)
	bne.s	loc_20FF8A
	bset	#0,plautoflag.w
	move.b	#0,mstno(a0)
	move.w	#$808,swdata.w
	addq.b	#word,r_no0(a0)

loc_20FF8A:
	subq.b	#1,act2B(a0)
	bne.s	locret_20FF98
	move.w	#2,gameflag

locret_20FF98:
	rts