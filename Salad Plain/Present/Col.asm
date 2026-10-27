clrchgctr:
	lea	clst1_1a0.l,a0
	subq.b	#1,clchgtim.w
	bpl.s	.jump2
	move.b	#7,clchgtim.w
	moveq	#0,d0
	move.b	clchgcnt.w,d0
	cmpi.b	#2,d0
	bne.s	.jump
	moveq	#0,d0
	bra.s	.jump1

.jump:
	addq.b	#1,d0

.jump1:
	move.b	d0,clchgcnt.w
	lsl.w	#3,d0
	lea	lpcolorwk+$6A.w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

.jump2:
	adda.w	#clst1_1a1-clst1_1a0,a0
	subq.b	#1,clchgtim+1.w
	bpl.s	.end
	move.b	#5,clchgtim+1.w
	moveq	#0,d0
	move.b	clchgcnt+1.w,d0
	cmpi.b	#2,d0
	bne.s	.jump3
	moveq	#0,d0
	bra.s	.jump4

.jump3:
	addq.b	#1,d0

.jump4:
	move.b	d0,clchgcnt+1.w
	andi.w	#3,d0
	lsl.w	#3,d0
	lea	lpcolorwk+$58.w,a1
	move.l	(a0,d0.w),(a1)+
	move.l	4(a0,d0.w),(a1)

.end:
	rts

clst1_1a0:
	dc.w	$ECC,$ECA,$EEE,$EA8
	dc.w	$EA8,$ECC,$ECC,$ECA
	dc.w	$ECA,$EA8,$ECA,$ECC

clst1_1a1:
	dc.w	$ECA,$EA8,$C60,$E86
	dc.w	$EA8,$E86,$C60,$ECA
	dc.w	$E86,$ECA,$C60,$EA8

;fadein:
;	move.w	#$003F,startcolor.w

fadein0:
	moveq	#0,d0
	lea	lpcolorwk.w,a0
	move.b	startcolor.w,d0
	adda.w	d0,a0
	moveq	#$000,d1
	move.b	colorcnt.w,d0

.loop:
	move.w	d1,(a0)+
	dbf	d0,.loop

	move.w	#22-1,d4

fadein0_new:
	move.b	#int_12,int_flg.w
	bsr.w	sync
	bsr.s	fadein1
	bsr.w	sub_20209A
	dbf	d4,fadein0_new

	rts

fadein1:
	moveq	#0,d0
	lea	lpcolorwk.w,a0
	lea	lpcolorwk2.w,a1
	move.b	startcolor.w,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	colorcnt.w,d0

.loop:
	bsr.s	fadein2
	dbf	d0,.loop

	cmpi.b	#stage_lz,stageno
	bne.s	.jump
	moveq	#0,d0
	lea	lpcolorwk3.w,a0
	lea	lpcolorwk4.w,a1
	move.b	startcolor.w,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	colorcnt.w,d0

.loop1:
	bsr.s	fadein2
	dbf	d0,.loop1

.jump:
	rts

fadein2:
	move.w	(a1)+,d2
	move.w	(a0),d3
	cmp.w	d2,d3
	beq.s	.jump2
	move.w	d3,d1
	addi.w	#$200,d1
	cmp.w	d2,d1
	bhi.s	.jump
	move.w	d1,(a0)+
	rts

.jump:
	move.w	d3,d1
	addi.w	#$20,d1
	cmp.w	d2,d1
	bhi.s	.jump1
	move.w	d1,(a0)+
	rts

.jump1:
	addq.w	#2,(a0)+
	rts

.jump2:
	addq.w	#2,a0
	rts

fadeout:
	move.w	#$003F,startcolor.w
	move.w	#22-1,d4

fadeout_new:
	move.b	#int_12,int_flg.w
	bsr.w	sync
	bsr.s	fadeout1
	bsr.w	sub_20209A
	dbf	d4,fadeout_new

	rts

fadeout1:
	moveq	#0,d0
	lea	lpcolorwk.w,a0
	move.b	startcolor.w,d0
	adda.w	d0,a0
	move.b	colorcnt.w,d0

.loop:
	bsr.s	fadeout2
	dbf	d0,.loop

	moveq	#0,d0
	lea	lpcolorwk3.w,a0
	move.b	startcolor.w,d0
	adda.w	d0,a0
	move.b	colorcnt.w,d0

.loop1:
	bsr.s	fadeout2
	dbf	d0,.loop1

	rts

fadeout2:
	move.w	(a0),d2
	beq.s	.jump2
	move.w	d2,d1
	andi.w	#$E,d1
	beq.s	.jump
	subq.w	#2,(a0)+
	rts

.jump:
	move.w	d2,d1
	andi.w	#$E0,d1
	beq.s	.jump1
	subi.w	#$20,(a0)+
	rts

.jump1:
	move.w	d2,d1
	andi.w	#$E00,d1
	beq.s	.jump2
	subi.w	#$200,(a0)+
	rts

.jump2:
	addq.w	#2,a0
	rts

