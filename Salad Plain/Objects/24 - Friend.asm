friend:
	moveq	#0,d0
	move.b	userflag(a0),d0
	add.w	d0,d0
	move.w	friend_move_tbl(pc,d0.w),d0
	jsr	friend_move_tbl(pc,d0.w)
	jmp	frameout_s.l

friend_move_tbl:
	dc.w	tsubame-friend_move_tbl
	dc.w	pecky-friend_move_tbl

tsubame:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	tsubame_move_tbl(pc,d0.w),d0
	jmp	tsubame_move_tbl(pc,d0.w)

tsubame_move_tbl:
	dc.w	t_init-tsubame_move_tbl
	dc.w	t_move-tsubame_move_tbl
	dc.w	t_movie-tsubame_move_tbl

t_init:
	addq.b	#word,r_no0(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#16/2,sprhs(a0)
	move.b	#16/2,sprvsize(a0)
	move.w	#friend1_vram,sproffset(a0)
	move.l	#pat_friend0,patbase(a0)
	move.l	xposi(a0),act2A(a0)
	move.l	yposi(a0),act2E(a0)
	move.b	#1,act32(a0)
	rts

t_move:
	move.b	act32(a0),d0
	jsr	sinset.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	act2A(a0),d1
	add.l	act2E(a0),d0
	move.l	d1,xposi(a0)
	move.l	d0,yposi(a0)
	move.w	#friend2_vram,sproffset(a0)
	addq.b	#1,act32(a0)
	cmpi.b	#$7F,act32(a0)
	bpl.w	loc_20DD6C

loc_20DD58:
	lea	pchg0.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20DD6C:
	addq.b	#word,r_no0(a0)
	bra.s	loc_20DD58

t_movie:
	move.b	act32(a0),d0
	jsr	sinset.l
	swap	d1
	swap	d0
	asr.l	#1,d1
	asr.l	#1,d0
	add.l	act2A(a0),d1
	add.l	act2E(a0),d0
	move.l	d1,xposi(a0)
	move.l	d0,yposi(a0)
	move.w	#friend1_vram,sproffset(a0)
	addi.b	#-1,act32(a0)
	cmpi.b	#1,act32(a0)
	bmi.w	loc_20DDAC
	bra.s	loc_20DD58

loc_20DDAC:
	addi.b	#-word,r_no0(a0)
	bra.s	loc_20DD58

pchg0:
	dc.w	pchg00-pchg0
pchg00:
	dc.b	20-1
	dc.b	0,1
	dc.b	$FF
	even

pat_friend0:
	include	"Patterns/Friend 0.asm"

pecky:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	off_20DDD8(pc,d0.w),d0
	jmp	off_20DDD8(pc,d0.w)

off_20DDD8:
	dc.w	p_init-off_20DDD8
	dc.w	p_move-off_20DDD8
	dc.w	p_movie-off_20DDD8

p_init:
	addq.b	#word,r_no0(a0)
	move.b	#%00000100,actflg(a0)
	move.b	#1,sprpri(a0)
	move.b	#16/2,sprhs(a0)
	move.b	#16/2,sprvsize(a0)
	move.w	#friend1_vram,sproffset(a0)
	move.l	#pat_friend1,patbase(a0)
	move.l	#-$40000,act2A(a0)
	rts

p_move:
	move.w	#friend1_vram,sproffset(a0)
	addi.l	#$10000,xposi(a0)
	move.l	act2A(a0),d0
	add.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	addi.l	#$2000,act2A(a0)
	bmi.w	loc_20DE40
	move.b	#1,mstno(a0)

loc_20DE40:
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_20DE60

loc_20DE4C:
	lea	pchg1.l,a1
	jsr	patchg.l
	jmp	actionsub.l
	rts

loc_20DE60:
	addq.b	#word,r_no0(a0)
	move.l	#-$40000,act2A(a0)
	bra.s	loc_20DE4C

p_movie:
	move.w	#friend2_vram,sproffset(a0)
	addi.l	#-$10000,xposi(a0)
	move.l	act2A(a0),d0
	add.l	d0,yposi(a0)
	move.b	#0,mstno(a0)
	addi.l	#$2000,act2A(a0)
	bmi.w	loc_20DE9C
	move.b	#1,mstno(a0)

loc_20DE9C:
	jsr	emycol_d.l
	tst.w	d1
	bmi.w	loc_20DEAA
	bra.s	loc_20DE4C

loc_20DEAA:
	addi.b	#-word,r_no0(a0)
	move.l	#-$40000,act2A(a0)
	bra.s	loc_20DE4C

pchg1:
	dc.w	pchg10-pchg1
	dc.w	pchg11-pchg1
pchg10:
	dc.b	20-1
	dc.b	1
	dc.b	$FF
	even
pchg11:
	dc.b	20-1
	dc.b	0
	dc.b	$FF
	even

pat_friend1:
	include	"Patterns/Friend 1.asm"