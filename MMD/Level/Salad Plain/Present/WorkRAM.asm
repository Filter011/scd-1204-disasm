; ===========================================================================
; Segment type: Regular
; segment "RAM"

	include	"s1.sounddriver.ram.asm"

	phase	$FF0000
	ds.b	$580
byte_FF0580:		ds.b	1
byte_FF0580_ext:	equ	byte_FF0580+$FF<<24
	ds.b	$A7F
stackwk:		ds.b	$200
stackwk_end:
	ds.b	2
gameflag:		ds.w	1
gametimer:		ds.w	1
byte_FF1206:		ds.b	1
	ds.b	1
editmode:		ds.w	1
	ds.b	2
dword_FF120C:		ds.l	1
stageno:		ds.b	1
stageact:		ds.b	1
pl_suu:			ds.b	1
	ds.b	1
pl_air:			ds.w	1
	ds.b	3
byte_FF1219:		ds.b	1
pltimeover_f:		ds.b	1
plring_f2:		ds.b	1
pl_suu_f:		ds.b	1
plring_f:		ds.b	1
pltime_f:		ds.b	1
plscore_f:		ds.b	1
plring:			ds.w	1
pltime:			ds.b	1
byte_FF1223:		ds.b	1
byte_FF1224:		ds.b	1
byte_FF1225:		ds.b	1
dword_FF1226:		ds.l	1
byte_FF122A:		ds.b	1
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
byte_FF123C:		ds.b	1
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
byte_FF125A:		ds.b	1
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
word_FF1278:		ds.w	1
byte_FF127A:		ds.b	1
byte_FF127B:		ds.b	1
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
	ds.b	$2A
word_FF12F4:		ds.w	1
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
	ds.b	$B4
debugwork:		ds.b	1
debugwork2:		ds.b	1
debugwork3:		ds.b	1
debugwork4:		ds.b	1
word_FF13F0:		ds.w	1
	ds.b	2
word_FF13F4:		ds.w	1
	ds.b	2
mdstatus:		ds.b	1
	ds.b	1
debugflag:		ds.w	1
init_f:			ds.l	1
flagwork:		ds.b	$180
flagwork_end:
byte_FF1580:		ds.b	$300
dword_FF1880:		ds.l	1
word_FF1884:		ds.w	1
byte_FF1886:		ds.b	1
	ds.b	3
byte_FF188A:		ds.b	1
	ds.b	$75
powerupwrtwk:		ds.b	$300
powerupwrtwk_end:
	ds.b	$180
powerupwrtwk_dma_end:
	ds.b	$6280
	dephase
	!org 0

	phase	$FFFF8000
	ds.b	$2400
mapwka:			ds.b	$400
mapwkb:			equ	mapwka+$40
mapwka_end:
linework:		ds.b	$200
bitdevwk:		ds.b	$200
pbuffer:		ds.b	$400
blockwk:		ds.b	$1800
playwrtwk:		ds.b	$2E0
playwrtwk_end:
	ds.b	$20
playposiwk:		ds.b	$100
hscrollwork:		ds.b	$380
hscrollwork_end:
	ds.b	$80
hscrollwork_end_padded:
actwk:			ds.b	actfree
byte_FFD040:		ds.b	actfree
byte_FFD080:		ds.b	actfree
byte_FFD0C0:		ds.b	actfree
byte_FFD100:		ds.b	actfree
byte_FFD140:		ds.b	actfree
byte_FFD180:		ds.b	actfree
byte_FFD1C0:		ds.b	actfree
byte_FFD200:		ds.b	actfree
byte_FFD240:		ds.b	actfree
byte_FFD280:		ds.b	actfree
byte_FFD2C0:		ds.b	actfree
byte_FFD300:		ds.b	actfree
byte_FFD340:		ds.b	actfree
byte_FFD380:		ds.b	actfree
byte_FFD3C0:		ds.b	actfree
unk_FFD400:		ds.b	$400
byte_FFD800:		ds.b	$1800
byte_FFD800_end:
actwk_end:

soundram:		SMPS_RAM
	ds.b	$40
gamemode:		ds.b	1
	ds.b	1
swdata:			ds.w	1
swdata1:		ds.w	1
swdata2:		ds.w	1
	ds.b	4
word_FFF60C:		ds.w	1
	ds.b	6
generictimer:		ds.w	1
vscroll:		ds.l	1
hscroll:		ds.l	1
	ds.b	6
hintposi:		ds.w	1
startcolor:		ds.b	1
colorcnt:		ds.b	1
intcnt:			ds.b	1
	ds.b	1
int_flg:		ds.b	1
	ds.b	1
