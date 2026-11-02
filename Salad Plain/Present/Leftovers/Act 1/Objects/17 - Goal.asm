	moveq	#0,d0
	move.b	r_no0(a0),d0
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
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)

loc_20FB6C:
	jsr	$2043A4.l
	move.w	xposi(a0),d0
	cmp.w	xposi(a6),d0
	bhs.s	locret_20FB98
	move.w	scralim_right.w,scralim_left.w
	move.b	#60,act2A(a0)
	move.b	#180,act2B(a0)
	move.b	#240,act2B(a0)
	addq.b	#word,r_no0(a0)

locret_20FB98:
	rts

loc_20FB9A:
	subq.b	#1,act2A(a0)
	bne.s	loc_20FBA4
	addq.b	#word,r_no0(a0)

loc_20FBA4:
	subq.b	#1,act2B(a0)
	bne.s	loc_20FBC0
	bset	#0,plautoflag.w
	move.b	#0,mstno(a0)
	move.w	#$808,swdata.w
	addq.b	#word,r_no0(a0)

loc_20FBC0:
	subq.b	#1,act2B(a0)
	bne.s	locret_20FBCE
	move.w	#2,gameflag

locret_20FBCE:
	rts