main_chk:
	lea	playerwk.w,a6
	tst.b	main_play
	beq.s	locret_2023FA
	lea	byte_FFD040.w,a6

locret_2023FA:
	rts

scr_set:
	bsr.s	main_chk
	moveq	#0,d0
	move.b	d0,scrh_flag.w
	move.b	d0,scrv_flag.w
	move.b	d0,scr_die.w
	move.b	d0,scr_timer.w
	move.b	d0,zone_flag.w
	lea	scr_dir_tbl.l,a0
	move.w	(a0)+,d0
	move.w	d0,scrar_no.w
	move.l	(a0)+,d0
	move.l	d0,scralim_left.w
	move.l	d0,scralim_n_left.w
	move.l	(a0)+,d0
	move.l	d0,scralim_up.w
	move.l	d0,scralim_n_up.w
	move.w	scralim_left.w,d0
	addi.w	#$240,d0
	move.w	d0,scra_h_keep.w
	move.w	#$1010,scra_h_count.w
	move.w	(a0)+,d0
	move.w	d0,scra_vline.w
	bra.w	playposiset

scr_dir_tbl:
	dc.w	4
	dc.w	0,$2697
	dc.w	0,$310
	dc.w	$60

endplpositbl:
	dc.w	$50,$3B0
	dc.w	$EA0,$46C
	dc.w	$1750,$BD
	dc.w	$A00,$62C
	dc.w	$BB0,$4C
	dc.w	$1570,$16C
	dc.w	$1B0,$72C
	dc.w	$1400,$2AC

playposiset:
	tst.b	plflag
	beq.s	loc_202498
	jsr	playload.l
	moveq	#0,d0
	moveq	#0,d1
	move.w	xposi(a6),d1
	move.w	yposi(a6),d0
	bra.s	loc_2024D4

loc_202498:
	lea	playpositbl.l,a1
	tst.w	demoflag
	bpl.s	loc_2024BA
	move.w	enddemono,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	endplpositbl.l,a1
	adda.w	d0,a1
	bra.s	loc_2024C4

