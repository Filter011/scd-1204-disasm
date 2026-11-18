	cpu	68000

ZeroOffsetOptimization = 0

	include	"MacroSetup.asm"
	include	"Equates.asm"
	include	"WorkRAM.asm"
	include	"Macros.asm"

	phase	workram

	dc.b	0,0
	dc.l	mmd_init
	dc.w	$C00-1
	dc.l	mmd_init

	align	$100

mmd_init:
	move.l	#vint,intmd
	bsr.w	memwait

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

	lea	colorssel(pc),a0
	lea	lpcolorwk,a1
	moveq	#(colorssel_end-colorssel)/4-1,d7

.loop1:
	move.l	(a0)+,(a1)+
	dbf	d7,.loop1

	bset	#1,$FF0583
	bsr.w	sub_FF2346
	bsr.w	sub_FF2D1C
	bsr.w	sub_FF2364

.loop2:
	lea	word_FF21CE(pc),a0
	move.w	#$8000,d0
	bsr.w	sub_FF2416
	lea	word_FF20DE(pc),a1
	moveq	#0,d6
	moveq	#$A,d7
	btst	#0,swdata1+1
	beq.s	.jump
	bsr.w	sub_FF23DE

.jump:
	btst	#1,swdata1+1
	beq.s	.jump1
	bsr.w	sub_FF23EC

.jump1:
	move.w	(a1),d0
	mulu.w	#10,d0
	lea	word_FF2228(pc),a0
	lea	(a0,d0.w),a0
	move.w	#$8040,d0
	bsr.w	sub_FF2416
	bsr.w	sub_FF2D1C
	move.b	swdata1+1,d0
	andi.w	#$F0,d0
	beq.s	.loop2
	bsr.w	sub_FF22E0
	move.w	word_FF20DE.l,d0
	rts

word_FF20DE:
	dc.w	0

vint:
	movem.l	d0-a6,-(sp)
	move.b	#1,mcpu_int2
	bclr	#0,$FF0583
	beq.s	.end
	bset	#6,$FF0597
	move.w	$FF0596,vdp_cmd

	bsr.w	z80bus_on
	move.w	vdp_cmd,d0
	bclr	#1,$FF0583
	beq.s	.jump
	dma68k	lpcolorwk,$C
	dmawrt	0,$C,(a6)
	move.w	lpcolorwk,vdp_dat

.jump:
	jsr	read_sw(pc)
	bsr.w	z80bus_off

.end:
	movem.l	(sp)+,d0-a6
	rte

memwait:
	btst	#1,mcpu_memmode
	bne.s	.end
	bset	#1,mcpu_memmode

.loop:
	btst	#1,mcpu_memmode
	beq.s	.loop

.end:
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

colorssel:
	incbin	"Palette/Stage Select.bin"
colorssel_end:
	even

word_FF21CE:
	dc.w	11-1
	dc.l	stage11a
	dc.l	$42040003
	dc.l	stage11b
	dc.l	$42840003
	dc.l	stage11c
	dc.l	$43040003
	dc.l	stage11d
	dc.l	$43840003
	dc.l	stage12a
	dc.l	$44040003
	dc.l	stage12b
	dc.l	$44840003
	dc.l	stage12c
	dc.l	$45040003
	dc.l	stage12d
	dc.l	$45840003
	dc.l	warp
	dc.l	$46040003
	dc.l	opening
	dc.l	$46840003
	dc.l	come
	dc.l	$47040003

word_FF2228:
	dc.w	0
	dc.l	stage11a
	dc.l	$42040003
	dc.w	0
	dc.l	stage11b
	dc.l	$42840003
	dc.w	0
	dc.l	stage11c
	dc.l	$43040003
	dc.w	0
	dc.l	stage11d
	dc.l	$43840003
	dc.w	0
	dc.l	stage12a
	dc.l	$44040003
	dc.w	0
	dc.l	stage12b
	dc.l	$44840003
	dc.w	0
	dc.l	stage12c
	dc.l	$45040003
	dc.w	0
	dc.l	stage12d
	dc.l	$45840003
	dc.w	0
	dc.l	warp
	dc.l	$46040003
	dc.w	0
	dc.l	opening
	dc.l	$46840003
	dc.w	0
	dc.l	come
	dc.l	$47040003

	charset	' ',$00
	charset	'0','9',$01
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

stage11a:
	dc.b	"1-1-A"
	dc.b	-1

stage11b:
	dc.b	"1-1-B"
	dc.b	-1

stage11c:
	dc.b	"1-1-C"
	dc.b	-1

stage11d:
	dc.b	"1-1-D"
	dc.b	-1

stage12a:
	dc.b	"1-2-A"
	dc.b	-1

stage12b:
	dc.b	"1-2-B"
	dc.b	-1

stage12c:
	dc.b	"1-2-C"
	dc.b	-1

stage12d:
	dc.b	"1-2-D"
	dc.b	-1

warp:
	dc.b	"WARP"
	dc.b	-1

