; VRAM Location Equates
plane_w:	equ	$A000
plane_a:	equ	$C000
plane_b:	equ	$E000
sprdat_vram:	equ	$F800
hscroll_vram:	equ	$FC00

; Z80 Equates
z80ram:		equ	$A00000
z80busreq:	equ	$A11100
z80reset:	equ	$A11200

version:	equ	$A10001
port_1:		equ	$A10003		;port A
port_2:		equ	$A10005		;port B
port_3:		equ	$A10007		;port C
cont_1:		equ	$A10009		;cont A
cont_2:		equ	$A1000b		;cont B  === PCM-IPT conect enable ===
cont_3:		equ	$A1000D		;cont C

; Tile Equates
tile_size:	equ	8*8/2

; VDP Equates
vdp_dat:	equ	$C00000		;read & write address of vram data
vdp_cmd:	equ	$C00004		;address set,vdp reg.
v_read:		equ	$C00008		;read h,v counter

; PSG Equates
psg68k:		equ	$C00011

; Mega CD Equates
wkram:		equ	$200000

; Mega CD Main CPU Equates
mcpu_int2:	equ	$A12000
mcpu_comcmd:	equ	$A12010
mcpu_comsts:	equ	$A12020

; Mega CD Main CPU Commands
	phase	1
mcpu_r11aload:		ds.b	1	; $01
mcpu_r11bload:		ds.b	1	; $02
mcpu_r11cload:		ds.b	1	; $03
mcpu_r11dload:		ds.b	1	; $04
mcpu_mdinit:		ds.b	1	; $05
mcpu_unk0:		ds.b	1	; $06
mcpu_unk1:		ds.b	1	; $07
mcpu_unk2:		ds.b	1	; $08
mcpu_unk3:		ds.b	1	; $09
mcpu_unk4:		ds.b	1	; $0A
mcpu_unk5:		ds.b	1	; $0B
mcpu_unk6:		ds.b	1	; $0C
mcpu_unk7:		ds.b	1	; $0D
mcpu_fadeCDA:		ds.b	1	; $0E Fade out CDA music
mcpu_r1aBGM:		ds.b	1	; $0F Track 2 (Salad Plain Present)
mcpu_timeattackBGM:	ds.b	1	; $10 Track 3 (Collision Chaos Present)
mcpu_titleBGM:		ds.b	1	; $11 Track 4 (You Can Do Anything)
mcpu_r1dBGM:		ds.b	1	; $12 Track 5 (Salad Plain Good Future)
mcpu_r1cBGM:		ds.b	1	; $13 Track 6 (Salad Plain Bad Future)
mcpu_r1bBGM:		ds.b	1	; $14 Track 7 (Salad Plain Past)
	dephase

; Actor Equates
word:		equ	2
	phase	0
actno:		ds.b	1
actflg:		ds.b	1
sproffset:	ds.w	1
patbase:	ds.l	1
xposi:		ds.l	1
yposi:		ds.l	1
xspeed:		ds.w	1
yspeed:		ds.w	1
mspeed:		ds.w	1
sprvsize:	ds.b	1
sprhs:		ds.b	1
sprpri:		ds.b	1
sprhsize:	ds.b	1
patno:		ds.b	1
patcnt:		ds.b	1
mstno:		ds.b	1
mstrestart:	ds.b	1
pattim:		ds.b	1
pattimm:	ds.b	1
colino:		ds.b	1
colicnt:	ds.b	1
cddat:		ds.b	1
cdsts:		ds.b	1
r_no0:		ds.b	1
r_no1:		ds.b	1
direc:		ds.w	1
userflag:	ds.b	1
act29:		ds.b	1
act2A:		ds.b	1
act2B:		ds.b	1
act2C:		ds.b	1
act2D:		ds.b	1
act2E:		ds.b	1
act2F:		ds.b	1
act30:		ds.b	1
act31:		ds.b	1
act32:		ds.b	1
act33:		ds.b	1
act34:		ds.b	1
act35:		ds.b	1
act36:		ds.b	1
act37:		ds.b	1
act38:		ds.b	1
act39:		ds.b	1
act3A:		ds.b	1
act3B:		ds.b	1
act3C:		ds.b	1
act3D:		ds.b	1
act3E:		ds.b	1
act3F:		ds.b	1
actfree:	ds.b	0
	dephase

