vint:
	bset	#0,mcpu_int2
	movem.l	d0-a6,-(sp)
	tst.b	int_flg
	beq.s	int00
	move.w	vdp_cmd,d0
	move.l	#$40000010,vdp_cmd
	move.l	vscroll,vdp_dat
	btst	#6,mdstatus
	beq.s	.jump
	move.w	#$700,d0
	dbf	d0,*

.jump:
	move.b	int_flg,d0
	move.b	#int_00,int_flg
	move.w	#1,hintflag
	andi.w	#$3E,d0
	move.w	int_tbl(pc,d0.w),d0
	jsr	int_tbl(pc,d0.w)

loc_2016A4:
	jsr	sound.l

loc_2016AA:
	bsr.w	bye_cnt
	bsr.w	back_to_cnt
	addq.l	#1,systemtimer
	movem.l	(sp)+,d0-a6
	rte

int_tbl:

int_ptr	macro	ptr,{INTLABEL}
__LABEL__:	label	*-int_tbl
	dc.w	ptr-int_tbl
	endm

int_00:	int_ptr	int00
int_02:	int_ptr	int02
int_04:	int_ptr	int04
int_06:	int_ptr	int06
int_08:	int_ptr	int08
int_0A:	int_ptr	int0A
int_0C:	int_ptr	int0C
int_0E:	int_ptr	int0E
int_10:	int_ptr	int10
int_12:	int_ptr	int12
int_14:	int_ptr	int14
int_16:	int_ptr	int16
int_18:	int_ptr	int0C

int00:
	cmpi.b	#gamemd_s1+$80,gmmode
	beq.s	loc_2016EA
	cmpi.b	#gamemd_s1,gmmode
	bne.w	loc_2016A4

loc_2016EA:
	cmpi.b	#stage_lz,stageno
	bne.w	loc_2016A4
	move.w	vdp_cmd,d0
	btst	#6,mdstatus
	beq.s	loc_20170E
	move.w	#$700,d0
	dbf	d0,*

loc_20170E:
	move.w	#1,hintflag
	jsr	z80bus_on.l
	tst.b	waterflag
	bne.s	loc_201746
	dma68k	lpcolorwk,$C,0
	bra.s	loc_20176A

loc_201746:
	dma68k	lpcolorwk3,$C,0

loc_20176A:
	move.w	hintposi,(a5)
	jsr	z80bus_off.l
	bra.w	loc_2016A4

int02:
	bsr.w	sub_201B1A

int14:
	tst.w	waittimer
	beq.w	.end
	subq.w	#1,waittimer

.end:
	rts

int04:
	bsr.w	sub_201B1A
	bsr.w	scrollwrtadva
	bsr.w	sub_2020F0
	tst.w	waittimer
	beq.w	.end
	subq.w	#1,waittimer

.end:
	rts

int06:
	bsr.w	sub_201B1A
	rts

int10:
	cmpi.b	#spgamemd,gmmode
	beq.w	int0A

int08:
	jsr	z80bus_on.l
	bsr.w	read_sw
	tst.b	waterflag
	bne.s	loc_2017EA
	dma68k	lpcolorwk,$C,0
	bra.s	loc_20180E

loc_2017EA:
	dma68k	lpcolorwk3,$C,0

loc_20180E:
	move.w	hintposi,(a5)
	dma68k	hscrollwork,4,hscroll_vram
	dma68k	sprdat,4,sprdat_vram
	lea	playerwk,a0
	bsr.w	playwrt
	tst.b	playwrtflag
	beq.s	loc_201892
	dma68k	playwrtwk,4,play00_vram*tile_size
	move.b	#0,playwrtflag

loc_201892:
	lea	player2wk,a0
	bsr.w	playwrt
	tst.b	playwrtflag
	beq.s	loc_2018CA
	dma68k	playwrtwk,4,play01_vram*tile_size
	move.b	#0,playwrtflag

loc_2018CA:
	tst.w	time_stop
	bne.s	loc_2018D8
	jsr	sub_20DFF4.l

