koma:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	koma_move_tbl(pc,d0.w),d0
	jsr	koma_move_tbl(pc,d0.w)
	move.w	act36(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.w	frameout
	rts

koma_move_tbl:
	dc.w	koma_init-koma_move_tbl
	dc.w	koma_move-koma_move_tbl
	dc.w	koma_move2-koma_move_tbl

koma_init:
	addq.b	#word,r_no0(a0)
	ori.b	#4,actflg(a0)
	move.b	#4,sprpri(a0)
	move.l	#komapat,patbase(a0)
	move.b	#8,sprhsize(a0)
	move.b	#8,sprvsize(a0)
	move.w	xposi(a0),act36(a0)
	move.w	#$180,xspeed(a0)
	moveq	#14,d0
	jsr	pa_set.l
	jsr	actwkchk.l
	beq.s	loc_208462
	jmp	frameout.l

loc_208462:
	_move.b	#spring_act,actno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	subi.w	#$10,yposi(a1)
	move.b	#$F0,act39(a1)
	move.w	a0,act34(a1)
	move.b	userflag(a0),userflag(a1)

koma_move:
	jsr	emycol_d.l
	tst.w	d1
	bpl.s	loc_2084A4
	add.w	d1,yposi(a0)
	move.w	yposi(a0),act32(a0)
	addq.b	#word,r_no0(a0)
	rts

loc_2084A4:
	addq.w	#1,yposi(a0)
	rts

koma_move2:
	tst.w	time_stop
	bne.s	loc_2084E0
	jsr	emycol_d.l
	add.w	d1,yposi(a0)
	move.w	act32(a0),d0
	sub.w	yposi(a0),d0
	cmpi.w	#$C,d0
	blo.s	loc_2084CE
	neg.w	xspeed(a0)

loc_2084CE:
	jsr	speedset2.l
	lea	komachg.l,a1
	jsr	patchg.l

loc_2084E0:
	jmp	actionsub.l

spring:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	beq.s	loc_2084F4
	tst.b	actflg(a0)
	bpl.s	loc_2084FC

loc_2084F4:
	move.w	sjump_move_tbl(pc,d0.w),d1
	jsr	sjump_move_tbl(pc,d1.w)

loc_2084FC:
	bsr.w	actionsub
	move.l	#$FFFF0000,d1
	move.w	act34(a0),d1
	beq.s	loc_20852E
	movea.l	d1,a1
	move.w	xposi(a1),xposi(a0)
	move.w	yposi(a1),yposi(a0)
	move.b	act38(a0),d0
	ext.w	d0
	add.w	d0,xposi(a0)
	move.b	act39(a0),d0
	ext.w	d0
	add.w	d0,yposi(a0)

loc_20852E:
	move.w	act36(a0),d0
	andi.w	#$FF80,d0
	move.w	scra_h_posit.w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.w	frameout
	rts

sjump_move_tbl:
	dc.w	sjumpinit-sjump_move_tbl
	dc.w	sjumpmove-sjump_move_tbl
	dc.w	sjumpmove2-sjump_move_tbl
	dc.w	sjumpmove3-sjump_move_tbl
	dc.w	sdushmove-sjump_move_tbl
	dc.w	sdushmove2-sjump_move_tbl
	dc.w	sdushmove3-sjump_move_tbl
	dc.w	sjump2move-sjump_move_tbl
	dc.w	sjump2move2-sjump_move_tbl
	dc.w	sjump2move3-sjump_move_tbl
	dc.w	sjump3move-sjump_move_tbl
	dc.w	sjump3move2-sjump_move_tbl
	dc.w	sjump3move3-sjump_move_tbl

sjumpinit:
	addq.b	#word,r_no0(a0)
	move.l	#springpat,patbase(a0)
	move.w	#$520,sproffset(a0)
	ori.b	#4,actflg(a0)
	move.b	#16,sprhsize(a0)
	move.b	#8,sprvsize(a0)
	move.w	xposi(a0),act36(a0)
	move.b	#4,sprpri(a0)
	move.b	userflag(a0),d0
	btst	#2,d0
	beq.s	loc_2085BE
	move.b	#8,r_no0(a0)
	move.b	#8,sprhsize(a0)
	move.b	#16,sprvsize(a0)
	move.l	#spring90pat,patbase(a0)
	bra.s	loc_2085FA

loc_2085BE:
	btst	#3,d0
	beq.s	loc_2085E6
	move.b	#$14,r_no0(a0)
	move.b	#16,sprvsize(a0)
	move.l	#spring45pat,patbase(a0)
	move.l	d0,-(sp)
	moveq	#15,d0
	jsr	pa_set.l
	move.l	(sp)+,d0
	bra.s	loc_2085FA

loc_2085E6:
	btst	#1,actflg(a0)
	beq.s	loc_2085FA
	move.b	#$E,r_no0(a0)
	bset	#1,cddat(a0)

loc_2085FA:
	btst	#1,d0
	beq.s	loc_208606
	bset	#5,sproffset(a0)

loc_208606:
	andi.w	#2,d0
	move.w	sjumptbl(pc,d0.w),act30(a0)
	rts

sjumptbl:
	dc.w	-$1000
	dc.w	-$A00

ride_on_chk_s:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	ride_on_chk.l

sjumpmove:
	tst.b	actflg(a0)
	bpl.s	locret_20863C
	lea	playerwk.w,a1
	bsr.s	ride_on_chk_s
	beq.s	loc_208634
	bsr.s	sub_20863E

loc_208634:
	lea	player2wk.w,a1
	bsr.s	ride_on_chk_s
	bne.s	sub_20863E

locret_20863C:
	rts

sub_20863E:
	move.b	#4,r_no0(a0)
	addq.w	#8,yposi(a1)
	move.w	act30(a0),yspeed(a1)
	bset	#cd_walk,cddat(a1)
	bclr	#cd_ride,cddat(a1)
	move.b	#$10,mstno(a1)
	bclr	#3,cddat(a0)
	move.w	#se_98,d0
	jmp	soundset.l

sjumpmove2:
	lea	playerwk.w,a1
	bsr.s	ride_on_chk_s
	lea	player2wk.w,a1
	bsr.s	ride_on_chk_s
	lea	springchg.l,a1
	bra.w	patchg

sjumpmove3:
	bclr	#3,cddat(a0)
	move.b	#1,mstrestart(a0)
	subq.b	#4,r_no0(a0)
	move.b	#0,patno(a0)
	rts

ride_on_chk_s1:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	ride_on_chk.l

sdushmove:
	tst.b	actflg(a0)
	bpl.s	locret_2086D0
	lea	playerwk.w,a1
	bsr.s	ride_on_chk_s1
	btst	#5,cddat(a0)
	beq.s	loc_2086C2
	bsr.s	sub_2086D2

loc_2086C2:
	lea	player2wk.w,a1
	bsr.s	ride_on_chk_s1
	btst	#5,cddat(a0)
	bne.s	sub_2086D2

locret_2086D0:
	rts

sub_2086D2:
	move.b	#$A,r_no0(a0)
	move.w	act30(a0),xspeed(a1)
	addq.w	#8,xposi(a1)
	bset	#cd_left,cddat(a1)
	btst	#0,cddat(a0)
	bne.s	loc_208700
	subi.w	#$10,xposi(a1)
	neg.w	xspeed(a1)
	bclr	#cd_left,cddat(a1)

loc_208700:
	move.w	#$F,act3E(a1)
	move.w	xspeed(a1),mspeed(a1)
	btst	#cd_ball,cddat(a1)
	bne.s	loc_20871A
	move.b	#0,mstno(a1)

loc_20871A:
	clr.b	direc(a1)
	bclr	#5,cddat(a0)
	bclr	#cd_push,cddat(a1)
	move.w	#se_98,d0
	jmp	soundset.l

sdushmove2:
	lea	playerwk.w,a1
	bsr.w	ride_on_chk_s1
	lea	player2wk.w,a1
	bsr.w	ride_on_chk_s1
	lea	springchg.l,a1
	bra.w	patchg

sdushmove3:
	move.b	#1,mstrestart(a0)
	subq.b	#4,r_no0(a0)
	move.b	#0,patno(a0)
	rts

ride_on_chk_s2:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d4
	jmp	ride_on_chk.l

sjump2move:
	tst.b	actflg(a0)
	bpl.s	locret_208786
	lea	playerwk.w,a1
	bsr.s	ride_on_chk_s2
	beq.s	loc_20877E
	bsr.s	sub_208788

loc_20877E:
	lea	player2wk.w,a1
	bsr.s	ride_on_chk_s2
	bne.s	sub_208788

locret_208786:
	rts

sub_208788:
	move.b	#$10,r_no0(a0)
	subq.w	#8,yposi(a1)
	move.w	act30(a0),yspeed(a1)
	neg.w	yspeed(a1)
	bset	#cd_walk,cddat(a1)
	bclr	#cd_ride,cddat(a1)
	bclr	#3,cddat(a0)
	move.w	#se_98,d0
	jsr	soundset.l

sjump2move2:
	lea	playerwk.w,a1
	bsr.s	ride_on_chk_s2
	lea	player2wk.w,a1
	bsr.s	ride_on_chk_s2
	lea	springchg.l,a1
	bra.w	patchg

sjump2move3:
	move.b	#1,mstrestart(a0)
	subq.b	#4,r_no0(a0)
	move.b	#0,patno(a0)
	rts

sjump3move:
	tst.b	actflg(a0)
	bpl.s	locret_20880C
	lea	playerwk.w,a1
	bsr.w	ride_on_chk_s2
	bne.s	loc_2087F8
	btst	#5,cddat(a0)
	beq.s	loc_2087FA

loc_2087F8:
	bsr.s	sub_20880E

loc_2087FA:
	lea	player2wk.w,a1
	bsr.w	ride_on_chk_s2
	bne.s	sub_20880E
	btst	#5,cddat(a0)
	bne.s	sub_20880E

locret_20880C:
	rts

sub_20880E:
	move.b	#$16,r_no0(a0)
	moveq	#0,d0
	move.b	#$D0,d0
	jsr	sinset.l
	move.w	act30(a0),d2
	neg.w	d2
	mulu.w	d2,d0
	mulu.w	d2,d1
	lsr.l	#8,d0
	lsr.l	#8,d1
	move.w	d0,yspeed(a1)
	move.w	d1,xspeed(a1)
	addq.w	#8,yposi(a1)
	btst	#1,actflg(a0)
	beq.s	loc_20884C
	subi.w	#$10,yposi(a1)
	neg.w	yspeed(a1)

loc_20884C:
	bclr	#cd_left,cddat(a1)
	subq.w	#8,xposi(a1)
	btst	#0,cddat(a0)
	beq.s	loc_20886E
	addi.w	#$10,xposi(a1)
	bset	#cd_left,cddat(a1)
	neg.w	xspeed(a1)

loc_20886E:
	bset	#cd_walk,cddat(a1)
	bclr	#cd_ride,cddat(a1)
	bclr	#cd_push,cddat(a1)
	bclr	#3,cddat(a0)
	bclr	#5,cddat(a0)
	move.w	#se_98,d0
	jsr	soundset.l

sjump3move2:
	lea	springchg.l,a1
	bra.w	patchg

sjump3move3:
	move.b	#1,mstrestart(a0)
	subq.b	#4,r_no0(a0)
	move.b	#0,patno(a0)
	rts

sjumpchg:
	dc.w	sjumpchg0-sjumpchg
	dc.w	sjumpchg1-sjumpchg

sjumpchg0:
	dc.b	0
	dc.b	0,0,0,2,2,2,2,2,2,0
	dc.b	$FC
	even
sjumpchg1:
	dc.b	0
	dc.b	4,3,3,5,5,5,5,5,5,3
	dc.b	$FC
	even

banepat:
	dc.w	banevsp00-banepat
	dc.w	banevsp01-banepat
	dc.w	banevsp02-banepat
	dc.w	banehsp00-banepat
	dc.w	banehsp01-banepat
	dc.w	banehsp02-banepat

banevsp00:
	dc.b	2
	dc.b	-8,$C,0,0,$F0
	dc.b	0,$C,0,4,$F0
banevsp01:
	dc.b	1
	dc.b	0,$C,0,0,$F0
banevsp02:
	dc.b	3
	dc.b	$E8,$C,0,0,$F0
	dc.b	$F0,5,0,8,-8
	dc.b	0,$C,0,$C,$F0
banehsp00:
	dc.b	1
	dc.b	$F0,7,0,0,-8
banehsp01:
	dc.b	1
	dc.b	$F0,3,0,4,-8
banehsp02:
	dc.b	4
	dc.b	$F0,3,0,4,$10
	dc.b	-8,9,0,8,-8
	dc.b	$F0,0,0,0,-8
	dc.b	8,0,0,3,-8

springchg:
	dc.w	springchg0-springchg

springchg0:
	dc.b	0
	dc.b	0,1,1,2,2,2,2,2,2,1
	dc.b	$FC
	even

springpat:
	dc.w	spat00-springpat
	dc.w	spat01-springpat
	dc.w	spat02-springpat

spring90pat:
	dc.w	spat03-spring90pat
	dc.w	spat04-spring90pat
	dc.w	spat05-spring90pat

spat00:
	dc.b	2
	dc.b	-8,$C,0,0,$F0
	dc.b	0,$C,0,4,$F0
	even
spat01:
	dc.b	1
	dc.b	0,$C,0,0,$F0
	even
spat02:
	dc.b	3
	dc.b	$E0,$C,0,0,$F0
	dc.b	$E8,6,0,8,-8
	dc.b	0,$C,0,$E,$F0
	even
spat03:
	dc.b	2
	dc.b	$F0,3,0,$12,0
	dc.b	$F0,3,0,$16,-8
	even
spat04:
	dc.b	1
	dc.b	$F0,3,0,$12,-8
	even
spat05:
	dc.b	3
	dc.b	$F0,3,0,$12,$18
	dc.b	-8,9,0,$1A,0
	dc.b	$F0,3,0,$20,-8
	even

spring45pat:
	dc.w	spat06-spring45pat
	dc.w	spat07-spring45pat
	dc.w	spat08-spring45pat

spat06:
	dc.b	3
	dc.b	$F0,8,0,0,$F0
	dc.b	-8,$D,0,3,$F0
	dc.b	8,8,0,$B,-8
	even
spat07:
	dc.b	4
	dc.b	$F0,5,0,$E,$F0
	dc.b	-8,0,0,$12,0
	dc.b	0,0,0,$13,$F0
	dc.b	0,9,0,$14,-8
	even
spat08:
	dc.b	5
	dc.b	$E0,8,0,0,0
	dc.b	$E8,$E,0,$1A,0
	dc.b	$F0,1,0,$26,-8
	dc.b	-8,1,0,$28,$F0
	dc.b	0,5,0,$2A,-8
	even

komachg:
	dc.w	komachg0-komachg

komachg0:
	dc.b	8
	dc.b	0,1
	dc.b	$FF
	even

komapat:
	dc.w	kpat00-komapat
	dc.w	kpat01-komapat

kpat00:
	dc.b	1
	dc.b	-8,5,0,0,-8
	even
kpat01:
	dc.b	1
	dc.b	-8,5,0,4,-8
	even