opening:
	dc.b	"OPENING"
	dc.b	-1

come:
	dc.b	"COMMING SOON"
	dc.b	-1

	charset

sub_FF22E0:
	move.b	#1,$FFFFFA00
	moveq	#8-1,d6
	moveq	#0,d0
	moveq	#1,d1

.loop:
	bsr.s	sub_FF2312
	addq.w	#2,d0
	dbf	d6,.loop

	moveq	#8-1,d6
	moveq	#0,d0
	moveq	#5,d1

.loop1:
	bsr.s	sub_FF2312
	addq.w	#2,d0
	dbf	d6,.loop1

	moveq	#8-1,d6
	moveq	#0,d0
	moveq	#9,d1

.loop2:
	bsr.s	sub_FF2312
	addq.w	#2,d0
	dbf	d6,.loop2

	rts

sub_FF2312:
	lea	lpcolorwk,a1
	moveq	#(lpcolorwk_end-lpcolorwk)/2-1,d7

.loop:
	move.w	(a1),d2
	rol.w	#1,d2
	ror.w	d1,d2
	move.w	d2,d3
	andi.w	#$E,d2
	andi.w	#$EEE0,d3
	sub.w	d0,d2
	bhs.s	.jump
	moveq	#0,d2

.jump:
	or.w	d3,d2
	ror.w	#1,d2
	rol.w	d1,d2
	move.w	d2,(a1)+
	dbf	d7,.loop

	bset	#1,$FF0583
	bra.w	sub_FF2D1C

sub_FF2346:
	lea	lpcolorwk,a1
	lea	lpcolorwk2,a2
	moveq	#0,d1
	moveq	#(lpcolorwk_end-lpcolorwk)/4-1,d7

.loop:
	move.l	(a1),(a2)+
	move.l	d1,(a1)+
	dbf	d7,.loop

	bset	#1,$FF0583
	rts

sub_FF2364:
	move.w	#8-1,d6
	moveq	#0,d0
	moveq	#9,d1

.loop:
	bsr.w	sub_FF23A2
	addq.w	#2,d0
	dbf	d6,.loop

	move.w	#8-1,d6
	moveq	#0,d0
	moveq	#5,d1

.loop1:
	bsr.w	sub_FF23A2
	addq.w	#2,d0
	dbf	d6,.loop1

	move.w	#8-1,d6
	moveq	#0,d0
	moveq	#1,d1

.loop2:
	bsr.w	sub_FF23A2
	addq.w	#2,d0
	dbf	d6,.loop2

	move.b	#0,$FFFFFA00
	rts

sub_FF23A2:
	lea	lpcolorwk,a1
	lea	lpcolorwk2,a2
	moveq	#(lpcolorwk_end-lpcolorwk)/2-1,d7

.loop:
	move.w	(a2)+,d2
	move.w	(a1),d3
	rol.w	#1,d2
	rol.w	#1,d3
	ror.w	d1,d2
	ror.w	d1,d3
	andi.w	#$E,d2
	andi.w	#$EEE0,d3
	cmp.w	d0,d2
	bls.s	.jump
	move.w	d0,d2

.jump:
	or.w	d3,d2
	rol.w	d1,d2
	ror.w	#1,d2
	move.w	d2,(a1)+
	dbf	d7,.loop

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

.loop:
	movea.l	(a0)+,a1
	move.l	(a0)+,vdp_cmd

.loop1:
	moveq	#0,d1
	move.b	(a1)+,d1
	cmpi.b	#-1,d1
	beq.s	.end
	add.w	d0,d1
	move.w	d1,(a2)
	bra.s	.loop1

.end:
	dbf	d2,.loop

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

	dmawrt	0,4
	lea	vdp_dat,a0
	moveq	#0,d0
	move.w	#$10000/16-1,d7

.vramclear:
	rept	4
	move.l	d0,(a0)
	endr
	dbf	d7,.vramclear

	move.l	#$40000010,vdp_cmd
	move.l	#0,vdp_dat
	bsr.w	z80bus_off

	move.w	#$8100|%00110100,$FF0596
	rts

textcg:
	incbin	"Art/BitDev/Text.nem"
	even

	include	"../../Shared/Decompression/BitDev.asm"
	include	"../../Shared/Decompression/MapDev.asm"

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

read_sw:
	lea	swdata1,a0
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

.loop:
	btst	#0,$FF0583
	bne.s	.loop
	rts

sub_sync:
	move.w	d0,mcpu_comcmd

.loop:
	tst.w	mcpu_comsts
	beq.s	.loop
	move.w	#0,mcpu_comcmd

.loop1:
	tst.w	mcpu_comsts
	bne.s	.loop1
	rts

	move.w	d0,$A12012

loc_FF2D5A:
	tst.w	$A12022
	beq.s	loc_FF2D5A
	move.w	#0,$A12012

.loop1:
	tst.w	$A12022
	bne.s	.loop1
	rts

	dephase