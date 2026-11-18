; CD Sonic The Hedgehog (Dec 4th, 1992 Prototype) Disassembly
; Date: December 4, 1992 21:34:01

	cpu	68000

; Stage Act Setting
act_number:	equ	0

ZeroOffsetOptimization = 0

	include	"MacroSetup.asm"
	include	"Equates.asm"
	include	"WorkRAM.asm"
	include	"Macros.asm"

	phase	wordram

vectors:
	dc.b	0,0
	dc.l	0
	dc.w	0
	dc.l	mmd_init
	dc.l	mmd_hint
	dc.l	mmd_vint

	align	$100

mmd_init:
	jmp	init.l

mmd_error:
	jmp	error.l

mmd_hint:
	jmp	hint.l

mmd_vint:
	jmp	vint.l

error:
	nop
	nop
	bra.s	error

init:
	btst	#6,cont_3
	beq.s	.jump
	cmpi.l	#"init",init_flag
	beq.w	.jump1

.jump:
	lea	stacksave,a6
	moveq	#0,d7
	move.w	#(stacksave_end-stacksave)/4-1,d6

.loop:
	move.l	d7,(a6)+
	dbf	d6,.loop

	move.b	version,d0
	andi.b	#%11000000,d0
	move.b	d0,mdstatus

	move.l	#"init",init_flag

.jump1:
	bsr.w	vdpinit
	bsr.w	sw_init
	move.b	#gamemd,gmmode
	move.b	gmmode,d0
	andi.w	#%00011100,d0
	jmp	gmmodetbl(pc,d0.w)

gmmodetbl:

gmmode_ptr	macro	gmmode,{INTLABEL}
__LABEL__:	label	*-gmmodetbl
	bra.w	gmmode
	endm

gamemd:	gmmode_ptr	game

	include	"Col.asm"
	include	"Etc.asm"
	include	"FCol.asm"
	include	"Game.asm"
	include	"Int.asm"
	include	"IO.asm"

z80bus_on:
	move.w	sr,int_sts
	move.w	#%00100111<<8,sr
	move.w	#$100,z80busreq

.wait:
	btst	#0,z80busreq
	bne.s	.wait
	rts

z80bus_off:
	move.w	#$000,z80busreq
	move.w	int_sts,sr
	rts

soundinit:
	move.w	#$100,z80reset
	jsr	z80bus_on(pc)
	lea	z80ram,a1
	lea	soundcnt.l,a2
	move.w	#(soundcnt_end-soundcnt)-1,d0

.loop:
	move.b	(a2)+,(a1)+
	dbf	d0,.loop

	lea	z80ram+SETB,a1
	lea	soundsetb.l,a2
	move.w	#(soundsetb_end-soundsetb)-1,d0

.loop1:
	move.b	(a2)+,(a1)+
	dbf	d0,.loop1

	lea	z80ram+adrtb_bnk_adr,a1
	lea	soundadrtb.l,a2
	move.w	#(soundadrtb_end-soundadrtb)-1,d0

.loop2:
	move.b	(a2)+,(a1)+
	dbf	d0,.loop2

	move.w	#$000,z80reset
	ror.b	#8,d0
	move.w	#$100,z80reset
	jmp	z80bus_off(pc)

bgmset:
;	move.b	d0,sound_ram+buf1
	rts

soundset:
	move.b	d0,sound_ram+buf2
	rts

backsoundset:
	move.b	d0,sound_ram+buf3
	rts

sound:
	jsr	z80bus_on.l
	tst.b	sound_ram+buf2
	beq.s	.jump
	move.b	sound_ram+buf2,z80ram+KYFLAG0
	move.b	#0,sound_ram+buf2
	bra.s	.jump1

.jump:
	tst.b	sound_ram+buf3
	beq.s	.jump1
	move.b	sound_ram+buf3,z80ram+KYFLAG0
	move.b	#0,sound_ram+buf3

.jump1:
	jmp	z80bus_off.l

copy_map_vram:
	lea	vdp_dat,a6
	move.l	#$800000,d4

.loop:
	move.l	d0,vdp_cmd-vdp_dat(a6)
	move.w	d1,d3

.loop1:
	move.w	(a1)+,(a6)
	dbf	d3,.loop1

	add.l	d4,d0
	dbf	d2,.loop

	rts

	include	"Decompression/BitDev.asm"
	include	"Decompression/MapDev.asm"
	include	"Decompression/UnLZE.asm"
	include	"Scr.asm"
	include	"ScrChk.asm"
	include	"Action.asm"
	include	"Objects/01, 02 - Player.asm"

fadeout_s:
	move.w	#mcpu_fadeCDA,d0

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

patchg:
	tst.b	actflg(a0)
	bpl.s	locret_205486
	moveq	#0,d0
	move.b	mstno(a0),d0
	cmp.b	mstrestart(a0),d0
	beq.s	loc_205446
	move.b	d0,mstrestart(a0)
	move.b	#0,patcnt(a0)
	move.b	#0,pattim(a0)

loc_205446:
	subq.b	#1,pattim(a0)
	bpl.s	locret_205486
	add.w	d0,d0
	adda.w	(a1,d0.w),a1
	move.b	(a1),pattim(a0)
	moveq	#0,d1
	move.b	patcnt(a0),d1
	move.b	1(a1,d1.w),d0
	bmi.s	loc_205488

loc_205462:
	move.b	d0,d1
	andi.b	#%00011111,d0
	move.b	d0,patno(a0)
	move.b	cddat(a0),d0
	rol.b	#3,d1
	eor.b	d0,d1
	andi.b	#%00000011,d1
	andi.b	#%11111100,actflg(a0)
	or.b	d1,actflg(a0)
	addq.b	#1,patcnt(a0)

locret_205486:
	rts

loc_205488:
	addq.b	#1,d0
	bne.s	loc_205498
	move.b	#0,patcnt(a0)
	move.b	1(a1),d0
	bra.s	loc_205462

loc_205498:
	addq.b	#1,d0
	bne.s	loc_2054AC
	move.b	2(a1,d1.w),d0
	sub.b	d0,patcnt(a0)
	sub.b	d0,d1
	move.b	1(a1,d1.w),d0
	bra.s	loc_205462

loc_2054AC:
	addq.b	#1,d0
	bne.s	loc_2054B6
	move.b	2(a1,d1.w),mstno(a0)

loc_2054B6:
	addq.b	#1,d0
	bne.s	loc_2054BE
	addq.b	#word,r_no0(a0)

loc_2054BE:
	addq.b	#1,d0
	bne.s	loc_2054CC
	move.b	#0,patcnt(a0)
	clr.b	r_no1(a0)

loc_2054CC:
	addq.b	#1,d0
	bne.s	locret_2054D4
	addq.b	#word,r_no1(a0)

locret_2054D4:
	rts

	include	"Objects/06 - Test.asm"
	include	"Objects/18, 1F - Bakuha, Flower.asm"
	include	"Objects/0E - Mizukiri.asm"
	include	"Objects/0D - Futa.asm"
	include	"Objects/0B, 0C - Exit2.asm"
	include	"Objects/03 - Baria.asm"

