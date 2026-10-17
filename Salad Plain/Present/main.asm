; CD Sonic The Hedgehog R11A Disassembly
; Date of R11A: December 4, 1992 21:34:01

	cpu	68000

ZeroOffsetOptimization = 0

	include	"MacroSetup.asm"
	include	"Equates.asm"
	include	"WorkRAM.asm"
	include	"Macros.asm"

	phase	wkram	; set section to use workram

vectors:
	dc.l	0
	dc.l	0
	dc.l	MMD_INIT
	dc.l	MMD_HINT
	dc.l	MMD_VINT

	align	$100

MMD_INIT:
	jmp	init

MMD_ERROR:
	jmp	error

MMD_HINT:
	jmp	hint

MMD_VINT:
	jmp	vint

error:
	nop
	nop
	bra.s	error

init:
	btst	#6,cont_3
	beq.s	.stack
	cmpi.l	#"init",init_flag
	beq.w	.jump

.stack:
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

.jump:
	bsr.w	vdpinit
	bsr.w	sw_init
	move.b	#gamemd,gmmode.w
	move.b	gmmode.w,d0
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
	move.w	sr,statusr.w
	move.w	#$2700,sr
	move.w	#$100,z80busreq

.wait:
	btst	#0,z80busreq
	bne.s	.wait
	rts

z80bus_off:
	move.w	#0,z80busreq
	move.w	statusr.w,sr
	rts

z80snddriverload:
	move.w	#$100,z80reset
	jsr	z80bus_on(pc)
	lea	z80ram,a1
	lea	unk_22EB40.l,a2
	move.w	#(unk_22EB40_end-unk_22EB40)-1,d0

loc_201E42:
	move.b	(a2)+,(a1)+
	dbf	d0,loc_201E42

	lea	z80ram+$B00,a1
	lea	unk_22E3E4.l,a2
	move.w	#(unk_22E3E4_end-unk_22E3E4)-1,d0

loc_201E58:
	move.b	(a2)+,(a1)+
	dbf	d0,loc_201E58

	lea	z80ram+$1900,a1
	lea	unk_22E3AC.l,a2
	move.w	#(unk_22E3AC_end-unk_22E3AC)-1,d0

loc_201E6E:
	move.b	(a2)+,(a1)+
	dbf	d0,loc_201E6E

	move.w	#0,z80reset
	ror.b	#8,d0
	move.w	#$100,z80reset
	jmp	z80bus_off(pc)

bgmset:
;	move.b	d0,sound_ram+buf1.w
	rts

soundset:
	move.b	d0,sound_ram+buf2.w
	rts

	move.b	d0,sound_ram+buf3.w
	rts

sound:
	jsr	z80bus_on.l
	tst.b	sound_ram+buf2.w
	beq.s	loc_201EB4
	move.b	sound_ram+buf2.w,z80ram+$1C09
	move.b	#0,sound_ram+buf2.w
	bra.s	loc_201EC8

loc_201EB4:
	tst.b	sound_ram+buf3.w
	beq.s	loc_201EC8
	move.b	sound_ram+buf3.w,z80ram+$1C09
	move.b	#0,sound_ram+buf3.w

loc_201EC8:
	jmp	z80bus_off.l

copy_map_vram:
	lea	vdpdata,a6
	move.l	#$800000,d4

.loop:
	move.l	d0,vdpctrl-vdpdata(a6)
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
	include	"Actors/01, 02 - Player.asm"

loc_205400:
	move.w	#scpu_fadeCDA,d0

sub_sync:
	move.w	d0,scpu_commcmd0

.loop:
	tst.w	scpu_commstats
	beq.s	.loop
	move.w	#0,scpu_commcmd0

.loop0:
	tst.w	scpu_commstats
	bne.s	.loop0
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
	andi.b	#$1F,d0
	move.b	d0,patno(a0)
	move.b	cddat(a0),d0
	rol.b	#3,d1
	eor.b	d0,d1
	andi.b	#%0011,d1
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

	include	"Actors/06 - Test.asm"
	include	"Actors/18, 1F - Bakuha, Flower.asm"
	include	"Actors/0E - Mizukiri.asm"
	include	"Actors/0D - Futa.asm"
	include	"Actors/0B, 0C - Exit2.asm"
	include	"Actors/03 - Baria.asm"

exit2chg:
	dc.w	exit2chg0-exit2chg
	dc.w	exit2chg1-exit2chg
	dc.w	exit2chg2-exit2chg
exit2chg0:
	dc.b	3
	dc.b	0,4,3,1,2
	dc.b	$FC
	even
exit2chg1:
	dc.b	3
	dc.b	0,1,2
	dc.b	$FC
	even
exit2chg2:
	dc.b	3
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
	dc.b	0
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
	dc.b	3
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
	dc.b	3
	dc.b	0,5,6,3,4
	dc.b	$FC
	even
bakuchg1:
	dc.b	3
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
	dc.b	3
	dc.b	0,1
	dc.b	$FF
	even
flowchg1:
	dc.b	3
	dc.b	2,3,2,3
	dc.b	$FC
	even
flowchg2:
	dc.b	1
	dc.b	5,5,4,6
	dc.b	$FC
	even
flowchg3:
	dc.b	$13
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
	include	"Actors/04, 05, 08 - Taki, Jisin.asm"
	include	"Edit.asm"

actsetchk:
	moveq	#0,d0
	move.b	actset_rno.w,d0
	move.w	actset_tbl(pc,d0.w),d0
	jmp	actset_tbl(pc,d0.w)

actset_tbl:
	dc.w	actsetinit-actset_tbl
	dc.w	actset-actset_tbl

actsetinit:
	addq.b	#2,actset_rno.w
	lea	asettbl.l,a0
	movea.l	a0,a1
	adda.w	(a0),a0
	move.l	a0,asetadr.w
	move.l	a0,asetadr2.w
	adda.w	2(a1),a1
	move.l	a1,asetadrz.w
	move.l	a1,asetadrz2.w
	lea	flagwork,a2
	move.w	#$101,(a2)+
	move.w	#(flagwork_end-flagwork-2)/4-1,d0

loc_206DF2:
	clr.l	(a2)+
	dbf	d0,loc_206DF2

	lea	flagwork,a2
	moveq	#0,d2
	move.w	scra_h_posit.w,d6
	subi.w	#$80,d6
	bhs.s	loc_206E0C
	moveq	#0,d6

loc_206E0C:
	andi.w	#$FF80,d6
	movea.l	asetadr.w,a0

loc_206E14:
	cmp.w	(a0),d6
	bls.s	loc_206E26
	tst.b	4(a0)
	bpl.s	loc_206E22
	move.b	(a2),d2
	addq.b	#1,(a2)

loc_206E22:
	addq.w	#8,a0
	bra.s	loc_206E14

loc_206E26:
	move.l	a0,asetadr.w
	movea.l	asetadr2.w,a0
	subi.w	#$80,d6
	blo.s	loc_206E46

loc_206E34:
	cmp.w	(a0),d6
	bls.s	loc_206E46
	tst.b	4(a0)
	bpl.s	loc_206E42
	addq.b	#1,1(a2)

loc_206E42:
	addq.w	#8,a0
	bra.s	loc_206E34

loc_206E46:
	move.l	a0,asetadr2.w
	move.w	#$FFFF,asetposi.w

actset:
	lea	flagwork,a2
	moveq	#0,d2
	move.w	scra_h_posit.w,d6
	andi.w	#$FF80,d6
	cmp.w	asetposi.w,d6
	beq.w	locret_206F0C
	bge.s	loc_206EC8
	move.w	d6,asetposi.w
	movea.l	asetadr2.w,a0
	subi.w	#$80,d6
	blo.s	loc_206EA4

loc_206E78:
	cmp.w	-8(a0),d6
	bge.s	loc_206EA4
	subq.w	#8,a0
	tst.b	4(a0)
	bpl.s	loc_206E8E
	subq.b	#1,1(a2)
	move.b	1(a2),d2

loc_206E8E:
	bsr.w	actnoset
	bne.s	loc_206E98
	subq.w	#8,a0
	bra.s	loc_206E78

loc_206E98:
	tst.b	4(a0)
	bpl.s	loc_206EA2
	addq.b	#1,1(a2)

loc_206EA2:
	addq.w	#8,a0

loc_206EA4:
	move.l	a0,asetadr2.w
	movea.l	asetadr.w,a0
	addi.w	#$300,d6

loc_206EB0:
	cmp.w	-8(a0),d6
	bgt.s	loc_206EC2
	tst.b	-4(a0)
	bpl.s	loc_206EBE
	subq.b	#1,(a2)

loc_206EBE:
	subq.w	#8,a0
	bra.s	loc_206EB0

loc_206EC2:
	move.l	a0,asetadr.w
	rts

loc_206EC8:
	move.w	d6,asetposi.w
	movea.l	asetadr.w,a0
	addi.w	#$280,d6

loc_206ED4:
	cmp.w	(a0),d6
	bls.s	loc_206EE8
	tst.b	4(a0)
	bpl.s	loc_206EE2
	move.b	(a2),d2
	addq.b	#1,(a2)

loc_206EE2:
	bsr.w	actnoset
	beq.s	loc_206ED4

loc_206EE8:
	move.l	a0,asetadr.w
	movea.l	asetadr2.w,a0
	subi.w	#$300,d6
	blo.s	loc_206F08

loc_206EF6:
	cmp.w	(a0),d6
	bls.s	loc_206F08
	tst.b	4(a0)
	bpl.s	loc_206F04
	addq.b	#1,1(a2)

loc_206F04:
	addq.w	#8,a0
	bra.s	loc_206EF6

loc_206F08:
	move.l	a0,asetadr2.w

locret_206F0C:
	rts

tm_setchk:
	moveq	#0,d0
	move.b	time_flag,d0
	move.w	d2,d3
	add.w	d3,d3
	add.w	d2,d3
	add.w	d0,d3
	move.b	6(a0),d1
	rol.b	#3,d1
	andi.b	#7,d1
	btst	d0,d1
	rts

actnoset:
	bsr.s	tm_setchk
	beq.s	loc_206F3E
	tst.b	4(a0)
	bpl.s	loc_206F44
	bset	#7,2(a2,d3.w)
	beq.s	loc_206F44

loc_206F3E:
	addq.w	#8,a0
	moveq	#0,d0
	rts

loc_206F44:
	bsr.w	actwkchk
	bne.s	locret_206F84
	move.w	(a0)+,xposi(a1)
	move.w	(a0)+,d0
	move.w	d0,d1
	andi.w	#$FFF,d0
	move.w	d0,yposi(a1)
	rol.w	#2,d1
	andi.b	#3,d1
	move.b	d1,actflg(a1)
	move.b	d1,cddat(a1)
	move.b	(a0)+,d0
	bpl.s	loc_206F74
	andi.b	#$7F,d0
	move.b	d2,cdsts(a1)

loc_206F74:
	_move.b	d0,actno(a1)
	move.b	(a0)+,userflag(a1)
	move.b	(a0)+,d0
	move.b	(a0)+,act29(a1)
	moveq	#0,d0

locret_206F84:
	rts

actwkchk:
	lea	byte_FFD800.w,a1
	move.w	#(byte_FFD800_end-byte_FFD800)/actfree-1,d0

loc_206F8E:
	tst.b	actno(a1)
	beq.s	locret_206F9A
	lea	actfree(a1),a1
	dbf	d0,loc_206F8E

locret_206F9A:
	rts

actwkchk2:
	movea.l	a0,a1
	move.w	#byte_FFD800_end&$FFFF,d0
	sub.w	a0,d0
	lsr.w	#6,d0
	subq.w	#1,d0
	blo.s	locret_206FB6

loc_206FAA:
	tst.b	actno(a1)
	beq.s	locret_206FB6
	lea	actfree(a1),a1
	dbf	d0,loc_206FAA

locret_206FB6:
	rts

frameout_s:
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bls.s	locret_206FFE
	moveq	#0,d0
	move.b	cdsts(a0),d0
	beq.s	loc_206FF8
	lea	flagwork,a1
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_flag,d1
	add.w	d1,d0
	bclr	#7,2(a1,d0.w)

loc_206FF8:
	jmp	frameout.l

locret_206FFE:
	rts

asettbl:
	dc.w	asettbl10-asettbl
	dc.w	asettbl10z-asettbl

	dc.w	$FFFF,0,0,0

asettbl10:
	incbin	"Actor Positions/ActPos.bin"
	even

asettbl10z:
	dc.w	$FFFF,0,0

	include	"Actors/07 - Shooter.asm"
	include	"RideChk.asm"
	include	"Actors/09 - Dai_K.asm"
	include	"Actors/1B - Iwa.asm"
	include	"Actors/0A, 0F - Spring, Koma.asm"
	include	"Actors/10, 11 - Rings.asm"
	include	"Actors/12 - Block.asm"
	include	"Actors/19, 1A - Item.asm"
	include	"Actors/1C - Score.asm"
	include	"Score.asm"

marker:
	move.b	userflag(a0),d0
	bmi.w	loc_209DD4
	bra.w	loc_209C32

obj14:
	move.b	userflag(a0),d0
	bmi.w	loc_209F7C
	bra.w	loc_20A18E

obj15:
	move.b	userflag(a0),d0
	bmi.w	loc_20A51E
	bra.w	loc_20A3A0

obj16:
	move.b	userflag(a0),d0
	bmi.w	loc_20A814
	bra.w	loc_20A702

obj22:
	move.b	userflag(a0),d0
	bmi.w	loc_20AC58
	bra.w	loc_20A926

	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_209BA4(pc,d0.w),d0
	jmp	off_209BA4(pc,d0.w)

off_209BA4:
	dc.w	loc_209BA8-off_209BA4
	dc.w	loc_209BFC-off_209BA4

loc_209BA8:
	addq.b	#word,r_no0(a0)
	move.l	#off_20B4C8,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	move.w	#$C00,sproffset(a0)
	move.w	#$1400,sproffset(a0)
	move.w	#$24FC,sproffset(a0)
	move.l	playerwk+xposi.w,d0
	addi.l	#$A0000,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi.w,d0
	subi.l	#$320000,d0
	move.l	d0,yposi(a0)
	rts

loc_209BFC:
	move.l	playerwk+xposi.w,d0
	addi.l	#$A0000,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi.w,d0
	subi.l	#$320000,d0
	move.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	lea	off_20B4B6.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209C32:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_209C4C
	tst.b	actflg(a0)
	bmi.s	loc_209C4C
	jsr	actionsub.l
	jmp	frameout_s.l

loc_209C4C:
	move.w	off_209C5A(pc,d0.w),d0
	jsr	off_209C5A(pc,d0.w)
	jmp	frameout_s.l

off_209C5A:
	dc.w	loc_209C66-off_209C5A
	dc.w	loc_209CA2-off_209C5A
	dc.w	loc_209CEA-off_209C5A
	dc.w	loc_209D5C-off_209C5A
	dc.w	loc_209D8A-off_209C5A
	dc.w	loc_209DC0-off_209C5A

loc_209C66:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj13_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#0,d0
	jsr	pa_set.l
	move.b	#1,mstno(a0)
	move.l	xposi(a0),d0
	move.l	d0,act2C(a0)
	rts

loc_209CA2:
	bra.w	loc_209CEA

	move.w	#$2C00,sproffset(a0)
	move.l	xposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	act2C(a0),d1
	addi.w	#$6E,d1
	cmp.w	d0,d1
	bpl.w	loc_209CD2
	move.b	#4,r_no0(a0)

loc_209CD2:
	bsr.w	loc_209D2A
	lea	obj13_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209CEA:
	moveq	#0,d0
	jsr	pa_set.l
	move.l	xposi(a0),d0
	subi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	act2C(a0),d1
	subi.w	#$6E,d1
	cmp.w	d0,d1
	bmi.w	loc_209D12

loc_209D12:
	bsr.w	loc_209D2A
	lea	obj13_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209D2A:
	move.w	playerwk+xposi.w,d1
	move.w	xposi(a0),d0
	move.w	d1,d2
	addi.w	#$32,d1
	subi.w	#$32,d2
	cmp.w	d1,d0
	bpl.w	locret_209D5A
	cmp.w	d2,d0
	bmi.w	locret_209D5A
	move.b	#6,r_no0(a0)
	move.b	#2,mstno(a0)
	move.w	#$32,act2A(a0)

locret_209D5A:
	rts

loc_209D5C:
	move.w	act2A(a0),d0
	subq.w	#1,d0
	move.w	d0,act2A(a0)
	bne.w	loc_209D76
	move.b	#8,r_no0(a0)
	move.b	#3,mstno(a0)

loc_209D76:
	lea	obj13_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209D8A:
	move.l	yposi(a0),d0
	addi.l	#$60000,d0
	move.l	d0,yposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_209DB8
	lea	obj13_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209DB8:
	move.b	#$A,r_no0(a0)
	rts

loc_209DC0:
	lea	obj13_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209DD4:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_209DEE
	tst.b	actflg(a0)
	bmi.s	loc_209DEE
	jsr	actionsub.l
	jmp	frameout_s.l

loc_209DEE:
	move.w	off_209DFC(pc,d0.w),d0
	jsr	off_209DFC(pc,d0.w)
	jmp	frameout_s.l

off_209DFC:
	dc.w	loc_209E08-off_209DFC
	dc.w	loc_209E4A-off_209DFC
	dc.w	loc_209E92-off_209DFC
	dc.w	loc_209F04-off_209DFC
	dc.w	loc_209F32-off_209DFC
	dc.w	loc_209F68-off_209DFC

loc_209E08:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj13b_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	moveq	#0,d0
	jsr	pa_set.l
	move.b	#1,mstno(a0)
	move.l	xposi(a0),d0
	move.l	d0,act2C(a0)
	rts

loc_209E4A:
	bra.w	loc_209E92

	move.w	#$2C00,sproffset(a0)
	move.l	xposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	act2C(a0),d1
	addi.w	#$6E,d1
	cmp.w	d0,d1
	bpl.w	loc_209E7A
	move.b	#4,r_no0(a0)

loc_209E7A:
	bsr.w	sub_209ED2
	lea	obj13b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209E92:
	moveq	#0,d0
	jsr	pa_set.l
	move.l	xposi(a0),d0
	subi.l	#$10000,d0
	move.l	d0,xposi(a0)
	move.w	xposi(a0),d0
	move.w	act2C(a0),d1
	subi.w	#$6E,d1
	cmp.w	d0,d1
	bmi.w	loc_209EBA

loc_209EBA:
	bsr.w	sub_209ED2
	lea	obj13b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_209ED2:
	move.w	playerwk+xposi.w,d1
	move.w	xposi(a0),d0
	move.w	d1,d2
	addi.w	#$32,d1
	subi.w	#$32,d2
	cmp.w	d1,d0
	bpl.w	locret_209F02
	cmp.w	d2,d0
	bmi.w	locret_209F02
	move.b	#6,r_no0(a0)
	move.b	#2,mstno(a0)
	move.w	#$3C,act2A(a0)

locret_209F02:
	rts

loc_209F04:
	move.w	act2A(a0),d0
	subq.w	#1,d0
	move.w	d0,act2A(a0)
	bne.w	loc_209F1E
	move.b	#8,r_no0(a0)
	move.b	#3,mstno(a0)

loc_209F1E:
	lea	obj13b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209F32:
	move.l	yposi(a0),d0
	addi.l	#$60000,d0
	move.l	d0,yposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_209F60
	lea	obj13b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209F60:
	move.b	#$A,r_no0(a0)
	rts

loc_209F68:
	lea	obj13b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_209F7C:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_209F90(pc,d0.w),d0
	jsr	off_209F90(pc,d0.w)
	jmp	frameout_s.l

off_209F90:
	dc.w	loc_209F9A-off_209F90
	dc.w	loc_209FE8-off_209F90
	dc.w	loc_20A11C-off_209F90
	dc.w	loc_20A072-off_209F90
	dc.w	loc_20A11C-off_209F90

loc_209F9A:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj14_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#1,d0
	jsr	pa_set.l
	move.w	#0,act30(a0)
	move.w	#0,act2A(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	move.l	yposi(a0),d0
	move.l	d0,act2C(a0)
	rts

loc_209FE8:
	tst.b	actflg(a0)
	bpl.s	loc_20A06C
	move.b	#0,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	bsr.w	sub_20A0FA
	move.l	xposi(a0),d0
	subi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	act30(a0),d0
	addq.w	#1,d0
	move.w	d0,act30(a0)
	cmpi.w	#$FA,d0
	bne.w	loc_20A040
	move.w	#0,act30(a0)
	move.b	#$60,act32(a0)
	move.b	#4,r_no0(a0)
	rts

loc_20A040:
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A060
	move.w	#0,act2A(a0)
	move.b	#6,r_no0(a0)
	rts

loc_20A060:
	lea	obj14_ani.l,a1
	jsr	patchg.l

loc_20A06C:
	jmp	actionsub.l

loc_20A072:
	tst.b	actflg(a0)
	bpl.s	loc_20A06C
	move.b	#1,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bsr.w	sub_20A0FA
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	move.l	xposi(a0),d0
	addi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	act30(a0),d0
	addq.w	#1,d0
	move.w	d0,act30(a0)
	cmpi.w	#$FA,d0
	bne.w	loc_20A0C8
	move.w	#0,act30(a0)
	move.b	#$60,act32(a0)
	move.b	#8,r_no0(a0)

loc_20A0C8:
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A0E6
	move.w	#0,act2A(a0)
	move.b	#2,r_no0(a0)

loc_20A0E6:
	lea	obj14_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_20A0FA:
	move.w	act2A(a0),d0
	mulu.w	#256,d0
	divu.w	#128,d0
	jsr	sinset.l
	muls.w	#$1C00,d0
	move.l	act2C(a0),d1
	add.l	d0,d1
	move.l	d1,yposi(a0)
	rts

loc_20A11C:
	tst.b	actflg(a0)
	bpl.w	loc_20A06C
	move.b	act32(a0),d0
	subq.w	#1,d0
	move.b	d0,act32(a0)
	beq.w	loc_20A168
	move.l	#$4000,d1
	addi.b	#$30,d0
	andi.b	#$3F,d0
	cmpi.b	#$20,d0
	bpl.w	loc_20A14A
	neg.l	d1

loc_20A14A:
	move.l	yposi(a0),d2
	add.l	d1,d2
	move.l	d2,yposi(a0)
	lea	obj14_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A168:
	move.w	#0,act30(a0)
	move.b	r_no0(a0),d0
	cmpi.b	#4,d0
	beq.w	loc_20A17E
	bra.w	loc_20A186

loc_20A17E:
	move.b	#2,r_no0(a0)
	rts

loc_20A186:
	move.b	#6,r_no0(a0)
	rts

loc_20A18E:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20A1A2(pc,d0.w),d0
	jsr	off_20A1A2(pc,d0.w)
	jmp	frameout_s.l

off_20A1A2:
	dc.w	loc_20A1AC-off_20A1A2
	dc.w	loc_20A1FA-off_20A1A2
	dc.w	loc_20A32E-off_20A1A2
	dc.w	loc_20A286-off_20A1A2
	dc.w	loc_20A32E-off_20A1A2

loc_20A1AC:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj14_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#1,d0
	jsr	pa_set.l
	move.w	#0,act30(a0)
	move.w	#0,act2A(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	move.l	yposi(a0),d0
	move.l	d0,act2C(a0)
	rts

loc_20A1FA:
	tst.b	actflg(a0)
	bpl.w	loc_20A280
	move.b	#0,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bsr.w	sub_20A30C
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	move.l	xposi(a0),d0
	subi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	act30(a0),d0
	addq.w	#1,d0
	move.w	d0,act30(a0)
	cmpi.w	#$1F4,d0
	bne.w	loc_20A254
	move.w	#0,act30(a0)
	move.b	#$60,act32(a0)
	move.b	#4,r_no0(a0)
	rts

loc_20A254:
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A274
	move.w	#0,act2A(a0)
	move.b	#6,r_no0(a0)
	rts

loc_20A274:
	lea	obj14b_ani.l,a1
	jsr	patchg.l

loc_20A280:
	jmp	actionsub.l

loc_20A286:
	tst.b	actflg(a0)
	bpl.s	loc_20A280
	move.b	#1,mstno(a0)
	moveq	#1,d0
	jsr	pa_set.l
	bsr.w	sub_20A30C
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	move.l	xposi(a0),d0
	addi.l	#$8000,d0
	move.l	d0,xposi(a0)
	move.w	act30(a0),d0
	addq.w	#1,d0
	move.w	d0,act30(a0)
	cmpi.w	#$1F4,d0
	bne.w	loc_20A2DC
	move.w	#0,act30(a0)
	move.b	#$60,act32(a0)
	move.b	#8,r_no0(a0)

loc_20A2DC:
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	cmpi.w	#$300,d0
	bne.w	loc_20A2FA
	move.w	#0,act2A(a0)
	move.b	#2,r_no0(a0)

loc_20A2FA:
	lea	obj14b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

sub_20A30C:
	move.w	act2A(a0),d0
	mulu.w	#256,d0
	divu.w	#128,d0
	jsr	sinset.l
	muls.w	#$3800,d0
	move.l	act2C(a0),d1
	add.l	d0,d1
	move.l	d1,yposi(a0)
	rts

loc_20A32E:
	tst.b	actflg(a0)
	bne.w	loc_20A280
	move.b	act32(a0),d0
	subq.w	#1,d0
	move.b	d0,act32(a0)
	beq.w	loc_20A37A
	move.l	#$4000,d1
	addi.b	#$30,d0
	andi.b	#$3F,d0
	cmpi.b	#$20,d0
	bpl.w	loc_20A35C
	neg.l	d1

loc_20A35C:
	move.l	yposi(a0),d2
	add.l	d1,d2
	move.l	d2,yposi(a0)
	lea	obj14b_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A37A:
	move.w	#0,act30(a0)
	move.b	r_no0(a0),d0
	cmpi.b	#4,d0
	beq.w	loc_20A390
	bra.w	loc_20A398

loc_20A390:
	move.b	#2,r_no0(a0)
	rts

loc_20A398:
	move.b	#6,r_no0(a0)
	rts

loc_20A3A0:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_20A3BA
	tst.b	actflg(a0)
	bmi.s	loc_20A3BA
	jsr	actionsub.l
	jmp	frameout_s.l

loc_20A3BA:
	move.w	off_20A3C8(pc,d0.w),d0
	jsr	off_20A3C8(pc,d0.w)
	jmp	frameout_s.l

off_20A3C8:
	dc.w	loc_20A3D0-off_20A3C8
	dc.w	loc_20A404-off_20A3C8
	dc.w	loc_20A43E-off_20A3C8
	dc.w	loc_20A4AE-off_20A3C8

loc_20A3D0:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj15_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#2,d0
	jsr	pa_set.l
	move.b	#0,mstno(a0)
	rts

loc_20A404:
	move.l	yposi(a0),d0
	addi.l	#$20000,d0
	move.l	d0,yposi(a0)
	move.b	#$12,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_20A436
	lea	off_20B11C.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20A436:
	move.b	#4,r_no0(a0)
	rts

loc_20A43E:
	move.b	#$12,sprvsize(a0)
	subi.l	#$10000,xposi(a0)
	moveq	#8,d3
	jsr	emycol_l.l
	tst.b	d1
	bne.w	loc_20A45E
	bra.w	loc_20A498

loc_20A45E:
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A484
	cmpi.w	#7,d1
	bpl.w	loc_20A498
	cmpi.w	#-8,d1
	bmi.w	loc_20A498
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A484:
	lea	off_20B11C.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A498:
	move.b	#6,r_no0(a0)
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	rts
	rts

loc_20A4AE:
	move.b	#$12,sprvsize(a0)
	addi.l	#$10000,xposi(a0)
	moveq	#8,d3
	jsr	emycol_r.l
	tst.b	d1
	bne.w	loc_20A4CE
	bra.w	loc_20A508

loc_20A4CE:
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A4F4
	cmpi.w	#7,d1
	bpl.w	loc_20A508
	cmpi.w	#-8,d1
	bmi.w	loc_20A508
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A4F4:
	lea	off_20B11C.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A508:
	move.b	#4,r_no0(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	rts
	rts

loc_20A51E:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_20A538
	tst.b	actflg(a0)
	bmi.s	loc_20A538
	jsr	actionsub.l
	jmp	frameout_s.l

loc_20A538:
	move.w	off_20A546(pc,d0.w),d0
	jsr	off_20A546(pc,d0.w)
	jmp	frameout_s.l

off_20A546:
	dc.w	loc_20A552-off_20A546
	dc.w	loc_20A58C-off_20A546
	dc.w	loc_20A5C6-off_20A546
	dc.w	loc_20A642-off_20A546
	dc.w	loc_20A686-off_20A546
	dc.w	loc_20A664-off_20A546

loc_20A552:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj15_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#2,d0
	jsr	pa_set.l
	move.b	#1,mstno(a0)
	move.w	#0,act3E(a0)
	rts

loc_20A58C:
	move.l	yposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,yposi(a0)
	move.b	#$12,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_20A5BE
	lea	off_20B11C.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20A5BE:
	move.b	#4,r_no0(a0)
	rts

loc_20A5C6:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$F0,d0
	beq.w	loc_20A634
	move.b	#$12,sprvsize(a0)
	subi.l	#$C000,xposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A60C
	cmpi.w	#7,d1
	bpl.w	loc_20A620
	cmpi.w	#-7,d1
	bmi.w	loc_20A620
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A60C:
	lea	off_20B11C.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A620:
	move.b	#8,r_no0(a0)
	bset	#0,cddat(a0)
	bset	#0,actflg(a0)
	rts

loc_20A634:
	move.w	#0,act3E(a0)
	move.b	#6,r_no0(a0)
	bra.s	loc_20A60C

loc_20A642:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$3C,d0
	beq.w	loc_20A656
	bra.s	loc_20A60C

loc_20A656:
	move.w	#0,act3E(a0)
	move.b	#4,r_no0(a0)
	bra.s	loc_20A60C

loc_20A664:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$3C,d0
	beq.w	loc_20A678
	bra.s	loc_20A60C

loc_20A678:
	move.w	#0,act3E(a0)
	move.b	#8,r_no0(a0)
	bra.s	loc_20A60C

loc_20A686:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$F0,d0
	beq.w	loc_20A6F4
	move.b	#$12,sprvsize(a0)
	addi.l	#$C000,xposi(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A6CC
	cmpi.w	#7,d1
	bpl.w	loc_20A6E0
	cmpi.w	#-7,d1
	bmi.w	loc_20A6E0
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20A6CC:
	lea	off_20B11C.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A6E0:
	move.b	#4,r_no0(a0)
	bclr	#0,cddat(a0)
	bclr	#0,actflg(a0)
	rts

loc_20A6F4:
	move.w	#0,act3E(a0)
	move.b	#$A,r_no0(a0)
	bra.s	loc_20A6CC

loc_20A702:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20A716(pc,d0.w),d0
	jsr	off_20A716(pc,d0.w)
	jmp	frameout_s.l

off_20A716:
	dc.w	loc_20A71E-off_20A716
	dc.w	loc_20A75A-off_20A716
	dc.w	loc_20A7AA-off_20A716
	dc.w	loc_20A802-off_20A716

loc_20A71E:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj16_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#3,d0
	jsr	pa_set.l
	move.l	#-$40000,act2A(a0)
	move.b	#0,mstno(a0)
	rts

loc_20A75A:
	addi.l	#$1000,act2A(a0)
	move.l	yposi(a0),d0
	move.l	act2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	tst.l	d1
	bpl.w	loc_20A79C
	cmpi.l	#-$6000,d1
	bpl.w	loc_20A794

loc_20A780:
	lea	obj16_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A794:
	move.b	#2,mstno(a0)
	bra.s	loc_20A780

loc_20A79C:
	move.b	#4,r_no0(a0)
	move.b	#3,mstno(a0)
	bra.s	loc_20A780

loc_20A7AA:
	addi.l	#$1000,act2A(a0)
	move.l	yposi(a0),d0
	move.l	act2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	move.l	#-$40000,d2
	neg.l	d2
	cmp.l	d2,d1
	bpl.w	loc_20A7EC
	cmpi.l	#$10000,d1
	bpl.w	loc_20A7FA

loc_20A7D8:
	lea	obj16_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A7EC:
	move.b	#6,r_no0(a0)
	move.w	#$C8,act2E(a0)
	rts

loc_20A7FA:
	move.b	#1,mstno(a0)
	bra.s	loc_20A7D8

loc_20A802:
	subq.w	#1,act2E(a0)
	beq.w	loc_20A80C
	rts

loc_20A80C:
	move.b	#0,r_no0(a0)
	rts

loc_20A814:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20A828(pc,d0.w),d0
	jsr	off_20A828(pc,d0.w)
	jmp	frameout_s.l

off_20A828:
	dc.w	loc_20A830-off_20A828
	dc.w	loc_20A86C-off_20A828
	dc.w	loc_20A8BC-off_20A828
	dc.w	loc_20A914-off_20A828

loc_20A830:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj16_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#3,d0
	jsr	pa_set.l
	move.l	#-$60000,act2A(a0)
	move.b	#4,mstno(a0)
	rts

loc_20A86C:
	addi.l	#$2000,act2A(a0)
	move.l	yposi(a0),d0
	move.l	act2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	tst.l	d1
	bpl.w	loc_20A8AE
	cmpi.l	#-$10000,d1
	bpl.w	loc_20A8A6

loc_20A892:
	lea	obj16_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A8A6:
	move.b	#6,mstno(a0)
	bra.s	loc_20A892

loc_20A8AE:
	move.b	#4,r_no0(a0)
	move.b	#7,mstno(a0)
	bra.s	loc_20A892

loc_20A8BC:
	addi.l	#$2000,act2A(a0)
	move.l	yposi(a0),d0
	move.l	act2A(a0),d1
	add.l	d1,d0
	move.l	d0,yposi(a0)
	move.l	#-$60000,d2
	neg.l	d2
	cmp.l	d2,d1
	bpl.w	loc_20A8FE
	cmpi.l	#$10000,d1
	bpl.w	loc_20A90C

loc_20A8EA:
	lea	obj16_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A8FE:
	move.b	#6,r_no0(a0)
	move.w	#$C8,act2E(a0)
	rts

loc_20A90C:
	move.b	#5,mstno(a0)
	bra.s	loc_20A8EA

loc_20A914:
	subq.w	#1,act2E(a0)
	beq.w	loc_20A91E
	rts

loc_20A91E:
	move.b	#0,r_no0(a0)
	rts

loc_20A926:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20A93A(pc,d0.w),d0
	jsr	off_20A93A(pc,d0.w)
	jmp	frameout_s.l

off_20A93A:
	dc.w	loc_20A946-off_20A93A
	dc.w	loc_20A992-off_20A93A
	dc.w	loc_20A9EA-off_20A93A
	dc.w	loc_20AA90-off_20A93A
	dc.w	loc_20ABA4-off_20A93A
	dc.w	loc_20AB36-off_20A93A

loc_20A946:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj22_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	move.w	#$C00,sproffset(a0)
	move.w	#$1400,sproffset(a0)
	move.w	#$24C1,sproffset(a0)
	moveq	#4,d0
	jsr	pa_set.l
	move.w	#0,act3E(a0)
	rts

