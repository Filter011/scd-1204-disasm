	moveq	#0,d0
	move.b	$24(a0),d0
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
	addq.b	#2,$24(a0)
	ori.b	#4,1(a0)
	move.b	#4,$18(a0)
	move.w	#$503,2(a0)
	move.l	#off_20E1DA,4(a0)

loc_20E11A:
	jsr	$2023EA.l
	move.w	8(a0),d0
	cmp.w	8(a6),d0
	bhs.s	locret_20E146
	move.w	$FFF72A.w,$FFF728.w
	clr.b	$FF121E
	move.b	#60,$2A(a0)
	move.b	#0,$1A(a0)
	addq.b	#2,$24(a0)

locret_20E146:
	rts

loc_20E148:
	subq.b	#1,$2A(a0)
	bne.s	locret_20E158
	addq.b	#2,$24(a0)
	move.b	#1,$2A(a0)

locret_20E158:
	rts

loc_20E15A:
	subq.b	#1,$2A(a0)
	bne.s	locret_20E176
	bset	#0,$FFF7CC.w
	move.w	#$808,$FFF602.w
	move.b	#60,$2A(a0)
	addq.b	#2,$24(a0)

locret_20E176:
	rts

loc_20E178:
	subq.b	#1,$2A(a0)
	bne.s	locret_20E1CE
	move.w	#2,$FF1202
	move.b	#0,$FF1230
	clr.w	$FF12F4
	clr.l	$FF1880
	move.b	#1,$FF123D
	move.b	$FF1211,d0
	addq.b	#1,d0
	cmpi.b	#2,d0
	bne.s	loc_20E1C2
	moveq	#0,d0
	move.b	#0,$FF1212
	bclr	#0,$FF122A

loc_20E1C2:
	move.b	d0,$FF1211
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