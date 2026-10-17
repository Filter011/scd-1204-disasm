obj23:
	moveq	#0,d0
	move.b	userflag(a0),d0
	andi.w	#$7F,d0
	add.w	d0,d0
	move.w	off_20B510(pc,d0.w),d0
	jmp	off_20B510(pc,d0.w)
	rts

off_20B510:
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	locret_20B524-off_20B510
	dc.w	loc_20B526-off_20B510

locret_20B524:
	rts

loc_20B526:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20B534(pc,d0.w),d0
	jmp	off_20B534(pc,d0.w)

off_20B534:
	dc.w	loc_20B538-off_20B534
	dc.w	loc_20B578-off_20B534

loc_20B538:
	addq.b	#word,r_no0(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#4,sprhs(a0)
	move.b	#4,sprvsize(a0)
	move.w	#$2400,sproffset(a0)
	move.l	#obj23_map,patbase(a0)
	move.l	#$10000,act2A(a0)
	move.b	act3F(a0),d0
	bpl.w	locret_20B576
	neg.l	act2A(a0)

locret_20B576:
	rts

loc_20B578:
	move.l	act2A(a0),d0
	add.l	d0,xposi(a0)
	lea	obj23_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

obj23_ani:
	dc.w	byte_20B592-obj23_ani

byte_20B592:
	dc.b	1
	dc.b	0,1
	dc.b	$FF
	even

obj23_map:
	dc.w	byte_20B59E-obj23_map
	dc.w	byte_20B5B3-obj23_map
byte_20B59E:
	dc.b	4
	dc.b	-8,0,0,$2A,-8
	dc.b	-8,0,8,$2A,0
	dc.b	0,0,$10,$2A,-8
	dc.b	0,0,$18,$2A,0
byte_20B5B3:
	dc.b	4
	dc.b	-8,0,0,$2B,-8
	dc.b	-8,0,8,$2B,0
	dc.b	0,0,$10,$2B,-8
	dc.b	0,0,$18,$2B,0
	even