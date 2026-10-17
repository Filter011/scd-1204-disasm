edit:
	move.b	swdata1.w,d0
	andi.b	#$F,d0
	bne.s	.jump
	move.l	#$4000,edit_spd.l
	bra.s	.jump1

.jump:
	addi.l	#$2000,edit_spd.l
	cmpi.l	#$80000,edit_spd.l
	bls.s	.jump1
	move.l	#$80000,edit_spd.l

.jump1:
	move.l	edit_spd.l,d0
	btst	#0,swdata1.w
	beq.s	.jump2
	sub.l	d0,yposi(a0)

.jump2:
	btst	#1,swdata1.w
	beq.s	.jump3
	add.l	d0,yposi(a0)

.jump3:
	btst	#2,swdata1.w
	beq.s	.jump4
	sub.l	d0,xposi(a0)

.jump4:
	btst	#3,swdata1.w
	beq.s	.jump5
	add.l	d0,xposi(a0)

.jump5:
	move.w	yposi(a0),d2
	move.b	sprvsize(a0),d0
	ext.w	d0
	add.w	d0,d2
	move.w	xposi(a0),d3
	jsr	scramapad.l
	move.w	(a1),word_FF1884
	lea	edit_tbl.l,a2
	btst	#6,swdata1+1.w
	beq.s	.jump77
	moveq	#0,d1
	move.b	editno,d1
	addq.b	#1,d1
	cmp.b	(a2),d1
	blo.s	.jump66
	move.b	#0,d1

.jump66:
	move.b	d1,editno

.jump77:
	btst	#7,swdata1+1.w
	beq.s	.jump7
	moveq	#0,d1
	move.b	editno,d1
	subq.b	#1,d1
	cmpi.b	#$FF,d1
	bne.s	.jump6
	move.b	(a2),d1

.jump6:
	move.b	d1,editno

.jump7:
	moveq	#0,d1
	move.b	editno,d1
	mulu.w	#12,d1
	move.l	4(a2,d1.w),patbase(a0)
	move.w	8(a2,d1.w),sproffset(a0)
	move.b	3(a2,d1.w),sprpri(a0)
	move.b	13(a2,d1.w),patno(a0)
	move.b	12(a2,d1.w),byte_FF188A
	move.b	11(a2,d1.w),d0
	ori.b	#%0100,d0
	move.b	d0,actflg(a0)
	move.b	#0,mstno(a0)
	btst	#5,swdata1+1.w		; c button check
	beq.s	.jump8
	bsr.w	actwkchk
	bne.s	.worknai		;z=0:ok	z=1:no
	moveq	#0,d1
	move.b	editno,d1
	mulu.w	#12,d1
	_move.b	2(a2,d1.w),actno(a1)
	move.b	10(a2,d1.w),userflag(a1)
	move.b	12(a2,d1.w),act29(a1)
	move.b	13(a2,d1.w),patno(a1)
	move.w	xposi(a0),xposi(a1)
	move.w	yposi(a0),yposi(a1)
	move.b	actflg(a0),d0
	andi.b	#%0011,d0
	move.b	d0,actflg(a1)
	move.b	d0,cddat(a1)

.worknai:
.jump8:
	btst	#4,swdata1+1.w		; b button check
	beq.s	.jump9
	move.b	#0,editmode
	move.l	#playpat,patbase(a0)
	move.w	#$780,sproffset(a0)
	move.b	#2,sprpri(a0)
	move.b	#0,patno(a0)
	move.b	#4,actflg(a0)

.jump9:
	jmp	actionsub.l

edit_spd:
	dc.l	$4000

dcblw	macro	p1,p2,p3,p4,p5,p6,p7,p8
	dc.b	p1
	dc.b	p2
	dc.l	p3
	dc.w	p4
	dc.b	p5
	dc.b	p6
	dc.b	p7
	dc.b	p8
	endm

