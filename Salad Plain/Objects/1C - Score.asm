score:
	moveq	#0,d0
	move.b	r_no0(a0),d0
	move.w	score_move_tbl(pc,d0.w),d0
	jmp	score_move_tbl(pc,d0.w)

score_move_tbl:
	dc.w	score_init-score_move_tbl
	dc.w	score_move-score_move_tbl

score_init:
	addq.b	#word,r_no0(a0)
	move.l	#scorepat,patbase(a0)
	move.w	#score_vram|tile_pri,sproffset(a0)
	move.w	#$90,xposi(a0)
	move.w	#$88,yposi-2(a0)
	tst.w	debugflag
	beq.s	.jump
	move.b	#2,patno(a0)

.jump:
	tst.b	userflag(a0)
	beq.s	score_move
	move.w	#$90,xposi(a0)
	move.w	#$148,yposi-2(a0)
	move.b	#1,patno(a0)

score_move:
	tst.b	userflag(a0)
	bne.s	.actionsub
	move.b	#0,patno(a0)
	tst.w	debugflag
	beq.s	.actionsub
	move.b	#2,patno(a0)

.actionsub:
	jmp	actionsub.l

scorepat:
	include	"Patterns/Score.asm"