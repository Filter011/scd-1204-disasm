scrchk:
	bsr.w	main_chk
	moveq	#0,d0
	move.b	stageno,d0
	add.w	d0,d0
	move.w	zonechktbl(pc,d0.w),d0
	jsr	zonechktbl(pc,d0.w)
	moveq	#4,d1
	move.w	scralim_n_down.w,d0
	sub.w	scralim_down.w,d0
	beq.s	locret_203074
	bhs.s	loc_203076
	neg.w	d1
	move.w	scra_v_posit.w,d0
	cmp.w	scralim_n_down.w,d0
	bls.s	loc_20306A
	move.w	d0,scralim_down.w
	andi.w	#$FFFE,scralim_down.w

loc_20306A:
	add.w	d1,scralim_down.w
	move.b	#1,limmoveflag.w

locret_203074:
	rts

loc_203076:
	move.w	scra_v_posit.w,d0
	addq.w	#8,d0
	cmp.w	scralim_down.w,d0
	blo.s	loc_20308E
	btst	#1,cddat(a6)
	beq.s	loc_20308E
	add.w	d1,d1
	add.w	d1,d1

loc_20308E:
	add.w	d1,scralim_down.w
	move.b	#1,limmoveflag.w
	rts

zonechktbl:
	dc.w	zone1chk-zonechktbl
	dc.w	zone1chk-zonechktbl
	dc.w	zone3chk-zonechktbl
	dc.w	zone4chk-zonechktbl
	dc.w	zone4chk-zonechktbl
	dc.w	zone4chk-zonechktbl
	dc.w	zone4chk-zonechktbl
	dc.w	zone4chk-zonechktbl

zone1chk:
	moveq	#0,d0
	move.b	stageact,d0
	add.w	d0,d0
	move.w	zone1chktbl(pc,d0.w),d0
	jmp	zone1chktbl(pc,d0.w)

zone1chktbl:
	dc.w	zone11chk-zone1chktbl
	dc.w	zone11chk-zone1chktbl
	dc.w	zone11chk-zone1chktbl

zone11chk:
	move.w	#$310,scralim_n_down.w
	rts

zone3chk:
	moveq	#0,d0
	move.b	stageact,d0
	add.w	d0,d0
	move.w	zone3chktbl(pc,d0.w),d0
	jmp	zone3chktbl(pc,d0.w)

zone3chktbl:
	dc.w	zone31chk-zone3chktbl
	dc.w	zone31chk-zone3chktbl
	dc.w	zone31chk-zone3chktbl

zone31chk:
	move.w	#$510,scralim_n_down.w
	rts

zone4chk:
	move.w	#$710,scralim_n_down.w
	rts