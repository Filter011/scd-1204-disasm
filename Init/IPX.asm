byte_FF0000:
		dc.b	0
		dc.b	0
		dc.l	byte_FF0000
		dc.w	$3FF
		dc.l	byte_FF0000

		align	$100

		move.l	#loc_FF0212,$FFFD08.w
		bset	#1,$A12003
		moveq	#5,d0
		bsr.w	sub_FF0286

loc_FF0116:
		moveq	#$B,d0
		bsr.w	sub_FF0286
		tst.b	d1
		beq.w	loc_FF01A4
		tst.w	d0
		beq.w	loc_FF01AE
		bra.w	loc_FF0254

		moveq	#6,d0
		bsr.w	sub_FF0286
		mulu.w	#6,d0
		move.w	word_FF0164(pc,d0.w),$FF1210
		move.b	byte_FF0166(pc,d0.w),$FF123D
		move.b	byte_FF0167(pc,d0.w),$FF127A
		move.w	word_FF0162(pc,d0.w),d0
		move.b	#0,$FF0580
		bsr.w	sub_FF0286
		bra.w	loc_FF0116

word_FF0162:
		dc.w	1
word_FF0164:
		dc.w	0
byte_FF0166:
		dc.b	1
byte_FF0167:
		dc.b	0
		dc.w	2
		dc.w	0
		dc.b	0
		dc.b	0
		dc.w	3
		dc.w	0
		dc.b	2
		dc.b	1
		dc.w	4
		dc.w	0
		dc.b	2
		dc.b	0
		dc.w	7
		dc.w	1
		dc.b	1
		dc.b	0
		dc.w	8
		dc.w	1
		dc.b	0
		dc.b	0
		dc.w	9
		dc.w	1
		dc.b	2
		dc.b	1
		dc.w	$A
		dc.w	1
		dc.b	2
		dc.b	0
		dc.w	$C
		dc.w	0
		dc.b	0
		dc.b	0
		dc.w	$24
		dc.w	0
		dc.b	0
		dc.b	0
		dc.w	$25
		dc.w	0
		dc.b	0
		dc.b	0

loc_FF01A4:
		moveq	#$24,d0
		bsr.w	sub_FF0286
		bra.w	loc_FF0116

loc_FF01AE:
		move.b	#1,$FF123D
		move.b	#0,$FF0580
		bsr.w	sub_FF01D8
		tst.b	$FF1212
		beq.s	loc_FF01CE
		bsr.w	sub_FF01E8

loc_FF01CE:
		moveq	#$25,d0
		bsr.w	sub_FF0286
		bra.w	loc_FF0116

sub_FF01D8:
		lea	word_FF0244(pc),a0
		move.w	#0,$FF1210
		bra.w	loc_FF01F8

sub_FF01E8:
		lea	word_FF024C(pc),a0
		move.w	#1,$FF1210
		bra.w	loc_FF01F8

loc_FF01F8:
		move.w	0(a0),d0

loc_FF01FC:
		bsr.w	sub_FF0286
		tst.b	$FF1212
		beq.s	locret_FF0242
		btst	#7,$FF123D
		beq.s	locret_FF0242

loc_FF0212:
		moveq	#$C,d0
		bsr.w	sub_FF0286
		move.b	$FF123D,d1
		move.w	2(a0),d0
		andi.b	#$7F,d1
		beq.s	loc_FF01FC
		move.w	0(a0),d0
		subq.b	#1,d1
		beq.s	loc_FF01FC
		move.w	6(a0),d0
		tst.b	$FF127A
		beq.s	loc_FF01FC
		move.w	4(a0),d0
		bra.s	loc_FF01FC

locret_FF0242:
		rts

word_FF0244:
		dc.w	1
		dc.w	2
		dc.w	3
		dc.w	4
word_FF024C:
		dc.w	7
		dc.w	8
		dc.w	9
		dc.w	$A

loc_FF0254:
		moveq	#$D,d0
		bsr.w	sub_FF0286
		move.w	d0,$FF0594
		beq.w	loc_FF0116
		add.w	d0,d0
		move.w	loc_FF0280(pc,d0.w),d0
		move.b	#1,$FF0580
		bsr.w	sub_FF0286
		move.l	$FF1222,$FF0590

loc_FF0280:
		bra.s	loc_FF0254

		dc.w	1
		dc.w	7

sub_FF0286:
		move.l	a0,-(sp)
		bsr.w	sub_FF031C
		move.l	$200008,d0
		beq.s	loc_FF030E
		movea.l d0,a0
		move.l	$200002,d0
		beq.s	loc_FF02B2
		movea.l d0,a2
		lea	$200100,a1
		move.w	$200006,d7

loc_FF02AC:
		move.l	(a1)+,(a2)+
		dbf	d7,loc_FF02AC

loc_FF02B2:
		move.l	$20000E,d0
		beq.s	loc_FF02BE
		move.l	d0,$FFFD0E

loc_FF02BE:
		move.l	$200010,d0
		beq.s	loc_FF02CA
		move.l	d0,$FFFD08

loc_FF02CA:
		btst	#6,$200000
		beq.s	loc_FF02DC
		bset	#1,$A12003

loc_FF02DC:
		jsr	(a0)
		move.b	#0,$FF0583
		move.l	#$FF021A,$FFFD0E.w
		move.l	#loc_FF0212,$FFFD08.w
		move.w	#$8134,$FF0596
		move.w	#$8134,$C00004
		bset	#1,$A12003

loc_FF030E:
		movea.l (sp)+,a0
		rts

		bset	#0,$A12000
		rte

sub_FF031C:
		move.w	d0,$A12010
loc_FF0322:
		tst.w	$A12020
		beq.s	loc_FF0322
		move.w	#0,$A12010
loc_FF0332:
		tst.w	$A12020
		bne.s	loc_FF0332
		rts