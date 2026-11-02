	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20E0F2(pc,d0.w),d0
	jsr	off_20E0F2(pc,d0.w)
	jmp	$203206.l

off_20E0F2:
	dc.w	loc_20E0FC-off_20E0F2
	dc.w	loc_20E11A-off_20E0F2
	dc.w	loc_20E148-off_20E0F2
	dc.w	loc_20E15A-off_20E0F2
	dc.w	loc_20E178-off_20E0F2

loc_20E0FC:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)
	move.w	#$503,sproffset(a0)
	move.l	#off_20E1DA,patbase(a0)

loc_20E11A:
	jsr	$2023EA.l
	move.w	xposi(a0),d0
	cmp.w	xposi(a6),d0
	bhs.s	locret_20E146
	move.w	scralim_right.w,scralim_left.w
	clr.b	pltime_f
	move.b	#60,act2A(a0)
	move.b	#0,patno(a0)
	addq.b	#word,r_no0(a0)

locret_20E146:
	rts

loc_20E148:
	subq.b	#1,act2A(a0)
	bne.s	locret_20E158
	addq.b	#word,r_no0(a0)
	move.b	#1,act2A(a0)

locret_20E158:
	rts

loc_20E15A:
	subq.b	#1,act2A(a0)
	bne.s	locret_20E176
	bset	#0,plautoflag.w
	move.w	#$808,swdata.w
	move.b	#60,act2A(a0)
	addq.b	#word,r_no0(a0)

locret_20E176:
	rts

loc_20E178:
	subq.b	#1,act2A(a0)
	bne.s	locret_20E1CE
	move.w	#2,gameflag
	move.b	#0,plflag
	clr.w	enecgpnt
	clr.l	flowercnt
	move.b	#1,time_flag
	move.b	stageact,d0
	addq.b	#1,d0
	cmpi.b	#2,d0
	bne.s	loc_20E1C2
	moveq	#0,d0
	move.b	#0,pl_suu
	bclr	#0,play_start

loc_20E1C2:
	move.b	d0,stageact
	jmp	$20544A.l

locret_20E1CE:
	rts

off_20E1D0:
	dc.w	byte_20E1D2-off_20E1D0

byte_20E1D2:
	dc.b	1
	dc.b	0,1,2,3,4
	dc.b	$FF
	even

off_20E1DA:
	dc.w	byte_20E1DC-off_20E1DA

byte_20E1DC:
	dc.b	6
	dc.b	$D8,$B,0,0,$E8
	dc.b	$D8,$B,0,$C,0
	dc.b	$F4,2,0,$18,-8
	dc.b	4,0,0,$1B,$F0
	dc.b	$F4,2,8,$18,0
	dc.b	4,0,8,$1B,8
	even