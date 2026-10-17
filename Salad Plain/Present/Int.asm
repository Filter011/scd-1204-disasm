vint:
	bset	#0,scpu_IRQ2
	movem.l	d0-a6,-(sp)
	tst.b	int_flg.w
	beq.s	vint00
	move.w	vdpctrl,d0
	move.l	#$40000010,vdpctrl
	move.l	vscroll.w,vdpdata
	btst	#6,mdstatus
	beq.s	loc_201688
	move.w	#$700,d0

loc_201684:
	dbf	d0,loc_201684

loc_201688:
	move.b	int_flg.w,d0
	move.b	#vintid_00,int_flg.w
	move.w	#1,hintflag.w
	andi.w	#$3E,d0
	move.w	vint_tbl(pc,d0.w),d0
	jsr	vint_tbl(pc,d0.w)

loc_2016A4:
	jsr	sound.l

loc_2016AA:
	bsr.w	bye_cnt
	bsr.w	back_to_cnt
	addq.l	#1,systemtimer
	movem.l	(sp)+,d0-a6
	rte

vint_tbl:

vint_ptr	macro	ptr,{INTLABEL}
__LABEL__:	label	*-vint_tbl
	dc.w	ptr-vint_tbl
	endm

vintid_00:	vint_ptr	vint00
vintid_02:	vint_ptr	vint02
vintid_04:	vint_ptr	vint04
vintid_06:	vint_ptr	vint06
vintid_08:	vint_ptr	vint08
vintid_0A:	vint_ptr	vint0A
vintid_0C:	vint_ptr	vint0C
vintid_0E:	vint_ptr	vint0E
vintid_10:	vint_ptr	vint10
vintid_12:	vint_ptr	vint12
vintid_14:	vint_ptr	vint14
vintid_16:	vint_ptr	vint16
vintid_18:	vint_ptr	vint0C

vint00:
	cmpi.b	#gamemd_s1+$80,gmmode.w
	beq.s	loc_2016EA
	cmpi.b	#gamemd_s1,gmmode.w
	bne.w	loc_2016A4

loc_2016EA:
	cmpi.b	#stage_lz,stageno
	bne.w	loc_2016A4
	move.w	vdpctrl,d0
	btst	#6,mdstatus
	beq.s	loc_20170E
	move.w	#$700,d0

loc_20170A:
	dbf	d0,loc_20170A

loc_20170E:
	move.w	#1,hintflag.w
	jsr	z80bus_on.l
	tst.b	waterflag.w
	bne.s	loc_201746
	dma68k	lpcolorwk,$80,$C,0
	bra.s	loc_20176A

loc_201746:
	dma68k	lpcolorwk3,$80,$C,0

loc_20176A:
	move.w	hintposi.w,(a5)
	jsr	z80bus_off.l
	bra.w	loc_2016A4

vint02:
	bsr.w	sub_201B1A

vint14:
	tst.w	waittimer.w
	beq.w	locret_201788
	subq.w	#1,waittimer.w

locret_201788:
	rts

vint04:
	bsr.w	sub_201B1A
	bsr.w	scrollwrtadva
	bsr.w	sub_2020F0
	tst.w	waittimer.w
	beq.w	locret_2017A2
	subq.w	#1,waittimer.w

locret_2017A2:
	rts

vint06:
	bsr.w	sub_201B1A
	rts

vint10:
	cmpi.b	#spgamemd,gmmode.w
	beq.w	vint0A
vint08:
	jsr	z80bus_on.l
	bsr.w	read_sw
	tst.b	waterflag.w
	bne.s	loc_2017EA
	dma68k	lpcolorwk,$80,$C,0
	bra.s	loc_20180E

loc_2017EA:
	dma68k	lpcolorwk3,$80,$C,0

loc_20180E:
	move.w	hintposi.w,(a5)
	dma68k	hscrollwork,(hscrollwork_end-hscrollwork),4,hscroll_vram
	dma68k	sprdat,(sprdat_end-sprdat),4,sprdat_vram
	lea	playerwk.w,a0
	bsr.w	playwrt
	tst.b	playwrtflag.w
	beq.s	loc_201892
	dma68k	playwrtwk,(playwrtwk_end-playwrtwk),4,$780*tile_size
	move.b	#0,playwrtflag.w

loc_201892:
	lea	byte_FFD040.w,a0
	bsr.w	playwrt
	tst.b	playwrtflag.w
	beq.s	loc_2018CA
	dma68k	playwrtwk,(playwrtwk_end-playwrtwk),4,$797*tile_size
	move.b	#0,playwrtflag.w

loc_2018CA:
	tst.w	time_stop
	bne.s	loc_2018D8
	jsr	sub_20DFF4.l

