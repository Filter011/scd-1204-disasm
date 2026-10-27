bgm_tbl:
	dc.b	bgm_81
	dc.b	bgm_82
	dc.b	bgm_83
	dc.b	bgm_84
	dc.b	bgm_85
	dc.b	bgm_86
	dc.b	bgm_8D
	even

game:
	bset	#0,play_start
	bne.s	loc_2011FE
	move.b	#3,pl_suu
	tst.b	ta_flag
	beq.s	loc_2011FE
	move.b	#1,pl_suu

loc_2011FE:
	bset	#7,gmmode.w
	bsr.w	sub_20208C
	btst	#7,time_flag
	beq.s	loc_20122C
	bsr.w	flashout
	clr.b	time_item.w
	tst.w	gameflag
	beq.s	loc_201256
	move.w	#0,gameflag
	rts

loc_20122C:
	bsr.w	fadeout
	cmpi.w	#2,gameflag
	bne.s	loc_201244
	move.w	#0,gameflag
	rts

loc_201244:
	tst.b	pl_suu
	bne.s	loc_201256
	bclr	#0,play_start
	rts

loc_201256:
	bsr.w	da_set
	moveq	#0,d0
;	move.b	stageno,d0
;	lsl.w	#4,d0
	lea	mapinittbl.l,a2
	moveq	#0,d0
	move.b	(a2),d0
	beq.s	loc_20126C
	bsr.w	divdevset

loc_20126C:
	moveq	#ddevid_01,d0
	bsr.w	divdevset

	clr.b	plsubchg_flag
	clr.l	flowercnt

	lea	actwk.w,a1
	moveq	#0,d0
	move.w	#(actwk_end-actwk)/4-1,d1

loc_201288:
	move.l	d0,(a1)+
	dbf	d1,loc_201288

	lea	intcnt.w,a1
	moveq	#0,d0
	move.w	#(divdevwk-intcnt)/4-1,d1

loc_201298:
	move.l	d0,(a1)+
	dbf	d1,loc_201298

	lea	scra_h_posit.w,a1
	moveq	#0,d0
	move.w	#(sprdat-scra_h_posit)/4-1,d1

loc_2012A8:
	move.l	d0,(a1)+
	dbf	d1,loc_2012A8

	move.w	#$2700,sr
	bsr.w	scrinit
	lea	vdp_cmd,a6
	move.w	#$8B00+%0011,(a6)
	move.w	#$8200+plane_a>>10,(a6)
	move.w	#$8400+plane_b>>13,(a6)
	move.w	#$8500+sprdat_vram>>9,(a6)
	move.w	#$9001,(a6)
	move.w	#$8000+%0100,(a6)
	move.w	#$8720,(a6)
	move.w	#$8A00+223,hintposi.w
	move.w	hintposi.w,(a6)
	move.w	#30,pl_air
	move.w	#$2300,sr
	moveq	#colorgame,d0
	bsr.w	colorset2
	moveq	#colorgame,d0
	bsr.w	colorset
	move.w	word_FFF60C.w,d0
	ori.b	#$40,d0
	move.w	d0,vdp_cmd

loc_201308:
	move.b	#int_0C,int_flg.w
	bsr.w	sync
	bsr.w	sub_20209A
	bne.s	loc_201308
	tst.l	divdevwk.w
	bne.s	loc_201308
	bsr.w	scr_set
	bsr.w	scroll
	bset	#2,scrflaga.w
	bsr.w	mapinit
	bsr.w	mapwrt
	jsr	scdcnv.l
	bsr.w	scdset

loc_20133E:
	move.b	#int_0C,int_flg.w
	bsr.w	sync
	bsr.w	sub_20209A
	bne.s	loc_20133E
	tst.l	divdevwk.w
	bne.s	loc_20133E
	bsr.w	play_act_set
	move.b	#score_act,scorewk.w
	move.b	#score_act,score2wk.w
	move.b	#1,score2wk+userflag.w
	bsr.w	sub_2015E8
	move.w	#0,swdata.w
	move.w	#0,swdata1.w
	move.w	#0,swdata2.w
	move.w	#0,byecnt0.w
	move.w	#0,byecnt1.w
	moveq	#0,d0
	tst.b	plflag
	bne.s	loc_2013A8
	move.w	d0,plring
	move.l	d0,pltime
	move.b	d0,plring_f2

loc_2013A8:
	move.b	d0,pltimeover_f
	move.b	d0,plpower_b
	move.b	d0,plpower_m
	move.b	d0,plpower_s
	move.b	d0,plpower_a
	move.w	d0,editmode
	move.w	d0,gameflag
	move.w	d0,gametimer
	move.b	#1,plscore_f
	move.b	#1,plring_f
	move.b	#1,pltime_f
	move.b	#1,pl_suu_f
	move.w	#0,swbufcnt.w
	move.w	#$202F,startcolor.w
	bclr	#7,time_flag
	beq.s	loc_201414
	bsr.w	flashin
	bra.s	loc_201418

