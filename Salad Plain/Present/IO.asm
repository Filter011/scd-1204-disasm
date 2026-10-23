sw_init:				;port initial
	bsr.w	z80bus_on
	moveq	#$40,d0			;set TH out
	move.b	d0,cont_1
	move.b	d0,cont_2
	move.b	d0,cont_3
	bra.w	z80bus_off

read_sw:
	lea	swdata1.w,a0		;switch data store address
	lea	port_1,a1		;port for p1
	bsr.s	.rs_0
	addq.w	#2,a1			;a1 = port_2

;
.rs_0:
	move.b	#$0,(a1)		;set TH = 0
	nop
	nop
	move.b	(a1),d0			;input data when TH = 0
	lsl.b	#2,d0			;chane data when TH = 0 & wait
	andi.b	#%11000000,d0		;chane data when TH = 0 & wait
	move.b	#$40,(a1)		;set TH = 1
	nop
	nop
	move.b	(a1),d1			;input data when TH = 1
	andi.b	#%00111111,d1
	or.b	d1,d0
	not.b	d0			;push -> 1
	move.b	(a0),d1			;copy
	eor.b	d0,d1
	move.b	d0,(a0)+		; switch data
	and.b	d0,d1
	move.b	d1,(a0)+		;switch edge data
	rts

vdpinit:
	lea	vdp_cmd,a0
	lea	vdp_dat,a1
	lea	word_201D50.l,a2
	moveq	#(word_201D50_end-word_201D50)/2-1,d7

loc_201CE8:
	move.w	(a2)+,(a0)
	dbf	d7,loc_201CE8

	move.w	word_201D50+2.l,d0
	move.w	d0,word_FFF60C.w
	move.w	#$8A00+223,hintposi.w
	moveq	#0,d0
	move.l	#$C0000000,vdp_cmd
	move.w	#$80/2-1,d7

loc_201D0E:
	move.w	d0,(a1)
	dbf	d7,loc_201D0E

	clr.l	vscroll.w
	clr.l	hscroll.w

	move.l	d1,-(sp)

	lea	vdp_cmd,a5
	move.w	#$8F01,(a5)
	move.l	#$94FF93FF,(a5)
	move.w	#$9780,(a5)
	move.l	#$40000080,(a5)
	move.w	#0,vdp_dat

loc_201D40:
	move.w	(a5),d1
	btst	#1,d1
	bne.s	loc_201D40
	move.w	#$8F02,(a5)

	move.l	(sp)+,d1
	rts

word_201D50:
	dc.w	$8000+%0100
	dc.w	$8100+%00110100
	dc.w	$8200+plane_a>>10
	dc.w	$8300+plane_w>>10
	dc.w	$8400+plane_b>>13
	dc.w	$8500+sprdat_vram>>9
	dc.w	$8600
	dc.w	$8700
	dc.w	$8800
	dc.w	$8900
	dc.w	$8A00
	dc.w	$8B00
	dc.w	$8C81
	dc.w	$8D00+hscroll_vram>>10
	dc.w	$8E00
	dc.w	$8F02
	dc.w	$9001
	dc.w	$9100
	dc.w	$9200
word_201D50_end:

scrinit:
	lea	vdp_cmd,a5
	move.w	#$8F01,(a5)
	move.l	#$940F93FF,(a5)
	move.w	#$9780,(a5)
	move.l	#$40000083,(a5)
	move.w	#0,vdp_dat

loc_201D98:
	move.w	(a5),d1
	btst	#1,d1
	bne.s	loc_201D98
	move.w	#$8F02,(a5)

	lea	vdp_cmd,a5
	move.w	#$8F01,(a5)
	move.l	#$940F93FF,(a5)
	move.w	#$9780,(a5)
	move.l	#$60000083,(a5)
	move.w	#0,vdp_dat

loc_201DC6:
	move.w	(a5),d1
	btst	#1,d1
	bne.s	loc_201DC6
	move.w	#$8F02,(a5)

	clr.l	vscroll.w
	clr.l	hscroll.w

	lea	sprdat.w,a1
	moveq	#0,d0
	move.w	#(sprdat_end-sprdat)/4,d1

loc_201DE4:
	move.l	d0,(a1)+
	dbf	d1,loc_201DE4

	lea	hscrollwork.w,a1
	moveq	#0,d0
	move.w	#(hscrollwork_end_padded-hscrollwork)/4,d1

loc_201DF4:
	move.l	d0,(a1)+
	dbf	d1,loc_201DF4

	rts