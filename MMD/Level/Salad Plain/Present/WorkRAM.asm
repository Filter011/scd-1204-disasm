; ===========================================================================
; Segment type: Regular
; segment "RAM"

	include	"s1.sounddriver.ram.asm"

	phase	$FF0000
	ds.b $580
byte_FF0580:	ds.b 1
byte_FF0580_ext:	equ	byte_FF0580+$FF<<24
	ds.b $A7F
stackwk:	ds.b $200
stackwk_end:
	ds.b 2
lvl_reset:	ds.w 1
word_FF1204:	ds.w 1
byte_FF1206:	ds.b 1
	ds.b 1
word_FF1208:	ds.w 1
	ds.b 2
dword_FF120C:	ds.l 1
zone:		ds.b 1
act:		ds.b 1
byte_FF1212:	ds.b 1
	ds.b 1
play_air:	ds.w 1
	ds.b 3
byte_FF1219:	ds.b 1
byte_FF121A:	ds.b 1
byte_FF121B:	ds.b 1
byte_FF121C:	ds.b 1
byte_FF121D:	ds.b 1
byte_FF121E:	ds.b 1
byte_FF121F:	ds.b 1
word_FF1220:	ds.w 1
byte_FF1222:	ds.b 1
byte_FF1223:	ds.b 1
byte_FF1224:	ds.b 1
byte_FF1225:	ds.b 1
dword_FF1226:	ds.l 1
byte_FF122A:	ds.b 1
	ds.b 1
byte_FF122C:	ds.b 1
byte_FF122D:	ds.b 1
byte_FF122E:	ds.b 1
byte_FF122F:	ds.b 1
byte_FF1230:	ds.b 1
byte_FF1231:	ds.b 1
word_FF1232:	ds.w 1
word_FF1234:	ds.w 1
word_FF1236:	ds.w 1
dword_FF1238:	ds.l 1
byte_FF123C:	ds.b 1
byte_FF123D:	ds.b 1
word_FF123E:	ds.w 1
word_FF1240:	ds.w 1
word_FF1242:	ds.w 1
word_FF1244:	ds.w 1
word_FF1246:	ds.w 1
word_FF1248:	ds.w 1
word_FF124A:	ds.w 1
word_FF124C:	ds.w 1
word_FF124E:	ds.w 1
word_FF1250:	ds.w 1
byte_FF1252:	ds.b 1
byte_FF1253:	ds.b 1
byte_FF1254:	ds.b 1
byte_FF1255:	ds.b 1
word_FF1256:	ds.w 1
word_FF1258:	ds.w 1
byte_FF125A:	ds.b 1
	ds.b 1
word_FF125C:	ds.w 1
word_FF125E:	ds.w 1
word_FF1260:	ds.w 1
word_FF1262:	ds.w 1
word_FF1264:	ds.w 1
word_FF1266:	ds.w 1
word_FF1268:	ds.w 1
word_FF126A:	ds.w 1
word_FF126C:	ds.w 1
word_FF126E:	ds.w 1
byte_FF1270:	ds.b 1
byte_FF1271:	ds.b 1
	ds.b 6
word_FF1278:	ds.w 1
byte_FF127A:	ds.b 1
byte_FF127B:	ds.b 1
	ds.b $44
byte_FF12C0:	ds.b 1
byte_FF12C1:	ds.b 1
ring_time:	ds.b 1
ring_frame:	ds.b 1
byte_FF12C4:	ds.b 1
byte_FF12C5:	ds.b 1
byte_FF12C6:	ds.b 1
byte_FF12C7:	ds.b 1
word_FF12C8:	ds.w 1
	ds.b $2A
word_FF12F4:	ds.w 1
	ds.b $1A
dword_FF1310:	ds.l 1
	ds.b 4
dword_FF1318:	ds.l 1
	ds.b 4
byte_FF1320:	ds.b 8
byte_FF1328:	ds.b 8
dword_FF1330:	ds.l 1
word_FF1334:	ds.w 1
word_FF1336:	ds.w 1
	ds.b $B4
byte_FF13EC:	ds.b 1
byte_FF13ED:	ds.b 1
byte_FF13EE:	ds.b 1
byte_FF13EF:	ds.b 1
word_FF13F0:	ds.w 1
	ds.b 2
word_FF13F4:	ds.w 1
	ds.b 2
mdstatus:	ds.b 1
	ds.b 1
word_FF13FA:	ds.w 1
init_f:	ds.l 1
unk_FF1400:	ds.b $180
unk_FF1400_end:
byte_FF1580:	ds.b $300
dword_FF1880:	ds.l 1
word_FF1884:	ds.w 1
byte_FF1886:	ds.b 1
	ds.b 3
byte_FF188A:	ds.b 1
	ds.b $75
powerupwrtwk:	ds.b $300
powerupwrtwk_end:
	ds.b $180
powerupwrtwk_dma_end:
	ds.b $6280
	dephase
	!org 0

	phase	$FFFF8000
	ds.b $2400
lvllayoutwk:	ds.b $400
lvllayoutwk_end:
byte_FFA800:	ds.b $200
bitdevwk:	ds.b $200
spr_list:	ds.b $400
blkwk:		ds.b $1800
playwrtwk:	ds.b $2E0
playwrtwk_end:
	ds.b $20
playposiwk:	ds.b $100
hscrollwk:	ds.b $380
hscrollwk_end:
	ds.b $80