loc_2018D8:
	jsr	z80bus_off.l
	movem.l	scra_h_posit,d0-d7
	movem.l	d0-d7,scra_h_posiw
	movem.l	scrflaga,d0-d1
	movem.l	d0-d1,scrflagaw
	cmpi.b	#96,hintposi+1
	bhs.s	doupdates
	move.b	#1,waterflag2
	addq.l	#4,sp
	bra.w	loc_2016AA

doupdates:
	bsr.w	scrollwrt
	bsr.w	sub_20210C
	jsr	scoreset.l
	tst.w	waittimer
	beq.w	.end
	subq.w	#1,waittimer

.end:
	rts

int0A:
	rts

int0C:
	jsr	z80bus_on.l
	bsr.w	read_sw
	tst.b	waterflag
	bne.s	loc_201962
	dma68k	lpcolorwk,$C,0
	bra.s	loc_201986

loc_201962:
	dma68k	lpcolorwk3,$C,0

loc_201986:
	move.w	hintposi,(a5)
	dma68k	hscrollwork,4,hscroll_vram
	dma68k	sprdat,4,sprdat_vram
	lea	playerwk,a0
	bsr.w	playwrt
	tst.b	playwrtflag
	beq.s	loc_201A0A
	dma68k	playwrtwk,4,play00_vram*tile_size
	move.b	#0,playwrtflag

loc_201A0A:
	jsr	z80bus_off.l
	movem.l	scra_h_posit,d0-d7
	movem.l	d0-d7,scra_h_posiw
	movem.l	scrflaga,d0-d1
	movem.l	d0-d1,scrflagaw
	bsr.w	scrollwrt
	bsr.w	sub_2020F0
	jsr	scoreset.l
	rts

int0E:
	bsr.w	sub_201B1A
	addq.b	#1,intcnt
	move.b	#int_0E,int_flg
	rts

int12:
	bsr.w	sub_201B1A
	move.w	hintposi,(a5)
	bra.w	sub_2020F0

int16:
	jsr	z80bus_on.l
	bsr.w	read_sw
	dma68k	lpcolorwk,$C,0
	dma68k	sprdat,4,sprdat_vram
	dma68k	hscrollwork,4,hscroll_vram
	jsr	z80bus_off.l
	lea	playerwk,a0
	bsr.w	playwrt
	tst.b	playwrtflag
	beq.s	loc_201B0C
	dma68k	playwrtwk,4,play00_vram*tile_size
	move.b	#0,playwrtflag

loc_201B0C:
	tst.w	waittimer
	beq.w	.end
	subq.w	#1,waittimer

.end:
	rts

sub_201B1A:
	jsr	z80bus_on.l
	bsr.w	read_sw
	tst.b	waterflag
	bne.s	.jump
	dma68k	lpcolorwk,$C,0
	bra.s	.jump1

.jump:
	dma68k	lpcolorwk3,$C,0

.jump1:
	dma68k	sprdat,4,sprdat_vram
	dma68k	hscrollwork,4,hscroll_vram
	jmp	z80bus_off.l

hint:
	move.w	#$2700,sr
	tst.w	hintflag
	beq.s	locret_201C38
	move.w	#0,hintflag
	movem.l	a0-a1,-(sp)
	lea	vdp_dat,a1
	lea	lpcolorwk3,a0
	move.l	#$C0000000,vdp_cmd-vdp_dat(a1)
	rept	32
	move.l	(a0)+,(a1)
	endr
	move.w	#$8A00+223,vdp_cmd-vdp_dat(a1)
	movem.l	(sp)+,a0-a1
	tst.b	waterflag2
	bne.s	loc_201C3A

locret_201C38:
	rte

loc_201C3A:
	clr.b	waterflag2
	movem.l	d0-a6,-(sp)
	bsr.w	doupdates
	movem.l	(sp)+,d0-a6
	rte

back_to_cnt:
	tst.w	backto_cnt
	beq.s	loc_201C56
	addq.w	#1,backto_cnt

loc_201C56:
	tst.w	time_stop
	beq.s	locret_201C64
	subq.w	#1,time_stop

locret_201C64:
	rts

bye_cnt:
	tst.w	byecnt0
	beq.s	loc_201C70
	addq.w	#1,byecnt0

loc_201C70:
	tst.w	byecnt1
	beq.s	locret_201C7A
	addq.w	#1,byecnt1

locret_201C7A:
	rts