exit2chg:
	dc.w	exit2chg0-exit2chg
	dc.w	exit2chg1-exit2chg
	dc.w	exit2chg2-exit2chg
exit2chg0:
	dc.b	4-1
	dc.b	0,4,3,1,2
	dc.b	$FC
	even
exit2chg1:
	dc.b	4-1
	dc.b	0,1,2
	dc.b	$FC
	even
exit2chg2:
	dc.b	4-1
	dc.b	6,5
	dc.b	$FC
	even

exit2pat:
	dc.w	byte_205C74-exit2pat
	dc.w	byte_205C80-exit2pat
	dc.w	byte_205C8C-exit2pat
	dc.w	byte_205C92-exit2pat
	dc.w	byte_205CA8-exit2pat
	dc.w	byte_205CBE-exit2pat
	dc.w	byte_205CC4-exit2pat
byte_205C74:
	dc.b	2
	dc.b	$F0,5,0,0,-4
	dc.b	-8,0,0,4,$F4
	even
byte_205C80:
	dc.b	2
	dc.b	$E0,0,0,5,-8
	dc.b	$E8,$E,0,6,$F0
	even
byte_205C8C:
	dc.b	1
	dc.b	$E0,$F,0,$12,$F0
	even
byte_205C92:
	dc.b	4
	dc.b	$D0,6,0,$22,-8
	dc.b	$D8,0,0,$28,$F0
	dc.b	$E0,0,0,$29,8
	dc.b	$E8,$E,0,$2A,$F0
	even
byte_205CA8:
	dc.b	4
	dc.b	$C0,0,0,$36,-8
	dc.b	$C8,6,0,$37,-8
	dc.b	$D8,0,0,$3D,$F0
	dc.b	$E0,$F,0,$3E,$F0
	even
byte_205CBE:
	dc.b	1
	dc.b	$F0,9,0,$4E,$F4
	even
byte_205CC4:
	dc.b	1
	dc.b	-8,4,0,$54,-8
	even

futachg:
	dc.w	futachg0-futachg
futachg0:
	dc.b	1-1
	dc.b	0,0,1,1,1,1,1,1,1,1
	dc.b	$FC
	even

futapat:
	dc.w	byte_205CE8-futapat
	dc.w	byte_205CDC-futapat
byte_205CDC:
	dc.b	2
	dc.b	$D0,3,0,0,$E4
	dc.b	$F0,1,0,4,$E4
	even
byte_205CE8:
	dc.b	2
	dc.b	-8,$C,0,6,$E8
	dc.b	-8,4,0,$A,8
	even

mizukichg:
	dc.w	mizukichg0-mizukichg
mizukichg0:
	dc.b	4-1
	dc.b	0,1,2
	dc.b	$FC
	even

mizukipat:
	dc.w	byte_205D02-mizukipat
	dc.w	byte_205D08-mizukipat
	dc.w	byte_205D0E-mizukipat
byte_205D02:
	dc.b	1
	dc.b	$F0,$F,0,0,$F0
	even
byte_205D08:
	dc.b	1
	dc.b	$F4,$A,0,$10,$F4
	even
byte_205D0E:
	dc.b	1
	dc.b	-8,5,0,$19,-8
	even

bakuchg:
	dc.w	bakuchg0-bakuchg
	dc.w	bakuchg1-bakuchg
bakuchg0:
	dc.b	4-1
	dc.b	0,5,6,3,4
	dc.b	$FC
	even
bakuchg1:
	dc.b	4-1
	dc.b	0,1,2,3,4
	dc.b	$FC
	even

bakupat:
	dc.w	byte_205D36-bakupat
	dc.w	byte_205D42-bakupat
	dc.w	byte_205D52-bakupat
	dc.w	byte_205D68-bakupat
	dc.w	byte_205D7E-bakupat
	dc.w	byte_205D94-bakupat
	dc.w	byte_205DA4-bakupat
byte_205D36:
	dc.b	2
	dc.b	-8,5,0,0,$F0
	dc.b	-8,5,8,0,0
	even
byte_205D42:
	dc.b	3
	dc.b	$F0,$D,0,4,$F0
	dc.b	0,5,0,$C,$F0
	dc.b	0,5,8,$C,0
	even
byte_205D52:
	dc.b	4
	dc.b	$F0,5,0,$10,$F0
	dc.b	$F0,5,0,$14,0
	dc.b	0,5,0,$18,$F0
	dc.b	0,5,$18,$10,0
	even
byte_205D68:
	dc.b	4
	dc.b	$E8,$A,0,$1C,$E8
	dc.b	$E8,$A,8,$1C,0
	dc.b	0,$A,$10,$1C,$E8
	dc.b	0,$A,$18,$1C,0
	even
byte_205D7E:
	dc.b	4
	dc.b	$E8,$A,0,$25,$E8
	dc.b	$E8,$A,8,$25,0
	dc.b	0,$A,$10,$25,$E8
	dc.b	0,$A,$18,$25,0
	even
byte_205D94:
	dc.b	3
	dc.b	$F0,$D,0,$2E,$F0
	dc.b	0,5,0,$36,$F0
	dc.b	0,5,8,$36,0
	even
byte_205DA4:
	dc.b	4
	dc.b	$F0,5,0,$3A,$F0
	dc.b	$F0,5,0,$3E,0
	dc.b	0,5,0,$42,$F0
	dc.b	0,5,$18,$3A,0
	even

flowchg:
	dc.w	flowchg0-flowchg
	dc.w	flowchg1-flowchg
	dc.w	flowchg2-flowchg
	dc.w	flowchg3-flowchg
flowchg0:
	dc.b	4-1
	dc.b	0,1
	dc.b	$FF
	even
flowchg1:
	dc.b	4-1
	dc.b	2,3,2,3
	dc.b	$FC
	even
flowchg2:
	dc.b	2-1
	dc.b	5,5,4,6
	dc.b	$FC
	even
flowchg3:
	dc.b	20-1
	dc.b	6,7
	dc.b	$FF
	even

flow_pat:
	dc.w	byte_205DE6-flow_pat
	dc.w	byte_205DEC-flow_pat
	dc.w	byte_205DF2-flow_pat
	dc.w	byte_205DF8-flow_pat
	dc.w	byte_205DFE-flow_pat
	dc.w	byte_205E0A-flow_pat
	dc.w	byte_205E10-flow_pat
	dc.w	byte_205E20-flow_pat
byte_205DE6:
	dc.b	1
	dc.b	$F0,1,0,0,-4
	even
byte_205DEC:
	dc.b	1
	dc.b	$F0,1,8,0,-4
	even
byte_205DF2:
	dc.b	1
	dc.b	$F0,5,0,2,-8
	even
byte_205DF8:
	dc.b	1
	dc.b	$F0,5,0,6,-8
	even
byte_205DFE:
	dc.b	2
	dc.b	$E8,9,0,$1C,$F4
	dc.b	-8,0,0,$22,-4
	even
byte_205E0A:
	dc.b	1
	dc.b	$F0,5,0,$23,-8
	even
byte_205E10:
	dc.b	3
	dc.b	$D0,$A,0,$A,$F4
	dc.b	$E8,9,0,$1C,$F4
	dc.b	-8,0,0,$22,-4
	even
