; VRAM Location Equates
scroll_w_vram:	equ	$A000
scroll_a_vram:	equ	$C000
scroll_b_vram:	equ	$E000
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
cont_2:		equ	$A1000B		;cont B  === PCM-IPT conect enable ===
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
mcpu_memmd:	equ	$A12003
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