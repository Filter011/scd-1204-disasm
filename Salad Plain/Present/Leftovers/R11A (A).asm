	phase	wkram+$E3FA

	include	"Actors/25 - Hashi.asm"
	include	"Actors/26.asm"
	include	"Actors/29.asm"

	dc.b	1
	dc.b	-8,5,0,0,-8
	dc.b	1
	dc.b	-8,$D,0,4,$F0
	dc.b	1
	dc.b	-4,0,0,$C,-4
	dc.b	1
	dc.b	$F0,3,0,$D,-4
	dc.b	1
	dc.b	$F0,3,0,$11,-4
	dc.b	1
	dc.b	-8,5,8,0,-8
	dc.b	1
	dc.b	-8,$D,8,4,$F0
	dc.b	1
	dc.b	-4,0,8,$C,-4
	dc.b	1
	dc.b	$F0,3,8,$D,-4
	dc.b	1
	dc.b	$F0,3,8,$11,-4
	even

off_20EB04:
	dc.w	unk_20EB0E-off_20EB04
	dc.w	unk_20EB1E-off_20EB04
	dc.w	unk_20EB28-off_20EB04
	dc.w	unk_20EB32-off_20EB04
	dc.w	unk_20EB36-off_20EB04
unk_20EB0E:
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	5
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	$FF
unk_20EB1E:
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	1
	dc.b	0
	dc.b	$FF
	even
unk_20EB28:
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	5
	dc.b	3
	dc.b	4
	dc.b	3
	dc.b	$FF
	even
unk_20EB32:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20EB36:
	dc.b	0
	dc.b	3
	dc.b	$FF
	even

off_20EB3A:
	dc.w	byte_20EB46-off_20EB3A
	dc.w	byte_20EB52-off_20EB3A
	dc.w	byte_20EB5E-off_20EB3A
	dc.w	byte_20EB6A-off_20EB3A
	dc.w	byte_20EB76-off_20EB3A
	dc.w	byte_20EB82-off_20EB3A
byte_20EB46:
	dc.b	2
	dc.b	-4,1,0,0,-8
	dc.b	-4,8,0,2,0
	even
byte_20EB52:
	dc.b	2
	dc.b	-4,5,0,5,-8
	dc.b	0,5,0,9,8
	even
byte_20EB5E:
	dc.b	2
	dc.b	-4,5,0,$D,-8
	dc.b	$F0,5,0,$11,8
	even
byte_20EB6A:
	dc.b	2
	dc.b	-4,1,8,0,0
	dc.b	-4,8,8,2,$E8
	even
byte_20EB76:
	dc.b	2
	dc.b	-4,5,8,5,-8
	dc.b	0,5,8,9,$E8
	even
byte_20EB82:
	dc.b	2
	dc.b	-4,5,8,$D,-8
	dc.b	$F0,5,8,$11,$E8
	even

off_20EB8E:
	dc.w	unk_20EBAA-off_20EB8E
	dc.w	unk_20EBBA-off_20EB8E
	dc.w	unk_20EBBE-off_20EB8E
	dc.w	unk_20EBC2-off_20EB8E
	dc.w	unk_20EBC6-off_20EB8E
	dc.w	unk_20EBCA-off_20EB8E
	dc.w	unk_20EBCE-off_20EB8E
	dc.w	unk_20EBD2-off_20EB8E
	dc.w	unk_20EBD6-off_20EB8E
	dc.w	unk_20EBDA-off_20EB8E
	dc.w	unk_20EBDE-off_20EB8E
	dc.w	unk_20EBE2-off_20EB8E
	dc.w	unk_20EBE6-off_20EB8E
	dc.w	unk_20EBEA-off_20EB8E
unk_20EBAA:
	dc.b	9
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	5
	dc.b	6
	dc.b	7
	dc.b	8
	dc.b	9
	dc.b	$A
	dc.b	$B
	dc.b	$C
	dc.b	$FF
	even
unk_20EBBA:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20EBBE:
	dc.b	0
	dc.b	1
	dc.b	$FF
	even
unk_20EBC2:
	dc.b	0
	dc.b	2
	dc.b	$FF
	even
unk_20EBC6:
	dc.b	0
	dc.b	3
	dc.b	$FF
	even
unk_20EBCA:
	dc.b	0
	dc.b	4
	dc.b	$FF
	even
unk_20EBCE:
	dc.b	0
	dc.b	5
	dc.b	$FF
	even
unk_20EBD2:
	dc.b	0
	dc.b	6
	dc.b	$FF
	even
unk_20EBD6:
	dc.b	0
	dc.b	7
	dc.b	$FF
	even
unk_20EBDA:
	dc.b	0
	dc.b	8
	dc.b	$FF
	even
unk_20EBDE:
	dc.b	0
	dc.b	9
	dc.b	$FF
	even
unk_20EBE2:
	dc.b	0
	dc.b	$A
	dc.b	$FF
	even
unk_20EBE6:
	dc.b	0
	dc.b	$B
	dc.b	$FF
	even
unk_20EBEA:
	dc.b	0
	dc.b	$C
	dc.b	$FF
	even

off_20EBEE:
	dc.w	byte_20EC08-off_20EBEE
	dc.w	byte_20EC18-off_20EBEE
	dc.w	byte_20EC32-off_20EBEE
	dc.w	byte_20EC42-off_20EBEE
	dc.w	byte_20EC66-off_20EBEE
	dc.w	byte_20EC80-off_20EBEE
	dc.w	byte_20EC90-off_20EBEE
	dc.w	byte_20ECA0-off_20EBEE
	dc.w	byte_20ECBA-off_20EBEE
	dc.w	byte_20ECCA-off_20EBEE
	dc.w	byte_20ECEE-off_20EBEE
	dc.w	byte_20ED08-off_20EBEE
	dc.w	byte_20ED18-off_20EBEE
byte_20EC08:
	dc.b	3
	dc.b	$F0,$C,0,0,0
	dc.b	8,$C,$18,0,$E0
	dc.b	-4,0,$C0,$2E,-4
byte_20EC18:
	dc.b	5
	dc.b	$F0,$C,0,4,0
	dc.b	$E8,0,0,8,$18
	dc.b	8,$C,$18,4,$E0
	dc.b	$10,0,$18,8,$E0
	dc.b	-4,0,$C0,$2E,-4
byte_20EC32:
	dc.b	3
	dc.b	$E8,$D,0,9,0
	dc.b	8,$D,$18,9,$E0
	dc.b	-4,0,$C0,$2E,-4
byte_20EC42:
	dc.b	7
	dc.b	$E8,$D,0,$11,0
	dc.b	$E0,0,0,$19,$10
	dc.b	$F0,0,0,$1A,-8
	dc.b	8,$D,$18,$11,$E0
	dc.b	$18,0,$18,$19,$E8
	dc.b	8,0,$18,$1A,0
	dc.b	-4,0,$C0,$2E,-4
byte_20EC66:
	dc.b	5
	dc.b	$E0,$E,0,$1B,0
	dc.b	$F0,0,0,$27,-8
	dc.b	8,$E,$18,$1B,$E0
	dc.b	8,0,$18,$27,0
	dc.b	-4,0,$C0,$2E,-4
byte_20EC80:
	dc.b	3
	dc.b	$E0,6,0,$28,-8
	dc.b	8,6,$10,$28,-8
	dc.b	-4,0,$C0,$2E,-4
byte_20EC90:
	dc.b	3
	dc.b	$F0,$C,8,0,$E0
	dc.b	8,$C,$10,0,0
	dc.b	-4,0,$C0,$2E,-4
byte_20ECA0:
	dc.b	5
	dc.b	$F0,$C,8,4,$E0
	dc.b	$E8,0,8,8,$E0
	dc.b	8,$C,$10,4,0
	dc.b	$10,0,$10,8,$18
	dc.b	-4,0,$C0,$2E,-4
byte_20ECBA:
	dc.b	3
	dc.b	$E8,$D,8,9,$E0
	dc.b	8,$D,$10,9,0
	dc.b	-4,0,$C0,$2E,-4