edit_tbl:
	dc.b	55,0
	dcblw	hashi_act,1,hashipat,$31E,0,0,0,0		;1:
	dcblw	iwa_act,1,iwapat,$326,0,0,0,0			;2:
	dcblw	objid_26,1,act26pat,$33A,0,0,0,0		;3:
	dcblw	objid_28,1,act28pat,$342,0,0,0,0		;4:
	dcblw	objid_28,1,act28pat,$342,1,1,0,0		;5:
	dcblw	futa_act,1,futapat,$357,0,0,0,0			;6:
	dcblw	objid_27,1,act27pat,$49B,0,0,0,0		;7:
	dcblw	dai_k_act,1,k_daipat,$4D2,0,0,0,0		;8:
	dcblw	dai_k_act,1,k_daipat,$47C,0,0,1,0		;9:
	dcblw	dodai_act,1,dai11a_pattbl,$4000,1,0,0,0		;10:
	dcblw	koma_act,4,komapat,$4D4,0,0,0,0			;11:
	dcblw	koma_act,4,komapat,$493,0,0,1,0			;12:
	dcblw	spring_act,1,springpat,$520,0,0,0,0		;13:
	dcblw	spring_act,1,springpat,$520,0,2,0,0		;14:
	dcblw	spring_act,1,spring90pat,$520,4,0,0,0		;15:
	dcblw	spring_act,1,spring90pat,$520,4,1,0,0		;16:
	dcblw	spring_act,1,spring45pat,$3A1,8,0,0,0		;17:
	dcblw	spring_act,1,spring45pat,$3A1,8,2,0,0		;18:
	dcblw	spring_act,1,spring45pat,$3A1,8,1,0,0		;19:
	dcblw	spring_act,1,spring45pat,$3A1,8,3,0,0		;20:
	dcblw	spring_act,1,springpat,$2520,2,0,0,0		;21:
	dcblw	spring_act,1,springpat,$2520,2,2,0,0		;22:
	dcblw	spring_act,1,spring90pat,$2520,6,0,0,0		;23:
	dcblw	spring_act,1,spring90pat,$2520,6,1,0,0		;24:
	dcblw	spring_act,1,spring45pat,$23A1,$A,0,0,0		;25:
	dcblw	spring_act,1,spring45pat,$23A1,$A,2,0,0		;26:
	dcblw	spring_act,1,spring45pat,$23A1,$A,1,0,0		;27:
	dcblw	spring_act,1,spring45pat,$23A1,$A,3,0,0		;28:
	dcblw	friend_act,1,pat_friend0,$3C7,0,0,0,0		;29:
	dcblw	friend_act,1,pat_friend1,$3C7,1,0,0,0		;30:
	dcblw	marker_act,4,obj13_map,$23DF,0,0,0,0		;31:
	dcblw	objid_14,4,obj14_map,$23DF,0,0,0,0		;32:
	dcblw	objid_15,4,obj15_map,$2456,0,0,0,0		;33:
	dcblw	objid_16,4,obj16_map,$2428,0,0,0,0		;34:
	dcblw	objid_22,4,obj22_map,$2413,0,0,0,0		;35:
	dcblw	item_act,4,itempat,$5A8,0,0,0,0			;36:
	dcblw	item_act,4,itempat,$5A8,1,0,0,1			;37:
	dcblw	item_act,4,itempat,$5A8,2,0,0,2			;38:
	dcblw	item_act,4,itempat,$5A8,3,0,0,3			;39:
	dcblw	item_act,4,itempat,$5A8,4,0,0,4			;40:
	dcblw	item_act,4,itempat,$5A8,5,0,0,5			;41:
	dcblw	item_act,4,itempat,$5A8,6,0,0,6			;42:
	dcblw	item_act,4,itempat,$5A8,7,0,0,7			;43:
	dcblw	taki_act,1,shibukipat,$3BA,0,0,0,0		;44:
	dcblw	mizuki_act,1,mizukipat,$31E,0,0,0,0		;45:
	dcblw	kuzure_act,3,patbase_kuzure_a,$4000,$10,1,0,0	;46:
	dcblw	kuzure_act,3,patbase_kuzure_a,$4000,0,0,0,0	;47:
	dcblw	kuzure_act,3,patbase_kuzure_b,$4000,$80,0,0,0	;48:
	dcblw	kuzure_act,3,patbase_kuzure_b,$4000,$81,0,0,1	;49:
	dcblw	kuzure_act,3,patbase_kuzure_b,$4000,$82,0,0,2	;50:
	dcblw	kuzure_act,3,patbase_kuzure_b,$4000,$83,0,0,3	;51:
	dcblw	kuzure_act,3,patbase_kuzure_b,$4000,$84,0,0,4	;52:
	dcblw	kuzure_act,3,patbase_kuzure_b,$4000,$85,0,0,5	;53:
	dcblw	item_act,4,itempat,$5A8,8,0,0,$A		;54:
	dcblw	item_act,4,itempat,$5A8,9,0,0,$C		;55: