playloadb:
	move.b	plflag_sb,plflag
	move.w	plxposi_sb,xposi(a6)
	move.w	plyposi_sb,yposi(a6)
	move.b	zone_flag_sb,zone_flag.w
	move.b	water_flag_sb,water_flag.w
	move.w	scralim_down_sb,scralim_down.w
	move.w	scralim_down_sb,scralim_n_down.w
	move.w	scra_h_posit_sb,scra_h_posit.w
	move.w	scra_v_posit_sb,scra_v_posit.w
	move.w	scrb_h_posit_sb,scrb_h_posit.w
	move.w	scrb_v_posit_sb,scrb_v_posit.w
	move.w	scrc_h_posit_sb,scrc_h_posit.w
	move.w	scrc_v_posit_sb,scrc_v_posit.w
	move.w	scrz_h_posit_sb,scrz_h_posit.w
	move.w	scrz_v_posit_sb,scrz_v_posit.w
	cmpi.b	#stage_lz,stageno
	bne.s	loc_205ECC
	move.w	waterposi_m_sb,waterposi_m.w
	move.b	water_flag_sb,water_flag.w
	move.b	waterflag_sb,waterflag.w

loc_205ECC:
	tst.b	plflag
	bpl.s	locret_205EE2
	move.w	plxposi_sb,d0
	subi.w	#160,d0
	move.w	d0,scralim_left.w

locret_205EE2:
	rts

playload:
	cmpi.b	#2,plflag
	beq.w	playloadb
	move.b	plflag_s,plflag
	move.w	plxposi_s,xposi(a6)
	move.w	plyposi_s,yposi(a6)
	move.w	plring_s,plring
	move.b	plring_f2_s,plring_f2
	clr.w	plring
	clr.b	plring_f2
	move.l	pltime_s,pltime
	move.b	#59,pltime+3
	subq.b	#1,pltime+2
	move.b	zone_flag_s,zone_flag.w
	move.b	water_flag_s,water_flag.w
	move.w	scralim_down_s,scralim_down.w
	move.w	scralim_down_s,scralim_n_down.w
	move.w	scra_h_posit_s,scra_h_posit.w
	move.w	scra_v_posit_s,scra_v_posit.w
	move.w	scrb_h_posit_s,scrb_h_posit.w
	move.w	scrb_v_posit_s,scrb_v_posit.w
	move.w	scrc_h_posit_s,scrc_h_posit.w
	move.w	scrc_v_posit_s,scrc_v_posit.w
	move.w	scrz_h_posit_s,scrz_h_posit.w
	move.w	scrz_v_posit_s,scrz_v_posit.w
	cmpi.b	#stage_lz,stageno
	bne.s	loc_205FC4
	move.w	waterposi_m_s,waterposi_m.w
	move.b	water_flag_s,water_flag.w
	move.b	waterflag_s,waterflag.w

loc_205FC4:
	tst.b	plflag
	bpl.s	locret_205FDA
	move.w	plxposi_s,d0
	subi.w	#160,d0
	move.w	d0,scralim_left.w

locret_205FDA:
	rts