byte_20ECCA:
	dc.b	7
	dc.b	$E8,$D,8,$11,$E0
	dc.b	$E0,0,8,$19,$E8
	dc.b	$F0,0,8,$1A,0
	dc.b	8,$D,$10,$11,0
	dc.b	$18,0,$10,$19,$10
	dc.b	8,0,$10,$1A,-8
	dc.b	-4,0,$C0,$2E,-4
byte_20ECEE:
	dc.b	5
	dc.b	$E0,$E,8,$1B,$E0
	dc.b	$F0,0,8,$27,0
	dc.b	8,$E,$10,$1B,0
	dc.b	8,0,$10,$27,-8
	dc.b	-4,0,$C0,$2E,-4
byte_20ED08:
	dc.b	3
	dc.b	$E0,6,8,$28,-8
	dc.b	8,6,$18,$28,-8
	dc.b	-4,0,$C0,$2E,-4
byte_20ED18:
	dc.b	1
	dc.b	-4,0,$C0,$2E,-4
	even

off_20ED1E:
	dc.w	unk_20ED24-off_20ED1E
	dc.w	unk_20ED28-off_20ED1E
	dc.w	unk_20ED2C-off_20ED1E
unk_20ED24:
	dc.b	$1D
	dc.b	0,1
	dc.b	$FF
	even
unk_20ED28:
	dc.b	0
	dc.b	0
	dc.b	$FF
	even
unk_20ED2C:
	dc.b	0
	dc.b	1
	dc.b	$FF
	even

off_20ED30:
	dc.w	byte_20ED34-off_20ED30
	dc.w	byte_20ED3A-off_20ED30
byte_20ED34:
	dc.b	1
	dc.b	-8,5,0,0,-8
byte_20ED3A:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even

off_20ED40:
	dc.w	unk_20ED4C-off_20ED40
	dc.w	unk_20ED50-off_20ED40
	dc.w	unk_20ED54-off_20ED40
	dc.w	unk_20ED58-off_20ED40
	dc.w	unk_20ED5C-off_20ED40
	dc.w	unk_20ED60-off_20ED40
unk_20ED4C:
	dc.b	$1D
	dc.b	0
	dc.b	$FF
	even
unk_20ED50:
	dc.b	$1D
	dc.b	1
	dc.b	$FF
	even
unk_20ED54:
	dc.b	$1D
	dc.b	2
	dc.b	$FF
	even
unk_20ED58:
	dc.b	$1D
	dc.b	3
	dc.b	$FF
	even
unk_20ED5C:
	dc.b	$1D
	dc.b	4
	dc.b	$FF
	even
unk_20ED60:
	dc.b	$1D
	dc.b	5
	dc.b	$FF
	even

off_20ED64:
	dc.w	byte_20ED6A-off_20ED64
	dc.w	byte_20ED75-off_20ED64
	dc.w	byte_20ED80-off_20ED64
byte_20ED6A:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20ED75:
	dc.b	2
	dc.b	$F0,$D,0,8,$F0
	dc.b	0,$D,0,8,$F0
byte_20ED80:
	dc.b	2
	dc.b	$F0,$D,8,8,$F0
	dc.b	0,$D,8,8,$F0
	even

off_20ED8C:
	dc.w	byte_20ED94-off_20ED8C
	dc.w	byte_20EDA9-off_20ED8C
	dc.w	byte_20EDBE-off_20ED8C
	dc.w	byte_20EDD3-off_20ED8C
byte_20ED94:
	dc.b	4
	dc.b	$F0,3,0,0,$F0
	dc.b	$F1,3,0,0,-8
	dc.b	$F2,3,0,0,0
	dc.b	$F3,3,0,0,8
byte_20EDA9:
	dc.b	4
	dc.b	$F0,$C,0,4,$F0
	dc.b	-8,$C,0,4,$F1
	dc.b	0,$C,0,4,$F2
	dc.b	8,$C,0,4,$F3
byte_20EDBE:
	dc.b	4
	dc.b	$F0,$C,8,4,$F3
	dc.b	-8,$C,8,4,$F2
	dc.b	0,$C,8,4,$F1
	dc.b	8,$C,8,4,$F0
byte_20EDD3:
	dc.b	2
	dc.b	$F0,3,0,0,$F4
	dc.b	$F0,3,0,0,4
	even

off_20EDDE:
	dc.w	byte_20EDEA-off_20EDDE
	dc.w	byte_20EDF5-off_20EDDE
	dc.w	byte_20EE0A-off_20EDDE
	dc.w	byte_20EE1F-off_20EDDE
	dc.w	byte_20EE26-off_20EDDE
	dc.w	byte_20EE2C-off_20EDDE
byte_20EDEA:
	dc.b	2
	dc.b	$F0,7,0,0,$F0
	dc.b	$F0,7,0,0,0
byte_20EDF5:
	dc.b	4
	dc.b	$F0,$C,0,8,$F0
	dc.b	-8,$C,0,8,$F0
	dc.b	0,$C,0,8,$F0
	dc.b	8,$C,0,8,$F0
byte_20EE0A:
	dc.b	4
	dc.b	$F0,$C,8,8,$F0
	dc.b	-8,$C,8,8,$F0
	dc.b	0,$C,8,8,$F0
	dc.b	8,$C,8,8,$F0
byte_20EE1F:
	dc.b	1
	dc.b	$F0,3,0,0,-4
	even
byte_20EE26:
	dc.b	1
	dc.b	-4,$C,0,8,$F0
byte_20EE2C:
	dc.b	1
	dc.b	-4,$C,8,8,$F0
	even

off_20EE32:
	dc.w	unk_20EE3A-off_20EE32
	dc.w	unk_20EE40-off_20EE32
	dc.w	unk_20EE44-off_20EE32
	dc.w	unk_20EE48-off_20EE32
unk_20EE3A:
	dc.b	$1D
	dc.b	0,1,2
	dc.b	$FF
	even
unk_20EE40:
	dc.b	$1D
	dc.b	0
	dc.b	$FF
	even
unk_20EE44:
	dc.b	$1D
	dc.b	1
	dc.b	$FF
	even
unk_20EE48:
	dc.b	$1D
	dc.b	2
	dc.b	$FF
	even

off_20EE4C:
	dc.w	byte_20EE52-off_20EE4C
	dc.w	byte_20EE58-off_20EE4C
	dc.w	byte_20EE5E-off_20EE4C
byte_20EE52:
	dc.b	1
	dc.b	-8,5,0,0,-8
byte_20EE58:
	dc.b	1
	dc.b	-8,5,0,4,-8
byte_20EE5E:
	dc.b	2
	dc.b	-8,9,0,8,$E8
	dc.b	-8,9,8,8,0
	even

	include	"Actors/20 - Kuzureru Tikei.asm"
	include	"Actors/21 - DoDai.asm"

	lea	word_20F8B0(pc),a1
	moveq	#0,d0
	moveq	#0,d1
	move.w	scra_h_posit.w,d0

loc_20F88E:
	cmp.w	(a1)+,d0
	blo.s	loc_20F896
	addq.b	#2,d1
	bra.s	loc_20F88E

loc_20F896:
	cmp.b	enecgpnt,d1
	bne.s	loc_20F8A0
	rts

loc_20F8A0:
	move.b	d1,enecgpnt
	move.w	word_20F8B8(pc,d1.w),d0
	jmp	$20201A.l

word_20F8B0:
	dc.w	$700
	dc.w	$1100
	dc.w	$1A00
	dc.w	$FFFF

word_20F8B8:
	dc.w	4
	dc.w	5
	dc.w	6
	dc.w	7

sub_20F8C0:
	lea	off_20F8E2.l,a1
	add.w	d0,d0
	move.w	off_20F8E2(pc,d0.w),d4
	lea	off_20F8E2(pc,d4.w),a2
	moveq	#0,d1
	move.b	act29(a0),d1
	add.w	d1,d1
	move.w	(a2,d1.w),d5
	move.w	d5,sproffset(a0)
	rts

off_20F8E2:
	dc.w	word_20F902-off_20F8E2
	dc.w	word_20F904-off_20F8E2
	dc.w	word_20F906-off_20F8E2
	dc.w	word_20F908-off_20F8E2
	dc.w	word_20F90A-off_20F8E2
	dc.w	word_20F90C-off_20F8E2
	dc.w	word_20F916-off_20F8E2
	dc.w	word_20F910-off_20F8E2
	dc.w	word_20F914-off_20F8E2
	dc.w	word_20F912-off_20F8E2
	dc.w	word_20F90E-off_20F8E2
	dc.w	word_20F918-off_20F8E2
	dc.w	word_20F91A-off_20F8E2
	dc.w	word_20F91C-off_20F8E2
	dc.w	word_20F91E-off_20F8E2
	dc.w	word_20F920-off_20F8E2
word_20F902:
	dc.w	$2475
word_20F904:
	dc.w	$240B
word_20F906:
	dc.w	$23F5
word_20F908:
	dc.w	$2447
word_20F90A:
	dc.w	$2475
word_20F90C:
	dc.w	$2000
word_20F90E:
	dc.w	$339
word_20F910:
	dc.w	$345
word_20F912:
	dc.w	$443F
word_20F914:
	dc.w	$4447
word_20F916:
	dc.w	$3D2
word_20F918:
	dc.w	$3E1
word_20F91A:
	dc.w	$83B4
word_20F91C:
	dc.w	$46C
word_20F91E:
	dc.w	$3AC
word_20F920:
	dc.w	$386

	include	"Actors/24 - Friend.asm"
	include	"Actors/17 - Goal.asm"

	jmp	$207908.l

	dc.l	3<<24+$238018
	dc.l	2<<24+$236DEE
	dc.l	$23AB36
	dc.w	bgm_zone1
	dc.b	4,4

off_20FBE6:
	dc.w	word_20FBF6-off_20FBE6
	dc.w	word_20FBFE-off_20FBE6
	dc.w	word_20FC30-off_20FBE6
	dc.w	word_20FBF6-off_20FBE6
	dc.w	word_20FC8C-off_20FBE6
	dc.w	word_20FC94-off_20FBE6
	dc.w	word_20FCAE-off_20FBE6
	dc.w	word_20FCBC-off_20FBE6

word_20FBF6:	ddev_header
	ddev_entry	$238018,0
word_20FBF6_end:

word_20FBFE:	ddev_header
	ddev_entry	$231B28,$4FE
	ddev_entry	$231C36,$511
	ddev_entry	$23051E,$520
	ddev_entry	$231832,$568
	ddev_entry	$230740,$5A8
	ddev_entry	$230CD6,$680
	ddev_entry	$23195E,$6D6
	ddev_entry	$2311BE,$7AE
word_20FBFE_end:

word_20FC30:	ddev_header
	ddev_entry	$233AAA,$339
	ddev_entry	$2335AE,$345
	ddev_entry	$23051E,$35A
	ddev_entry	$230256,$386
	ddev_entry	$231D1C,$3AC
	ddev_entry	$2321AC,$3B4
	ddev_entry	$231C36,$3C0
	ddev_entry	$231DD2,$3D2
	ddev_entry	$231B28,$3E1
	ddev_entry	$232C1C,$3F5
	ddev_entry	$23290E,$40B
	ddev_entry	$2338E2,$43F
	ddev_entry	$232E00,$447
	ddev_entry	$2324F4,$475
	ddev_entry	$233C5A,$4BF
word_20FC30_end:

word_20FC8C:	ddev_header
	ddev_entry	$2324F4,$475
word_20FC8C_end:

word_20FC94:	ddev_header
	ddev_entry	$2338E2,$43F
	ddev_entry	$232E00,$447
	ddev_entry	$233154,$475
	ddev_entry	$233C5A,$4BF
word_20FC94_end:

word_20FCAE:	ddev_header
	ddev_entry	$2336E6,$447
	ddev_entry	$231EC0,$480
word_20FCAE_end:

word_20FCBC:	ddev_header
	ddev_entry	$232E00,$447
	ddev_entry	$2324F4,$475
word_20FCBC_end: