	cpu	68000

ZeroOffsetOptimization = 0

	include	"MacroSetup.asm"
	include	"Equates.asm"
	include	"WorkRAM.asm"
	include	"Macros.asm"

	phase	wkram

	dc.b	0,0
	dc.l	mmd_init
	dc.w	$C00-1
	dc.l	mmd_init

	align	$100

mmd_init:
	move.l	#vint,intmd
	bsr.w	sub_FF2158

	lea	$FFFF8000,a0
	move.w	#($7C00)/4-1,d7

.loop:
	move.l	#0,(a0)+
	dbf	d7,.loop

	lea	vdptbl(pc),a0
	bsr.w	sub_FF243C

	dmawrt	hscroll_vram,4
	move.l	#0,vdp_dat

	dmawrt	0,4
	lea	textcg(pc),a0
	bsr.w	bitdevr

	lea	word_FF21CE(pc),a0
	move.w	#$8000,d0
	bsr.w	sub_FF2416

	lea	word_FF21AE(pc),a0
	lea	lpcolorwk,a1
	moveq	#($20)/4-1,d7

loc_FF2062:
	move.l	(a0)+,(a1)+
	dbf	d7,loc_FF2062

	bset	#1,$FF0583
	bsr.w	sub_FF2346
	bsr.w	sub_FF2D1C
	bsr.w	sub_FF2364

loc_FF207C:
	lea	word_FF21CE(pc),a0
	move.w	#$8000,d0
	bsr.w	sub_FF2416
	lea	word_FF20DE(pc),a1
	moveq	#0,d6
	moveq	#$A,d7
	btst	#0,$A1201F
	beq.s	loc_FF209E
	bsr.w	sub_FF23DE

loc_FF209E:
	btst	#1,$A1201F
	beq.s	loc_FF20AC
	bsr.w	sub_FF23EC

loc_FF20AC:
	move.w	(a1),d0
	mulu.w	#10,d0
	lea	word_FF2228(pc),a0
	lea	(a0,d0.w),a0
	move.w	#$8040,d0
	bsr.w	sub_FF2416
	bsr.w	sub_FF2D1C
	move.b	$A1201F,d0
	andi.w	#$F0,d0
	beq.s	loc_FF207C
	bsr.w	sub_FF22E0
	move.w	word_FF20DE.l,d0
	rts

word_FF20DE:
	dc.w	0

vint:
	movem.l	d0-a6,-(sp)
	move.b	#1,mcpu_int2
	bclr	#0,$FF0583
	beq.s	loc_FF2152
	bset	#6,$FF0597
	move.w	$FF0596,vdp_cmd

	bsr.w	z80bus_on
	move.w	vdp_cmd,d0
	bclr	#1,$FF0583
	beq.s	loc_FF214A
	dma68k	lpcolorwk,$C
	dmawrt	0,$C,(a6)
	move.w	lpcolorwk,vdp_dat

loc_FF214A:
	jsr	sub_FF2CE4(pc)
	bsr.w	z80bus_off

loc_FF2152:
	movem.l	(sp)+,d0-a6
	rte

sub_FF2158:
	btst	#1,mcpu_memmode
	bne.s	locret_FF2174
	bset	#1,mcpu_memmode

loc_FF216A:
	btst	#1,mcpu_memmode
	beq.s	loc_FF216A

locret_FF2174:
	rts

loc_FF2176:
	btst	#0,mcpu_memmode
	beq.s	loc_FF2176
	rts

loc_FF2182:
	btst	#7,mcpu_comflag
	beq.s	loc_FF2182
	rts

loc_FF218E:
	btst	#7,mcpu_comflag
	bne.s	loc_FF218E
	rts

vdptbl:
	dc.b	%00000100
	dc.b	%00110100
	dc.b	scroll_a_vram>>10
	dc.b	scroll_w_vram>>10
	dc.b	scroll_b_vram>>13
	dc.b	sprdat_vram>>9
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%00000000
	dc.b	%10000001
	dc.b	hscroll_vram>>10
	dc.b	%00000000
	dc.b	%00000010
	dc.b	%00000001
	dc.b	%00000000
	dc.b	%00000000
vdptbl_end:
	even

word_FF21AE:
	incbin	"Palette/Stage Select.bin"
	even

word_FF21CE:
	dc.w	11-1
	dc.l	byte_FF2296
	dc.l	$42040003
	dc.l	byte_FF229C
	dc.l	$42840003
	dc.l	byte_FF22A2
	dc.l	$43040003
	dc.l	byte_FF22A8
	dc.l	$43840003
	dc.l	byte_FF22AE
	dc.l	$44040003
	dc.l	byte_FF22B4
	dc.l	$44840003
	dc.l	byte_FF22BA
	dc.l	$45040003
	dc.l	byte_FF22C0
	dc.l	$45840003
	dc.l	byte_FF22C6
	dc.l	$46040003
	dc.l	byte_FF22CB
	dc.l	$46840003
	dc.l	byte_FF22D3
	dc.l	$47040003

word_FF2228:
	dc.w	0
	dc.l	byte_FF2296
	dc.l	$42040003
	dc.w	0
	dc.l	byte_FF229C
	dc.l	$42840003
	dc.w	0
	dc.l	byte_FF22A2
	dc.l	$43040003
	dc.w	0
	dc.l	byte_FF22A8
	dc.l	$43840003
	dc.w	0
	dc.l	byte_FF22AE
	dc.l	$44040003
	dc.w	0
	dc.l	byte_FF22B4
	dc.l	$44840003
	dc.w	0
	dc.l	byte_FF22BA
	dc.l	$45040003
	dc.w	0
	dc.l	byte_FF22C0
	dc.l	$45840003
	dc.w	0
	dc.l	byte_FF22C6
	dc.l	$46040003
	dc.w	0
	dc.l	byte_FF22CB
	dc.l	$46840003
	dc.w	0
	dc.l	byte_FF22D3
	dc.l	$47040003

	charset	' ',$00
	charset '0','9',$01
	charset	'A','Z',$0B
	charset	'-',$25
	charset	',',$26
	charset	'.',$27