flashin:
	move.w	#$003F,startcolor.w
	moveq	#0,d0
	lea	lpcolorwk.w,a0
	move.b	startcolor.w,d0
	adda.w	d0,a0
	move.w	#$EEE,d1
	move.b	colorcnt.w,d0

.loop:
	move.w	d1,(a0)+
	dbf	d0,.loop

	move.w	#22-1,d4

flashin_new:
	move.b	#int_12,int_flg.w
	bsr.w	sync
	bsr.s	flashin1
	bsr.w	sub_20209A
	dbf	d4,flashin_new

	rts

flashin1:
	moveq	#0,d0
	lea	lpcolorwk.w,a0
	lea	lpcolorwk2.w,a1
	move.b	startcolor.w,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	colorcnt.w,d0

.loop:
	bsr.s	flashin2
	dbf	d0,.loop

	cmpi.b	#stage_lz,stageno
	bne.s	.jump
	moveq	#0,d0
	lea	lpcolorwk3.w,a0
	lea	lpcolorwk4.w,a1
	move.b	startcolor.w,d0
	adda.w	d0,a0
	adda.w	d0,a1
	move.b	colorcnt.w,d0

.loop1:
	bsr.s	flashin2
	dbf	d0,.loop1

.jump:
	rts

flashin2:
	move.w	(a1)+,d2
	move.w	(a0),d3
	cmp.w	d2,d3
	beq.s	.jump2
	move.w	d3,d1
	subi.w	#$200,d1
	blo.s	.jump
	cmp.w	d2,d1
	blo.s	.jump
	move.w	d1,(a0)+
	rts

.jump:
	move.w	d3,d1
	subi.w	#$20,d1
	blo.s	.jump1
	cmp.w	d2,d1
	blo.s	.jump1
	move.w	d1,(a0)+
	rts

.jump1:
	subq.w	#2,(a0)+
	rts

.jump2:
	addq.w	#2,a0
	rts

flashout:
	move.w	#$003F,startcolor.w
	move.w	#22-1,d4

flashout_new:
	move.b	#int_12,int_flg.w
	bsr.w	sync
	bsr.s	flashout1
	bsr.w	sub_20209A
	dbf	d4,flashout_new

	rts

flashout1:
	moveq	#0,d0
	lea	lpcolorwk.w,a0
	move.b	startcolor.w,d0
	adda.w	d0,a0
	move.b	colorcnt.w,d0

.loop:
	bsr.s	flashout2
	dbf	d0,.loop

	moveq	#0,d0
	lea	lpcolorwk3.w,a0
	move.b	startcolor.w,d0
	adda.w	d0,a0
	move.b	colorcnt.w,d0

.loop1:
	bsr.s	flashout2
	dbf	d0,.loop1

	rts

flashout2:
	move.w	(a0),d2
	cmpi.w	#$EEE,d2
	beq.s	.jump2
	move.w	d2,d1
	andi.w	#$E,d1
	cmpi.w	#$E,d1
	beq.s	.jump
	addq.w	#2,(a0)+
	rts

.jump:
	move.w	d2,d1
	andi.w	#$E0,d1
	cmpi.w	#$E0,d1
	beq.s	.jump1
	addi.w	#$20,(a0)+
	rts

.jump1:
	move.w	d2,d1
	andi.w	#$E00,d1
	cmpi.w	#$E00,d1
	beq.s	.jump2
	addi.w	#$200,(a0)+
	rts

.jump2:
	addq.w	#2,a0
	rts

colorset:
	lea	colortbl.l,a1
	lsl.w	#3,d0
	adda.w	d0,a1
	movea.l	(a1)+,a2
	movea.w	(a1)+,a3
	adda.w	#lpcolorwk2-lpcolorwk,a3
	move.w	(a1)+,d7

.loop:
	move.l	(a2)+,(a3)+
	dbf	d7,.loop

	rts

colorset2:
	lea	colortbl.l,a1
	lsl.w	#3,d0
	adda.w	d0,a1
	movea.l	(a1)+,a2
	movea.w	(a1)+,a3
	move.w	(a1)+,d7

.loop:
	move.l	(a2)+,(a3)+
	dbf	d7,.loop

	rts

colortbl:

pal_ptr	macro	ptr,line,size,{INTLABEL}
__LABEL__:	label	(*-colortbl)/8
	dc.l	ptr
	dc.w	lpcolorwk+line*$10
	dc.w	size/2-1
	endm

colorlogo:	pal_ptr	logocolor,0,64
coloradva:	pal_ptr	advacolor,0,64
coloradva2:	pal_ptr	advacolor2,0,64
colorgame:	pal_ptr	gamecolor,0,16
colorzone1:	pal_ptr	zone1color,2,48

logocolor:
;	incbin	"Leftovers/Palettes/Sega Background (Sonic 1).bin"
;	even

advacolor:
	incbin	"Leftovers/Palettes/Title Screen (Sonic 1).bin"
	even

advacolor2:
	incbin	"Leftovers/Palettes/Level Select (Sonic 1).bin"
	even

gamecolor:
	incbin	"Palettes/Player.bin"
	even

zone1color:
	incbin	"Palettes/SPZ.bin"
	even