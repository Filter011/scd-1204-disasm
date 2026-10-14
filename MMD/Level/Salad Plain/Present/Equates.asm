; VRAM Location Equates
plane_w:	equ	$A000
plane_a:	equ	$C000
plane_b:	equ	$E000
sprtbl_vram:	equ	$F800
hscroll_vram:	equ	$FC00

; Z80 Equates
z80ram:		equ	$A00000
z80busreq:	equ	$A11100
z80reset:	equ	$A11200

version:	equ	$A10001
port_1:		equ	$A10003
port_2:		equ	$A10005
port_3:		equ	$A10007
cont_1:		equ	$A10009
cont_2:		equ	$A1000B
cont_3:		equ	$A1000D

; Tile Equates
tile_size:	equ	8*8/2

; VDP Equates
vdpdata:	equ	$C00000
vdpctrl:	equ	$C00004

; Mega CD Equates
wkram:		equ	$200000

; Mega CD Sub-CPU Equates
scpu_IRQ2:	equ	$A12000
scpu_commcmd0:	equ	$A12010
scpu_commstats:	equ	$A12020

; Mega CD Sub-CPU Commands
	phase	1
scpu_r11aload:		ds.b	1	; $01
scpu_r11bload:		ds.b	1	; $02
scpu_r11cload:		ds.b	1	; $03
scpu_r11dload:		ds.b	1	; $04
scpu_mdinit:		ds.b	1	; $05
scpu_unk0:		ds.b	1	; $06
scpu_unk1:		ds.b	1	; $07
scpu_unk2:		ds.b	1	; $08
scpu_unk3:		ds.b	1	; $09
scpu_unk4:		ds.b	1	; $0A
scpu_unk5:		ds.b	1	; $0B
scpu_unk6:		ds.b	1	; $0C
scpu_unk7:		ds.b	1	; $0D
scpu_fadeCDA:		ds.b	1	; $0E Fade out CDDA music
scpu_r11aMUS:		ds.b	1	; $0F Track 2 (Salad Plain Present)
scpu_timeattackMUS:	ds.b	1	; $10 Track 3 (Collision Chaos Present)
scpu_titleMUS:		ds.b	1	; $11 Track 4 (You Can Do Anything)
scpu_r11dMUS:		ds.b	1	; $12 Track 5 (Salad Plain Good Future)
scpu_r11cMUS:		ds.b	1	; $13 Track 6 (Salad Plain Bad Future)
scpu_r11bMUS:		ds.b	1	; $14 Track 7 (Salad Plain Past)
	dephase

; Actor Equates
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
pl_height:	equ	19
pl_width:	equ	9
rollheight:	equ	14
rollwidth:	equ	7
chibiheight:	equ	10
chibiwidth:	equ	5
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
mapsize:	equ	(16*2)*16	; (width*2) * height

; Stage Equates
stage_SPZ:	equ	0

; Act Equates
act_1:		equ	0
act_2:		equ	1
act_3:		equ	2
act_4:		equ	3

; Sonic The Hedgehog (Mega Drive) Leftover Equates

; Game Mode Equates
gamemd_S1:	equ	$C
spgamemd:	equ	$10

; Stage Equates
stage_LZ:	equ	1
stage_MZ:	equ	2
stage_SLZ:	equ	3

; BGM Equates
bgm_GHZ:	equ	$81
bgm_LZ:		equ	$82
bgm_MZ:		equ	$83
bgm_SLZ:	equ	$84
bgm_SYZ:	equ	$85
bgm_SBZ:	equ	$86
bgm_FZ:		equ	$8D