loc_2024BA:
	move.w	demoflag,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_2024C4:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,xposi(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,yposi(a6)

loc_2024D4:
	subi.w	#320/2,d1
	bhs.s	loc_2024DC
	moveq	#0,d1

loc_2024DC:
	move.w	scralim_right.w,d2
	cmp.w	d2,d1
	blo.s	loc_2024E6
	move.w	d2,d1

loc_2024E6:
	move.w	d1,scra_h_posit.w
	subi.w	#224/2-16,d0
	bhs.s	loc_2024F2
	moveq	#0,d0

loc_2024F2:
	cmp.w	scralim_down.w,d0
	blt.s	loc_2024FC
	move.w	scralim_down.w,d0

loc_2024FC:
	move.w	d0,scra_v_posit.w
	bsr.w	scrbinit
	lea	playmapnotbl.l,a1
	move.l	(a1),loopmapno.w
	rts

playpositbl:
	incbin	"Player Positions/Player Positions.bin"
	even

playmapnotbl:
	dc.b	$8C,$7F,$1E,$1E
	even

scrbinit:
	swap	d0
	asr.l	#4,d0
	move.l	d0,d2
	add.l	d2,d2
	add.l	d2,d0
	move.l	d0,scrb_v_posit.w
	swap	d0
	move.w	d0,scrc_v_posit.w
	move.w	d0,scrz_v_posit.w
	lsr.w	#1,d1
	move.w	d1,scrb_h_posit.w
	lsr.w	#1,d1
	move.w	d1,scrc_h_posit.w
	lsr.w	#1,d1
	move.w	d1,scrz_h_posit.w
	lea	linework.w,a2
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	rts

scroll:
	bsr.w	main_chk
	tst.b	scroll_start.w
	beq.s	loc_20255C
	rts

loc_20255C:
	clr.w	scrflaga.w
	clr.w	scrflagb.w
	clr.w	scrflagc.w
	clr.w	scrflagz.w
	bsr.w	scroll_h
	bsr.w	scroll_v
	bsr.w	scrchk
	move.w	scra_v_posit.w,vscroll.w
	move.w	scrb_v_posit.w,vscroll+2.w
	move.w	scra_hz.w,d4
	ext.l	d4
	asl.l	#5,d4
	moveq	#6,d6
	bsr.w	scrollz_h
	move.w	scra_hz.w,d4
	ext.l	d4
	asl.l	#6,d4
	moveq	#4,d6
	bsr.w	scrollc_h
	lea	linework+$10.w,a1
	move.w	scra_hz.w,d4
	ext.l	d4
	asl.l	#7,d4
	move.w	scra_vz.w,d5
	ext.l	d5
	asl.l	#4,d5
	move.l	d5,d3
	add.l	d5,d5
	add.l	d3,d5
	bsr.w	scrollb_hv
	move.w	scrb_v_posit.w,vscroll+2.w
	move.w	scrb_v_posit.w,scrc_v_posit.w
	move.w	scrb_v_posit.w,scrz_v_posit.w
	move.b	scrflagz.w,d0
	or.b	scrflagc.w,d0
	or.b	d0,scrflagb.w
	clr.b	scrflagz.w
	clr.b	scrflagc.w
	lea	linework.w,a2
	addi.l	#$10000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$4000,(a2)+
	move.w	scra_h_posit.w,d0
	neg.w	d0
	swap	d0
	move.w	linework.w,d0
	add.w	scrz_h_posit.w,d0
	neg.w	d0
	move.w	#4-1,d1

loc_202616:
	move.w	d0,(a1)+
	dbf	d1,loc_202616

	move.w	linework+4.w,d0
	add.w	scrz_h_posit.w,d0
	neg.w	d0
	move.w	#4-1,d1

loc_20262A:
	move.w	d0,(a1)+
	dbf	d1,loc_20262A

	move.w	linework+8.w,d0
	add.w	scrz_h_posit.w,d0
	neg.w	d0
	move.w	#3-1,d1

loc_20263E:
	move.w	d0,(a1)+
	dbf	d1,loc_20263E

	move.w	linework+$C.w,d0
	add.w	scrz_h_posit.w,d0
	neg.w	d0
	move.w	#1-1,d1

loc_202652:
	move.w	d0,(a1)+
	dbf	d1,loc_202652

	move.w	#6-1,d1
	move.w	scrz_h_posit.w,d0
	neg.w	d0

loc_202662:
	move.w	d0,(a1)+
	dbf	d1,loc_202662

	move.w	#8-1,d1
	move.w	scrc_h_posit.w,d0
	neg.w	d0

loc_202672:
	move.w	d0,(a1)+
	dbf	d1,loc_202672

	lea	hscrollwork.w,a1
	lea	linework+$10.w,a2
	move.w	scrb_v_posit.w,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	move.w	d0,d3
	lsr.w	#1,d3
	moveq	#$19,d1
	moveq	#$1C,d5
	sub.w	d3,d1
	blo.s	loc_2026A2
	sub.w	d1,d5
	lea	(a2,d0.w),a2
	bsr.w	sub_2026D4

loc_2026A2:
	move.w	scrc_h_posit.w,d0
	move.w	scra_h_posit.w,d2
	sub.w	d0,d2
	ext.l	d2
	asl.l	#8,d2
	divs.w	#256,d2
	ext.l	d2
	asl.l	#8,d2
	moveq	#0,d3
	move.w	d0,d3
	move.w	d5,d1
	lsl.w	#3,d1
	subq.w	#1,d1

loc_2026C2:
	move.w	d3,d0
	neg.w	d0
	move.l	d0,(a1)+
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d1,loc_2026C2
	rts

sub_2026D4:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_2026E2(pc,d2.w)

loc_2026E0:
	move.w	(a2)+,d0

loc_2026E2:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_2026E0
	rts

	neg.w	d0
	jmp	loc_202700(pc,d2.w)

	neg.w	d0

loc_202700:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_2026E0
	rts

scroll_h:
	move.w	scra_h_posit.w,d4
	bsr.s	scrh_move
	move.w	scra_h_posit.w,d0
	andi.w	#$10,d0
	move.b	scra_h_count.w,d1
	eor.b	d1,d0
	bne.s	locret_202748
	eori.b	#$10,scra_h_count.w
	move.w	scra_h_posit.w,d0
	sub.w	d4,d0
	bpl.s	loc_202742
	bset	#2,scrflaga.w
	rts

loc_202742:
	bset	#3,scrflaga.w

locret_202748:
	rts

scrh_move:
	move.w	xposi(a6),d0
	sub.w	scra_h_posit.w,d0
	subi.w	#144,d0
	blt.s	loc_20278E
	subi.w	#16,d0
	bge.s	loc_202764
	clr.w	scra_hz.w
	rts

loc_202764:
	cmpi.w	#16,d0
	blt.s	loc_20276E
	move.w	#16,d0

loc_20276E:
	add.w	scra_h_posit.w,d0
	cmp.w	scralim_right.w,d0
	blt.s	loc_20277C
	move.w	scralim_right.w,d0

loc_20277C:
	move.w	d0,d1
	sub.w	scra_h_posit.w,d1
	asl.w	#8,d1
	move.w	d0,scra_h_posit.w
	move.w	d1,scra_hz.w
	rts

loc_20278E:
	cmpi.w	#-16,d0
	bge.s	loc_202798
	move.w	#-16,d0

loc_202798:
	add.w	scra_h_posit.w,d0
	cmp.w	scralim_left.w,d0
	bgt.s	loc_20277C
	move.w	scralim_left.w,d0
	bra.s	loc_20277C

	tst.w	d0
	bpl.s	loc_2027B2
	move.w	#-2,d0
	bra.s	loc_20278E

loc_2027B2:
	move.w	#2,d0
	bra.s	loc_202764

scroll_v:
	moveq	#0,d1
	move.w	yposi(a6),d0
	sub.w	scra_v_posit.w,d0
	btst	#cd_ball,cddat(a6)
	beq.s	loc_2027CC
	subq.w	#walkheight-rollheight,d0

loc_2027CC:
	btst	#cd_jump,cddat(a6)
	beq.s	loc_2027EC
	addi.w	#32,d0
	sub.w	scra_vline.w,d0
	blo.s	sv_move_main2
	subi.w	#64,d0
	bhs.s	sv_move_main2
	tst.b	limmoveflag.w
	bne.s	sv_move_sub2
	bra.s	loc_2027F8

loc_2027EC:
	sub.w	scra_vline.w,d0
	bne.s	sv_move_main
	tst.b	limmoveflag.w
	bne.s	sv_move_sub2

loc_2027F8:
	clr.w	scra_vz.w
	rts

sv_move_main:
	cmpi.w	#$60,scra_vline.w
	bne.s	sv_move_main1
	move.w	mspeed(a6),d1
	bpl.s	loc_20280E
	neg.w	d1

loc_20280E:
	cmpi.w	#$800,d1
	bhs.s	sv_move_main2
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	sv_move_plus
	cmpi.w	#-6,d0
	blt.s	sv_move_minus
	bra.s	sv_move_sub

sv_move_main1:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	sv_move_plus
	cmpi.w	#-2,d0
	blt.s	sv_move_minus
	bra.s	sv_move_sub

sv_move_main2:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	sv_move_plus
	cmpi.w	#-$10,d0
	blt.s	sv_move_minus
	bra.s	sv_move_sub

sv_move_sub2:
	moveq	#0,d0
	move.b	d0,limmoveflag.w

sv_move_sub:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scra_v_posit.w,d1
	tst.w	d0
	bpl.w	scrv_down_ch
	bra.w	scrv_up_ch

sv_move_minus:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scra_v_posit.w,d1
	swap	d1

scrv_up_ch:
	cmp.w	scralim_up.w,d1
	bgt.s	scrv_move
	cmpi.w	#-$100,d1
	bgt.s	loc_202892
	andi.w	#$7FF,d1
	andi.w	#$7FF,yposi(a6)
	andi.w	#$7FF,scra_v_posit.w
	andi.w	#$3FF,scrb_v_posit.w
	bra.s	scrv_move

loc_202892:
	move.w	scralim_up.w,d1
	bra.s	scrv_move

sv_move_plus:
	ext.l	d1
	asl.l	#8,d1
	add.l	scra_v_posit.w,d1
	swap	d1

scrv_down_ch:
	cmp.w	scralim_down.w,d1
	blt.s	scrv_move
	subi.w	#$800,d1
	blo.s	loc_2028C2
	andi.w	#$7FF,yposi(a6)
	subi.w	#$800,scra_v_posit.w
	andi.w	#$3FF,scrb_v_posit.w
	bra.s	scrv_move

loc_2028C2:
	move.w	scralim_down.w,d1

scrv_move:
	move.w	scra_v_posit.w,d4
	swap	d1
	move.l	d1,d3
	sub.l	scra_v_posit.w,d3
	ror.l	#8,d3
	move.w	d3,scra_vz.w
	move.l	d1,scra_v_posit.w
	move.w	scra_v_posit.w,d0
	andi.w	#$10,d0
	move.b	scra_v_count.w,d1
	eor.b	d1,d0
	bne.s	locret_202908
	eori.b	#$10,scra_v_count.w
	move.w	scra_v_posit.w,d0
	sub.w	d4,d0
	bpl.s	loc_202902
	bset	#0,scrflaga.w
	rts

loc_202902:
	bset	#1,scrflaga.w

locret_202908:
	rts

scrollb_hv:
	move.l	scrb_h_posit.w,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scrb_h_posit.w
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scrb_h_count.w,d3
	eor.b	d3,d1
	bne.s	loc_20293E
	eori.b	#$10,scrb_h_count.w
	sub.l	d2,d0
	bpl.s	loc_202938
	bset	#2,scrflagb.w
	bra.s	loc_20293E

loc_202938:
	bset	#3,scrflagb.w

loc_20293E:
	move.l	scrb_v_posit.w,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scrb_v_posit.w
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scrb_v_count.w,d2
	eor.b	d2,d1
	bne.s	locret_202972
	eori.b	#$10,scrb_v_count.w
	sub.l	d3,d0
	bpl.s	loc_20296C
	bset	#0,scrflagb.w
	rts

loc_20296C:
	bset	#1,scrflagb.w

locret_202972:
	rts

	move.l	scrb_v_posit.w,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scrb_v_posit.w
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scrb_v_count.w,d2
	eor.b	d2,d1
	bne.s	locret_2029A8
	eori.b	#$10,scrb_v_count.w
	sub.l	d3,d0
	bpl.s	loc_2029A2
	bset	#4,scrflagb.w
	rts

loc_2029A2:
	bset	#5,scrflagb.w

locret_2029A8:
	rts

scrollb_v:
	move.w	scrb_v_posit.w,d3
	move.w	d0,scrb_v_posit.w
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scrb_v_count.w,d2
	eor.b	d2,d1
	bne.s	locret_2029D8
	eori.b	#$10,scrb_v_count.w
	sub.w	d3,d0
	bpl.s	loc_2029D2
	bset	#0,scrflagb.w
	rts

loc_2029D2:
	bset	#1,scrflagb.w

locret_2029D8:
	rts

scrollb_h:
	move.l	scrb_h_posit.w,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scrb_h_posit.w
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scrb_h_count.w,d3
	eor.b	d3,d1
	bne.s	locret_202A0C
	eori.b	#$10,scrb_h_count.w
	sub.l	d2,d0
	bpl.s	loc_202A06
	bset	d6,scrflagb.w
	bra.s	locret_202A0C

loc_202A06:
	addq.b	#1,d6
	bset	d6,scrflagb.w

locret_202A0C:
	rts

scrollc_h:
	move.l	scrc_h_posit.w,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scrc_h_posit.w
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scrc_h_count.w,d3
	eor.b	d3,d1
	bne.s	locret_202A40
	eori.b	#$10,scrc_h_count.w
	sub.l	d2,d0
	bpl.s	loc_202A3A
	bset	d6,scrflagc.w
	bra.s	locret_202A40

loc_202A3A:
	addq.b	#1,d6
	bset	d6,scrflagc.w

locret_202A40:
	rts

scrollz_h:
	move.l	scrz_h_posit.w,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scrz_h_posit.w
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scrz_h_count.w,d3
	eor.b	d3,d1
	bne.s	locret_202A74
	eori.b	#$10,scrz_h_count.w
	sub.l	d2,d0
	bpl.s	loc_202A6E
	bset	d6,scrflagz.w
	bra.s	locret_202A74

loc_202A6E:
	addq.b	#1,d6
	bset	d6,scrflagz.w

locret_202A74:
	rts

scrollwrtadva:
	lea	vdpctrl,a5
	lea	vdpdata,a6
	lea	scrflagb.w,a2
	lea	scrb_h_posit.w,a3
	lea	mapwkb.w,a4
	move.w	#$6000,d2
	bsr.w	scrollwrtb
	lea	scrflagc.w,a2
	lea	scrc_h_posit.w,a3
	bra.w	scrollwrtc

scrollwrt:
	lea	vdpctrl,a5
	lea	vdpdata,a6
	lea	scrflagbw,a2
	lea	scrb_h_posiw,a3
	lea	mapwkb.w,a4
	move.w	#$6000,d2
	bsr.w	scrollwrtb
	lea	scrflagcw,a2
	lea	scrc_h_posiw,a3
	bsr.w	scrollwrtc
	lea	scrflagzw,a2
	lea	scrz_h_posiw,a3
	bsr.w	scrollwrtz
	lea	scrflagaw,a2
	lea	scra_h_posiw,a3
	lea	mapwka.w,a4
	move.w	#$4000,d2
	tst.b	(a2)
	beq.s	locret_202B5E
	bclr	#0,(a2)
	beq.s	loc_202B14
	moveq	#-16,d4
	moveq	#-16,d5
	bsr.w	vramadrset
	moveq	#-16,d4
	moveq	#-16,d5
	bsr.w	hblockwrt

loc_202B14:
	bclr	#1,(a2)
	beq.s	loc_202B2E
	move.w	#224,d4
	moveq	#-16,d5
	bsr.w	vramadrset
	move.w	#224,d4
	moveq	#-16,d5
	bsr.w	hblockwrt

loc_202B2E:
	bclr	#2,(a2)
	beq.s	loc_202B44
	moveq	#-16,d4
	moveq	#-16,d5
	bsr.w	vramadrset
	moveq	#-16,d4
	moveq	#-16,d5
	bsr.w	vblockwrt

loc_202B44:
	bclr	#3,(a2)
	beq.s	locret_202B5E
	moveq	#-16,d4
	move.w	#320,d5
	bsr.w	vramadrset
	moveq	#-16,d4
	move.w	#320,d5
	bsr.w	vblockwrt

locret_202B5E:
	rts

scrollwrtb:
	lea	z81awrttbl.l,a0
	adda.w	#1,a0
	moveq	#-16,d4
	bclr	#0,(a2)
	bne.s	loc_202B7C
	bclr	#1,(a2)
	beq.s	loc_202BC6
	move.w	#224,d4

loc_202B7C:
	move.w	scrb_v_posit.w,d0
	add.w	d4,d0
	andi.w	#$FFF0,d0
	asr.w	#4,d0
	move.b	(a0,d0.w),d0
	ext.w	d0
	add.w	d0,d0
	movea.l	vblockwrtbtbl(pc,d0.w),a3
	beq.s	loc_202BAE
	moveq	#-16,d5
	move.l	a0,-(sp)
	movem.l	d4-d5,-(sp)
	bsr.w	vramadrset
	movem.l	(sp)+,d4-d5
	bsr.w	hblockwrt
	movea.l	(sp)+,a0
	bra.s	loc_202BC6

loc_202BAE:
	moveq	#0,d5
	move.l	a0,-(sp)
	movem.l	d4-d5,-(sp)
	bsr.w	vramadrset1
	movem.l	(sp)+,d4-d5
	moveq	#$20-1,d6
	bsr.w	hblockwrt1
	movea.l	(sp)+,a0

loc_202BC6:
	tst.b	(a2)
	bne.s	loc_202bhs
	rts

loc_202bhs:
	moveq	#-16,d4
	moveq	#-16,d5
	move.b	(a2),d0
	andi.b	#$A8,d0
	beq.s	loc_202BE0
	lsr.b	#1,d0
	move.b	d0,(a2)
	move.w	#320,d5

loc_202BE0:
	move.w	scrb_v_posit.w,d0
	andi.w	#$FFF0,d0
	asr.w	#4,d0
	suba.w	#1,a0
	lea	(a0,d0.w),a0
	bra.w	loc_202C06

vblockwrtbtbl:
	dc.l	scrb_h_posiw
	dc.l	scrb_h_posiw
	dc.l	scrc_h_posiw
	dc.l	scrz_h_posiw

loc_202C06:
	moveq	#16-1,d6
	move.l	#$800000,d7

loc_202C0E:
	moveq	#0,d0
	move.b	(a0)+,d0
	btst	d0,(a2)
	beq.s	loc_202C38
	add.w	d0,d0
	movea.l	vblockwrtbtbl(pc,d0.w),a3
	movem.l	d4-d5/a0,-(sp)
	movem.l	d4-d5,-(sp)
	bsr.w	mapadrset
	movem.l	(sp)+,d4-d5
	bsr.w	vramadrset
	bsr.w	blockwrt
	movem.l	(sp)+,d4-d5/a0

loc_202C38:
	addi.w	#16,d4
	dbf	d6,loc_202C0E
	clr.b	(a2)
	rts

scrollwrtc:
	rts

scrollwrtz:
	rts

hblockwrt:
	moveq	#$16-1,d6

loc_202C4A:
	move.l	#$800000,d7
	move.l	d0,d1

loc_202C52:
	movem.l	d4-d5,-(sp)
	bsr.w	mapadrset
	move.l	d1,d0
	bsr.w	blockwrt
	addq.b	#4,d1
	andi.b	#$7F,d1
	movem.l	(sp)+,d4-d5
	addi.w	#16,d5
	dbf	d6,loc_202C52
	rts

hblockwrt1:
	move.l	#$800000,d7
	move.l	d0,d1

loc_202C7C:
	movem.l	d4-d5,-(sp)
	bsr.w	mapadrset1
	move.l	d1,d0
	bsr.w	blockwrt
	addq.b	#4,d1
	andi.b	#$7F,d1
	movem.l	(sp)+,d4-d5
	addi.w	#16,d5
	dbf	d6,loc_202C7C
	rts

vblockwrt:
	moveq	#16-1,d6
	move.l	#$800000,d7
	move.l	d0,d1

loc_202CA8:
	movem.l	d4-d5,-(sp)
	bsr.w	mapadrset
	move.l	d1,d0
	bsr.w	blockwrt
	addi.w	#$100,d1
	andi.w	#$FFF,d1
	movem.l	(sp)+,d4-d5
	addi.w	#16,d4
	dbf	d6,loc_202CA8
	rts

blockwrt:
	or.w	d2,d0
	swap	d0
	btst	#4,(a0)
	bne.s	loc_202D08
	btst	#3,(a0)
	bne.s	loc_202CE8
	move.l	d0,(a5)
	move.l	(a1)+,(a6)
	add.l	d7,d0
	move.l	d0,(a5)
	move.l	(a1)+,(a6)
	rts

loc_202CE8:
	move.l	d0,(a5)
	move.l	(a1)+,d4
	eori.l	#$8000800,d4
	swap	d4
	move.l	d4,(a6)
	add.l	d7,d0
	move.l	d0,(a5)
	move.l	(a1)+,d4
	eori.l	#$8000800,d4
	swap	d4
	move.l	d4,(a6)
	rts

loc_202D08:
	btst	#3,(a0)
	bne.s	loc_202D2A
	move.l	d0,(a5)
	move.l	(a1)+,d5
	move.l	(a1)+,d4
	eori.l	#$10001000,d4
	move.l	d4,(a6)
	add.l	d7,d0
	move.l	d0,(a5)
	eori.l	#$10001000,d5
	move.l	d5,(a6)
	rts

loc_202D2A:
	move.l	d0,(a5)
	move.l	(a1)+,d5
	move.l	(a1)+,d4
	eori.l	#$18001800,d4
	swap	d4
	move.l	d4,(a6)
	add.l	d7,d0
	move.l	d0,(a5)
	eori.l	#$18001800,d5
	swap	d5
	move.l	d5,(a6)
	rts

mapadrset:
	add.w	(a3),d5

mapadrset1:
	add.w	4(a3),d4

mapadrset2:
	lea	blockwk.w,a1
	move.w	d4,d3
	lsr.w	#1,d3
	andi.w	#$380,d3
	lsr.w	#3,d5
	move.w	d5,d0
	lsr.w	#5,d0
	andi.w	#$7F,d0
	add.w	d3,d0
	move.l	#mapwk,d3
	move.b	(a4,d0.w),d3
	beq.s	locret_202D98
	subq.b	#1,d3
	andi.w	#$7F,d3
	ror.w	#7,d3
	add.w	d4,d4
	andi.w	#$1E0,d4
	andi.w	#$1E,d5
	add.w	d4,d3
	add.w	d5,d3
	movea.l	d3,a0
	move.w	(a0),d3
	andi.w	#$3FF,d3
	lsl.w	#3,d3
	adda.w	d3,a1
	moveq	#1,d0

locret_202D98:
	rts

	move.w	d4,d3
	lsr.w	#1,d3
	andi.w	#$380,d3
	lsr.w	#3,d5
	move.w	d5,d0
	lsr.w	#5,d0
	andi.w	#$7F,d0
	add.w	d3,d0
	move.l	#mapwk,d3
	move.b	(a4,d0.w),d3
	subq.b	#1,d3
	andi.w	#$7F,d3
	ror.w	#7,d3
	add.w	d4,d4
	andi.w	#$1E0,d4
	andi.w	#$1E,d5
	add.w	d4,d3
	add.w	d5,d3
	movea.l	d3,a0
	rts

block_wrt:
	move.l	a0,-(sp)
	lea	mapwka.w,a4
	lea	vdpctrl,a5
	lea	vdpdata,a6
	move.w	#$4000,d2
	move.l	#$800000,d7
	movem.l	d3-d5,-(sp)
	bsr.w	mapadrset2
	bne.s	loc_202DFE
	movem.l	(sp)+,d3-d5
	bra.s	loc_202E26

loc_202DFE:
	movem.l	(sp)+,d3-d5
	move.w	d3,(a0)
	bsr.w	block_chk
	bne.s	loc_202E26
	movem.l	d3-d5,-(sp)
	lea	blockwk.w,a1
	andi.w	#$3FF,d3
	lsl.w	#3,d3
	adda.w	d3,a1
	bsr.w	vramadrset0
	bsr.w	blockwrt
	movem.l	(sp)+,d3-d5

loc_202E26:
	movea.l	(sp)+,a0
	rts

block_chk:
	move.w	scra_v_posit.w,d0
	move.w	d0,d1
	andi.w	#$FFF0,d0
	subi.w	#16,d0
	cmp.w	d0,d4
	blo.s	loc_202E6A
	addi.w	#224+16,d1
	andi.w	#$FFF0,d1
	cmp.w	d1,d4
	bgt.s	loc_202E6A
	move.w	scra_h_posit.w,d0
	move.w	d0,d1
	andi.w	#$FFF0,d0
	subi.w	#16,d0
	cmp.w	d0,d5
	blo.s	loc_202E6A
	addi.w	#320+16,d1
	andi.w	#$FFF0,d1
	cmp.w	d1,d5
	bgt.s	loc_202E6A
	moveq	#0,d0
	rts

loc_202E6A:
	moveq	#1,d0
	rts

vramadrset:
	add.w	(a3),d5

vramadrset1:
	add.w	4(a3),d4

vramadrset0:
	andi.w	#$F0,d4
	andi.w	#$1F0,d5
	lsl.w	#4,d4
	lsr.w	#2,d5
	add.w	d5,d4
	moveq	#3,d0
	swap	d0
	move.w	d4,d0
	rts

	add.w	4(a3),d4
	add.w	(a3),d5
	andi.w	#$F0,d4
	andi.w	#$1F0,d5
	lsl.w	#4,d4
	lsr.w	#2,d5
	add.w	d5,d4
	moveq	#2,d0
	swap	d0
	move.w	d4,d0
	rts

mapwrt:
	lea	vdpctrl,a5
	lea	vdpdata,a6
	lea	scra_h_posit.w,a3
	lea	mapwka.w,a4
	move.w	#$4000,d2
	bsr.s	mapwrt2
	lea	scrb_h_posit.w,a3
	lea	mapwkb.w,a4
	move.w	#$6000,d2
	bra.w	mapwrt_z81a

mapwrt2:
	moveq	#-16,d4
	moveq	#16-1,d6

mapwrt3:
	movem.l	d4-d6,-(sp)
	moveq	#0,d5
	move.w	d4,d1
	bsr.w	vramadrset
	move.w	d1,d4
	moveq	#0,d5
	moveq	#$20-1,d6
	bsr.w	loc_202C4A
	movem.l	(sp)+,d4-d6
	addi.w	#16,d4
	dbf	d6,mapwrt3
	rts

mapwrt_z81a:
	moveq	#-16,d4
	moveq	#16-1,d6

loc_202EFC:
	movem.l	d4-d6/a0,-(sp)
	lea	z81awrttbl.l,a0
	adda.w	#1,a0
	move.w	scrb_v_posit.w,d0
	add.w	d4,d0
	andi.w	#$1F0,d0
	bsr.w	mapwrt_sub
	movem.l	(sp)+,d4-d6/a0
	addi.w	#16,d4
	dbf	d6,loc_202EFC
	rts

z81awrttbl:
	dc.b	0,0,0,0,0,0,0,6,6,6
	dc.b	4,4,4,4,0,0,0,0,0,0
	dc.b	0,0,0,0,0,0,0,0,0,0
	dc.b	0,0,0,0
	even

mapwrt_tbl:
	dc.l	scrb_h_posit&$FFFFFF
	dc.l	scrb_h_posit&$FFFFFF
	dc.l	scrc_h_posit&$FFFFFF
	dc.l	scrz_h_posit&$FFFFFF

mapwrt_sub:
	lsr.w	#4,d0
	move.b	(a0,d0.w),d0
	add.w	d0,d0
	movea.l	mapwrt_tbl(pc,d0.w),a3
	beq.s	loc_202F7A
	moveq	#-16,d5
	movem.l	d4-d5,-(sp)
	bsr.w	vramadrset
	movem.l	(sp)+,d4-d5
	bsr.w	hblockwrt
	bra.s	locret_202F8E

loc_202F7A:
	moveq	#0,d5
	movem.l	d4-d5,-(sp)
	bsr.w	vramadrset1
	movem.l	(sp)+,d4-d5
	moveq	#$20-1,d6
	bsr.w	hblockwrt1

locret_202F8E:
	rts

mapinit:
	moveq	#0,d0
;	move.b	stageno,d0
;	lsl.w	#4,d0
	lea	mapinittbl.l,a2
	move.l	a2,-(sp)
	addq.l	#4,a2
	movea.l	(a2)+,a0
	lea	blockwk.w,a4
	bsr.w	bitdevr_work
	movea.l	(a2)+,a0
	lea	mapwk.l,a1
	bsr.w	unlze
	bsr.w	mapset
	move.w	(a2)+,d0
;	bsr.w	bgmset
	move.w	(a2),d0
	andi.w	#$FF,d0
	bsr.w	colorset
	movea.l	(sp)+,a2
	addq.w	#4,a2
	btst	#7,time_flag
	beq.s	loc_202FD6
	jmp	enecginit.l

loc_202FD6:
	moveq	#0,d0
	move.b	(a2),d0
	beq.s	locret_202FE0
	bsr.w	divdevset

locret_202FE0:
	rts

mapset:
	lea	mapwka.w,a3
	move.w	#(mapwka_end-mapwka)/2-1,d1
	moveq	#0,d0

.loop:
	move.l	d0,(a3)+
	dbf	d1,.loop

	lea	mapwka.w,a3
	moveq	#0,d1
	bsr.w	mapset_sub
	lea	mapwkb.w,a3
	moveq	#2,d1

mapset_sub:
	moveq	#0,d0
	add.w	d1,d0
	lea	zonemaptbl.l,a1
	move.w	(a1,d0.w),d0
	lea	(a1,d0.w),a1
	moveq	#0,d1
	move.w	d1,d2
	move.b	(a1)+,d1
	move.b	(a1)+,d2

.loop:
	move.w	d1,d0
	movea.l	a3,a0

.loop1:
	move.b	(a1)+,(a0)+
	dbf	d0,.loop1

	lea	$80(a3),a3
	dbf	d2,.loop

	rts