loc_20A992:
	move.b	#1,mstno(a0)
	move.l	yposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,yposi(a0)
	move.b	#$E,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20A9D0
	bmi.w	loc_20A9D0
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A9D0:
	move.b	#4,r_no0(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20A9EA:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$120,d0
	beq.w	loc_20AA5C
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	move.b	#1,mstno(a0)
	move.b	#$E,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AA3A
	cmpi.w	#7,d1
	bpl.w	loc_20AA5C
	cmpi.w	#-7,d1
	bmi.w	loc_20AA5C
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AA3A:
	move.l	xposi(a0),d0
	subi.l	#$C000,d0
	move.l	d0,xposi(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AA5C:
	move.l	xposi(a0),d0
	addi.l	#$C000,d0
	move.l	d0,xposi(a0)
	move.w	#0,act3E(a0)
	move.b	#$A,r_no0(a0)
	move.b	#2,mstno(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AA90:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$120,d0
	beq.w	loc_20AB02
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	move.b	#1,mstno(a0)
	move.b	#$E,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AAE0
	cmpi.w	#7,d1
	bpl.w	loc_20AB02
	cmpi.w	#-7,d1
	bmi.w	loc_20AB02
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AAE0:
	move.l	xposi(a0),d0
	addi.l	#$C000,d0
	move.l	d0,xposi(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AB02:
	move.w	#0,act3E(a0)
	move.b	#8,r_no0(a0)
	move.b	#2,mstno(a0)
	move.l	xposi(a0),d0
	subi.l	#$C000,d0
	move.l	d0,xposi(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AB36:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$46,d0
	beq.w	loc_20AB82
	cmpi.w	#$5A,d0
	beq.w	loc_20AB9E
	cmpi.w	#$96,d0
	beq.w	loc_20AB8A
	cmpi.w	#$B4,d0
	beq.w	loc_20AB74

loc_20AB60:
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AB74:
	move.w	#0,act3E(a0)
	move.b	#6,r_no0(a0)
	bra.s	loc_20AB60

loc_20AB82:
	move.b	#3,mstno(a0)
	bra.s	loc_20AB60

loc_20AB8A:
	move.b	#2,mstno(a0)
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	bra.s	loc_20AB60

loc_20AB9E:
	bsr.w	sub_20AC12
	bra.s	loc_20AB60

loc_20ABA4:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$46,d0
	beq.w	loc_20ABF0
	cmpi.w	#$5A,d0
	beq.w	loc_20AC0C
	cmpi.w	#$96,d0
	beq.w	loc_20ABF8
	cmpi.w	#$B4,d0
	beq.w	loc_20ABE2

loc_20ABCE:
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20ABE2:
	move.w	#0,act3E(a0)
	move.b	#4,r_no0(a0)
	bra.s	loc_20ABCE

loc_20ABF0:
	move.b	#3,mstno(a0)
	bra.s	loc_20ABCE

loc_20ABF8:
	move.b	#2,mstno(a0)
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	bra.s	loc_20ABCE

loc_20AC0C:
	bsr.w	sub_20AC12
	bra.s	loc_20ABCE

sub_20AC12:
	move.b	#1,d6
	bsr.w	sub_20AC24
	move.b	#2,d6
	bsr.w	sub_20AC24
	rts

sub_20AC24:
	jsr	sub_20B4D8.l
	tst.b	d0
	beq.w	locret_20AC56
	move.b	d6,userflag(a2)
	_move.b	#objid_23,actno(a2)
	move.l	xposi(a0),d1
	addi.l	#0,d1
	move.l	d1,xposi(a2)
	move.l	yposi(a0),d1
	addi.l	#$FFF00000,d1
	move.l	d1,yposi(a2)

locret_20AC56:
	rts

loc_20AC58:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20AC6C(pc,d0.w),d0
	jsr	off_20AC6C(pc,d0.w)
	jmp	frameout_s.l

off_20AC6C:
	dc.w	loc_20AC78-off_20AC6C
	dc.w	loc_20ACC4-off_20AC6C
	dc.w	loc_20AD1C-off_20AC6C
	dc.w	loc_20ADC2-off_20AC6C
	dc.w	loc_20AED6-off_20AC6C
	dc.w	loc_20AE68-off_20AC6C

loc_20AC78:
	move.b	#6,colino(a0)
	addq.b	#word,r_no0(a0)
	move.l	#obj22_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$400,sproffset(a0)
	move.w	#$C00,sproffset(a0)
	move.w	#$1400,sproffset(a0)
	move.w	#$24C1,sproffset(a0)
	moveq	#4,d0
	jsr	pa_set.l
	move.w	#0,act3E(a0)
	rts

loc_20ACC4:
	move.b	#4,mstno(a0)
	move.l	yposi(a0),d0
	addi.l	#$10000,d0
	move.l	d0,yposi(a0)
	move.b	#$E,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AD02
	bmi.w	loc_20AD02
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AD02:
	move.b	#4,r_no0(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AD1C:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$1B0,d0
	beq.w	loc_20AD8E
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	move.b	#4,mstno(a0)
	move.b	#$E,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AD6C
	cmpi.w	#7,d1
	bpl.w	loc_20AD8E
	cmpi.w	#-7,d1
	bmi.w	loc_20AD8E
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AD6C:
	move.l	xposi(a0),d0
	subi.l	#$5000,d0
	move.l	d0,xposi(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AD8E:
	move.l	xposi(a0),d0
	addi.l	#$5000,d0
	move.l	d0,xposi(a0)
	move.w	#0,act3E(a0)
	move.b	#$A,r_no0(a0)
	move.b	#2,mstno(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20ADC2:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$1B0,d0
	beq.w	loc_20AE34
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	move.b	#4,mstno(a0)
	move.b	#$E,sprvsize(a0)
	jsr	emycol_d.l
	tst.w	d1
	beq.w	loc_20AE12
	cmpi.w	#7,d1
	bpl.w	loc_20AE34
	cmpi.w	#-7,d1
	bmi.w	loc_20AE34
	move.w	yposi(a0),d0
	add.w	d1,d0
	move.w	d0,yposi(a0)

loc_20AE12:
	move.l	xposi(a0),d0
	addi.l	#$5000,d0
	move.l	d0,xposi(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AE34:
	move.w	#0,act3E(a0)
	move.b	#8,r_no0(a0)
	move.b	#2,mstno(a0)
	move.l	xposi(a0),d0
	subi.l	#$5000,d0
	move.l	d0,xposi(a0)
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AE68:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$50,d0
	beq.w	loc_20AEB4
	cmpi.w	#$96,d0
	beq.w	loc_20AED0
	cmpi.w	#$BE,d0
	beq.w	loc_20AEBC
	cmpi.w	#$F0,d0
	beq.w	loc_20AEA6

loc_20AE92:
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AEA6:
	move.w	#0,act3E(a0)
	move.b	#6,r_no0(a0)
	bra.s	loc_20AE92

loc_20AEB4:
	move.b	#3,mstno(a0)
	bra.s	loc_20AE92

loc_20AEBC:
	move.b	#2,mstno(a0)
	bset	#0,actflg(a0)
	bset	#0,cddat(a0)
	bra.s	loc_20AE92

loc_20AED0:
	bsr.w	sub_20AF44
	bra.s	loc_20AE92

loc_20AED6:
	move.w	act3E(a0),d0
	addq.w	#1,d0
	move.w	d0,act3E(a0)
	cmpi.w	#$50,d0
	beq.w	loc_20AF22
	cmpi.w	#$96,d0
	beq.w	loc_20AF3E
	cmpi.w	#$BE,d0
	beq.w	loc_20AF2A
	cmpi.w	#$F0,d0
	beq.w	loc_20AF14

loc_20AF00:
	lea	obj22_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20AF14:
	move.w	#0,act3E(a0)
	move.b	#4,r_no0(a0)
	bra.s	loc_20AF00

loc_20AF22:
	move.b	#3,mstno(a0)
	bra.s	loc_20AF00

loc_20AF2A:
	move.b	#2,mstno(a0)
	bclr	#0,actflg(a0)
	bclr	#0,cddat(a0)
	bra.s	loc_20AF00

loc_20AF3E:
	bsr.w	sub_20AF44
	bra.s	loc_20AF00

sub_20AF44:
	move.b	#3,d6
	bsr.w	sub_20AF56
	move.b	#4,d6
	bsr.w	sub_20AF56
	rts

sub_20AF56:
	jsr	sub_20B4D8.l
	tst.b	d0
	beq.w	locret_20AF88
	move.b	d6,userflag(a2)
	_move.b	#objid_23,actno(a2)
	move.l	xposi(a0),d1
	addi.l	#0,d1
	move.l	d1,xposi(a2)
	move.l	yposi(a0),d1
	addi.l	#$FFF00000,d1
	move.l	d1,yposi(a2)

locret_20AF88:
	rts

obj13_ani:
	dc.w	unk_20AF92-obj13_ani
	dc.w	unk_20AF9A-obj13_ani
	dc.w	unk_20AF9E-obj13_ani
	dc.w	unk_20AFAE-obj13_ani
unk_20AF92:
	dc.b	$13
	dc.b	0,1,2,3,4
	dc.b	$FF
	even
unk_20AF9A:
	dc.b	1
	dc.b	0,1
	dc.b	$FF
	even
unk_20AF9E:
	dc.b	6
	dc.b	2,3,4,4,4,4,4,4,4,4,4,4,4
	dc.b	$FF
	even
unk_20AFAE:
	dc.b	0
	dc.b	4
	dc.b	$FF
	even

obj13_map:
	dc.w	byte_20AFBC-obj13_map
	dc.w	byte_20AFC7-obj13_map
	dc.w	byte_20AFD2-obj13_map
	dc.w	byte_20AFE2-obj13_map
	dc.w	byte_20AFF2-obj13_map
byte_20AFBC:
	dc.b	2
	dc.b	$F4,$A,0,0,-8
	dc.b	-4,0,0,9,$F0
byte_20AFC7:
	dc.b	2
	dc.b	-4,9,0,$A,-8
	dc.b	-4,0,0,9,$F0
byte_20AFD2:
	dc.b	3
	dc.b	$F0,6,0,$10,0
	dc.b	8,4,0,$16,$F0
	dc.b	0,0,0,$18,-8
byte_20AFE2:
	dc.b	3
	dc.b	$F0,9,0,$19,-8
	dc.b	0,4,0,$1F,-8
	dc.b	8,0,0,$21,-8
byte_20AFF2:
	dc.b	3
	dc.b	$F0,6,0,$22,$F4
	dc.b	8,0,0,$28,-4
	dc.b	$F0,0,0,$29,4
	even

obj13b_ani:
	dc.w	unk_20B00A-obj13b_ani
	dc.w	unk_20B012-obj13b_ani
	dc.w	unk_20B016-obj13b_ani
	dc.w	unk_20B020-obj13b_ani
unk_20B00A:
	dc.b	$13
	dc.b	0,1,2,3,4
	dc.b	$FF
	even
unk_20B012:
	dc.b	4
	dc.b	0,1
	dc.b	$FF
	even
unk_20B016:
	dc.b	$E
	dc.b	2,3,4,4,4,4,4
	dc.b	$FF
	even
unk_20B020:
	dc.b	0
	dc.b	4
	dc.b	$FF
	even

obj13b_map:
	dc.w	byte_20B02E-obj13b_map
	dc.w	byte_20B039-obj13b_map
	dc.w	byte_20B03F-obj13b_map
	dc.w	byte_20B04F-obj13b_map
	dc.w	byte_20B05F-obj13b_map
byte_20B02E:
	dc.b	2
	dc.b	$F4,$A,0,$2A,-8
	dc.b	-4,1,0,$33,$F0
byte_20B039:
	dc.b	1
	dc.b	-4,$D,0,$35,$F0
byte_20B03F:
	dc.b	3
	dc.b	$F0,6,0,$10,0
	dc.b	0,1,0,$3D,-8
	dc.b	8,0,0,$3F,$F0
byte_20B04F:
	dc.b	3
	dc.b	$F0,9,0,$19,-8
	dc.b	0,4,0,$40,-8
	dc.b	8,0,0,$42,-8
byte_20B05F:
	dc.b	3
	dc.b	$F0,6,0,$43,$F4
	dc.b	8,0,0,$49,-4
	dc.b	$F0,0,0,$29,4
	even

obj14b_ani:
	dc.w	unk_20B07A-obj14b_ani
	dc.w	unk_20B082-obj14b_ani
	dc.b	$13
	dc.b	0,1,2,1
	dc.b	$FF
	even
unk_20B07A:
	dc.b	4
	dc.b	0,0,1,2,1
	dc.b	$FF
	even
unk_20B082:
	dc.b	4
	dc.b	3,3,4,5,4
	dc.b	$FF
	even

obj14_map:
	dc.w	byte_20B096-obj14_map
	dc.w	byte_20B0A6-obj14_map
	dc.w	byte_20B0B6-obj14_map
	dc.w	byte_20B096-obj14_map
	dc.w	byte_20B0A6-obj14_map
	dc.w	byte_20B0B6-obj14_map
byte_20B096:
	dc.b	3
	dc.b	$F0,8,0,0,-8
	dc.b	-8,$D,0,3,$F0
	dc.b	8,8,0,$B,$F0
	even
byte_20B0A6:
	dc.b	3
	dc.b	-8,9,0,$E,$F0
	dc.b	0,0,0,$14,8
	dc.b	8,0,0,$15,0
	even
byte_20B0B6:
	dc.b	3
	dc.b	$F0,0,0,$16,$F0
	dc.b	-8,8,0,$17,$F0
	dc.b	0,$D,0,$1A,$F0
	even

obj14_ani:
	dc.w	unk_20B0D0-obj14_ani
	dc.w	unk_20B0D8-obj14_ani
	dc.b	$13
	dc.b	0,1,2,1
	dc.b	$FF
	even
unk_20B0D0:
	dc.b	4
	dc.b	0,0,1,2,1
	dc.b	$FF
	even
unk_20B0D8:
	dc.b	4
	dc.b	3,3,4,5,4
	dc.b	$FF
	even

off_20B0E0:
	dc.w	byte_20B0EC-off_20B0E0
	dc.w	byte_20B0FC-off_20B0E0
	dc.w	byte_20B10C-off_20B0E0
	dc.w	byte_20B0EC-off_20B0E0
	dc.w	byte_20B0FC-off_20B0E0
	dc.w	byte_20B10C-off_20B0E0
byte_20B0EC:
	dc.b	3
	dc.b	$F0,8,0,0,-8
	dc.b	-8,$D,0,$22,$F0
	dc.b	8,8,0,$B,$F0
	even
byte_20B0FC:
	dc.b	3
	dc.b	-8,9,0,$E,$F0
	dc.b	0,0,0,$14,8
	dc.b	8,0,0,$15,0
	even
byte_20B10C:
	dc.b	3
	dc.b	$F0,0,0,$16,$F0
	dc.b	-8,8,0,$17,$F0
	dc.b	0,$D,0,$2A,$F0
	even

off_20B11C:
	dc.w	unk_20B132-off_20B11C
	dc.w	unk_20B136-off_20B11C
	dc.w	unk_20B12E-off_20B11C
	dc.w	unk_20B124-off_20B11C
unk_20B124:
	dc.b	$13
	dc.b	0,1,2,3,4,5,6,7
	dc.b	$FF
	even
unk_20B12E:
	dc.b	$13
	dc.b	0
	dc.b	$FF
	even
unk_20B132:
	dc.b	3
	dc.b	6,7
	dc.b	$FF
	even
unk_20B136:
	dc.b	3
	dc.b	8,9
	dc.b	$FF
	even

obj15_map:
	dc.w	byte_20B1B6-obj15_map
	dc.w	byte_20B1C6-obj15_map
	dc.w	byte_20B1CC-obj15_map
	dc.w	byte_20B1D2-obj15_map
	dc.w	byte_20B1D8-obj15_map
	dc.w	byte_20B1DE-obj15_map
	dc.w	byte_20B14E-obj15_map
	dc.w	byte_20B168-obj15_map
	dc.w	byte_20B182-obj15_map
	dc.w	byte_20B19C-obj15_map
byte_20B14E:
	dc.b	5
	dc.b	$EA,5,0,0,$F4
	dc.b	$FA,0,0,4,$F4
	dc.b	$FA,5,0,5,-4
	dc.b	2,5,0,9,-8
	dc.b	$FA,0,0,$11,$E
	even
byte_20B168:
	dc.b	5
	dc.b	$EB,5,0,0,$F4
	dc.b	$FB,0,0,4,$F4
	dc.b	$FB,5,0,5,-4
	dc.b	2,5,0,$D,-8
	dc.b	$FA,0,0,$11,$12
	even
byte_20B182:
	dc.b	5
	dc.b	$EA,5,0,$12,$F4
	dc.b	$FA,0,0,4,$F4
	dc.b	$FA,5,0,5,-4
	dc.b	2,5,0,9,-8
	dc.b	$FA,0,0,$11,$E
	even
byte_20B19C:
	dc.b	5
	dc.b	$EB,5,0,$12,$F4
	dc.b	$FB,0,0,4,$F4
	dc.b	$FB,5,0,5,-4
	dc.b	2,5,0,$D,-8
	dc.b	$FA,0,0,$11,$12
	even
byte_20B1B6:
	dc.b	3
	dc.b	$F0,5,0,0,$F4
	dc.b	0,0,0,4,$F4
	dc.b	0,5,0,5,-4
	even
byte_20B1C6:
	dc.b	1
	dc.b	-8,5,0,9,-8
	even
byte_20B1CC:
	dc.b	1
	dc.b	-8,5,0,$D,-8
	even
byte_20B1D2:
	dc.b	1
	dc.b	-4,0,0,$11,-4
	even
byte_20B1D8:
	dc.b	1
	dc.b	-4,0,0,$11,0
	even
byte_20B1DE:
	dc.b	3
	dc.b	$F0,5,0,$12,$F4
	dc.b	0,0,0,4,$F4
	dc.b	0,5,0,5,-4
	even

obj16_ani:
	dc.w	unk_20B202-obj16_ani
	dc.w	unk_20B206-obj16_ani
	dc.w	unk_20B20A-obj16_ani
	dc.w	unk_20B20E-obj16_ani
	dc.w	unk_20B212-obj16_ani
	dc.w	unk_20B216-obj16_ani
	dc.w	unk_20B21A-obj16_ani
	dc.w	unk_20B21E-obj16_ani
	dc.w	unk_20B222-obj16_ani
	dc.w	unk_20B22A-obj16_ani
unk_20B202:
	dc.b	9
	dc.b	6,7
	dc.b	$FF
	even
unk_20B206:
	dc.b	9
	dc.b	8,9
	dc.b	$FF
	even
unk_20B20A:
	dc.b	$27
	dc.b	$A
	dc.b	$FF
	even
unk_20B20E:
	dc.b	$27
	dc.b	$B
	dc.b	$FF
	even
unk_20B212:
	dc.b	9
	dc.b	6,7
	dc.b	$FF
	even
unk_20B216:
	dc.b	9
	dc.b	$C,$D
	dc.b	$FF
	even
unk_20B21A:
	dc.b	$27
	dc.b	$A
	dc.b	$FF
	even
unk_20B21E:
	dc.b	$27
	dc.b	$E
	dc.b	$FF
	even
unk_20B222:
	dc.b	$27
	dc.b	0,1,2,3,4,5
	dc.b	$FF
	even
unk_20B22A:
	dc.b	9
	dc.b	6,7,6,7,6,7,$A,$A,$B,$B,8,9,9,8,9,8,9
	dc.b	$FF
	even

obj16_map:
	dc.w	byte_20B25C-obj16_map
	dc.w	byte_20B271-obj16_map
	dc.w	byte_20B286-obj16_map
	dc.w	byte_20B29B-obj16_map
	dc.w	byte_20B2B0-obj16_map
	dc.w	byte_20B2BB-obj16_map
	dc.w	byte_20B2F0-obj16_map
	dc.w	byte_20B310-obj16_map
	dc.w	byte_20B330-obj16_map
	dc.w	byte_20B350-obj16_map
	dc.w	byte_20B370-obj16_map
	dc.w	byte_20B386-obj16_map
	dc.w	byte_20B39B-obj16_map
	dc.w	byte_20B3BA-obj16_map
	dc.w	byte_20B3D9-obj16_map
byte_20B25C:
	dc.b	4
	dc.b	$F0,3,0,0,-8
	dc.b	-8,0,0,4,$F0
	dc.b	$F0,3,8,0,0
	dc.b	-8,0,8,4,8
byte_20B271:
	dc.b	4
	dc.b	$F0,6,0,5,$F0
	dc.b	8,0,0,$B,-8
	dc.b	$F0,6,8,5,0
	dc.b	8,0,8,$B,0
byte_20B286:
	dc.b	4
	dc.b	-8,6,0,$C,$F0
	dc.b	$F0,0,0,$12,-8
	dc.b	-8,6,8,$C,0
	dc.b	$F0,0,8,$12,0
byte_20B29B:
	dc.b	4
	dc.b	$F0,3,0,$13,-8
	dc.b	0,0,$10,4,$F0
	dc.b	$F0,3,8,$13,0
	dc.b	0,0,$18,4,8
byte_20B2B0:
	dc.b	2
	dc.b	$F4,6,0,$17,$F0
	dc.b	$F4,6,8,$17,0
byte_20B2BB:
	dc.b	2
	dc.b	$F4,6,0,$1D,$F0
	dc.b	$F4,6,8,$1D,0

	dc.b	4
	dc.b	-8,6,0,$23,$F0
	dc.b	$F0,0,0,$29,-8
	dc.b	-8,6,8,$23,0
	dc.b	$F0,0,8,$29,0

	dc.b	4
	dc.b	$F0,3,0,$2A,-8
	dc.b	0,0,$10,4,$F0
	dc.b	$F0,3,8,$2A,0
	dc.b	0,0,$18,4,8

byte_20B2F0:
	dc.b	6
	dc.b	$F0,3,0,0,-8
	dc.b	-8,0,0,4,$F0
	dc.b	$F0,3,8,0,0
	dc.b	-8,0,8,4,8
	dc.b	$E5,6,0,$17,$F0
	dc.b	$E5,6,8,$17,0
	even
byte_20B310:
	dc.b	6
	dc.b	$F0,3,0,0,-8
	dc.b	-8,0,0,4,$F0
	dc.b	$F0,3,8,0,0
	dc.b	-8,0,8,4,8
	dc.b	$E5,6,0,$1D,$F0
	dc.b	$E5,6,8,$1D,0
	even
byte_20B330:
	dc.b	6
	dc.b	$F0,3,0,$13,-8
	dc.b	0,0,$10,4,$F0
	dc.b	$F0,3,8,$13,0
	dc.b	0,0,$18,4,8
	dc.b	3,6,$10,$17,$F0
	dc.b	3,6,$18,$17,0
	even
byte_20B350:
	dc.b	6
	dc.b	$F0,3,0,$13,-8
	dc.b	0,0,$10,4,$F0
	dc.b	$F0,3,8,$13,0
	dc.b	0,0,$18,4,8
	dc.b	3,6,$10,$1D,$F0
	dc.b	3,6,$18,$1D,0
	even
byte_20B370:
	dc.b	4
	dc.b	$F0,6,0,5,$F0
	dc.b	8,0,0,$B,-8
	dc.b	$F0,6,8,5,0
	dc.b	8,0,8,$B,0
	even
byte_20B386:
	dc.b	4
	dc.b	-8,6,0,$C,$F0
	dc.b	$F0,0,0,$12,-8
	dc.b	-8,6,8,$C,0
	dc.b	$F0,0,8,$12,0
byte_20B39B:
	dc.b	6
	dc.b	$F0,3,0,$2A,-8
	dc.b	0,0,$10,4,$F0
	dc.b	$F0,3,8,$2A,0
	dc.b	0,0,$18,4,8
	dc.b	3,6,$10,$17,$F0
	dc.b	3,6,$18,$17,0
	even
byte_20B3BA:
	dc.b	6
	dc.b	$F0,3,0,$2A,-8
	dc.b	0,0,$10,4,$F0
	dc.b	$F0,3,8,$2A,0
	dc.b	0,0,$18,4,8
	dc.b	3,6,$10,$1D,$F0
	dc.b	3,6,$18,$1D,0
byte_20B3D9:
	dc.b	4
	dc.b	-8,6,0,$23,$F0
	dc.b	$F0,0,0,$29,-8
	dc.b	-8,6,8,$23,0
	dc.b	$F0,0,8,$29,0
	even

obj22_ani:
	dc.w	unk_20B3F8-obj22_ani
	dc.w	unk_20B434-obj22_ani
	dc.w	unk_20B43A-obj22_ani
	dc.w	unk_20B43E-obj22_ani
	dc.w	unk_20B442-obj22_ani
unk_20B3F8:
	dc.b	$13
	dc.b	0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,5
	dc.b	7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,5
	dc.b	0,1,2,3,4,5,6,7
	dc.b	$FF
	even
unk_20B434:
	dc.b	$13
	dc.b	0,1,0,1
	dc.b	$FF
	even
unk_20B43A:
	dc.b	$13
	dc.b	0,0
	dc.b	$FF
	even
unk_20B43E:
	dc.b	9
	dc.b	2,2
	dc.b	$FF
	even
unk_20B442:
	dc.b	5
	dc.b	1,7,1,7
	dc.b	$FF
	even

obj22_map:
	dc.w	byte_20B458-obj22_map
	dc.w	byte_20B46D-obj22_map
	dc.w	byte_20B482-obj22_map
	dc.w	byte_20B48D-obj22_map
	dc.w	byte_20B493-obj22_map
	dc.w	byte_20B499-obj22_map
	dc.w	byte_20B49F-obj22_map
	dc.w	byte_20B4A5-obj22_map
byte_20B458:
	dc.b	4
	dc.b	$F0,9,0,0,-8
	dc.b	0,9,0,6,-8
	dc.b	-8,0,0,$C,$F0
	dc.b	0,0,0,$D,$F0
byte_20B46D:
	dc.b	4
	dc.b	$F1,9,0,0,-8
	dc.b	1,9,0,$E,-8
	dc.b	$F9,0,0,$C,$F0
	dc.b	1,0,0,$D,$F0
byte_20B482:
	dc.b	2
	dc.b	$F0,8,0,$14,-8
	dc.b	-8,$E,0,$17,$F0
byte_20B48D:
	dc.b	1
	dc.b	-4,0,0,$23,-4
byte_20B493:
	dc.b	1
	dc.b	-4,0,0,$24,-4
byte_20B499:
	dc.b	1
	dc.b	-8,5,0,$25,-8
byte_20B49F:
	dc.b	1
	dc.b	-8,5,0,$29,-8
byte_20B4A5:
	dc.b	3
	dc.b	$EF,9,0,$2D,-8
	dc.b	$F7,0,0,$C,$F0
	dc.b	$FF,$D,0,$33,$F0
	even

off_20B4B6:
	dc.w	unk_20B4BC-off_20B4B6
	dc.w	unk_20B4C0-off_20B4B6
	dc.w	unk_20B4C4-off_20B4B6
unk_20B4BC:
	dc.b	$1D
	dc.b	0,1
	dc.b	$FF
	even
unk_20B4C0:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20B4C4:
	dc.b	0
	dc.b	1
	dc.b	$FF
	even

off_20B4C8:
	dc.w	byte_20B4CC-off_20B4C8
	dc.w	byte_20B4D2-off_20B4C8
byte_20B4CC:
	dc.b	1
	dc.b	-8,5,0,0,-8
byte_20B4D2:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even

	include	"Actors/23.asm"

	movea.l	a0,a1
	moveq	#actfree-1,d0
	moveq	#0,d1

loc_20B5CE:
	move.b	d1,(a1)+
	dbf	d0,loc_20B5CE

	rts

random:
	move.l	d1,-(sp)
	move.l	ranum.w,d1
	bne.s	loc_20B5E4
	move.l	#$2A6D365A,d1

loc_20B5E4:
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
	move.l	d1,ranum.w
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
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	move.w	#$47A,sproffset(a0)
	move.l	playerwk+xposi.w,d0
	addi.l	#$32,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi.w,d0
	addi.l	#$320000,d0
	move.l	d0,yposi(a0)
	rts

loc_20B654:
	move.l	playerwk+xposi.w,d0
	addi.l	#$320000,d0
	move.l	d0,xposi(a0)
	move.l	playerwk+yposi.w,d0
	subi.l	#$320000,d0
	move.l	d0,yposi(a0)
	lea	obj26_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

sub_20B684:
	lea	playerwk.w,a1
	move.w	yspeed(a1),d1
	bmi.w	loc_20B694
	bra.w	loc_20B6EC

loc_20B694:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

	lea	playerwk.w,a1
	move.w	yspeed(a1),d1
	bpl.w	loc_20B6AE
	bra.w	loc_20B6EC

loc_20B6AE:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

	lea	playerwk.w,a1
	move.w	xspeed(a1),d1
	bmi.w	loc_20B6C8
	bra.w	loc_20B6EC

loc_20B6C8:
	moveq	#0,d1
	bclr	#3,cddat(a0)
	rts

	lea	playerwk.w,a1
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
	lea	playerwk.w,a1
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
	dc.b	8,$F8,$10,$F0
	dc.b	8,$F8,$18,$E8
	dc.b	$10,$F0,8,1
	dc.b	$10,$F0,0,$F8
	dc.b	$10,$F0,$10,$F0
	dc.b	8,$F8,$10,$C0
	dc.b	$17,$E9,$10,$F0
	dc.b	8,$F8,8,$F8
	dc.b	$10,$F0,$10,$F0
	dc.b	$10,$F0,$40,$C0
byte_20B806:
	dc.b	$10,$F0,$10,$F0
byte_20B80A:
	dc.b	$10,$F0,$10,$F0
byte_20B80E:
	dc.b	$10,$F0,$10,$F0

obj28:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20B826(pc,d0.w),d0
	jsr	off_20B826(pc,d0.w)
	jmp	frameout_s.l

off_20B826:
	dc.w	loc_20B834-off_20B826
	dc.w	loc_20B888-off_20B826
	dc.w	loc_20B8C8-off_20B826
	dc.w	loc_20B9B4-off_20B826
	dc.w	loc_20B908-off_20B826
	dc.w	loc_20B9FC-off_20B826
	dc.w	loc_20B950-off_20B826

loc_20B834:
	move.l	#act28pat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#7,d0
	jsr	pa_set(pc)
	move.b	#$18,sprhs(a0)
	move.b	#4,sprvsize(a0)
	move.b	userflag(a0),d0
	cmpi.b	#1,d0
	beq.w	loc_20B87A
	move.b	#3,mstno(a0)
	move.b	#2,r_no0(a0)
	rts

loc_20B87A:
	move.b	#4,mstno(a0)
	move.b	#4,r_no0(a0)
	rts

loc_20B888:
	moveq	#5,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B8B6
	lea	playerwk.w,a1
	move.l	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)
	move.b	#$A,r_no0(a0)
	move.b	#3,mstno(a0)

loc_20B8B6:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B8C8:
	moveq	#3,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B8F6
	lea	playerwk.w,a1
	move.l	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	swap	d1
	sub.l	d1,d0
	move.l	d0,yposi(a1)
	move.b	#$C,r_no0(a0)
	move.b	#4,mstno(a0)

loc_20B8F6:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B908:
	moveq	#3,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B926
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B926:
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	btst	#cd_walk,cddat(a1)
	bne.w	loc_20B942
	rts

loc_20B942:
	move.w	#$64,act2A(a0)
	move.b	#$C,r_no0(a0)
	rts

loc_20B950:
	move.b	#2,mstno(a0)
	moveq	#4,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B986
	lea	playerwk.w,a1
	move.w	yspeed(a1),d0
	addi.w	#$100,d0
	cmpi.w	#$A00,d0
	bmi.w	loc_20B97A
	move.w	#$A00,d0

loc_20B97A:
	neg.w	d0
	move.w	d0,yspeed(a1)
	move.w	#$64,act2A(a0)

loc_20B986:
	move.w	act2A(a0),d0
	subq.w	#1,d0
	move.w	d0,act2A(a0)
	bne.w	loc_20B9A2
	move.b	#4,r_no0(a0)
	move.b	#4,mstno(a0)
	rts

loc_20B9A2:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B9B4:
	moveq	#5,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20B9D2
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20B9D2:
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	move.b	#2,r_no0(a0)
	btst	#cd_walk,cddat(a1)
	bne.w	loc_20B9EE
	rts

loc_20B9EE:
	move.w	#$64,act2A(a0)
	move.b	#$A,r_no0(a0)
	rts

loc_20B9FC:
	move.b	#1,mstno(a0)
	moveq	#6,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BA32
	lea	playerwk.w,a1
	move.w	yspeed(a1),d0
	addi.w	#$100,d0
	cmpi.w	#$A00,d0
	bmi.w	loc_20BA26
	move.w	#$A00,d0

loc_20BA26:
	neg.w	d0
	move.w	d0,yspeed(a1)
	move.w	#$64,act2A(a0)

loc_20BA32:
	move.w	act2A(a0),d0
	subq.w	#1,d0
	move.w	d0,act2A(a0)
	bne.w	loc_20BA4E
	move.b	#2,r_no0(a0)
	move.b	#3,mstno(a0)
	rts

loc_20BA4E:
	lea	obj28_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

obj27:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20BA74(pc,d0.w),d0
	jsr	off_20BA74(pc,d0.w)
	jmp	frameout_s.l

off_20BA74:
	dc.w	loc_20BA7C-off_20BA74
	dc.w	loc_20BAA2-off_20BA74
	dc.w	loc_20BAE4-off_20BA74
	dc.w	loc_20BBA8-off_20BA74

loc_20BA7C:
	addq.b	#word,r_no0(a0)
	move.l	#act27pat,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#8,d0
	jsr	pa_set(pc)
	rts

loc_20BAA2:
	tst.b	actflg(a0)
	bpl.w	loc_20BADE
	moveq	#9,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BAD2
	lea	playerwk.w,a1
	bclr	#cd_walk,cddat(a1)
	bset	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	move.w	#0,act2A(a0)

loc_20BAD2:
	lea	obj27_ani.l,a1
	jsr	patchg.l

loc_20BADE:
	jmp	actionsub.l

loc_20BAE4:
	tst.b	actflg(a0)
	bpl.s	loc_20BADE
	moveq	#7,d0
	bsr.w	sub_20B684
	tst.b	d1
	bne.w	loc_20BB0C
	lea	playerwk.w,a1
	bclr	#cd_ride,cddat(a1)
	move.b	#6,r_no0(a0)
	move.w	#0,act2A(a0)

loc_20BB0C:
	lea	playerwk.w,a1
	move.w	xposi(a0),d2
	move.w	xposi(a1),d3
	move.w	xspeed(a1),d4
	beq.w	loc_20BB3C
	bmi.w	loc_20BB28
	bpl.w	loc_20BB32

loc_20BB28:
	cmp.w	d2,d3
	bpl.w	loc_20BB4A
	bra.w	loc_20BB3C

loc_20BB32:
	cmp.w	d2,d3
	bmi.w	loc_20BB4A
	bra.w	loc_20BB3C

loc_20BB3C:
	move.l	yposi(a1),d0
	addi.l	#$8000,d0
	move.l	d0,yposi(a1)

loc_20BB4A:
	moveq	#0,d0
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	lea	loc_20BC80.l,a3
	lea	unk_20BC1E.l,a2
	move.w	xposi(a0),d2
	move.w	xposi(a1),d3
	cmp.w	d2,d3
	bmi.w	loc_20BB7C
	lea	unk_20BC34.l,a2
	lea	loc_20BC80.l,a3

loc_20BB7C:
	divu.w	#2,d0
	move.b	(a2,d0.w),d1
	move.b	d1,mstno(a0)
	cmpi.b	#6,d1
	bne.w	loc_20BB96
	bclr	#cd_ride,cddat(a1)

loc_20BB96:
	lea	obj27_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20BBA8:
	tst.b	actflg(a0)
	bne.w	loc_20BADE
	moveq	#9,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20BBD8
	lea	playerwk.w,a1
	bclr	#cd_walk,cddat(a1)
	bset	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	move.w	#0,act2A(a0)

loc_20BBD8:
	lea	unk_20BC4A.l,a2
	move.w	act2A(a0),d0
	addq.w	#1,d0
	move.w	d0,act2A(a0)
	move.b	(a2,d0.w),d1
	bmi.w	loc_20BC06
	move.b	d1,mstno(a0)
	lea	obj27_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20BC06:
	move.b	#2,r_no0(a0)
	lea	obj27_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

unk_20BC1E:
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	4
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
unk_20BC34:
	dc.b	7
	dc.b	7
	dc.b	8
	dc.b	8
	dc.b	9
	dc.b	9
	dc.b	$A
	dc.b	$A
	dc.b	$B
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	0
unk_20BC4A:
	dc.b	0
	dc.b	5
	dc.b	4
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	0
	dc.b	$D
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	$B
	dc.b	$A
	dc.b	9
	dc.b	8
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	$D
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	9
	dc.b	8
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	$D
	dc.b	7
	dc.b	8
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	2
	dc.b	1
	dc.b	$D
	dc.b	7
	dc.b	$D
	dc.b	1
	dc.b	$D
	dc.b	$FF
	even

loc_20BC80:
	move.w	xposi(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	blo.s	locret_20BCA2
	jmp	frameout.l

locret_20BCA2:
	rts

	include	"Actors/25 - Hashi.asm"
	include	"Actors/26.asm"

obj29:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20C8C2(pc,d0.w),d0
	jmp	off_20C8C2(pc,d0.w)

off_20C8C2:
	dc.w	loc_20C8CA-off_20C8C2
	dc.w	loc_20C9AC-off_20C8C2
	dc.w	loc_20CB98-off_20C8C2
	dc.w	loc_20CC02-off_20C8C2

loc_20C8CA:
	addq.b	#word,r_no0(a0)
	move.l	#obj29_map,patbase(a0)
	move.b	#4,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#$10,sprhsize(a0)
	moveq	#$11,d0
	jsr	pa_set.l
	move.b	act3D(a0),d0
	bne.s	loc_20C92E
	move.b	userflag(a0),d6
	andi.w	#$F,d6
	jsr	sub_20C93C(pc)
	move.b	act3D(a1),d0
	ori.b	#$80,d0
	move.b	d0,act3D(a1)
	movea.w	a2,a4
	subq.w	#1,d6

loc_20C912:
	jsr	sub_20C93C(pc)
	subq.w	#1,d6
	bne.s	loc_20C912
	move.b	userflag(a0),d0
	andi.b	#$70,d0
	cmpi.b	#$70,d0
	bne.s	locret_20C92C
	jsr	sub_20C966(pc)

locret_20C92C:
	rts

loc_20C92E:
	move.b	act3D(a0),d0
	bpl.s	locret_20C93A
	move.b	#4,r_no0(a0)

locret_20C93A:
	rts

sub_20C93C:
	jsr	actwkchk.l
	bne.s	locret_20C964
	move.b	userflag(a0),userflag(a1)
	_move.b	#objid_29,actno(a1)
	move.w	a0,act3E(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	d6,act3D(a1)

locret_20C964:
	rts

sub_20C966:
	jsr	actwkchk.l
	bne.s	locret_20C964
	_move.b	#marker_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.w	a4,act3E(a1)
	move.b	#1,act3D(a1)
	rts

unk_20C98C:
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	dc.b	2
	even

loc_20C9AC:
	moveq	#0,d0
	move.b	act3D(a0),d0
	lea	unk_20C98C.l,a3
	move.b	(a3,d0.w),d2
	move.b	d2,mstno(a0)
	tst.b	d0
	beq.s	loc_20C9DA
	jsr	sub_20CB40(pc)
	lea	obj29_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l

loc_20C9DA:
	moveq	#0,d0
	move.b	userflag(a0),d0
	andi.w	#$F0,d0
	asr.w	#2,d0
	lea	off_20CA06.l,a3
	movea.l	(a3,d0.w),a4
	jsr	(a4)
	lea	obj29_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

off_20CA06:
	dc.l	loc_20CA26
	dc.l	loc_20CA32
	dc.l	loc_20CA3E
	dc.l	loc_20CA6E
	dc.l	loc_20CA9E
	dc.l	loc_20CAD4
	dc.l	loc_20CB0A
	dc.l	loc_20CA32

loc_20CA26:
	move.b	act3C(a0),d0
	addq.w	#1,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA32:
	move.b	act3C(a0),d0
	subq.w	#1,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA3E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,act32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20CA58
	bmi.w	loc_20CA62

loc_20CA58:
	addi.w	#$40,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA62:
	not.w	d0
	addi.w	#$40,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA6E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	andi.w	#$FF,d0
	move.w	d0,act32(a0)
	cmpi.w	#$80,d0
	bpl.w	loc_20CA88
	bmi.w	loc_20CA92

loc_20CA88:
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA92:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CA9E:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$300,d0
	bmi.w	loc_20CAAE
	moveq	#0,d0

loc_20CAAE:
	move.w	d0,act32(a0)
	cmpi.w	#$180,d0
	bpl.w	loc_20CABE
	bmi.w	loc_20CAC8

loc_20CABE:
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CAC8:
	not.w	d0
	addi.w	#$C0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CAD4:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$200,d0
	bmi.w	loc_20CAE4
	moveq	#0,d0

loc_20CAE4:
	move.w	d0,act32(a0)
	cmpi.w	#$100,d0
	bpl.w	loc_20CAF4
	bmi.w	loc_20CAFE

loc_20CAF4:
	addi.w	#$80,d0
	move.b	d0,act3C(a0)
	rts

loc_20CAFE:
	addi.w	#$80,d0
	not.w	d0
	move.b	d0,act3C(a0)
	rts

loc_20CB0A:
	move.w	act32(a0),d0
	addq.w	#1,d0
	cmpi.w	#$80,d0
	bmi.w	loc_20CB1A
	moveq	#0,d0

loc_20CB1A:
	move.w	d0,act32(a0)
	cmpi.w	#$40,d0
	bpl.w	loc_20CB2A
	bmi.w	loc_20CB34

loc_20CB2A:
	addi.w	#$A0,d0
	move.b	d0,act3C(a0)
	rts

loc_20CB34:
	addi.w	#$E0,d0
	not.w	d0
	move.b	d0,act3C(a0)
	rts

sub_20CB40:
	move.l	xposi(a0),act38(a0)
	move.l	yposi(a0),act34(a0)
	movea.w	act3E(a0),a2
	moveq	#0,d0
	move.b	act3C(a2),d0
	jsr	sinset.l
	moveq	#0,d3
	move.b	act3D(a0),d3
	andi.w	#$F,d3
	mulu.w	#$100,d3
	muls.w	d3,d0
	asl.l	#4,d0
	move.l	d0,d4
	move.l	xposi(a2),d2
	add.l	d0,d2
	move.l	d2,xposi(a0)
	muls.w	d3,d1
	asl.l	#4,d1
	move.l	d1,d5
	move.l	yposi(a2),d2
	add.l	d1,d2
	move.l	d2,yposi(a0)
	asr.l	#8,d4
	asr.l	#8,d5
	move.w	d4,xspeed(a2)
	move.w	d5,yspeed(a2)
	rts

loc_20CB98:
	move.b	#3,mstno(a0)
	bsr.s	sub_20CB40
	move.b	#$18,sprhsize(a0)
	move.b	#8,sprvsize(a0)
	move.b	#8,sprvsize(a0)
	lea	playerwk.w,a1
	bsr.w	sub_20B684
	beq.w	loc_20CBEE
	bsr.w	sub_20CC4C
	bne.w	loc_20CBEE
	move.w	yposi(a0),d0
	moveq	#0,d1
	move.b	sprvsize(a1),d1
	sub.w	d1,d0
	move.b	sprvsize(a0),d1
	sub.w	d1,d0
	move.w	d0,yposi(a1)
	bset	#cd_ride,cddat(a1)
	bclr	#cd_jump,cddat(a1)
	move.b	#6,r_no0(a0)

loc_20CBEE:
	lea	obj29_ani.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20CC02:
	move.b	#3,mstno(a0)
	bsr.w	sub_20CB40
	lea	playerwk.w,a1
	moveq	#$10,d0
	bsr.w	sub_20B684
	tst.b	d1
	beq.w	loc_20CC3E
	move.l	xposi(a0),d0
	sub.l	act38(a0),d0
	add.l	xposi(a1),d0
	move.l	d0,xposi(a1)
	move.l	yposi(a0),d0
	sub.l	act34(a0),d0
	add.l	yposi(a1),d0
	move.l	d0,yposi(a1)
	bra.s	loc_20CBEE

loc_20CC3E:
	bclr	#cd_ride,cddat(a1)
	move.b	#4,r_no0(a0)
	bra.s	loc_20CBEE

sub_20CC4C:
	lea	playerwk.w,a1
	moveq	#0,d2
	moveq	#0,d3
	move.b	sprvsize(a0),d2
	move.b	sprvsize(a1),d3
	move.w	yposi(a0),d0
	move.w	yposi(a1),d1
	add.w	d2,d0
	add.w	d3,d1
	cmp.w	d0,d1
	bpl.w	loc_20CC72
	bmi.w	loc_20CC76

loc_20CC72:
	moveq	#-1,d1
	rts

loc_20CC76:
	moveq	#0,d1
	rts

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

obj28_ani:
	dc.w	unk_20CCC0-obj28_ani
	dc.w	unk_20CCD0-obj28_ani
	dc.w	unk_20CCDA-obj28_ani
	dc.w	unk_20CCE4-obj28_ani
	dc.w	unk_20CCE8-obj28_ani
unk_20CCC0:
	dc.b	2
	dc.b	0,1,0,2,0,1,0,3,4,3,5,3,4,3
	dc.b	$FF
	even
unk_20CCD0:
	dc.b	2
	dc.b	0,1,0,2,0,1,0
	dc.b	$FF
	even
unk_20CCDA:
	dc.b	2
	dc.b	3,4,3,5,3,4,3
	dc.b	$FF
	even
unk_20CCE4:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20CCE8:
	dc.b	0
	dc.b	3
	dc.b	$FF
	even

act28pat:
	dc.w	byte_20CCF8-act28pat
	dc.w	byte_20CD04-act28pat
	dc.w	byte_20CD10-act28pat
	dc.w	byte_20CD1C-act28pat
	dc.w	byte_20CD28-act28pat
	dc.w	byte_20CD34-act28pat
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

obj27_ani:
	dc.w	unk_20CD5C-obj27_ani
	dc.w	unk_20CD6C-obj27_ani
	dc.w	unk_20CD70-obj27_ani
	dc.w	unk_20CD74-obj27_ani
	dc.w	unk_20CD78-obj27_ani
	dc.w	unk_20CD7C-obj27_ani
	dc.w	unk_20CD80-obj27_ani
	dc.w	unk_20CD84-obj27_ani
	dc.w	unk_20CD88-obj27_ani
	dc.w	unk_20CD8C-obj27_ani
	dc.w	unk_20CD90-obj27_ani
	dc.w	unk_20CD94-obj27_ani
	dc.w	unk_20CD98-obj27_ani
	dc.w	unk_20CD9C-obj27_ani
unk_20CD5C:
	dc.b	9
	dc.b	0,1,2,3,4,5,6,7,8,9,$A,$B,$C
	dc.b	$FF
	even
unk_20CD6C:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20CD70:
	dc.b	0
	dc.b	1
	dc.b	$FF
	even
unk_20CD74:
	dc.b	0
	dc.b	2
	dc.b	$FF
	even
unk_20CD78:
	dc.b	0
	dc.b	3
	dc.b	$FF
	even
unk_20CD7C:
	dc.b	0
	dc.b	4
	dc.b	$FF
	even
unk_20CD80:
	dc.b	0
	dc.b	5
	dc.b	$FF
	even
unk_20CD84:
	dc.b	0
	dc.b	6
	dc.b	$FF
	even
unk_20CD88:
	dc.b	0
	dc.b	7
	dc.b	$FF
	even
unk_20CD8C:
	dc.b	0
	dc.b	8
	dc.b	$FF
	even
unk_20CD90:
	dc.b	0
	dc.b	9
	dc.b	$FF
	even
unk_20CD94:
	dc.b	0
	dc.b	$A
	dc.b	$FF
	even
unk_20CD98:
	dc.b	0
	dc.b	$B
	dc.b	$FF
	even
unk_20CD9C:
	dc.b	0
	dc.b	$C
	dc.b	$FF
	even

act27pat:
	dc.w	byte_20CDBA-act27pat
	dc.w	byte_20CDCA-act27pat
	dc.w	byte_20CDE4-act27pat
	dc.w	byte_20CDF4-act27pat
	dc.w	byte_20CE18-act27pat
	dc.w	byte_20CE32-act27pat
	dc.w	byte_20CE42-act27pat
	dc.w	byte_20CE52-act27pat
	dc.w	byte_20CE6C-act27pat
	dc.w	byte_20CE7C-act27pat
	dc.w	byte_20CEA0-act27pat
	dc.w	byte_20CEBA-act27pat
	dc.w	byte_20CECA-act27pat
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
	dc.b	$1D
	dc.b	0,1
	dc.b	$FF
unk_20CEDA:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20CEDE:
	dc.b	0
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

obj26_ani:
	dc.w	unk_20CEFE-obj26_ani
	dc.w	unk_20CF02-obj26_ani
	dc.w	unk_20CF06-obj26_ani
	dc.w	unk_20CF0A-obj26_ani
	dc.w	unk_20CF0E-obj26_ani
	dc.w	unk_20CF12-obj26_ani
unk_20CEFE:
	dc.b	$1D
	dc.b	0
	dc.b	$FF
	even
unk_20CF02:
	dc.b	$1D
	dc.b	1
	dc.b	$FF
	even
unk_20CF06:
	dc.b	$1D
	dc.b	2
	dc.b	$FF
	even
unk_20CF0A:
	dc.b	$1D
	dc.b	3
	dc.b	$FF
	even
unk_20CF0E:
	dc.b	$1D
	dc.b	4
	dc.b	$FF
	even
unk_20CF12:
	dc.b	$1D
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

act26pat:
	dc.w	byte_20CF9C-act26pat
	dc.w	byte_20CFA7-act26pat
	dc.w	byte_20CFBC-act26pat
	dc.w	byte_20CFD1-act26pat
	dc.w	byte_20CFD8-act26pat
	dc.w	byte_20CFDE-act26pat
byte_20CF9C:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20CFA7:
	dc.b	4
	dc.b	$F0,$C,0,8,$F0
	dc.b	-8,$C,0,8,$F0
	dc.b	0,$C,0,8,$F0
	dc.b	8,$C,0,8,$F0
	even
byte_20CFBC:
	dc.b	4
	dc.b	$F0,$C,8,8,$F0
	dc.b	-8,$C,8,8,$F0
	dc.b	0,$C,8,8,$F0
	dc.b	8,$C,8,8,$F0
byte_20CFD1:
	dc.b	1
	dc.b	$F0,3,0,0,-4
	even
byte_20CFD8:
	dc.b	1
	dc.b	-4,$C,0,8,$F0
	even
byte_20CFDE:
	dc.b	1
	dc.b	-4,$C,8,8,$F0
	even

obj29_ani:
	dc.w	unk_20CFEC-obj29_ani
	dc.w	unk_20CFF2-obj29_ani
	dc.w	unk_20CFF6-obj29_ani
	dc.w	unk_20CFFA-obj29_ani
unk_20CFEC:
	dc.b	$1D
	dc.b	0,1,2
	dc.b	$FF
	even
unk_20CFF2:
	dc.b	$1D
	dc.b	0
	dc.b	$FF
	even
unk_20CFF6:
	dc.b	$1D
	dc.b	1
	dc.b	$FF
	even
unk_20CFFA:
	dc.b	$1D
	dc.b	2
	dc.b	$FF
	even

obj29_map:
	dc.w	byte_20D004-obj29_map
	dc.w	byte_20D00A-obj29_map
	dc.w	byte_20D010-obj29_map
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

	include	"Actors/20 - Kuzureru Tikei.asm"
	include	"Actors/21 - DoDai.asm"

enecginit:
	lea	word_20DC28(pc),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	scra_h_posit.w,d0

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
	move.w	scra_h_posit.w,d0

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
	dc.w	$D00
	dc.w	$1100
	dc.w	$1500
	dc.w	$1A00
	dc.w	$2000
	dc.w	$FFFF

word_20DC34:
	dc.w	ddevid_04
	dc.w	ddevid_05
	dc.w	ddevid_06
	dc.w	ddevid_07
	dc.w	ddevid_08
	dc.w	ddevid_09

word_20DC40:
	dc.w	ddevid_0A
	dc.w	ddevid_0B
	dc.w	ddevid_0C
	dc.w	ddevid_0D
	dc.w	ddevid_0E
	dc.w	ddevid_0F

pa_set:
	lea	off_20DC6E.l,a1
	add.w	d0,d0
	move.w	off_20DC6E(pc,d0.w),d4
	lea	off_20DC6E(pc,d4.w),a2
	moveq	#0,d1
	move.b	act29(a0),d1
	add.w	d1,d1
	move.w	(a2,d1.w),d5
	move.w	d5,sproffset(a0)
	rts

off_20DC6E:
	dc.w	word_20DC92-off_20DC6E
	dc.w	word_20DC94-off_20DC6E
	dc.w	word_20DC96-off_20DC6E
	dc.w	word_20DC98-off_20DC6E
	dc.w	word_20DC9A-off_20DC6E
	dc.w	word_20DC9C-off_20DC6E
	dc.w	word_20DCA6-off_20DC6E
	dc.w	word_20DCA0-off_20DC6E
	dc.w	word_20DCA4-off_20DC6E
	dc.w	word_20DCA2-off_20DC6E
	dc.w	word_20DC9E-off_20DC6E
	dc.w	word_20DCA8-off_20DC6E
	dc.w	word_20DCAA-off_20DC6E
	dc.w	word_20DCAC-off_20DC6E
	dc.w	word_20DCAE-off_20DC6E
	dc.w	word_20DCB0-off_20DC6E
	dc.w	word_20DCB2-off_20DC6E
	dc.w	word_20DCB4-off_20DC6E
word_20DC92:
	dc.w	$23E7
word_20DC94:
	dc.w	$24DC
word_20DC96:
	dc.w	$245F
word_20DC98:
	dc.w	$2431
word_20DC9A:
	dc.w	$23E7
word_20DC9C:
	dc.w	$4363
word_20DC9E:
	dc.w	$33A
word_20DCA0:
	dc.w	$342
word_20DCA2:
	dc.w	$431E
word_20DCA4:
	dc.w	$4495
word_20DCA6:
	dc.w	$375
word_20DCA8:
	dc.w	$326
word_20DCAA:
	dc.w	$8357
word_20DCAC:
	dc.w	$475
word_20DCAE:
	dc.w	$384
word_20DCB0:
	dc.w	$3A1
word_20DCB2:
	dc.w	$422
word_20DCB4:
	dc.w	0

	include	"Actors/24 - Friend.asm"
	include	"Actors/17 - Goal.asm"

sub_20DFF4:
	jmp	sub_2059B8.l

mapinittbl:
	dc.l	ddevid_03<<24+zone1cg
	dc.l	ddevid_02<<24+zone1blk
	dc.l	zone1map
	dc.w	bgm_zone1
	dc.b	colorzone1,colorzone1
	even

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
ddevid_0D:	ddev_ptr	ddev_0C
ddevid_0E:	ddev_ptr	ddev_0E
ddevid_0F:	ddev_ptr	ddev_0F

ddev_00:	ddev_header
	ddev_entry	zone1cg,0
ddev_00_end:

ddev_01:	ddev_header
	ddev_entry	cg_rock,$326
	ddev_entry	cg_spikes,$33A
	ddev_entry	cg_pole,$342
	ddev_entry	cg_flipper,$357
	ddev_entry	cg_platform,$363
	ddev_entry	cg_spinplatform,$375
	ddev_entry	cg_wheels,$384
	ddev_entry	cg_dspring,$3A1
	ddev_entry	cg_spring,$520
	ddev_entry	cg_hud,$568
	ddev_entry	cg_monitortimesign,$5A8
	ddev_entry	cg_explosion,$680
	ddev_entry	cg_flowers,$6D6
	ddev_entry	cg_ring,$7AE
ddev_01_end:

ddev_02:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_flickyricky,$3CF
	ddev_entry	cg_mosqui,$3E7
	ddev_entry	cg_tagataga,$431
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_splash2,$475
	ddev_entry	cg_patabata,$4DC
ddev_02_end:

ddev_04:	ddev_header
	ddev_entry	cg_mosqui,$3E7
	ddev_entry	cg_tagataga,$431
ddev_04_end:

ddev_05:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_tamabboh,$3E7
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_splash2,$475
ddev_05_end:

ddev_06:	ddev_header
	ddev_entry	cg_splash,$422
	ddev_entry	cg_card,$495
ddev_06_end:

ddev_07:	ddev_header
	ddev_entry	cg_tamabboh,$3E7
	ddev_entry	cg_splash,$422
ddev_07_end:

ddev_08:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_flickyricky,$3CF
	ddev_entry	cg_mosqui,$3E7
	ddev_entry	cg_tagataga,$431
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_signpost,$503
ddev_08_end:

ddev_09:	ddev_header
	ddev_entry	cg_signpost,$503
ddev_09_end:

ddev_0A:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_rock,$326
	ddev_entry	cg_spikes,$33A
	ddev_entry	cg_pole,$342
	ddev_entry	cg_flipper,$357
	ddev_entry	cg_platform,$363
	ddev_entry	cg_spinplatform,$375
	ddev_entry	cg_wheels,$384
	ddev_entry	cg_dspring,$3A1
	ddev_entry	cg_flickyricky,$3CF
	ddev_entry	cg_mosqui,$3E7
	ddev_entry	cg_tagataga,$431
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_splash2,$475
	ddev_entry	cg_patabata,$4DC
ddev_0A_end:

ddev_0B:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_rock,$326
	ddev_entry	cg_spikes,$33A
	ddev_entry	cg_pole,$342
	ddev_entry	cg_flipper,$357
	ddev_entry	cg_platform,$363
	ddev_entry	cg_spinplatform,$375
	ddev_entry	cg_wheels,$384
	ddev_entry	cg_dspring,$3A1
	ddev_entry	cg_flickyricky,$3CF
	ddev_entry	cg_tamabboh,$3E7
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_splash2,$475
	ddev_entry	cg_patabata,$4DC
ddev_0B_end:

ddev_0C:	ddev_header
	ddev_entry	cg_rock,$326
	ddev_entry	cg_spikes,$33A
	ddev_entry	cg_pole,$342
	ddev_entry	cg_flipper,$357
	ddev_entry	cg_platform,$363
	ddev_entry	cg_spinplatform,$375
	ddev_entry	cg_wheels,$384
	ddev_entry	cg_dspring,$3A1
	ddev_entry	cg_flickyricky,$3CF
	ddev_entry	cg_tamabboh,$3E7
	ddev_entry	cg_splash,$422
	ddev_entry	cg_card,$495
	ddev_entry	cg_patabata,$4DC
ddev_0C_end:

ddev_0E:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_rock,$326
	ddev_entry	cg_spikes,$33A
	ddev_entry	cg_pole,$342
	ddev_entry	cg_flipper,$357
	ddev_entry	cg_platform,$363
	ddev_entry	cg_spinplatform,$375
	ddev_entry	cg_wheels,$384
	ddev_entry	cg_dspring,$3A1
	ddev_entry	cg_flickyricky,$3CF
	ddev_entry	cg_mosqui,$3E7
	ddev_entry	cg_tagataga,$431
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_patabata,$4DC
ddev_0E_end:

ddev_0F:	ddev_header
	ddev_entry	cg_bridge,$31E
	ddev_entry	cg_rock,$326
	ddev_entry	cg_spikes,$33A
	ddev_entry	cg_pole,$342
	ddev_entry	cg_flipper,$357
	ddev_entry	cg_platform,$363
	ddev_entry	cg_spinplatform,$375
	ddev_entry	cg_wheels,$384
	ddev_entry	cg_dspring,$3A1
	ddev_entry	cg_mosqui,$3E7
	ddev_entry	cg_tagataga,$431
	ddev_entry	cg_anton,$45F
	ddev_entry	cg_patabata,$4DC
	ddev_entry	cg_signpost,$503
ddev_0F_end:

; unused
	ddev_entry	cg_dspring,$33F
	ddev_entry	cg_wheels,$36D
	ddev_entry	cg_flipper,$375
	ddev_entry	cg_platform,$381
	ddev_entry	cg_spinplatform,$393
	ddev_entry	cg_rock,$3A2
	ddev_entry	cg_flickyricky,$3B6
	ddev_entry	cg_anton,$3CE
	ddev_entry	cg_mosqui,$3E4
	ddev_entry	cg_patabata,$42E
	ddev_entry	cg_tamabboh,$462

ddev_unused_0:	ddev_header
	ddev_entry	cg_spikes,$31E
	ddev_entry	cg_pole,$32A
	ddev_entry	cg_dspring,$33F
	ddev_entry	cg_wheels,$36D
	ddev_entry	cg_flipper,$375
	ddev_entry	cg_platform,$381
	ddev_entry	cg_spinplatform,$393
	ddev_entry	cg_rock,$3A2
	ddev_entry	cg_flickyricky,$3B6
	ddev_entry	cg_anton,$3CE
	ddev_entry	cg_mosqui,$3E4
	ddev_entry	cg_splash,$469
ddev_unused_0_end:

ddev_unused_1:	ddev_header
	ddev_entry	cg_spikes,$31E
	ddev_entry	cg_pole,$32A
	ddev_entry	cg_dspring,$33F
	ddev_entry	cg_wheels,$36D
	ddev_entry	cg_flipper,$375
	ddev_entry	cg_platform,$381
	ddev_entry	cg_spinplatform,$393
	ddev_entry	cg_rock,$3A2
	ddev_entry	cg_flickyricky,$3B6
	ddev_entry	cg_anton,$3CE
	ddev_entry	cg_mosqui,$3E4
	ddev_entry	cg_patabata,$42E
	ddev_entry	cg_tamabboh,$462
ddev_unused_1_end:

ddev_unused_2:	ddev_header
	ddev_entry	cg_spikes,$31E
	ddev_entry	cg_pole,$32A
	ddev_entry	cg_dspring,$33F
	ddev_entry	cg_wheels,$36D
	ddev_entry	cg_flipper,$375
	ddev_entry	cg_platform,$381
	ddev_entry	cg_spinplatform,$393
	ddev_entry	cg_rock,$3A2
	ddev_entry	cg_anton,$3CE
	ddev_entry	cg_mosqui,$3E4
	ddev_entry	cg_patabata,$42E
	ddev_entry	cg_tamabboh,$462
ddev_unused_2_end:

	incbin	"Leftovers/R11A__.MMD"
	even

mapwk:
	incbin	"Leftovers/Chunks/Chunks.unc"
	even

	align	$210000+mapsize*$6C

	incbin	"Unknown/Unk1.unc"
	even

playcg:
	incbin	"Art/Uncompressed/Player.unc"
	even

playpat:
	include	"Patterns/Player.asm"

playwrtpat:
	include	"Patterns/Wrt/Player.asm"

unk_22E3AC:
	incbin	"Sound/Z80_3.bin"
	even
unk_22E3AC_end:

unk_22E3E4:
	incbin	"Sound/Z80_2.bin"
	even
unk_22E3E4_end:

unk_22EB40:
	incbin	"Sound/Z80_1.bin"
	even
unk_22EB40_end:

cg_shield:
	incbin	"Art/Uncompressed/Shield.unc"
	even

cg_stars:
	incbin	"Art/Uncompressed/Invincibility Stars.unc"
	even

cg_timetravel:
	incbin	"Art/Uncompressed/Time Travel Sparkles.unc"
	even

cg_dspring:
	incbin	"Art/BitDev/Diagonal Spring.nem"
	even

cg_spring:
	incbin	"Art/BitDev/Spring.nem"
	even

cg_monitortimesign:
	incbin	"Art/BitDev/Monitor and Time Sign.nem"
	even

cg_explosion:
	incbin	"Art/BitDev/Explosion.nem"
	even

cg_ring:
	incbin	"Art/BitDev/Ring.nem"
	even

cg_hudicon:
	incbin	"Art/Uncompressed/HUD Icon.unc"
	even

scorewrtcg:
	incbin	"Art/Uncompressed/HUD Numbers and Letters.unc"
	even

cg_hud:
	incbin	"Art/BitDev/HUD.nem"
	even

cg_flowers:
	incbin	"Art/BitDev/Flowers.nem"
	even

cg_signpost:
	incbin	"Art/BitDev/Goal.nem"
	even

cg_rock:
	incbin	"Art/BitDev/Rock.nem"
	even

cg_platform:
	incbin	"Art/BitDev/Appearing Platform.nem"
	even

cg_wheels:
	incbin	"Art/BitDev/Wheels.nem"
	even

cg_spinplatform:
	incbin	"Art/BitDev/Spinning Platform.nem"
	even

cg_splash:
	incbin	"Art/BitDev/Splash.nem"
	even

cg_flipper:
	incbin	"Art/BitDev/Flipper.nem"
	even

cg_splash2:
	incbin	"Art/BitDev/Splash 2.nem"
	even

cg_mosqui:
	incbin	"Art/BitDev/Mosqui.nem"
	even

cg_patabata:
	incbin	"Art/BitDev/Pata-Bata.nem"
	even

cg_anton:
	incbin	"Art/BitDev/Anton.nem"
	even

cg_tagataga:
	incbin	"Art/BitDev/Taga-Taga.nem"
	even

cg_tamabboh:
	incbin	"Art/BitDev/Tamabboh.nem"
	even

cg_pole:
	incbin	"Art/BitDev/Elastic Pole.nem"
	even

cg_card:
	incbin	"Art/BitDev/Rotating Card.nem"
	even

cg_bridge:
	incbin	"Art/BitDev/Bridge.nem"
	even

	incbin	"Art/BitDev/Switch.nem"
	even

cg_spikes:
	incbin	"Art/BitDev/Spikes.nem"
	even

cg_flickyricky:
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

	incbin	"Art/BitDev/Spinning Platform.nem"
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
	incbin	"Collision/SPZ.bin"
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
	incbin	"Layout/Foreground.bin"
	even
zone1_1b:
	incbin	"Layout/Background.bin"
	even
zone1_1z:
	dc.l 0
zone1_2a:
	incbin	"Leftovers/Layout/GHZ2 Foreground (Sonic 1).bin"
	even
zone1_2z:
	dc.l 0
zone1_3a:
	incbin	"Leftovers/Layout/GHZ3 Foreground (Sonic 1).bin"
	even
zone1_3b:
	dc.l 0
zone1_4:
	dc.l 0

zone1blk:
	incbin	"Blocks/Blocks.nem"
	even

zone1cg:
	incbin	"Art/BitDev/8x8 - SPZ.nem"
	even

zone1map:
	incbin	"Chunks/Chunks.kos"
	even

	incbin	"Leftovers/Chunks/Chunks.kos"
	even

	incbin	"Unknown/Unk2.kos"
	even

	incbin	"Unknown/Unk3.unc"
	even

	dephase