linkdata:		ds.b	1
	ds.b	5
clchgcnt:		ds.w	1
	ds.b	2
ranum:			ds.l	1
pauseflag:		ds.w	1
	ds.b	4
dmastack:		ds.w	1
	ds.b	2
hintflag:		ds.w	1
	ds.b	2
waterposi_m:		ds.w	1
	ds.b	3
water_flag:		ds.b	1
waterflag:		ds.b	1
waterflag2:		ds.b	1
	ds.b	$C
clchgtim:		ds.w	1
	ds.b	$22
dword_FFF680:		ds.l	1
word_FFF684:		ds.w	1
	ds.b	$5A
bitdev_a3:		ds.l	1
bitdev_d0:		ds.l	1
bitdev_d1:		ds.l	1
bitdev_d2:		ds.l	1
bitdev_d5:		ds.l	1
bitdev_d6:		ds.l	1
word_FFF6F8:		ds.w	1
word_FFF6FA:		ds.w	1
	ds.b	4
scra_h_posit:		ds.l	1
scra_v_posit:		ds.l	1
scrb_h_posit:		ds.l	1
scrb_v_posit:		ds.l	1
scrc_h_posit:		ds.l	1
scrc_v_posit:		ds.l	1
scrz_h_posit:		ds.l	1
scrz_v_posit:		ds.l	1
scralim_n_left:		ds.w	1
scralim_n_right:	ds.w	1
scralim_n_up:		ds.w	1
scralim_n_down:		ds.w	1
scralim_left:		ds.w	1
scralim_right:		ds.w	1
scralim_up:		ds.w	1
scralim_down:		ds.w	1
scrar_no:		ds.w	1
scra_h_keep:		ds.w	1
scra_v_keep:		ds.w	1	; unused
	ds.b	4
scra_hz:		ds.w	1
scra_vz:		ds.w	1
scra_vline:		ds.w	1
scrh_flag:		ds.b	1
scrv_flag:		ds.b	1
byte_FFF742:		ds.b	1
	ds.b	1
scroll_start:		ds.b	1
	ds.b	1
scr_die:		ds.b	1
	ds.b	1
scr_timer:		ds.b	1
	ds.b	1
scra_h_count:		ds.b	1
scra_v_count:		ds.b	1
scrb_h_count:		ds.b	1
scrb_v_count:		ds.b	1
scrc_h_count:		ds.b	1
scrc_v_count:		ds.b	1	; unused
scrz_h_count:		ds.b	1
scrz_v_count:		ds.b	1	; unused
	ds.b	2
scrflaga:		ds.w	1
scrflagb:		ds.w	1
scrflagc:		ds.w	1
scrflagz:		ds.w	1
limmoveflag:		ds.b	1
playpatno1:		ds.b	1
chibi_flag:		ds.b	1
byte_FFF75F:		ds.b	1
plmaxspdwk:		ds.w	1
pladdspdwk:		ds.w	1
plretspdwk:		ds.w	1
playpatno:		ds.b	1
playwrtflag:		ds.b	1
dirstk:			ds.b	1
	ds.b	1
dirstk2:		ds.b	1
	ds.b	1
actset_rno:		ds.b	1
	ds.b	1
asetposi:		ds.w	1
asetadr:		ds.l	1
asetadr2:		ds.l	1
asetadrz:		ds.l	1
asetadrz2:		ds.l	1
byecnt0:		ds.w	1
byecnt1:		ds.w	1
time_item:		ds.b	1
	ds.b	1
backto_cnt:		ds.w	1
scr_cnt:		ds.b	1
	ds.b	7
swbufcnt:		ds.w	1
	ds.b	4
scdadr:			ds.l	1
	ds.b	$E
plposiwkadr:		ds.w	1
bossstart:		ds.b	1
	ds.b	1
loopmapno:		ds.b	1
loopmapno2:		ds.b	1
ballmapno:		ds.b	1
ballmapno2:		ds.b	1
	ds.b	$17
byte_FFF7C7:		ds.b	1
	ds.b	2
mizuflag:		ds.b	1
	ds.b	1
byte_FFF7CC:		ds.b	1
	ds.b	3
emyscorecnt:		ds.w	1
	ds.b	8
statusr:		ds.w	1
byte_FFF7DC:		ds.b	1
	ds.b	$23
byte_FFF800:		ds.b	$280
byte_FFF800_end:
palette_water_fade:	equ	byte_FFF800_end-$80
palette_water:		ds.b	$80
palette:		ds.b	$80
palette_fade:		ds.b	$80
	ds.b	$400
	dephase
	!org 0