byte_205E20:
	dc.b	3
	dc.b	$D0,$A,0,$13,$F4
	dc.b	$E8,9,0,$1C,$F4
	dc.b	-8,0,0,$22,-4
	even

	include	"Save.asm"
	include	"DirCol.asm"
	include	"Coli.asm"
	include	"Objects/04, 05, 08 - Taki, Jisin.asm"
	include	"Edit.asm"
	include	"ActSet.asm"
	include	"Objects/07 - Shooter.asm"
	include	"RideChk.asm"
	include	"Objects/09 - Dai_K.asm"
	include	"Objects/1B - Iwa.asm"
	include	"Objects/0A, 0F - Spring, Koma.asm"
	include	"Objects/10, 11 - Rings.asm"
	include	"Objects/12 - Block.asm"
	include	"Objects/19, 1A - Item.asm"
	include	"Objects/1C - Score.asm"
	include	"Score.asm"
	include	"Enemy.asm"

	movea.l	a0,a1
	moveq	#actfree-1,d0
	moveq	#0,d1

loc_20B5CE:
	move.b	d1,(a1)+
	dbf	d0,loc_20B5CE

	rts

random:
	move.l	d1,-(sp)
	move.l	ranum,d1
	bne.s	.jump
	move.l	#$2A6D365A,d1

.jump:
	move.l	d1,d0
	asl.l	#2,d1
	add.l	d0,d1
	asl.l	#3,d1
	add.l	d0,d1
	move.w	d1,d0
	swap	d1
	add.w	d1,d0
	move.w	d0,d1
	swap	d1
	move.l	d1,ranum
	move.l	(sp)+,d1
	rts

	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20B60E(pc,d0.w),d0
	jmp	off_20B60E(pc,d0.w)

off_20B60E:
	dc.w	loc_20B612-off_20B60E
	dc.w	loc_20B654-off_20B60E

loc_20B612:
	addq.b	#word,r_no0(a0)
	move.l	#off_20CF16,patbase(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#16,sprhsize(a0)
	move.w	#$47A,sproffset(a0)
	move.l	playerwk+xposi,d0
	addi.l	#$32,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi,d0
	addi.l	#$320000,d0
	move.l	d0,yposi(a0)
	rts

loc_20B654:
	move.l	playerwk+xposi,d0
	addi.l	#$320000,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi,d0
	subi.l	#$320000,d0
	move.l	d0,yposi(a0)
	lea	togechg.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_20B684:
	lea	playerwk,a1
	move.w	yspeed(a1),d1
	bmi.w	loc_20B694
	bra.w	loc_20B6EC

loc_20B694:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

	lea	playerwk,a1
	move.w	yspeed(a1),d1
	bpl.w	loc_20B6AE
	bra.w	loc_20B6EC

loc_20B6AE:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

	lea	playerwk,a1
	move.w	xspeed(a1),d1
	bmi.w	loc_20B6C8
	bra.w	loc_20B6EC

loc_20B6C8:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

	lea	playerwk,a1
	move.w	xspeed(a1),d1
	bpl.w	loc_20B6E2
	bra.w	loc_20B6EC

loc_20B6E2:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

loc_20B6EC:
	lea	byte_20B7B6.l,a2
	move.l	d0,d1
	andi.w	#$FF00,d0
	cmpi.w	#$100,d0
	bne.w	loc_20B706
	lea	byte_20B806.l,a2

loc_20B706:
	cmpi.w	#$200,d0
	bne.w	loc_20B714
	lea	byte_20B80A.l,a2

loc_20B714:
	cmpi.w	#$300,d0
	bne.w	loc_20B722
	lea	byte_20B80E.l,a2

loc_20B722:
	move.w	d1,d0
	andi.w	#$FF,d0
	asl.w	#2,d0
	lea	(a2,d0.w),a2
	lea	playerwk,a1
	move.w	xposi(a0),d0
	move.w	xposi(a1),d1
	move.b	sprhs(a1),d3
	ext.w	d3
	_move.b	0(a2),d2
	ext.w	d2
	move.w	d0,d4
	move.w	d1,d5
	add.w	d2,d4
	sub.w	d3,d5
	cmp.w	d4,d5
	bpl.w	loc_20B7AC
	move.b	1(a2),d2
	ext.w	d2
	neg.w	d2
	move.w	d0,d4
	move.w	d1,d5
	sub.w	d2,d4
	add.w	d3,d5
	cmp.w	d5,d4
	bpl.w	loc_20B7AC
	move.w	yposi(a0),d0
	move.w	yposi(a1),d1
	move.b	sprvsize(a1),d3
	ext.w	d3
	move.b	2(a2),d2
	ext.w	d2
	move.w	d0,d4
	move.w	d1,d5
	add.w	d2,d4
	sub.w	d3,d5
	cmp.w	d4,d5
	bpl.w	loc_20B7AC
	move.b	3(a2),d2
	ext.w	d2
	neg.w	d2
	move.w	d0,d4
	move.w	d1,d5
	sub.w	d2,d4
	add.w	d3,d5
	cmp.w	d5,d4
	bpl.w	loc_20B7AC
	moveq	#-1,d1
	bset	#3,cddat(a0)
	rts

loc_20B7AC:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

byte_20B7B6:
	dc.b	$10,$F0,$10,$F0
	dc.b	$10,$F0,4,$FC
	dc.b	9,$F7,$38,$10
	dc.b	0,$E8,4,$FC
	dc.b	0,$E8,$C,0
	dc.b	$18,0,4,$FC
	dc.b	$18,0,$C,0
	dc.b	$20,$E0,$20,$E0
	dc.b	$10,$F0,$10,0
	dc.b	$20,$E0,$10,0
	dc.b	8,-8,$10,$F0
	dc.b	8,-8,$18,$E8
	dc.b	$10,$F0,8,1
	dc.b	$10,$F0,0,-8
	dc.b	$10,$F0,$10,$F0
	dc.b	8,-8,$10,$C0
	dc.b	$17,$E9,$10,$F0
	dc.b	8,-8,8,-8
	dc.b	$10,$F0,$10,$F0
	dc.b	$10,$F0,$40,$C0
byte_20B806:
	dc.b	$10,$F0,$10,$F0
byte_20B80A:
	dc.b	$10,$F0,$10,$F0
byte_20B80E:
	dc.b	$10,$F0,$10,$F0

	include	"Objects/27, 28 - Card, Pole.asm"
	include	"Objects/25 - Hashi.asm"
	include	"Objects/26 - Toge.asm"
	include	"Objects/29 - Buranko.asm"

	dc.b	1
	dc.b	-8,5,0,0,-8
	even
	dc.b	1
	dc.b	-8,$D,0,4,$F0
	even
	dc.b	1
	dc.b	-4,0,0,$C,-4
	even
	dc.b	1
	dc.b	$F0,3,0,$D,-4
	even
	dc.b	1
	dc.b	$F0,3,0,$11,-4
	even
	dc.b	1
	dc.b	-8,5,8,0,-8
	even
	dc.b	1
	dc.b	-8,$D,8,4,$F0
	even
	dc.b	1
	dc.b	-4,0,8,$C,-4
	even
	dc.b	1
	dc.b	$F0,3,8,$D,-4
	even
	dc.b	1
	dc.b	$F0,3,8,$11,-4
	even