loc_201414:
	bsr.w	fadein0

loc_201418:
	bclr	#7,gmmode.w

loc_20141E:
	move.b	#int_08,int_flg.w
	bsr.w	sync
	addq.w	#1,gametimer
	jsr	actsetchk.l
	jsr	action.l
	tst.w	gameflag
	bne.w	game
	tst.w	editmode
	bne.s	loc_201454
	cmpi.b	#6,playerwk+r_no0.w
	bhs.s	loc_201458

loc_201454:
	bsr.w	scroll

loc_201458:
	jsr	patset.l
	tst.w	time_stop
	bne.s	loc_20146A
	bsr.w	clrchgctr

loc_20146A:
	jsr	sub_20DBFA.l
	bsr.w	sub_20209A
	bsr.w	syspatchg
	bra.w	loc_20141E

play_act_set:
	lea	playerwk.w,a1
	moveq	#play00_act,d0
	tst.b	main_play
	beq.s	loc_201490
	lea	player2wk.w,a1
	moveq	#objid_02,d0

loc_201490:
	_move.b	d0,actno(a1)
	rts

flow_act_set:
	lea	flowercnt,a1
	moveq	#0,d0
	move.b	time_flag,d0
	bclr	#7,d0
	move.b	(a1,d0.w),d0
	beq.s	locret_2014EE
	subq.b	#1,d0
	lea	byte_FFD800.w,a2
	moveq	#0,d1

.loop:
	_move.b	#flow_act,actno(a2)
	move.w	d1,d2
	add.w	d2,d2
	add.w	d2,d2
	moveq	#0,d3
	move.b	time_flag,d3
	bclr	#7,d3
	lsl.w	#8,d3
	add.w	d3,d2
	lea	flowwk,a3
	move.w	(a3,d2.w),xposi(a2)
	move.w	2(a3,d2.w),yposi(a2)
	adda.w	#actfree,a2
	addq.b	#1,d1
	dbf	d0,.loop

locret_2014EE:
	rts

scdset:
	moveq	#0,d0
	move.b	stageno,d0
	lsl.w	#2,d0
	move.l	scdtbl(pc,d0.w),scdadr.w
	rts

scdtbl:
	dc.l	zone1scd
	dc.l	zone1scd
	dc.l	zone1scd
	dc.l	zone1scd
	dc.l	zone1scd
	dc.l	zone1scd
	dc.l	zone1scd
	dc.l	zone1scd

syspatchg:
	subq.b	#1,sys_pattim
	bpl.s	.end
	move.b	#11,sys_pattim
	subq.b	#1,sys_patno
	andi.b	#7,sys_patno

.end:
	subq.b	#1,sys_pattim2
	bpl.s	.end1
	move.b	#7,sys_pattim2
	addq.b	#1,sys_patno2
	andi.b	#3,sys_patno2

.end1:
	subq.b	#1,sys_pattim3
	bpl.s	.end2
	move.b	#7,sys_pattim3
	addq.b	#1,sys_patno3
	cmpi.b	#6,sys_patno3
	blo.s	.end2
	move.b	#0,sys_patno3

.end2:
	tst.b	sys_pattim4
	beq.s	.end3
	moveq	#0,d0
	move.b	sys_pattim4,d0
	add.w	sys_ringtimer,d0
	move.w	d0,sys_ringtimer
	rol.w	#7,d0
	andi.w	#3,d0
	move.b	d0,sys_patno4
	subq.b	#1,sys_pattim4

.end3:
	rts

da_set:
	moveq	#0,d0
	move.b	time_flag,d0
	bclr	#7,d0
	cmpi.b	#2,d0
	bne.s	loc_2015CE
	add.b	generate_flag,d0

loc_2015CE:
	move.b	da_tbl(pc,d0.w),d0
	ext.w	d0
	jmp	sub_sync.l

da_tbl:
	dc.b	mcpu_r1bBGM
	dc.b	mcpu_r1aBGM
	dc.b	mcpu_r1cBGM
	dc.b	mcpu_r1dBGM
	even

	move.w	#mcpu_r1aBGM,d0
	jsr	sub_sync.l

sub_2015E8:
	move.l	#$73E00002,d0
	moveq	#0,d2
	move.b	time_flag,d2
	bclr	#7,d2
	lsl.w	#7,d2
	move.l	d0,4(a6)
	lea	cg_hudicon.l,a1
	lea	(a1,d2.w),a3
	rept	32
	move.l	(a3)+,(a6)
	endr
	rts