scoreup:
	move.b	#1,plscore_f
	lea	plscore,a3
	add.l	d0,(a3)
	move.l	#999999,d1
	cmp.l	(a3),d1
	bhi.s	.jump
	move.l	d1,(a3)
.jump:
	move.l	(a3),d0
	rts

scoreset:
	tst.w	debugflag
	beq.s	.jump0
	bsr.w	posiwrt
	move.l	#$73200002,d0
	moveq	#0,d1
	move.b	byte_FF188A,d1
	bsr.w	sub_209AEA
	bra.w	.jump2

.jump0:
	tst.b	plscore_f
	beq.s	.jump
	clr.b	plscore_f
	move.l	#$70600002,d0
	move.l	plscore,d1
	bsr.w	scorewrt

.jump:
	tst.b	plring_f
	beq.s	.jump2
	bpl.s	.jump1
	bsr.w	ringinit

.jump1:
	clr.b	plring_f
	move.l	#$73200002,d0
	moveq	#0,d1
	move.w	plring,d1
	bsr.w	ringwrt

.jump2:
	tst.w	debugflag
	bne.w	.jump4
	tst.b	pltime_f
	beq.s	.jump4
	tst.w	pauseflag.w
	bne.s	.jump4
	lea	pltime,a1
	cmpi.l	#hudmscs(9,59,59),(a1)+
	addq.b	#1,-(a1)
	cmpi.b	#60,(a1)
	blo.s	.jump3
	move.b	#0,(a1)
	addq.b	#1,-(a1)
	cmpi.b	#60,(a1)
	blo.s	.jump3
	move.b	#0,(a1)
	addq.b	#1,-(a1)
	cmpi.b	#9,(a1)
	blo.s	.jump3
	move.b	#9,(a1)

.jump3:
	move.l	#$71E00002,d0
	moveq	#0,d1
	move.b	pltime+1,d1
	bsr.w	timewrt1
	move.l	#$72200002,d0
	moveq	#0,d1
	move.b	pltime+2,d1
	bsr.w	timewrt
	move.l	#$72A00002,d0
	moveq	#0,d1
	move.b	pltime+3,d1
	mulu.w	#100,d1
	divu.w	#60,d1
	swap	d1
	move.w	#0,d1
	swap	d1
	bsr.w	timewrt

.jump4:
	tst.b	pl_suu_f
	beq.s	.jump5
	clr.b	pl_suu_f
	bsr.w	playsuuwrt

.jump5:
	rts

.timeover:
	clr.b	pltime_f
	lea	playerwk.w,a0
	movea.l	a0,a2
	bsr.w	playdieset
	move.b	#1,pltimeover_f
	rts

ringinit:
	move.l	#$73200002,vdpctrl
	lea	ringinittbl(pc),a2
	move.w	#3-1,d2
	bra.s	scoreinitsub

scoreinit:
	lea	vdpdata,a6
	bsr.w	playsuuwrt
	move.l	#$5C400003,vdpctrl
	lea	scoreinittbl(pc),a2
	move.w	#15-1,d2

scoreinitsub:
	lea	scorewrtcg.l,a1

.loop:
	move.w	#16-1,d1
	move.b	(a2)+,d0
	bmi.s	.loop2
	ext.w	d0
	lsl.w	#5,d0
	lea	(a1,d0.w),a3

.loop1:
	move.l	(a3)+,(a6)
	dbf	d1,.loop1

.jump:
	dbf	d2,.loop
	rts

.loop2:
	move.l	#0,(a6)
	dbf	d1,.loop2
	bra.s	.jump

scoreinittbl:
	dc.b	$16,$FF,$FF,$FF,$FF,$FF,$FF,0
	dc.b	0,$14,0,0

ringinittbl:
	dc.b	$FF,$FF,0,0

posiwrt:
	move.l	#$70E00002,d0
	moveq	#0,d1
	move.w	playerwk+xposi.w,d1
	bsr.w	posiwrt0
	move.l	#$72200002,d0
	move.w	playerwk+yposi.w,d1
	bra.w	posiwrt0

ringwrt:
	lea	subtbl3.l,a2
	moveq	#3-1,d6
	bra.s	scorewrt2

scorewrt:
	lea	subtbl.l,a2
	moveq	#6-1,d6

scorewrt2:
	moveq	#0,d4
	lea	scorewrtcg.l,a1

.loop:
	moveq	#0,d2
	move.l	(a2)+,d3

.jump2:
	sub.l	d3,d1
	blo.s	.jump3
	addq.w	#1,d2
	bra.s	.jump2

.jump3:
	add.l	d3,d1
	tst.w	d2
	beq.s	.jump4
	move.w	#1,d4

.jump4:
	tst.w	d4
	beq.s	.jump5
	lsl.w	#6,d2
	move.l	d0,4(a6)
	lea	(a1,d2.w),a3
	rept	16
	move.l	(a3)+,(a6)
	endr

.jump5:
	addi.l	#$400000,d0
	dbf	d6,.loop
	rts

contwrt:
	move.l	#$5F800003,vdpctrl
	lea	vdpdata,a6
	lea	subtbl2.l,a2
	moveq	#2-1,d6
	moveq	#0,d4
	lea	scorewrtcg.l,a1

.loop:
	moveq	#0,d2
	move.l	(a2)+,d3

.jump2:
	sub.l	d3,d1
	blo.s	.jump3
	addq.w	#1,d2
	bra.s	.jump2

.jump3:
	add.l	d3,d1
	lsl.w	#6,d2
	lea	(a1,d2.w),a3
	rept	16
	move.l	(a3)+,(a6)
	endr
	dbf	d6,.loop
	rts

subtbl:
	dc.l	100000
subtbl5:
	dc.l	10000
subtbl4:
	dc.l	1000
subtbl3:
	dc.l	100
subtbl2:
	dc.l	10
subtbl1:
	dc.l	1

subtblh4:
	dc.l	$1000
	dc.l	$100
	dc.l	$10
	dc.l	1

posiwrt0:
	moveq	#4-1,d6
	lea	subtblh4.l,a2
	bra.s	timewrt0

playsuuwrt:
	move.l	#$74600002,d0
	moveq	#0,d1
	move.b	pl_suu,d1
	cmpi.b	#9,d1
	blo.s	sub_209AEA
	moveq	#9,d1

sub_209AEA:
	lea	subtbl1.l,a2
	moveq	#1-1,d6
	bra.s	timewrt0

timewrt1:
	lea	subtbl1.l,a2
	moveq	#1-1,d6
	bra.s	timewrt0

timewrt:
	lea	subtbl2.l,a2
	moveq	#2-1,d6

timewrt0:
	moveq	#0,d4
	lea	scorewrtcg.l,a1

.loop:
	moveq	#0,d2
	move.l	(a2)+,d3

.jump2:
	sub.l	d3,d1
	blo.s	.jump3
	addq.w	#1,d2
	bra.s	.jump2

.jump3:
	add.l	d3,d1
	tst.w	d2
	beq.s	.jump4
	move.w	#1,d4

.jump4:
	lsl.w	#6,d2
	move.l	d0,4(a6)
	lea	(a1,d2.w),a3
	rept	16
	move.l	(a3)+,(a6)
	endr
	addi.l	#$400000,d0
	dbf	d6,.loop
	rts