polechg:
	dc.w	unk_20CCC0-polechg
	dc.w	unk_20CCD0-polechg
	dc.w	unk_20CCDA-polechg
	dc.w	unk_20CCE4-polechg
	dc.w	unk_20CCE8-polechg
unk_20CCC0:
	dc.b	3-1
	dc.b	0,1,0,2,0,1,0,3,4,3,5,3,4,3
	dc.b	$FF
	even
unk_20CCD0:
	dc.b	3-1
	dc.b	0,1,0,2,0,1,0
	dc.b	$FF
	even
unk_20CCDA:
	dc.b	3-1
	dc.b	3,4,3,5,3,4,3
	dc.b	$FF
	even
unk_20CCE4:
	dc.b	1-1
	dc.b	0
	dc.b	$FF
	even
unk_20CCE8:
	dc.b	1-1
	dc.b	3
	dc.b	$FF
	even

polepat:
	dc.w	byte_20CCF8-polepat
	dc.w	byte_20CD04-polepat
	dc.w	byte_20CD10-polepat
	dc.w	byte_20CD1C-polepat
	dc.w	byte_20CD28-polepat
	dc.w	byte_20CD34-polepat
byte_20CCF8:
	dc.b	2
	dc.b	-4,1,0,0,-8
	dc.b	-4,8,0,2,0
	even
byte_20CD04:
	dc.b	2
	dc.b	-4,5,0,5,-8
	dc.b	0,5,0,9,8
	even
byte_20CD10:
	dc.b	2
	dc.b	-4,5,0,$D,-8
	dc.b	$F0,5,0,$11,8
	even
byte_20CD1C:
	dc.b	2
	dc.b	-4,1,8,0,0
	dc.b	-4,8,8,2,$E8
	even
byte_20CD28:
	dc.b	2
	dc.b	-4,5,8,5,-8
	dc.b	0,5,8,9,$E8
	even
byte_20CD34:
	dc.b	2
	dc.b	-4,5,8,$D,-8
	dc.b	$F0,5,8,$11,$E8
	even

cardchg:
	dc.w	unk_20CD5C-cardchg
	dc.w	unk_20CD6C-cardchg
	dc.w	unk_20CD70-cardchg
	dc.w	unk_20CD74-cardchg
	dc.w	unk_20CD78-cardchg
	dc.w	unk_20CD7C-cardchg
	dc.w	unk_20CD80-cardchg
	dc.w	unk_20CD84-cardchg
	dc.w	unk_20CD88-cardchg
	dc.w	unk_20CD8C-cardchg
	dc.w	unk_20CD90-cardchg
	dc.w	unk_20CD94-cardchg
	dc.w	unk_20CD98-cardchg
	dc.w	unk_20CD9C-cardchg
unk_20CD5C:
	dc.b	10-1
	dc.b	0,1,2,3,4,5,6,7,8,9,10,11,12
	dc.b	$FF
	even
unk_20CD6C:
	dc.b	1-1
	dc.b	0
	dc.b	$FF
	even
unk_20CD70:
	dc.b	1-1
	dc.b	1
	dc.b	$FF
	even
unk_20CD74:
	dc.b	1-1
	dc.b	2
	dc.b	$FF
	even
unk_20CD78:
	dc.b	1-1
	dc.b	3
	dc.b	$FF
	even
unk_20CD7C:
	dc.b	1-1
	dc.b	4
	dc.b	$FF
	even
unk_20CD80:
	dc.b	1-1
	dc.b	5
	dc.b	$FF
	even
unk_20CD84:
	dc.b	1-1
	dc.b	6
	dc.b	$FF
	even
unk_20CD88:
	dc.b	1-1
	dc.b	7
	dc.b	$FF
	even
unk_20CD8C:
	dc.b	1-1
	dc.b	8
	dc.b	$FF
	even
unk_20CD90:
	dc.b	1-1
	dc.b	9
	dc.b	$FF
	even
unk_20CD94:
	dc.b	1-1
	dc.b	10
	dc.b	$FF
	even
unk_20CD98:
	dc.b	1-1
	dc.b	11
	dc.b	$FF
	even
unk_20CD9C:
	dc.b	1-1
	dc.b	12
	dc.b	$FF
	even

cardpat:
	dc.w	byte_20CDBA-cardpat
	dc.w	byte_20CDCA-cardpat
	dc.w	byte_20CDE4-cardpat
	dc.w	byte_20CDF4-cardpat
	dc.w	byte_20CE18-cardpat
	dc.w	byte_20CE32-cardpat
	dc.w	byte_20CE42-cardpat
	dc.w	byte_20CE52-cardpat
	dc.w	byte_20CE6C-cardpat
	dc.w	byte_20CE7C-cardpat
	dc.w	byte_20CEA0-cardpat
	dc.w	byte_20CEBA-cardpat
	dc.w	byte_20CECA-cardpat
byte_20CDBA:
	dc.b	3
	dc.b	$F0,$C,0,0,0
	dc.b	8,$C,$18,0,$E0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CDCA:
	dc.b	5
	dc.b	$F0,$C,0,4,0
	dc.b	$E8,0,0,8,$18
	dc.b	8,$C,$18,4,$E0
	dc.b	$10,0,$18,8,$E0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CDE4:
	dc.b	3
	dc.b	$E8,$D,0,9,0
	dc.b	8,$D,$18,9,$E0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CDF4:
	dc.b	7
	dc.b	$E8,$D,0,$11,0
	dc.b	$E0,0,0,$19,$10
	dc.b	$F0,0,0,$1A,-8
	dc.b	8,$D,$18,$11,$E0
	dc.b	$18,0,$18,$19,$E8
	dc.b	8,0,$18,$1A,0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CE18:
	dc.b	5
	dc.b	$E0,$E,0,$1B,0
	dc.b	$F0,0,0,$27,-8
	dc.b	8,$E,$18,$1B,$E0
	dc.b	8,0,$18,$27,0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CE32:
	dc.b	3
	dc.b	$E0,6,0,$28,-8
	dc.b	8,6,$10,$28,-8
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CE42:
	dc.b	3
	dc.b	$F0,$C,8,0,$E0
	dc.b	8,$C,$10,0,0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CE52:
	dc.b	5
	dc.b	$F0,$C,8,4,$E0
	dc.b	$E8,0,8,8,$E0
	dc.b	8,$C,$10,4,0
	dc.b	$10,0,$10,8,$18
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CE6C:
	dc.b	3
	dc.b	$E8,$D,8,9,$E0
	dc.b	8,$D,$10,9,0
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CE7C:
	dc.b	7
	dc.b	$E8,$D,8,$11,$E0
	dc.b	$E0,0,8,$19,$E8
	dc.b	$F0,0,8,$1A,0
	dc.b	8,$D,$10,$11,0
	dc.b	$18,0,$10,$19,$10
	dc.b	8,0,$10,$1A,-8
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CEA0:
	dc.b	5
	dc.b	$E0,$E,8,$1B,$E0
	dc.b	$F0,0,8,$27,0
	dc.b	8,$E,$10,$1B,0
	dc.b	8,0,$10,$27,-8
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CEBA:
	dc.b	3
	dc.b	$E0,6,8,$28,-8
	dc.b	8,6,$18,$28,-8
	dc.b	-4,0,$C0,$2E,-4
	even