hscrollwk_end_padded:
actwk:		obj
byte_FFD040:	obj
byte_FFD080:	obj
byte_FFD0C0:	obj
byte_FFD100:	obj
byte_FFD140:	obj
byte_FFD180:	obj
byte_FFD1C0:	obj
byte_FFD200:	obj
byte_FFD240:	obj
byte_FFD280:	obj
byte_FFD2C0:	obj
byte_FFD300:	obj
byte_FFD340:	obj
byte_FFD380:	obj
byte_FFD3C0:	obj
unk_FFD400:	ds.b $400
byte_FFD800:	ds.b $1800
byte_FFD800_end:
actwk_end:

soundram:	SMPS_RAM
	ds.b $40
gamemode:	ds.b 1
	ds.b 1
word_FFF602:	ds.w 1
word_FFF604:	ds.w 1
word_FFF606:	ds.w 1
	ds.b 4
word_FFF60C:	ds.w 1
	ds.b 6
generictimer:	ds.w 1
dword_FFF616:	ds.l 1
dword_FFF61A:	ds.l 1
	ds.b 6
word_FFF624:	ds.w 1
word_FFF626:	ds.w 1
byte_FFF628:	ds.b 1
	ds.b 1
vint_mode:	ds.b 1
	ds.b 1
byte_FFF62C:	ds.b 1
	ds.b 5
byte_FFF632:	ds.b 1
byte_FFF633:	ds.b 1
	ds.b 2
dword_FFF636:	ds.l 1
word_FFF63A:	ds.w 1
	ds.b 4
word_FFF640:	ds.w 1
	ds.b 2
word_FFF644:	ds.w 1
	ds.b 2
word_FFF648:	ds.w 1
	ds.b 3
byte_FFF64D:	ds.b 1
byte_FFF64E:	ds.b 1
byte_FFF64F:	ds.b 1
	ds.b $C
byte_FFF65C:	ds.b 1
byte_FFF65D:	ds.b 1
	ds.b $22
dword_FFF680:	ds.l 1
word_FFF684:	ds.w 1
	ds.b $5A
dword_FFF6E0:	ds.l 1
dword_FFF6E4:	ds.l 1
dword_FFF6E8:	ds.l 1
dword_FFF6EC:	ds.l 1
dword_FFF6F0:	ds.l 1
dword_FFF6F4:	ds.l 1
word_FFF6F8:	ds.w 1
word_FFF6FA:	ds.w 1
	ds.b 4
dword_FFF700:	ds.l 1
dword_FFF704:	ds.l 1
dword_FFF708:	ds.l 1
dword_FFF70C:	ds.l 1
dword_FFF710:	ds.l 1
word_FFF714:	ds.w 1
	ds.b 2
dword_FFF718:	ds.l 1
word_FFF71C:	ds.w 1
	ds.b 2
dword_FFF720:	ds.l 1
dword_FFF724:	ds.l 1
dword_FFF728:	ds.l 1
dword_FFF72C:	ds.l 1
word_FFF730:	ds.w 1
word_FFF732:	ds.w 1
	ds.b 6
word_FFF73A:	ds.w 1
word_FFF73C:	ds.w 1
word_FFF73E:	ds.w 1
byte_FFF740:	ds.b 1
byte_FFF741:	ds.b 1
byte_FFF742:	ds.b 1
	ds.b 1
byte_FFF744:	ds.b 1
	ds.b 1
byte_FFF746:	ds.b 1
	ds.b 1
byte_FFF748:	ds.b 1
	ds.b 1
word_FFF74A:	ds.w 1
byte_FFF74C:	ds.b 1
byte_FFF74D:	ds.b 1
byte_FFF74E:	ds.b 1
	ds.b 1
byte_FFF750:	ds.b 1
	ds.b 3
dword_FFF754:	ds.l 1
word_FFF758:	ds.w 1
word_FFF75A:	ds.w 1
byte_FFF75C:	ds.b 1
byte_FFF75D:	ds.b 1
chibi_flag:	ds.b 1
byte_FFF75F:	ds.b 1
word_FFF760:	ds.w 1
word_FFF762:	ds.w 1
word_FFF764:	ds.w 1
byte_FFF766:	ds.b 1
byte_FFF767:	ds.b 1
byte_FFF768:	ds.b 1
	ds.b 1
byte_FFF76A:	ds.b 1
	ds.b 1
byte_FFF76C:	ds.b 1
	ds.b 1
word_FFF76E:	ds.w 1
dword_FFF770:	ds.l 1
dword_FFF774:	ds.l 1
dword_FFF778:	ds.l 1
dword_FFF77C:	ds.l 1
word_FFF780:	ds.w 1
word_FFF782:	ds.w 1
byte_FFF784:	ds.b 1
	ds.b 1
word_FFF786:	ds.w 1
byte_FFF788:	ds.b 1
	ds.b 7
word_FFF790:	ds.w 1
	ds.b 4
dword_FFF796:	ds.l 1
	ds.b $E
word_FFF7A8:	ds.w 1
byte_FFF7AA:	ds.b 1
	ds.b 1
dword_FFF7AC:	ds.l 1
	ds.b $17
byte_FFF7C7:	ds.b 1
	ds.b 2
byte_FFF7CA:	ds.b 1
	ds.b 1
byte_FFF7CC:	ds.b 1
	ds.b 3
word_FFF7D0:	ds.w 1
	ds.b 8
word_FFF7DA:	ds.w 1
byte_FFF7DC:	ds.b 1
	ds.b $23
byte_FFF800:	ds.b $280
byte_FFF800_end:
palette_water_fade:	equ byte_FFF800_end-$80
palette_water:	ds.b $80
palette:	ds.b $80
palette_fade:	ds.b $80
	ds.b $400
	dephase
	!org 0