;	charset	''',$28
	charset	'"',$29
	charset	':',$2A
	charset	'?',$2B
	charset	'!',$2C
	charset	'x',$2D
	charset	'=',$2E

byte_FF2296:
	dc.b	"1-1-A"
	dc.b	-1

byte_FF229C:
	dc.b	"1-1-B"
	dc.b	-1

byte_FF22A2:
	dc.b	"1-1-C"
	dc.b	-1

byte_FF22A8:
	dc.b	"1-1-D"
	dc.b	-1

byte_FF22AE:
	dc.b	"1-2-A"
	dc.b	-1

byte_FF22B4:
	dc.b	"1-2-B"
	dc.b	-1

byte_FF22BA:
	dc.b	"1-2-C"
	dc.b	-1

byte_FF22C0:
	dc.b	"1-2-D"
	dc.b	-1

byte_FF22C6:
	dc.b	"WARP"
	dc.b	-1

byte_FF22CB:
	dc.b	"OPENING"
	dc.b	-1

byte_FF22D3:
	dc.b	"COMMING SOON"
	dc.b	-1

	charset

sub_FF22E0:
	move.b	#1,$FFFFFA00
	moveq	#8-1,d6
	moveq	#0,d0
	moveq	#1,d1

loc_FF22EC:
	bsr.s	sub_FF2312
	addq.w	#2,d0
	dbf	d6,loc_FF22EC

	moveq	#8-1,d6
	moveq	#0,d0
	moveq	#5,d1

loc_FF22FA:
	bsr.s	sub_FF2312
	addq.w	#2,d0
	dbf	d6,loc_FF22FA

	moveq	#8-1,d6
	moveq	#0,d0
	moveq	#9,d1

loc_FF2308:
	bsr.s	sub_FF2312
	addq.w	#2,d0
	dbf	d6,loc_FF2308

	rts

sub_FF2312:
	lea	lpcolorwk,a1
	moveq	#(lpcolorwk_end-lpcolorwk)/2-1,d7

loc_FF2318:
	move.w	(a1),d2
	rol.w	#1,d2
	ror.w	d1,d2
	move.w	d2,d3
	andi.w	#$E,d2
	andi.w	#$EEE0,d3
	sub.w	d0,d2
	bhs.s	loc_FF232E
	moveq	#0,d2

loc_FF232E:
	or.w	d3,d2
	ror.w	#1,d2
	rol.w	d1,d2
	move.w	d2,(a1)+
	dbf	d7,loc_FF2318

	bset	#1,$FF0583
	bra.w	sub_FF2D1C

sub_FF2346:
	lea	lpcolorwk,a1
	lea	$FFFFF980,a2
	moveq	#0,d1
	moveq	#(lpcolorwk_end-lpcolorwk)/4-1,d7

loc_FF2352:
	move.l	(a1),(a2)+
	move.l	d1,(a1)+
	dbf	d7,loc_FF2352

	bset	#1,$FF0583
	rts

sub_FF2364:
	move.w	#7,d6
	moveq	#0,d0
	moveq	#9,d1

loc_FF236C:
	bsr.w	sub_FF23A2
	addq.w	#2,d0
	dbf	d6,loc_FF236C

	move.w	#7,d6
	moveq	#0,d0
	moveq	#5,d1

loc_FF237E:
	bsr.w	sub_FF23A2
	addq.w	#2,d0
	dbf	d6,loc_FF237E

	move.w	#7,d6
	moveq	#0,d0
	moveq	#1,d1

loc_FF2390:
	bsr.w	sub_FF23A2
	addq.w	#2,d0
	dbf	d6,loc_FF2390

	move.b	#0,$FFFFFA00
	rts

sub_FF23A2:
	lea	lpcolorwk,a1
	lea	$FFFFF980,a2
	moveq	#(lpcolorwk_end-lpcolorwk)/2-1,d7

loc_FF23AC:
	move.w	(a2)+,d2
	move.w	(a1),d3
	rol.w	#1,d2
	rol.w	#1,d3
	ror.w	d1,d2
	ror.w	d1,d3
	andi.w	#$E,d2
	andi.w	#$EEE0,d3
	cmp.w	d0,d2
	bls.s	loc_FF23C6
	move.w	d0,d2

loc_FF23C6:
	or.w	d3,d2
	rol.w	d1,d2
	ror.w	#1,d2
	move.w	d2,(a1)+
	dbf	d7,loc_FF23AC

	bset	#1,$FF0583
	bra.w	sub_FF2D1C

sub_FF23DE:
	move.w	(a1),d0
	subq.w	#1,d0
	cmp.w	d6,d0
	bge.s	loc_FF23E8
	move.w	d7,d0

loc_FF23E8:
	move.w	d0,(a1)
	rts

sub_FF23EC:
	move.w	(a1),d0
	addq.w	#1,d0
	cmp.w	d7,d0
	bls.s	loc_FF23F6
	move.w	d6,d0

loc_FF23F6:
	move.w	d0,(a1)
	rts

	move.b	(a1),d0
	subq.b	#1,d0
	cmp.b	d6,d0
	bge.s	loc_FF2404
	move.b	d7,d0

loc_FF2404:
	move.b	d0,(a1)
	rts

	move.b	(a1),d0
	addq.b	#1,d0
	cmp.b	d7,d0
	bls.s	loc_FF2412
	move.b	d6,d0

loc_FF2412:
	move.b	d0,(a1)
	rts

sub_FF2416:
	lea	vdp_dat,a2
	move.w	(a0)+,d2

loc_FF241E:
	movea.l	(a0)+,a1
	move.l	(a0)+,vdp_cmd

loc_FF2426:
	moveq	#0,d1
	move.b	(a1)+,d1
	cmpi.b	#-1,d1
	beq.s	loc_FF2436
	add.w	d0,d1
	move.w	d1,(a2)
	bra.s	loc_FF2426

loc_FF2436:
	dbf	d2,loc_FF241E

	rts

sub_FF243C:
	move.w	#$8000,d0
	moveq	#(vdptbl_end-vdptbl)-1,d7

.loop:
	move.b	(a0)+,d0
	move.w	d0,vdp_cmd
	addi.w	#$100,d0
	dbf	d7,.loop

	moveq	#$40,d0
	move.b	d0,cont_1
	move.b	d0,cont_2
	move.b	d0,cont_3
	move.b	#$C0,port_1
	bsr.w	z80bus_on

	move.l	#$40000000,vdp_cmd
	lea	vdp_dat,a0
	moveq	#0,d0
	move.w	#$10000/16-1,d7

loc_FF2488:
	move.l	d0,(a0)
	move.l	d0,(a0)
	move.l	d0,(a0)
	move.l	d0,(a0)
	dbf	d7,loc_FF2488

	move.l	#$40000010,vdp_cmd
	move.l	#0,vdp_dat
	bsr.w	z80bus_off

	move.w	#$8100|%00110100,$FF0596
	rts

textcg:
	incbin	"Art/BitDev/Text.nem"
	even

bitdevr:
	movem.l	d0-a1/a3-a5,-(sp)
	lea	sub_FF2AC2.l,a3
	lea	vdp_dat,a4
	bra.s	loc_FF2A1C

	movem.l	d0-a1/a3-a5,-(sp)
	lea	loc_FF2AD8.l,a3

loc_FF2A1C:
	lea	bitdevwk,a1
	move.w	(a0)+,d2
	lsl.w	#1,d2
	bhs.s	loc_FF2A2A
	adda.w	#$A,a3

loc_FF2A2A:
	lsl.w	#2,d2
	movea.w	d2,a5
	moveq	#8,d3
	moveq	#0,d2
	moveq	#0,d4
	jsr	sub_FF2AEE(pc)
	move.b	(a0)+,d5
	asl.w	#8,d5
	move.b	(a0)+,d5
	move.w	#16,d6
	bsr.s	sub_FF2A4A
	movem.l	(sp)+,d0-a1/a3-a5
	rts

sub_FF2A4A:
	move.w	d6,d7
	subq.w	#8,d7
	move.w	d5,d1
	lsr.w	d7,d1
	cmpi.b	#%11111100,d1
	bhs.s	loc_FF2A96
	andi.w	#%11111111,d1
	add.w	d1,d1
	move.b	(a1,d1.w),d0
	ext.w	d0
	sub.w	d0,d6
	cmpi.w	#9,d6
	bhs.s	loc_FF2A72
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5

loc_FF2A72:
	move.b	1(a1,d1.w),d1
	move.w	d1,d0
	andi.w	#%00001111,d1
	andi.w	#%11110000,d0

loc_FF2A80:
	lsr.w	#4,d0

loc_FF2A82:
	lsl.l	#4,d4
	or.b	d1,d4
	subq.w	#1,d3
	bne.s	loc_FF2A90
	jmp	(a3)

loc_FF2A8C:
	moveq	#0,d4
	moveq	#8,d3

loc_FF2A90:
	dbf	d0,loc_FF2A82

	bra.s	sub_FF2A4A

loc_FF2A96:
	subq.w	#6,d6
	cmpi.w	#9,d6
	bhs.s	loc_FF2AA4
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5

loc_FF2AA4:
	subq.w	#7,d6
	move.w	d5,d1
	lsr.w	d6,d1
	move.w	d1,d0
	andi.w	#%00001111,d1
	andi.w	#%01110000,d0
	cmpi.w	#9,d6
	bhs.s	loc_FF2A80
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5
	bra.s	loc_FF2A80

sub_FF2AC2:
	move.l	d4,(a4)
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	loc_FF2A8C
	rts

	eor.l	d4,d2
	move.l	d2,(a4)
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	loc_FF2A8C
	rts

loc_FF2AD8:
	move.l	d4,(a4)+
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	loc_FF2A8C
	rts

	eor.l	d4,d2
	move.l	d2,(a4)+
	subq.w	#1,a5
	move.w	a5,d4
	bne.s	loc_FF2A8C
	rts

sub_FF2AEE:
	move.b	(a0)+,d0

loc_FF2AF0:
	cmpi.b	#%11111111,d0
	bne.s	loc_FF2AF8
	rts

loc_FF2AF8:
	move.w	d0,d7

loc_FF2AFA:
	move.b	(a0)+,d0
	cmpi.b	#%10000000,d0
	bhs.s	loc_FF2AF0
	move.b	d0,d1
	andi.w	#%00001111,d7
	andi.w	#%01110000,d1
	or.w	d1,d7
	andi.w	#%00001111,d0
	move.b	d0,d1
	lsl.w	#8,d1
	or.w	d1,d7
	moveq	#8,d1
	sub.w	d0,d1
	bne.s	loc_FF2B28
	move.b	(a0)+,d0
	add.w	d0,d0
	move.w	d7,(a1,d0.w)
	bra.s	loc_FF2AFA

loc_FF2B28:
	move.b	(a0)+,d0
	lsl.w	d1,d0
	add.w	d0,d0
	moveq	#1,d5
	lsl.w	d1,d5
	subq.w	#1,d5

loc_FF2B34:
	move.w	d7,(a1,d0.w)
	addq.w	#2,d0
	dbf	d5,loc_FF2B34

	bra.s	loc_FF2AFA

mapdevr:
	movem.l	d0-d7/a1-a5,-(sp)
	movea.w	d0,a3
	move.b	(a0)+,d0
	ext.w	d0
	movea.w	d0,a5
	move.b	(a0)+,d4
	lsl.b	#3,d4
	movea.w	(a0)+,a2
	adda.w	a3,a2
	movea.w	(a0)+,a4
	adda.w	a3,a4
	move.b	(a0)+,d5
	asl.w	#8,d5
	move.b	(a0)+,d5
	moveq	#16,d6

loc_FF2B60:
	moveq	#7,d0
	move.w	d6,d7
	sub.w	d0,d7
	move.w	d5,d1
	lsr.w	d7,d1
	andi.w	#%1111111,d1
	move.w	d1,d2
	cmpi.w	#%1000000,d1
	bhs.s	loc_FF2B7A
	moveq	#6,d0
	lsr.w	#1,d2

loc_FF2B7A:
	bsr.w	sub_FF2CAE
	andi.w	#%00001111,d2
	lsr.w	#4,d1
	add.w	d1,d1
	jmp	loc_FF2BD6(pc,d1.w)

loc_FF2B8A:
	move.w	a2,(a1)+
	addq.w	#1,a2
	dbf	d2,loc_FF2B8A

	bra.s	loc_FF2B60

loc_FF2B94:
	move.w	a4,(a1)+
	dbf	d2,loc_FF2B94

	bra.s	loc_FF2B60

loc_FF2B9C:
	bsr.w	loc_FF2BFE

loc_FF2BA0:
	move.w	d1,(a1)+
	dbf	d2,loc_FF2BA0

	bra.s	loc_FF2B60

loc_FF2BA8:
	bsr.w	loc_FF2BFE

loc_FF2BAC:
	move.w	d1,(a1)+
	addq.w	#1,d1
	dbf	d2,loc_FF2BAC

	bra.s	loc_FF2B60

loc_FF2BB6:
	bsr.w	loc_FF2BFE

loc_FF2BBA:
	move.w	d1,(a1)+
	subq.w	#1,d1
	dbf	d2,loc_FF2BBA

	bra.s	loc_FF2B60

loc_FF2BC4:
	cmpi.w	#$F,d2
	beq.s	loc_FF2BE6

loc_FF2BCA:
	bsr.w	loc_FF2BFE
	move.w	d1,(a1)+
	dbf	d2,loc_FF2BCA

	bra.s	loc_FF2B60

loc_FF2BD6:
	bra.s	loc_FF2B8A
	bra.s	loc_FF2B8A
	bra.s	loc_FF2B94
	bra.s	loc_FF2B94
	bra.s	loc_FF2B9C
	bra.s	loc_FF2BA8
	bra.s	loc_FF2BB6
	bra.s	loc_FF2BC4

loc_FF2BE6:
	subq.w	#1,a0
	cmpi.w	#16,d6
	bne.s	loc_FF2BF0
	subq.w	#1,a0

loc_FF2BF0:
	move.w	a0,d0
	lsr.w	#1,d0
	bhs.s	loc_FF2BF8
	addq.w	#1,a0

loc_FF2BF8:
	movem.l	(sp)+,d0-d7/a1-a5
	rts

loc_FF2BFE:
	move.w	a3,d3
	move.b	d4,d1
	add.b	d1,d1
	bhs.s	loc_FF2C10
	subq.w	#1,d6
	btst	d6,d5
	beq.s	loc_FF2C10
	ori.w	#$8000,d3

loc_FF2C10:
	add.b	d1,d1
	bhs.s	loc_FF2C1E
	subq.w	#1,d6
	btst	d6,d5
	beq.s	loc_FF2C1E
	addi.w	#$4000,d3

loc_FF2C1E:
	add.b	d1,d1
	bhs.s	loc_FF2C2C
	subq.w	#1,d6
	btst	d6,d5
	beq.s	loc_FF2C2C
	addi.w	#$2000,d3

loc_FF2C2C:
	add.b	d1,d1
	bhs.s	loc_FF2C3A
	subq.w	#1,d6
	btst	d6,d5
	beq.s	loc_FF2C3A
	ori.w	#$1000,d3

loc_FF2C3A:
	add.b	d1,d1
	bhs.s	loc_FF2C48
	subq.w	#1,d6
	btst	d6,d5
	beq.s	loc_FF2C48
	ori.w	#$800,d3

loc_FF2C48:
	move.w	d5,d1
	move.w	d6,d7
	sub.w	a5,d7
	bhs.s	loc_FF2C78
	move.w	d7,d6
	addi.w	#16,d6
	neg.w	d7
	lsl.w	d7,d1
	move.b	(a0),d5
	rol.b	d7,d5
	add.w	d7,d7
	and.w	loc_FF2C8C(pc,d7.w),d5
	add.w	d5,d1

loc_FF2C66:
	move.w	a5,d0
	add.w	d0,d0
	and.w	loc_FF2C8C(pc,d0.w),d1
	add.w	d3,d1
	move.b	(a0)+,d5
	lsl.w	#8,d5
	move.b	(a0)+,d5
	rts

loc_FF2C78:
	beq.s	loc_FF2C8A
	lsr.w	d7,d1
	move.w	a5,d0
	add.w	d0,d0
	and.w	loc_FF2C8C(pc,d0.w),d1
	add.w	d3,d1
	move.w	a5,d0
	bra.s	sub_FF2CAE

loc_FF2C8A:
	moveq	#16,d6

loc_FF2C8C:
	bra.s	loc_FF2C66

	dc.w	%0000000000000001,%0000000000000011,%0000000000000111,%0000000000001111
	dc.w	%0000000000011111,%0000000000111111,%0000000001111111,%0000000011111111
	dc.w	%0000000111111111,%0000001111111111,%0000011111111111,%0000111111111111
	dc.w	%0001111111111111,%0011111111111111,%0111111111111111,%1111111111111111

sub_FF2CAE:
	sub.w	d0,d6
	cmpi.w	#9,d6
	bhs.s	locret_FF2CBC
	addq.w	#8,d6
	asl.w	#8,d5
	move.b	(a0)+,d5

locret_FF2CBC:
	rts

z80bus_on:
	move.w	sr,$FFFFFA46
	move.w	#$100,z80busreq

.loop:
	btst	#0,z80busreq
	bne.s	.loop
	rts

z80bus_off:
	move.w	#$000,z80busreq
	move.w	$FFFFFA46,sr
	rts

sub_FF2CE4:
	lea	$A1201E,a0
	lea	port_1,a1
	move.b	#0,(a1)
	tst.w	(a0)
	move.b	(a1),d0
	lsl.b	#2,d0
	andi.b	#%11000000,d0
	move.b	#$40,(a1)
	tst.w	(a0)
	move.b	(a1),d1
	andi.b	#%00111111,d1
	or.b	d1,d0
	not.b	d0
	move.b	d0,d1
	move.b	(a0),d2
	eor.b	d2,d0
	move.b	d1,(a0)+
	and.b	d1,d0
	move.b	d0,(a0)+
	rts

sub_FF2D1C:
	bset	#0,$FF0583
	move.w	#$2500,sr

loc_FF2D28:
	btst	#0,$FF0583
	bne.s	loc_FF2D28
	rts

sub_sync:
	move.w	d0,mcpu_comcmd

loc_FF2D3A:
	tst.w	mcpu_comsts
	beq.s	loc_FF2D3A
	move.w	#0,mcpu_comcmd

loc_FF2D4A:
	tst.w	mcpu_comsts
	bne.s	loc_FF2D4A
	rts

	move.w	d0,$A12012

loc_FF2D5A:
	tst.w	$A12022
	beq.s	loc_FF2D5A
	move.w	#0,$A12012

loc_FF2D6A:
	tst.w	$A12022
	bne.s	loc_FF2D6A
	rts

	dephase