byte_20CECA:
	dc.b	1
	dc.b	-4,0,$C0,$2E,-4
	even

hashichg:
	dc.w	unk_20CED6-hashichg
	dc.w	unk_20CEDA-hashichg
	dc.w	unk_20CEDE-hashichg
unk_20CED6:
	dc.b	30-1
	dc.b	0,1
	dc.b	$FF
	even
unk_20CEDA:
	dc.b	1-1
	dc.b	0
	dc.b	$FF
	even
unk_20CEDE:
	dc.b	1-1
	dc.b	1
	dc.b	$FF
	even

hashipat:
	dc.w	byte_20CEE6-hashipat
	dc.w	byte_20CEEC-hashipat
byte_20CEE6:
	dc.b	1
	dc.b	-8,5,0,0,-8
	even
byte_20CEEC:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even

togechg:
	dc.w	unk_20CEFE-togechg
	dc.w	unk_20CF02-togechg
	dc.w	unk_20CF06-togechg
	dc.w	unk_20CF0A-togechg
	dc.w	unk_20CF0E-togechg
	dc.w	unk_20CF12-togechg
unk_20CEFE:
	dc.b	30-1
	dc.b	0
	dc.b	$FF
	even
unk_20CF02:
	dc.b	30-1
	dc.b	1
	dc.b	$FF
	even
unk_20CF06:
	dc.b	30-1
	dc.b	2
	dc.b	$FF
	even
unk_20CF0A:
	dc.b	30-1
	dc.b	3
	dc.b	$FF
	even
unk_20CF0E:
	dc.b	30-1
	dc.b	4
	dc.b	$FF
	even
unk_20CF12:
	dc.b	30-1
	dc.b	5
	dc.b	$FF
	even

off_20CF16:
	dc.w	byte_20CF1C-off_20CF16
	dc.w	byte_20CF27-off_20CF16
	dc.w	byte_20CF32-off_20CF16
byte_20CF1C:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20CF27:
	dc.b	2
	dc.b	$F0,$D,0,8,$F0
	dc.b	0,$D,0,8,$F0
	even
byte_20CF32:
	dc.b	2
	dc.b	$F0,$D,8,8,$F0
	dc.b	0,$D,8,8,$F0
	even

off_20CF3E:
	dc.w	byte_20CF46-off_20CF3E
	dc.w	byte_20CF5B-off_20CF3E
	dc.w	byte_20CF70-off_20CF3E
	dc.w	byte_20CF85-off_20CF3E
byte_20CF46:
	dc.b	4
	dc.b	$F0,3,0,0,$F0
	dc.b	$F1,3,0,0,-8
	dc.b	$F2,3,0,0,0
	dc.b	$F3,3,0,0,8
byte_20CF5B:
	dc.b	4
	dc.b	$F0,$C,0,4,$F0
	dc.b	-8,$C,0,4,$F1
	dc.b	0,$C,0,4,$F2
	dc.b	8,$C,0,4,$F3
	even
byte_20CF70:
	dc.b	4
	dc.b	$F0,$C,8,4,$F3
	dc.b	-8,$C,8,4,$F2
	dc.b	0,$C,8,4,$F1
	dc.b	8,$C,8,4,$F0
byte_20CF85:
	dc.b	2
	dc.b	$F0,3,0,0,$F4
	dc.b	$F0,3,0,0,4
	even

togepat:
	include	"Patterns/Spikes.asm"

burankochg:
	dc.w	unk_20CFEC-burankochg
	dc.w	unk_20CFF2-burankochg
	dc.w	unk_20CFF6-burankochg
	dc.w	unk_20CFFA-burankochg
unk_20CFEC:
	dc.b	30-1
	dc.b	0,1,2
	dc.b	$FF
	even
unk_20CFF2:
	dc.b	30-1
	dc.b	0
	dc.b	$FF
	even
unk_20CFF6:
	dc.b	30-1
	dc.b	1
	dc.b	$FF
	even
unk_20CFFA:
	dc.b	30-1
	dc.b	2
	dc.b	$FF
	even

burankopat:
	dc.w	byte_20D004-burankopat
	dc.w	byte_20D00A-burankopat
	dc.w	byte_20D010-burankopat
byte_20D004:
	dc.b	1
	dc.b	-8,5,0,0,-8
	even
byte_20D00A:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even
byte_20D010:
	dc.b	2
	dc.b	-8,9,0,8,$E8
	dc.b	-8,9,8,8,0
	even

	include	"Objects/20 - Kuzureru Tikei.asm"
	include	"Objects/21 - DoDai.asm"

enecginit:
	lea	word_20DC28(pc),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	scra_h_posit,d0

loc_20DBE2:
	cmp.w	(a1)+,d0
	blo.s	loc_20DBEA
	addq.b	#2,d1
	bra.s	loc_20DBE2

loc_20DBEA:
	move.b	d1,enecgpnt
	move.w	word_20DC40(pc,d1.w),d0
	jmp	divdevset.l

sub_20DBFA:
	lea	word_20DC28(pc),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	scra_h_posit,d0

loc_20DC06:
	cmp.w	(a1)+,d0
	blo.s	loc_20DC0E
	addq.b	#2,d1
	bra.s	loc_20DC06

loc_20DC0E:
	cmp.b	enecgpnt,d1
	bne.s	loc_20DC18
	rts

loc_20DC18:
	move.b	d1,enecgpnt
	move.w	word_20DC34(pc,d1.w),d0
	jmp	divdevset2.l

word_20DC28:
	if act_number=0
	dc.w	$D00
	dc.w	$1100
	dc.w	$1500
	dc.w	$1A00
	dc.w	$2000
	else
	dc.w	$B00
	dc.w	$1300
	dc.w	$1800
	dc.w	$1C00
	endif
	dc.w	-1

word_20DC34:
	if act_number=0
	dc.w	ddevid_04
	dc.w	ddevid_05
	dc.w	ddevid_06
	dc.w	ddevid_07
	dc.w	ddevid_08
	dc.w	ddevid_09
	else
	dc.w	ddevid_04
	dc.w	ddevid_05
	dc.w	ddevid_06
	dc.w	ddevid_07
	dc.w	ddevid_08
	endif

word_20DC40:
	if act_number=0
	dc.w	ddevid_0A
	dc.w	ddevid_0B
	dc.w	ddevid_0C
	dc.w	ddevid_0D
	dc.w	ddevid_0E
	dc.w	ddevid_0F
	else
	dc.w	ddevid_09
	dc.w	ddevid_0A
	dc.w	ddevid_0B
	dc.w	ddevid_0C
	dc.w	ddevid_0D
	endif

pa_set:
	lea	pa_set_tbl.l,a1
	add.w	d0,d0
	move.w	pa_set_tbl(pc,d0.w),d4
	lea	pa_set_tbl(pc,d4.w),a2
	moveq	#0,d1
	move.b	act29(a0),d1
	add.w	d1,d1
	move.w	(a2,d1.w),d5
	move.w	d5,sproffset(a0)
	rts

pa_set_tbl:
	dc.w	pa0-pa_set_tbl
	dc.w	pa1-pa_set_tbl
	dc.w	pa2-pa_set_tbl
	dc.w	pa3-pa_set_tbl
	dc.w	pa4-pa_set_tbl
	dc.w	pa5-pa_set_tbl
	dc.w	pa6-pa_set_tbl
	dc.w	pa7-pa_set_tbl
	dc.w	pa8-pa_set_tbl
	dc.w	pa9-pa_set_tbl
	dc.w	pa10-pa_set_tbl
	dc.w	pa11-pa_set_tbl
	dc.w	pa12-pa_set_tbl
	dc.w	pa13-pa_set_tbl
	dc.w	pa14-pa_set_tbl
	dc.w	pa15-pa_set_tbl
	dc.w	pa16-pa_set_tbl
	dc.w	pa17-pa_set_tbl

	if act_number=0

pa0:
	dc.w	$3E7|tile_col2
pa1:
	dc.w	$4DC|tile_col2
pa2:
	dc.w	$45F|tile_col2
pa3:
	dc.w	$431|tile_col2
pa4:
	dc.w	$3E7|tile_col2
pa5:
	dc.w	block_vram|tile_col3
pa10:
	dc.w	toge_vram
pa7:
	dc.w	$342
pa9:
	dc.w	hashi_vram|tile_col3
pa8:
	dc.w	$495|tile_col3
pa6:
	dc.w	dai_k_vram
pa11:
	dc.w	iwa_vram
pa12:
	dc.w	futa_vram|tile_pri
pa13:
	dc.w	exit2_vram
pa14:
	dc.w	koma_vram
pa15:
	dc.w	spring45_vram
pa16:
	dc.w	$422
pa17:
	dc.w	0

	else

pa0:
	dc.w	$413|tile_col2
pa1:
	dc.w	$413|tile_col2
pa2:
	dc.w	$4EB|tile_col2
pa3:
	dc.w	$3D8|tile_col2
pa4:
	dc.w	$3D8|tile_col2
pa5:
	dc.w	block_vram|tile_col3
pa10:
	dc.w	toge_vram
pa7:
	dc.w	$361
pa9:
	dc.w	hashi_vram|tile_col3
pa8:
	dc.w	$4B2|tile_col3
pa6:
	dc.w	dai_k_vram
pa11:
	dc.w	iwa_vram
pa12:
	dc.w	futa_vram|tile_pri
pa13:
	dc.w	exit2_vram
pa14:
	dc.w	koma_vram
pa15:
	dc.w	spring45_vram
pa16:
	dc.w	$503
pa17:
	dc.w	buranko_vram

	endif

	include	"Objects/24 - Friend.asm"
	include	"Objects/17 - Goal.asm"

sub_20DFF4:
	jmp	plsubchg.l

mapinittbl:
	dc.l	ddevid_03<<24|zone1cg
	dc.l	ddevid_02<<24|zone1blk
	dc.l	zone1map
	dc.w	bgm_81
	dc.b	colorzone1,colorzone1

ddev_header:	macro	{INTLABEL}
__LABEL__:	label	*
	dc.w	((__LABEL___end-__LABEL__-2)/6)-1
	endm

ddev_entry:	macro	cg,vram
	dc.l	cg
	dc.w	vram*tile_size
	endm

divdevtbl:

ddev_ptr:	macro	ptr,{INTLABEL}
__LABEL__:	label	(*-divdevtbl)/2
	dc.w	ptr-divdevtbl
	endm

ddevid_00:	ddev_ptr	ddev_00
ddevid_01:	ddev_ptr	ddev_01
ddevid_02:	ddev_ptr	ddev_02
ddevid_03:	ddev_ptr	ddev_00
ddevid_04:	ddev_ptr	ddev_04
ddevid_05:	ddev_ptr	ddev_05
ddevid_06:	ddev_ptr	ddev_06
ddevid_07:	ddev_ptr	ddev_07
ddevid_08:	ddev_ptr	ddev_08
ddevid_09:	ddev_ptr	ddev_09
ddevid_0A:	ddev_ptr	ddev_0A
ddevid_0B:	ddev_ptr	ddev_0B
ddevid_0C:	ddev_ptr	ddev_0C

	if act_number=0
ddevid_0D:	ddev_ptr	ddev_0C
ddevid_0E:	ddev_ptr	ddev_0E
ddevid_0F:	ddev_ptr	ddev_0F
	else
ddevid_0D:	ddev_ptr	ddev_0D
	endif

ddev_00:	ddev_header
	ddev_entry	zone1cg,0
ddev_00_end:

	if act_number=0
ddev_01:	ddev_header
	ddev_entry	iwacg,iwa_vram
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$342
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	springcg,spring_vram
	ddev_entry	scorecg,score_vram
	ddev_entry	itemcg,item_vram
	ddev_entry	bakuhacg,bakuha_vram
	ddev_entry	flowcg,flow_vram
	ddev_entry	ringcg,ring_vram
ddev_01_end:

ddev_02:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	friendcg,$3CF
	ddev_entry	kacg,$3E7
	ddev_entry	tagamecg,$431
	ddev_entry	aricg,$45F
	ddev_entry	exit2cg,exit2_vram
	ddev_entry	choucg,$4DC
ddev_02_end:

ddev_04:	ddev_header
	ddev_entry	kacg,$3E7
	ddev_entry	tagamecg,$431
ddev_04_end:

ddev_05:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	kamemusicg,$3E7
	ddev_entry	aricg,$45F
	ddev_entry	exit2cg,exit2_vram
ddev_05_end:

ddev_06:	ddev_header
	ddev_entry	exitcg,$422
	ddev_entry	cardcg,$495
ddev_06_end:

ddev_07:	ddev_header
	ddev_entry	kamemusicg,$3E7
	ddev_entry	exitcg,$422
ddev_07_end:

ddev_08:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	friendcg,$3CF
	ddev_entry	kacg,$3E7
	ddev_entry	tagamecg,$431
	ddev_entry	aricg,$45F
	ddev_entry	goalcg,goal_vram
ddev_08_end:

ddev_09:	ddev_header
	ddev_entry	goalcg,goal_vram
ddev_09_end:

ddev_0A:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$342
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	friendcg,$3CF
	ddev_entry	kacg,$3E7
	ddev_entry	tagamecg,$431
	ddev_entry	aricg,$45F
	ddev_entry	exit2cg,exit2_vram
	ddev_entry	choucg,$4DC
ddev_0A_end:

ddev_0B:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$342
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	friendcg,$3CF
	ddev_entry	kamemusicg,$3E7
	ddev_entry	aricg,$45F
	ddev_entry	exit2cg,exit2_vram
	ddev_entry	choucg,$4DC
ddev_0B_end:

ddev_0C:	ddev_header
	ddev_entry	iwacg,iwa_vram
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$342
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	friendcg,$3CF
	ddev_entry	kamemusicg,$3E7
	ddev_entry	exitcg,$422
	ddev_entry	cardcg,$495
	ddev_entry	choucg,$4DC
ddev_0C_end:

ddev_0E:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$342
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	friendcg,$3CF
	ddev_entry	kacg,$3E7
	ddev_entry	tagamecg,$431
	ddev_entry	aricg,$45F
	ddev_entry	choucg,$4DC
ddev_0E_end:

ddev_0F:	ddev_header
	ddev_entry	hashicg,hashi_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$342
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	kacg,$3E7
	ddev_entry	tagamecg,$431
	ddev_entry	aricg,$45F
	ddev_entry	choucg,$4DC
	ddev_entry	goalcg,goal_vram
ddev_0F_end:

; unused
	ddev_entry	spring45cg,$33F
	ddev_entry	komacg,$36D
	ddev_entry	futacg,$375
	ddev_entry	blockcg,$381
	ddev_entry	daikcg,$393
	ddev_entry	iwacg,$3A2
	ddev_entry	friendcg,$3B6
	ddev_entry	aricg,$3CE
	ddev_entry	kacg,$3E4
	ddev_entry	choucg,$42E
	ddev_entry	kamemusicg,$462

ddev_unused_0:	ddev_header
	ddev_entry	togecg,$31E
	ddev_entry	polecg,$32A
	ddev_entry	spring45cg,$33F
	ddev_entry	komacg,$36D
	ddev_entry	futacg,$375
	ddev_entry	blockcg,$381
	ddev_entry	daikcg,$393
	ddev_entry	iwacg,$3A2
	ddev_entry	friendcg,$3B6
	ddev_entry	aricg,$3CE
	ddev_entry	kacg,$3E4
	ddev_entry	exitcg,$469
ddev_unused_0_end:

ddev_unused_1:	ddev_header
	ddev_entry	togecg,$31E
	ddev_entry	polecg,$32A
	ddev_entry	spring45cg,$33F
	ddev_entry	komacg,$36D
	ddev_entry	futacg,$375
	ddev_entry	blockcg,$381
	ddev_entry	daikcg,$393
	ddev_entry	iwacg,$3A2
	ddev_entry	friendcg,$3B6
	ddev_entry	aricg,$3CE
	ddev_entry	kacg,$3E4
	ddev_entry	choucg,$42E
	ddev_entry	kamemusicg,$462
ddev_unused_1_end:

ddev_unused_2:	ddev_header
	ddev_entry	togecg,$31E
	ddev_entry	polecg,$32A
	ddev_entry	spring45cg,$33F
	ddev_entry	komacg,$36D
	ddev_entry	futacg,$375
	ddev_entry	blockcg,$381
	ddev_entry	daikcg,$393
	ddev_entry	iwacg,$3A2
	ddev_entry	aricg,$3CE
	ddev_entry	kacg,$3E4
	ddev_entry	choucg,$42E
	ddev_entry	kamemusicg,$462
ddev_unused_2_end:

	include	"Leftovers/R11A (Act 1).asm"

	else
ddev_01:	ddev_header
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$361
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	komacg,koma_vram
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	goalcg,goal_vram
	ddev_entry	springcg,spring_vram
	ddev_entry	scorecg,score_vram
	ddev_entry	itemcg,item_vram
	ddev_entry	bakuhacg,bakuha_vram
	ddev_entry	flowcg,flow_vram
	ddev_entry	ringcg,ring_vram
ddev_01_end:

ddev_02:	ddev_header
	ddev_entry	kamemusicg,$3D8
	ddev_entry	choucg,$413
	ddev_entry	friendcg,$45D
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	aricg,$4EB
ddev_02_end:

ddev_04:	ddev_header
	ddev_entry	choucg,$413
ddev_04_end:

ddev_05:	ddev_header
	ddev_entry	kacg,$413
	ddev_entry	friendcg,$45D
	ddev_entry	iwacg,iwa_vram
	ddev_entry	aricg,$4EB
ddev_05_end:

ddev_06:	ddev_header
	ddev_entry	exit2cg,$48A
ddev_06_end:

ddev_07:	ddev_header
	ddev_entry	kamemusicg,$3D8
	ddev_entry	kacg,$413
	ddev_entry	iwacg,iwa_vram
	ddev_entry	burankocg,buranko_vram
	ddev_entry	cardcg,$4B2
ddev_07_end:

ddev_08:	ddev_header
	ddev_entry	tagamecg,$3D8
	ddev_entry	hashicg,hashi_vram
	ddev_entry	choucg,$413
	ddev_entry	friendcg,$45D
	ddev_entry	goalcg,goal_vram
ddev_08_end:

ddev_09:	ddev_header
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$361
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	komacg,$3A4
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	kamemusicg,$3D8
	ddev_entry	choucg,$413
	ddev_entry	friendcg,$45D
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	aricg,$4EB
ddev_09_end:

ddev_0A:	ddev_header
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$361
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	komacg,$3A4
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	kamemusicg,$3D8
	ddev_entry	kacg,$413
	ddev_entry	friendcg,$45D
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	aricg,$4EB
ddev_0A_end:

ddev_0B:	ddev_header
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$361
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	komacg,$3A4
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	kamemusicg,$3D8
	ddev_entry	kacg,$413
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	exit2cg,$48A
	ddev_entry	aricg,$4EB
ddev_0B_end:

ddev_0C:	ddev_header
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$361
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	komacg,$3A4
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	kamemusicg,$3D8
	ddev_entry	kacg,$413
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	burankocg,buranko_vram
	ddev_entry	cardcg,$4B2
	ddev_entry	aricg,$4EB
ddev_0C_end:

ddev_0D:	ddev_header
	ddev_entry	togecg,toge_vram
	ddev_entry	polecg,$361
	ddev_entry	spring45cg,spring45_vram
	ddev_entry	komacg,$3A4
	ddev_entry	futacg,futa_vram
	ddev_entry	blockcg,block_vram
	ddev_entry	tagamecg,$3D8
	ddev_entry	hashicg,hashi_vram
	ddev_entry	choucg,$413
	ddev_entry	friendcg,$45D
	ddev_entry	daikcg,dai_k_vram
	ddev_entry	iwacg,iwa_vram
	ddev_entry	burankocg,buranko_vram
	ddev_entry	cardcg,$4B2
	ddev_entry	aricg,$4EB
ddev_0D_end:

	include	"Leftovers/R12A (A).asm"
	include	"Leftovers/R11A (Act 2).asm"

	endif

	include	"Leftovers/R12A (B).asm"

mapwk:
	incbin	"Leftovers/Act 2/Chunks/Present Act 2.unc"
	even

	incbin	"Leftovers/Unknown/Unk1.unc"
	even

	incbin	"Leftovers/Unknown/Unk2.unc"
	even

playcg:
	incbin	"Art/Uncompressed/Player.unc"
	even

playpat:
	include	"Patterns/Player.asm"

playwrtpat:
	include	"Patterns/Write/Player.asm"

soundadrtb:
	save
	cpu	z80
	phase	1900H
	listing	purecode
	include	"Sound/m5eq11.lib"
	include	"Sound/m5mcr11.lib"
	include	"Sound/chktb1.src"
	dephase
soundadrtb_end:

soundsetb:
	phase	0B00H
	include	"Sound/m5se11.s"
	even
	dephase
soundsetb_end:

soundcnt:
	phase	0
	include	"Sound/m5int11.src"
	include	"Sound/m5cnt11.src"
	include	"Sound/m5fmdr11.src"
	include	"Sound/m5cmd11.src"
	restore
	padding	off
	dephase
soundcnt_end:

bariacg:
	incbin	"Art/Uncompressed/Shield.unc"
	even

mutekicg:
	incbin	"Art/Uncompressed/Invincibility Stars.unc"
	even

backtocg:
	incbin	"Art/Uncompressed/Time Travel Sparkles.unc"
	even

spring45cg:
	incbin	"Art/BitDev/Diagonal Spring.nem"
	even

springcg:
	incbin	"Art/BitDev/Spring.nem"
	even

itemcg:
	incbin	"Art/BitDev/Monitor and Time Sign.nem"
	even

bakuhacg:
	incbin	"Art/BitDev/Explosion.nem"
	even

ringcg:
	incbin	"Art/BitDev/Ring.nem"
	even

playsuucg:
	incbin	"Art/Uncompressed/Life Icon.unc"
	even

scorewrtcg:
	incbin	"Art/Uncompressed/HUD Numbers and Letters.unc"
	even

scorecg:
	incbin	"Art/BitDev/HUD.nem"
	even

flowcg:
	incbin	"Art/BitDev/Flowers.nem"
	even

goalcg:
	incbin	"Art/BitDev/Goal.nem"
	even

iwacg:
	incbin	"Art/BitDev/Rock.nem"
	even

blockcg:
	incbin	"Art/BitDev/Block.nem"
	even

komacg:
	incbin	"Art/BitDev/Wheel.nem"
	even

daikcg:
	incbin	"Art/BitDev/Spinning Disc.nem"
	even

exitcg:
	incbin	"Art/BitDev/Splash.nem"
	even

futacg:
	incbin	"Art/BitDev/Flipper.nem"
	even

exit2cg:
	incbin	"Art/BitDev/Splash 2.nem"
	even

kacg:
	incbin	"Art/BitDev/Mosqui.nem"
	even

choucg:
	incbin	"Art/BitDev/Pata-Bata.nem"
	even

aricg:
	incbin	"Art/BitDev/Anton.nem"
	even

tagamecg:
	incbin	"Art/BitDev/Taga-Taga.nem"
	even

kamemusicg:
	incbin	"Art/BitDev/Tamabboh.nem"
	even

polecg:
	incbin	"Art/BitDev/Pole.nem"
	even

cardcg:
	incbin	"Art/BitDev/Rotating Card.nem"
	even

hashicg:
	incbin	"Art/BitDev/Bridge.nem"
	even

swichcg:
	incbin	"Art/BitDev/Switch.nem"
	even

togecg:
	incbin	"Art/BitDev/Spikes.nem"
	even

burankocg:
	incbin	"Art/BitDev/Swing.nem"
	even

friendcg:
	incbin	"Art/BitDev/Flicky and Ricky.nem"
	even

	incbin	"Art/BitDev/Swallow and Pecky.nem"
	even

	incbin	"Art/BitDev/Canary and Pocky.nem"
	even

	incbin	"Art/BitDev/Fish.nem"
	even

	incbin	"Art/BitDev/Dove and Sheep.nem"
	even

	incbin	"Art/BitDev/Spinning Disc.nem"
	even

	incbin	"Art/BitDev/Spikes (Unused).nem"
	even

	incbin	"Art/BitDev/Spikes (Unused 2).nem"
	even

scddirtbl:
	incbin	"Collision/Angle Map.bin"
	even

scdtblwk:
	incbin	"Collision/Collision Array 1.bin"
	even

scdtblwk2:
	incbin	"Collision/Collision Array 2.bin"
	even

zone1scd:
	if act_number=0
	incbin	"Collision/Act 1.bin"
	else
	incbin	"Collision/Act 2.bin"
	endif
	even

zonemaptbl:
	dc.w	zone1_1a-zonemaptbl,	zone1_1b-zonemaptbl,	zone1_1z-zonemaptbl
	dc.w	zone1_2a-zonemaptbl,	zone1_3b-zonemaptbl,	zone1_2z-zonemaptbl
	dc.w	zone1_3a-zonemaptbl,	zone1_3b-zonemaptbl,	zone1_3b-zonemaptbl
	dc.w	zone1_4-zonemaptbl,	zone1_4-zonemaptbl,	zone1_4-zonemaptbl

	dc.w	zone1_1a-zonemaptbl,	zone1_1b-zonemaptbl,	zone1_1z-zonemaptbl
	dc.w	zone1_2a-zonemaptbl,	zone1_3b-zonemaptbl,	zone1_2z-zonemaptbl
	dc.w	zone1_3a-zonemaptbl,	zone1_3b-zonemaptbl,	zone1_3b-zonemaptbl
	dc.w	zone1_4-zonemaptbl,	zone1_4-zonemaptbl,	zone1_4-zonemaptbl

	dc.w	zone1_1a-zonemaptbl,	zone1_1b-zonemaptbl,	zone1_1z-zonemaptbl
	dc.w	zone1_2a-zonemaptbl,	zone1_3b-zonemaptbl,	zone1_2z-zonemaptbl
	dc.w	zone1_3a-zonemaptbl,	zone1_3b-zonemaptbl,	zone1_3b-zonemaptbl
	dc.w	zone1_4-zonemaptbl,	zone1_4-zonemaptbl,	zone1_4-zonemaptbl

zone1_1a:
	if act_number=0
	incbin	"Layout/Present FG Act 1.bin"
	else
	incbin	"Layout/Present FG Act 2.bin"
	endif
	even
zone1_1b:
	if act_number=0
	incbin	"Layout/Present BG Act 1.bin"
	else
	incbin	"Layout/Present BG Act 2.bin"
	endif
	even
zone1_1z:
	dc.l	0
zone1_2a:
	incbin	"Leftovers/Layout/GHZ2 FG (Sonic 1).bin"
	even
zone1_2z:
	dc.l	0
zone1_3a:
	incbin	"Leftovers/Layout/GHZ3 FG (Sonic 1).bin"
	even
zone1_3b:
	dc.l	0
zone1_4:
	dc.l	0

zone1blk:
	if act_number=0
	incbin	"Blocks/Present Act 1.nem"
	else
	incbin	"Blocks/Present Act 2.nem"
	endif
	even

zone1cg:
	if act_number=0
	incbin	"Art/BitDev/8x8 - Present Act 1.nem"
	else
	incbin	"Art/BitDev/8x8 - Present Act 2.nem"
	endif
	even

zone1map:
	if act_number=0
	incbin	"Chunks/Present Act 1.kos"
	else
	incbin	"Chunks/Present Act 2.kos"
	endif
	even

	if act_number=0
	incbin	"Leftovers/Act 2/Chunks/Present Act 2.kos"
	even
	endif

	if act_number=0
	incbin	"Leftovers/Unknown/Unk1.kos"
	else
	incbin	"Leftovers/Unknown/Unk2.kos"
	endif
	even

	incbin	"Leftovers/Unknown/Unk3.kos"
	even

	incbin	"Leftovers/Unknown/Unk3.unc"
	even

	dephase