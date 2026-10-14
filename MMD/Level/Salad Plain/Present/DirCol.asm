dircol:
	move.l	xposi(a0),d3
	move.l	yposi(a0),d2
	move.w	xspeed(a0),d1
	ext.l	d1
	asl.l	#8,d1
	add.l	d1,d3
	move.w	yspeed(a0),d1
	ext.l	d1
	asl.l	#8,d1
	add.l	d1,d2
	swap	d2
	swap	d3
	move.b	d0,dirstk.w
	move.b	d0,dirstk2.w
	move.b	d0,d1
	addi.b	#$20,d0
	bpl.s	loc_206018
	move.b	d1,d0
	bpl.s	loc_206012
	subq.b	#1,d0

loc_206012:
	addi.b	#$20,d0
	bra.s	loc_206022

loc_206018:
	move.b	d1,d0
	bpl.s	loc_20601E
	addq.b	#1,d0

loc_20601E:
	addi.b	#$1F,d0

loc_206022:
	andi.b	#$C0,d0
	beq.w	dircol_d3
	cmpi.b	#$80,d0
	beq.w	dircol_u3
	andi.b	#$38,d1
	bne.s	loc_20603A
	addq.w	#8,d2

loc_20603A:
	cmpi.b	#$40,d0
	beq.w	dircol_l3
	bra.w	dircol_r3

dircol2:
	move.b	d0,dirstk.w
	move.b	d0,dirstk2.w
	addi.b	#$20,d0
	andi.b	#$C0,d0
	cmpi.b	#$40,d0
	beq.w	dircol_l
	cmpi.b	#$80,d0
	beq.w	dircol_u
	cmpi.b	#$C0,d0
	beq.w	dircol_r

dircol_d:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	jsr	scdchk.l
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	lea	dirstk2.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	jsr	scdchk.l
	move.w	(sp)+,d0
	move.b	#0,d2

dircolchk:
	move.b	dirstk2.w,d3
	cmp.w	d0,d1
	ble.s	loc_2060E0
	move.b	dirstk.w,d3
	exg.l	d0,d1

loc_2060E0:
	btst	#0,d3
	beq.s	locret_2060E8
	move.b	d2,d3

locret_2060E8:
	rts

dircol_d2:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3

dircol_d3:
	addi.w	#$A,d2
	lea	dirstk.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$E,d5
	jsr	scdchk.l
	move.b	#0,d2

dircolchk1:
	move.b	dirstk.w,d3
	btst	#0,d3
	beq.s	locret_20611A
	move.b	d2,d3

locret_20611A:
	rts

emycol_d:
	move.w	xposi(a0),d3
	move.w	yposi(a0),d2
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	lea	dirstk.w,a4
	move.b	#0,(a4)
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$D,d5
	jsr	scdchk.l
	move.b	dirstk.w,d3
	btst	#0,d3
	beq.s	locret_206154
	move.b	#0,d3

locret_206154:
	rts

dircol_r:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk2.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.w	(sp)+,d0
	move.b	#-$40,d2
	bra.w	dircolchk

dircol_r2:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3

dircol_r3:
	addi.w	#$A,d3
	lea	dirstk.w,a4
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.b	#-$40,d2
	bra.w	dircolchk1

emycol_r:
	add.w	xposi(a0),d3
	move.w	yposi(a0),d2
	lea	dirstk.w,a4
	move.b	#0,(a4)
	movea.w	#$10,a3
	move.w	#0,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.b	dirstk.w,d3
	btst	#0,d3
	beq.s	locret_206214
	move.b	#-$40,d3

locret_206214:
	rts

dircol_u:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d3
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$1000,d6
	moveq	#$E,d5
	jsr	scdchk.l
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d3
	lea	dirstk2.w,a4
	movea.w	#-$10,a3
	move.w	#$1000,d6
	moveq	#$E,d5
	jsr	scdchk.l
	move.w	(sp)+,d0
	move.b	#$80,d2
	bra.w	dircolchk

dircol_u2:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3

dircol_u3:
	subi.w	#$A,d2
	eori.w	#$F,d2
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$1000,d6
	moveq	#$E,d5
	jsr	scdchk.l
	move.b	#$80,d2
	bra.w	dircolchk1

emycol_u:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d2
	eori.w	#$F,d2
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$1000,d6
	moveq	#$E,d5
	jsr	scdchk.l
	move.b	dirstk.w,d3
	btst	#0,d3
	beq.s	locret_2062EA
	move.b	#$80,d3

locret_2062EA:
	rts

dircol_l:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	sub.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d3
	eori.w	#$F,d3
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.w	d1,-(sp)
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3
	moveq	#0,d0
	move.b	sprhs(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	sub.w	d0,d3
	eori.w	#$F,d3
	lea	dirstk2.w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.w	(sp)+,d0
	move.b	#$40,d2
	bra.w	dircolchk

dircol_l2:
	move.w	yposi(a0),d2
	move.w	xposi(a0),d3

dircol_l3:
	subi.w	#$A,d3
	eori.w	#$F,d3
	lea	dirstk.w,a4
	movea.w	#-$10,a3
	move.w	#$800,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.b	#$40,d2
	bra.w	dircolchk1

emycol_l:
	add.w	xposi(a0),d3
	move.w	yposi(a0),d2
	lea	dirstk.w,a4
	move.b	#0,(a4)
	movea.w	#-$10,a3
	move.w	#$800,d6
	moveq	#$E,d5
	jsr	scdchk_r.l
	move.b	dirstk.w,d3
	btst	#0,d3
	beq.s	locret_2063B6
	move.b	#$40,d3

locret_2063B6:
	rts