loc_2018D8:
	jsr	z80bus_off.l
	movem.l	scra_h_posit.w,d0-d7
	movem.l	d0-d7,scra_h_posiw
	movem.l	scrflaga.w,d0-d1
	movem.l	d0-d1,scrflagaw
	cmpi.b	#96,hintposi+1.w
	bhs.s	doupdates
	move.b	#1,waterflag2.w
	addq.l	#4,sp
	bra.w	loc_2016AA

doupdates:
	bsr.w	scrollwrt
	bsr.w	sub_20210C
	jsr	scoreset.l
	tst.w	waittimer.w
	beq.w	locret_201928
	subq.w	#1,waittimer.w

locret_201928:
	rts

vint0A:
	rts

vint0C:
	jsr	z80bus_on.l
	bsr.w	read_sw
	tst.b	waterflag.w
	bne.s	loc_201962
	dma68k	lpcolorwk,$80,$C,0
	bra.s	loc_201986

loc_201962:
	dma68k	lpcolorwk3,$80,$C,0

loc_201986:
	move.w	hintposi.w,(a5)
	dma68k	hscrollwork,(hscrollwork_end-hscrollwork),4,hscroll_vram
	dma68k	sprdat,(sprdat_end-sprdat),4,sprdat_vram
	lea	playerwk.w,a0
	bsr.w	playwrt
	tst.b	playwrtflag.w
	beq.s	loc_201A0A
	dma68k	playwrtwk,(playwrtwk_end-playwrtwk),4,$780*tile_size
	move.b	#0,playwrtflag.w

loc_201A0A:
	jsr	z80bus_off.l
	movem.l	scra_h_posit.w,d0-d7
	movem.l	d0-d7,scra_h_posiw
	movem.l	scrflaga.w,d0-d1
	movem.l	d0-d1,scrflagaw
	bsr.w	scrollwrt
	bsr.w	sub_2020F0
	jsr	scoreset.l
	rts

vint0E:
	bsr.w	sub_201B1A
	addq.b	#1,intcnt.w
	move.b	#vintid_0E,int_flg.w
	rts

vint12:
	bsr.w	sub_201B1A
	move.w	hintposi.w,(a5)
	bra.w	sub_2020F0

vint16:
	jsr	z80bus_on.l
	bsr.w	read_sw
	dma68k	lpcolorwk,$80,$C,0
	dma68k	sprdat,(sprdat_end-sprdat),4,sprdat_vram
	dma68k	hscrollwork,(hscrollwork_end-hscrollwork),4,hscroll_vram
	jsr	z80bus_off.l
	lea	playerwk.w,a0
	bsr.w	playwrt
	tst.b	playwrtflag.w
	beq.s	loc_201B0C
	dma68k	playwrtwk,(playwrtwk_end-playwrtwk),4,$780*tile_size
	move.b	#0,playwrtflag.w

loc_201B0C:
	tst.w	waittimer.w
	beq.w	locret_201B18
	subq.w	#1,waittimer.w

locret_201B18:
	rts

sub_201B1A:
	jsr	z80bus_on.l
	bsr.w	read_sw
	tst.b	waterflag.w
	bne.s	loc_201B50
	dma68k	lpcolorwk,$80,$C,0
	bra.s	loc_201B74

loc_201B50:
	dma68k	lpcolorwk3,$80,$C,0

loc_201B74:
	dma68k	sprdat,(sprdat_end-sprdat),4,sprdat_vram
	dma68k	hscrollwork,(hscrollwork_end-hscrollwork),4,hscroll_vram
	jmp	z80bus_off.l

hint:
	move.w	#$2700,sr
	tst.w	hintflag.w
	beq.s	locret_201C38
	move.w	#0,hintflag.w
	movem.l	a0-a1,-(sp)
	lea	vdpdata,a1
	lea	lpcolorwk3.w,a0
	move.l	#$C0000000,4(a1)
	rept	32
	move.l	(a0)+,(a1)
	endr
	move.w	#$8A00+223,4(a1)
	movem.l	(sp)+,a0-a1
	tst.b	waterflag2.w
	bne.s	loc_201C3A

locret_201C38:
	rte

loc_201C3A:
	clr.b	waterflag2.w
	movem.l	d0-a6,-(sp)
	bsr.w	doupdates
	movem.l	(sp)+,d0-a6
	rte

back_to_cnt:
	tst.w	backto_cnt.w
	beq.s	loc_201C56
	addq.w	#1,backto_cnt.w

loc_201C56:
	tst.w	time_stop
	beq.s	locret_201C64
	subq.w	#1,time_stop

locret_201C64:
	rts

bye_cnt:
	tst.w	byecnt0.w
	beq.s	loc_201C70
	addq.w	#1,byecnt0.w

loc_201C70:
	tst.w	byecnt1.w
	beq.s	locret_201C7A
	addq.w	#1,byecnt1.w

locret_201C7A:
	rts