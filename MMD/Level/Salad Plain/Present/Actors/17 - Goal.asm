goal:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	goal_tbl(pc,d0.w),d0
	jsr	goal_tbl(pc,d0.w)
	jmp	actionsub.l

goal_tbl:
	dc.w	goal_init-goal_tbl
	dc.w	goal_move0-goal_tbl
	dc.w	goal_move1-goal_tbl
	dc.w	goal_move2-goal_tbl
	dc.w	goal_move3-goal_tbl

goal_init:
	addq.b	#2,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)
	move.w	#$503,sproffset(a0)
	move.l	#goalpat,patbase(a0)

goal_move0:
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

goal_move1:
	subq.b	#1,act2A(a0)
	bne.s	locret_20DF50
	addq.b	#2,r_no0(a0)
	move.b	#1,act2A(a0)

locret_20DF50:
	rts

goal_move2:
	subq.b	#1,act2A(a0)
	bne.s	locret_20DF6E
	bset	#0,plautoflag.w
	move.w	#$808,swdata.w
	move.b	#60,act2A(a0)
	addq.b	#2,r_no0(a0)

locret_20DF6E:
	rts

goal_move3:
	subq.b	#1,act2A(a0)
	bne.s	locret_20DFC6
	move.w	#2,gameflag
	move.b	#0,plflag
	clr.w	word_FF12F4
	clr.l	flowerwk
	move.b	#1,time_flag
	move.b	stageact,d0
	addq.b	#1,d0
	cmpi.b	#act_3,d0
	bne.s	loc_20DFBA
	moveq	#0,d0
	move.b	#0,pl_suu
	bclr	#0,byte_FF122A

loc_20DFBA:
	move.b	d0,stageact
	jmp	loc_205400.l

locret_20DFC6:
	rts

goalchg:
	dc.w	goalchg0-goalchg
goalchg0:
	dc.b	1
	dc.b	0,1,2,3,4
	dc.b	$FF
	even

goalpat:
	include	"Mappings/Goal.asm"