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
lvl_reset:		ds.w	1
word_FF1204:		ds.w	1
byte_FF1206:		ds.b	1
	ds.b	1
word_FF1208:		ds.w	1
	ds.b	2
dword_FF120C:		ds.l	1
zone:			ds.b	1
act:			ds.b	1
pl_suu:			ds.b	1
	ds.b	1
pl_air:			ds.w	1
	ds.b	3
byte_FF1219:		ds.b	1
byte_FF121A:		ds.b	1
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
byte_FF122C:		ds.b	1
byte_FF122D:		ds.b	1
byte_FF122E:		ds.b	1
plpower_a:		ds.b	1
plflag:			ds.b	1
byte_FF1231:		ds.b	1
word_FF1232:		ds.w	1
word_FF1234:		ds.w	1
word_FF1236:		ds.w	1
dword_FF1238:		ds.l	1
byte_FF123C:		ds.b	1
time_flag:		ds.b	1
word_FF123E:		ds.w	1
word_FF1240:		ds.w	1
word_FF1242:		ds.w	1
word_FF1244:		ds.w	1
word_FF1246:		ds.w	1
word_FF1248:		ds.w	1
word_FF124A:		ds.w	1
word_FF124C:		ds.w	1
word_FF124E:		ds.w	1
word_FF1250:		ds.w	1
byte_FF1252:		ds.b	1
byte_FF1253:		ds.b	1
byte_FF1254:		ds.b	1
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
byte_FF12C0:		ds.b	1
byte_FF12C1:		ds.b	1
ring_time:		ds.b	1
ring_frame:		ds.b	1
byte_FF12C4:		ds.b	1
byte_FF12C5:		ds.b	1
byte_FF12C6:		ds.b	1
byte_FF12C7:		ds.b	1
word_FF12C8:		ds.w	1
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
word_FF13FA:		ds.w	1
init_f:			ds.l	1
unk_FF1400:		ds.b	$180
unk_FF1400_end:
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
lvllayoutwk:		ds.b	$400
lvllayoutwk_end:
byte_FFA800:		ds.b	$200
bitdevwk:		ds.b	$200
spr_list:		ds.b	$400
blkwk:			ds.b	$1800
playwrtwk:		ds.b	$2E0
playwrtwk_end:
	ds.b	$20
playposiwk:		ds.b	$100
hscrollwk:		ds.b	$380
hscrollwk_end:
	ds.b	$80
hscrollwk_end_padded:
actwk:			obj
byte_FFD040:		obj
byte_FFD080:		obj
byte_FFD0C0:		obj
byte_FFD100:		obj
byte_FFD140:		obj
byte_FFD180:		obj
byte_FFD1C0:		obj
byte_FFD200:		obj
byte_FFD240:		obj
byte_FFD280:		obj
byte_FFD2C0:		obj
byte_FFD300:		obj
byte_FFD340:		obj
byte_FFD380:		obj
byte_FFD3C0:		obj
unk_FFD400:		ds.b	$400
byte_FFD800:		ds.b	$1800
byte_FFD800_end:
actwk_end:

soundram:		SMPS_RAM
	ds.b	$40
gamemode:		ds.b	1
	ds.b	1
word_FFF602:		ds.w	1
word_FFF604:		ds.w	1
word_FFF606:		ds.w	1
	ds.b	4
word_FFF60C:		ds.w	1
	ds.b	6
generictimer:		ds.w	1
vscroll:		ds.l	1
dword_FFF61A:		ds.l	1
	ds.b	6
hintposi:		ds.w	1
startcolor:		ds.b	1
colorcnt:		ds.b	1
byte_FFF628:		ds.b	1
	ds.b	1
vint_mode:		ds.b	1
	ds.b	1
byte_FFF62C:		ds.b	1
	ds.b	5
byte_FFF632:		ds.b	1
byte_FFF633:		ds.b	1
	ds.b	2
dword_FFF636:		ds.l	1
word_FFF63A:		ds.w	1
	ds.b	4
word_FFF640:		ds.w	1
	ds.b	2
hintflag:		ds.w	1
	ds.b	2
waterposi_m:		ds.w	1
	ds.b	3
water_flag:		ds.b	1
waterflag:		ds.b	1
byte_FFF64F:		ds.b	1
	ds.b	$C
byte_FFF65C:		ds.b	1
byte_FFF65D:		ds.b	1
	ds.b	$22
dword_FFF680:		ds.l	1
word_FFF684:		ds.w	1
	ds.b	$5A
dword_FFF6E0:		ds.l	1
dword_FFF6E4:		ds.l	1
dword_FFF6E8:		ds.l	1
dword_FFF6EC:		ds.l	1
dword_FFF6F0:		ds.l	1
dword_FFF6F4:		ds.l	1
word_FFF6F8:		ds.w	1
word_FFF6FA:		ds.w	1
	ds.b	4
scra_h_posit:		ds.l	1
scra_v_posit:		ds.l	1
scrb_h_posit:		ds.l	1
scrb_v_posit:		ds.l	1
scrc_h_posit:		ds.l	1
scrc_v_posit:		ds.w	1
	ds.b	2
scrz_h_posit:		ds.l	1
scrz_v_posit:		ds.w	1
	ds.b	2
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
	ds.b	6
scra_hz:		ds.w	1
scra_vz:		ds.w	1
scra_vline:		ds.w	1
byte_FFF740:		ds.b	1
byte_FFF741:		ds.b	1
byte_FFF742:		ds.b	1
	ds.b	1
scroll_start:		ds.b	1
	ds.b	1
byte_FFF746:		ds.b	1
	ds.b	1
byte_FFF748:		ds.b	1
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
byte_FFF75D:		ds.b	1
chibi_flag:		ds.b	1
byte_FFF75F:		ds.b	1
plmaxspdwk:		ds.w	1
pladdspdwk:		ds.w	1
plretspdwk:		ds.w	1
byte_FFF766:		ds.b	1
playwrtflag:		ds.b	1
byte_FFF768:		ds.b	1
	ds.b	1
byte_FFF76A:		ds.b	1
	ds.b	1
byte_FFF76C:		ds.b	1
	ds.b	1
word_FFF76E:		ds.w	1
dword_FFF770:		ds.l	1
dword_FFF774:		ds.l	1
dword_FFF778:		ds.l	1
dword_FFF77C:		ds.l	1
word_FFF780:		ds.w	1
word_FFF782:		ds.w	1
time_item:		ds.b	1
	ds.b	1
backto_cnt:		ds.w	1
byte_FFF788:		ds.b	1
	ds.b	7
word_FFF790:		ds.w	1
	ds.b	4
dword_FFF796:		ds.l	1
	ds.b	$E
word_FFF7A8:		ds.w	1
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