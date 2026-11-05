	phase	$FFFF0000
	ds.b	$580
ta_flag:		ds.b	1
	ds.b	$A7F
	dephase
	phase	$FF1000
stacksave:		ds.b	$200
stacksave_end:
	ds.b	2
gameflag:		ds.w	1
gametimer:		ds.w	1
editno:			ds.b	1
	ds.b	1
editmode:		ds.w	1
edittimer:		ds.w	1	; unused
systemtimer:		ds.l	1
stageno:		ds.b	1
stageact:		ds.b	1
pl_suu:			ds.b	1
	ds.b	1
pl_air:			ds.w	1
	ds.b	3
main_play:		ds.b	1
pltimeover_f:		ds.b	1
plring_f2:		ds.b	1
pl_suu_f:		ds.b	1
plring_f:		ds.b	1
pltime_f:		ds.b	1
plscore_f:		ds.b	1
plring:			ds.w	1
pltime:			ds.l	1
plscore:		ds.l	1
play_start:		ds.b	1
	ds.b	1
plpower_b:		ds.b	1
plpower_m:		ds.b	1
plpower_s:		ds.b	1
plpower_a:		ds.b	1
plflag:			ds.b	1
plflag_s:		ds.b	1
plxposi_s:		ds.w	1
plyposi_s:		ds.w	1
plring_s:		ds.w	1
pltime_s:		ds.l	1
zone_flag_s:		ds.b	1
time_flag:		ds.b	1
scralim_down_s:		ds.w	1
scra_h_posit_s:		ds.w	1
scra_v_posit_s:		ds.w	1
scrb_h_posit_s:		ds.w	1
scrb_v_posit_s:		ds.w	1
scrc_h_posit_s:		ds.w	1
scrc_v_posit_s:		ds.w	1
scrz_h_posit_s:		ds.w	1
scrz_v_posit_s:		ds.w	1
waterposi_m_s:		ds.w	1
water_flag_s:		ds.b	1
waterflag_s:		ds.b	1
plring_f2_s:		ds.b	1
plflag_sb:		ds.b	1
plxposi_sb:		ds.w	1
plyposi_sb:		ds.w	1
zone_flag_sb:		ds.b	1
	ds.b	1
scralim_down_sb:	ds.w	1
scra_h_posit_sb:	ds.w	1
scra_v_posit_sb:	ds.w	1
scrb_h_posit_sb:	ds.w	1
scrb_v_posit_sb:	ds.w	1
scrc_h_posit_sb:	ds.w	1
scrc_v_posit_sb:	ds.w	1
scrz_h_posit_sb:	ds.w	1
scrz_v_posit_sb:	ds.w	1
waterposi_m_sb:		ds.w	1
water_flag_sb:		ds.b	1
waterflag_sb:		ds.b	1
	ds.b	6
time_stop:		ds.w	1
generate_flag:		ds.b	1
plsubchg_flag:		ds.b	1
	ds.b	$44
sys_pattim:		ds.b	1
sys_patno:		ds.b	1
sys_pattim2:		ds.b	1
sys_patno2:		ds.b	1
sys_pattim3:		ds.b	1
sys_patno3:		ds.b	1
sys_pattim4:		ds.b	1
sys_patno4:		ds.b	1
sys_ringtimer:		ds.w	1
	ds.b	$26
editstack:		ds.w	1	; unused
editstack2:		ds.w	1	; unused
enecgpnt:		ds.b	1
enecgflg:		ds.b	1
	ds.b	$1A
scra_h_posiw:		ds.l	1
scra_v_posiw:		ds.l	1	; unused
scrb_h_posiw:		ds.l	1
scrb_v_posiw:		ds.l	1	; unused
scrc_h_posiw:		ds.l	1
scrc_v_posiw:		ds.l	1	; unused
scrz_h_posiw:		ds.l	1
scrz_v_posiw:		ds.l	1	; unused
scrflagaw:		ds.w	1
scrflagbw:		ds.w	1
scrflagcw:		ds.w	1
scrflagzw:		ds.w	1
	ds.b	$88
extrascore:		ds.l	1	; unused
	ds.b	$28
debugwork:		ds.b	1
debugwork2:		ds.b	1
debugwork3:		ds.b	1
debugwork4:		ds.b	1
demoflag:		ds.w	1
demono:			ds.w	1	; unused
enddemono:		ds.w	1
	ds.b	2
mdstatus:		ds.b	1
	ds.b	1
debugflag:		ds.w	1
init_flag:		ds.l	1
flagwork:		ds.b	$180
flagwork_end:
flowwk:			ds.b	$300
flowercnt:		ds.b	3
tv_flag:		ds.b	1
word_FF1884:		ds.w	1
byte_FF1886:		ds.b	1
	ds.b	3
byte_FF188A:		ds.b	1
	ds.b	$75
powerupwrtwk:		ds.b	$480
powerupwrtwk_end:
	ds.b	$6280
	dephase
	!org 0