; Player Structs
playframe	struct dots
empty:		ds.b	1
stand:		ds.b	1
wait1:		ds.b	1
wait2:		ds.b	1
wait3:		ds.b	1
lookup:		ds.b	1
lookback:	ds.b	1
sneeze1:	ds.b	1
sneeze2:	ds.b	1
sneeze3:	ds.b	1
sneeze4:	ds.b	1
walkwater1:	ds.b	1
walkwater2:	ds.b	1
walkwater3:	ds.b	1
walkwater4:	ds.b	1
walkwater5:	ds.b	1
walkwater6:	ds.b	1
outofhere1:	ds.b	1
outofhere2:	ds.b	1
outofhere3:	ds.b	1
outofhere4:	ds.b	1
outofhere5:	ds.b	1
outofhere6:	ds.b	1
outofhere7:	ds.b	1
hang1:		ds.b	1
hang2:		ds.b	1
spin1:		ds.b	1
spin2:		ds.b	1
spin3:		ds.b	1
spin4:		ds.b	1
spin5:		ds.b	1
spin6:		ds.b	1
rollfront1:	ds.b	1
rollfront2:	ds.b	1
rollfront3:	ds.b	1
rollball1:	ds.b	1
rollback1:	ds.b	1
rollback2:	ds.b	1
rollback3:	ds.b	1
rollleft1:	ds.b	1
rollleft2:	ds.b	1
rollleft3:	ds.b	1
rollright1:	ds.b	1
rollright2:	ds.b	1
rollright3:	ds.b	1
roll1:		ds.b	1
roll2:		ds.b	1
roll3:		ds.b	1
roll4:		ds.b	1
rollball2:	ds.b	1
spring:		ds.b	1
walk1:		ds.b	1
walk2:		ds.b	1
walk3:		ds.b	1
walk4:		ds.b	1
walk5:		ds.b	1
walk6:		ds.b	1
walk45_1:	ds.b	1
walk45_2:	ds.b	1
walk45_3:	ds.b	1
walk45_4:	ds.b	1
walk45_5:	ds.b	1
walk45_6:	ds.b	1
walk90_1:	ds.b	1
walk90_2:	ds.b	1
walk90_3:	ds.b	1
walk90_4:	ds.b	1
walk90_5:	ds.b	1
walk90_6:	ds.b	1
walk135_1:	ds.b	1
walk135_2:	ds.b	1
walk135_3:	ds.b	1
walk135_4:	ds.b	1
walk135_5:	ds.b	1
walk135_6:	ds.b	1
run1:		ds.b	1
run2:		ds.b	1
run3:		ds.b	1
run4:		ds.b	1
run45_1:	ds.b	1
run45_2:	ds.b	1
run45_3:	ds.b	1
run45_4:	ds.b	1
run90_1:	ds.b	1
run90_2:	ds.b	1
run90_3:	ds.b	1
run90_4:	ds.b	1
run135_1:	ds.b	1
run135_2:	ds.b	1
run135_3:	ds.b	1
run135_4:	ds.b	1
skid1:		ds.b	1
skid2:		ds.b	1
hurt:		ds.b	1
waterfall:	ds.b	1
getair:		ds.b	1
duck:		ds.b	1
watertunnel1:	ds.b	1
watertunnel2:	ds.b	1
watertunnel3:	ds.b	1
push1:		ds.b	1
push2:		ds.b	1
push3:		ds.b	1
push4:		ds.b	1
burnt:		ds.b	1
drown:		ds.b	1
death:		ds.b	1
polehang1:	ds.b	1
polehang2:	ds.b	1
balance1:	ds.b	1
balance2:	ds.b	1
chibistand:	ds.b	1
chibiwait1:	ds.b	1
chibiwait2:	ds.b	1
chibiduck:	ds.b	1
chibiwalk1:	ds.b	1
chibiwalk2:	ds.b	1
chibiwalk3:	ds.b	1
chibirun1:	ds.b	1
chibirun2:	ds.b	1
chibiskid:	ds.b	1
chibihurt:	ds.b	1
chibibalance1:	ds.b	1
chibibalance2:	ds.b	1
chibirollball:	ds.b	1
chibiroll1:	ds.b	1
chibiroll2:	ds.b	1
	endstruct

; Player Equates
walkheight:	equ	19
walkwidth:	equ	9
rollheight:	equ	14
rollwidth:	equ	7
chibiheight:	equ	10
chibiwidth:	equ	5
mainplayflag:	equ	act29
lockcd:		equ	act2C
invulnerabilitytimer:	equ	act30
mutekitimer:	equ	act32
speeduptimer:	equ	act34
footdir:	equ	act36
convexflag:	equ	act38
jumpflag:	equ	act3C
hlocktimer:	equ	act3E

; Player Bit Equates
cd_left:	equ	0
cd_walk:	equ	1
cd_jump:	equ	1
cd_ball:	equ	2
cd_ride:	equ	3
cd_ballj:	equ	4
cd_push:	equ	5
cd_underwater:	equ	6

; Chunk Equates
map_size:	equ	(16*2)*16	; (width*2) * height

; Stage Equates
stage_spz:	equ	0

; Act Equates
act_1:		equ	0
act_2:		equ	1
act_3:		equ	2
act_4:		equ	3

; SE Equates
se_90:		equ	$90
se_91:		equ	$91
se_92:		equ	$92
se_93:		equ	$93
se_94:		equ	$94
se_95:		equ	$95
se_96:		equ	$96
se_97:		equ	$97
se_98:		equ	$98
se_99:		equ	$99
se_9A:		equ	$9A
se_9B:		equ	$9B
se_9C:		equ	$9C
se_9D:		equ	$9D
se_9E:		equ	$9E
se_9F:		equ	$9F
se_A0:		equ	$A0
se_A1:		equ	$A1
se_A2:		equ	$A2
se_A3:		equ	$A3
se_A4:		equ	$A4
se_A5:		equ	$A5
se_A6:		equ	$A6
se_A7:		equ	$A7
se_A8:		equ	$A8
se_A9:		equ	$A9
se_AA:		equ	$AA

	include	"Leftovers/Equates.asm"