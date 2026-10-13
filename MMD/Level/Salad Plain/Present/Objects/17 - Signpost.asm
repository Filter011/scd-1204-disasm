goal:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20DEEA(pc,d0.w),d0
	jsr	off_20DEEA(pc,d0.w)
	jmp	actionsub.l

off_20DEEA:
	dc.w	loc_20DEF4-off_20DEEA
	dc.w	loc_20DF12-off_20DEEA
	dc.w	loc_20DF40-off_20DEEA
	dc.w	loc_20DF52-off_20DEEA
	dc.w	loc_20DF70-off_20DEEA

loc_20DEF4:
	addq.b	#2,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)
	move.w	#$503,sproffset(a0)
	move.l	#obj17_map,patbase(a0)
loc_20DF12:
	jsr	sub_2023EA.l
	move.w	xposi(a0),d0
	cmp.w	xposi(a6),d0
	bhs.s	locret_20DF3E
	move.w	scralim_right.w,scralim_left.w
	clr.b	pltime_f
	move.b	#60,act2A(a0)
	move.b	#0,patno(a0)
	addq.b	#2,r_no0(a0)
locret_20DF3E:
	rts

loc_20DF40:
	subq.b	#1,act2A(a0)
	bne.s	locret_20DF50
	addq.b	#2,r_no0(a0)
	move.b	#1,act2A(a0)
locret_20DF50:
	rts

loc_20DF52:
	subq.b	#1,act2A(a0)
	bne.s	locret_20DF6E
	bset	#0,plautoflag.w
	move.w	#$808,swdata.w
	move.b	#60,act2A(a0)
	addq.b	#2,r_no0(a0)
locret_20DF6E:
	rts

loc_20DF70:
	subq.b	#1,act2A(a0)
	bne.s	locret_20DFC6
	move.w	#2,gameflag
	move.b	#0,plflag
	clr.w	word_FF12F4
	clr.l	flowerwk
	move.b	#1,time_flag
	move.b	stageact,d0
	addq.b	#1,d0
	cmpi.b	#actid_3,d0
	bne.s	loc_20DFBA
	moveq	#0,d0
	move.b	#0,pl_suu
	bclr	#0,byte_FF122A
loc_20DFBA:
	move.b	d0,stageact
	jmp	loc_205400.l

locret_20DFC6:
	rts