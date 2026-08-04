; ---------------------------------------------------------------------------
obj01:
obj02:
		move.b	obj.field_2A(a0),d0
		beq.s	loc_20362C
		addq.b	#1,d0
		cmpi.b	#60,d0
		bcs.s	loc_203628
		move.b	#60,d0
loc_203628:
		move.b	d0,obj.field_2A(a0)
loc_20362C:
		bsr.s	sub_2035B0
		clr.b	obj.field_29(a0)
		moveq	#0,d0
		_move.b	obj.id(a0),d0
		subq.b	#1,d0
		cmp.b	(byte_FF1219).l,d0
		bne.s	loc_203648
		move.b	#1,obj.field_29(a0)
loc_203648:
		moveq	#0,d0
		move.b	obj.routine(a0),d0
		move.w	off_203656(pc,d0.w),d1
		jmp	off_203656(pc,d1.w)
; ---------------------------------------------------------------------------
off_203656:
		dc.w loc_2036BE-off_203656
		dc.w loc_203CB8-off_203656
		dc.w loc_204CF2-off_203656
		dc.w loc_204D5E-off_203656
		dc.w loc_204DBA-off_203656
; ---------------------------------------------------------------------------
		tst.b	obj.field_29(a0)
		beq.s	locret_203674
		move.b	#1,(byte_FF122C).l
		move.b	#3,(byte_FFD180).w
locret_203674:
		rts
; ---------------------------------------------------------------------------

loc_203676:
		tst.b	(byte_FFD300).w
		bne.s	locret_2036BA
		tst.b	obj.field_29(a0)
		beq.s	locret_2036BA
		move.b	#1,(byte_FF122F).l
		move.b	#objid_03,(byte_FFD300).w
		move.b	#5,(byte_FFD300+obj.ani).w
		move.b	#objid_03,(byte_FFD340).w
		move.b	#6,(byte_FFD340+obj.ani).w
		move.b	#objid_03,(byte_FFD380).w
		move.b	#7,(byte_FFD380+obj.ani).w
		move.b	#objid_03,(byte_FFD3C0).w
		move.b	#8,(byte_FFD3C0+obj.ani).w
locret_2036BA:

		rts
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
loc_2036BE:
		addq.b	#2,obj.routine(a0)
		move.b	#playheight,obj.height(a0)
		move.b	#playwidth,obj.width(a0)
		tst.b	(chibi_flag).w
		beq.s	loc_2036E0
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
loc_2036E0:
		move.l	#player_map,obj.mappings(a0)
		move.w	#$780,obj.vram(a0)
		_cmpi.b	#objid_01,obj.id(a0)
		beq.s	loc_2036FC
		move.w	#$797,obj.vram(a0)
loc_2036FC:
		move.b	#2,obj.priority(a0)
		move.b	#$18,obj.field_19(a0)
		move.b	#4,obj.render(a0)
		move.w	#$600,(word_FFF760).w
		move.w	#$C,(word_FFF762).w
		move.w	#$80,(word_FFF764).w
; =============== S U B R O U T I N E =======================================
sub_203720:
		tst.b	(zone).l
		bne.s	locret_203786
		move.b	(word_FF1204+1).l,d0
		andi.b	#3,d0
		bne.s	locret_203786
		move.b	obj.height(a0),d2
		ext.w	d2
		add.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		bsr.w	sub_203800
		cmpi.b	#$2F,d1
		bne.s	locret_203788
		cmpi.w	#$15C0,obj.xpos(a0)
		bcc.s	locret_203786
		tst.b	obj.field_2C(a0)
		beq.s	locret_203786
		jsr	(findfreeobj).l
		bne.s	locret_203786
		_move.b	#objid_0E,obj.id(a1)
		move.w	obj.xpos(a0),obj.xpos(a1)
		move.w	obj.ypos(a0),obj.ypos(a1)
		moveq	#1,d0
		tst.w	obj.xvel(a0)
		bmi.s	loc_20377E
		moveq	#0,d0
loc_20377E:
		move.b	d0,obj.render(a1)
		move.b	d0,obj.status(a1)
locret_203786:
		rts
; ---------------------------------------------------------------------------
locret_203788:
		rts
; End of function sub_203720
; ---------------------------------------------------------------------------
		move.b	obj.height(a0),d2
		ext.w	d2
		add.w	obj.ypos(a0),d2
		cmpi.b	#$10,d1
		bne.s	loc_2037A8
		cmpi.w	#$210,d2
		bcc.s	locret_203786
		cmpi.w	#$208,d2
		bcs.s	locret_203786
		bra.s	loc_2037BA
; ---------------------------------------------------------------------------
loc_2037A8:
		cmpi.b	#$21,d1
		bne.s	locret_203786
		cmpi.w	#$2A0,d2
		bcc.s	locret_203786
		cmpi.w	#$298,d2
		bcs.s	locret_203786
loc_2037BA:
		tst.w	obj.inertia(a0)
		beq.s	locret_203786
		jsr	(findfreeobj).l
		bne.s	locret_203786
		_move.b	#objid_0B,obj.id(a1)
		move.w	obj.xpos(a0),obj.xpos(a1)
		andi.w	#$FFF8,d2
		move.w	d2,obj.ypos(a1)
		move.b	#1,obj.subtype(a1)
		move.w	obj.inertia(a0),d0
		bpl.s	loc_2037EA
		neg.w	d0
loc_2037EA:
		cmpi.w	#$600,d0
		bcc.s	loc_2037F6
		move.b	#2,obj.subtype(a1)
loc_2037F6:
		move.w	#$A1,d0
		jmp	(queuesound2).l
; =============== S U B R O U T I N E =======================================
sub_203800:
		move.w	d2,d0
		lsr.w	#1,d0
		andi.w	#$380,d0
		move.w	d3,d1
		lsr.w	#8,d1
		andi.w	#$7F,d1
		add.w	d1,d0
		move.l	#chunkwk,d1
		lea	(lvllayoutwk).w,a1
		move.b	(a1,d0.w),d1
		andi.b	#$7F,d1
		rts
; End of function sub_203800
; =============== S U B R O U T I N E =======================================
sub_203826:
		cmpi.b	#zoneid_MZ,(zone).l
		beq.s	loc_203832
		rts
; ---------------------------------------------------------------------------
loc_203832:
		move.w	obj.xvel(a0),d1
		move.w	obj.yvel(a0),d2
		jsr	(calcangle).l
		subi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_203916
		cmpi.b	#$80,d0
		beq.w	loc_20389C
		cmpi.b	#$C0,d0
		beq.w	loc_2038D8
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.height(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obj.width(a0),d0
		ext.w	d0
		sub.w	d0,d3
		bsr.w	sub_203954
		bne.s	locret_20389A
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.height(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obj.width(a0),d0
		ext.w	d0
		add.w	d0,d3
		bra.w	sub_203954
; ---------------------------------------------------------------------------
locret_20389A:
		rts
; ---------------------------------------------------------------------------
loc_20389C:
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.height(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obj.width(a0),d0
		ext.w	d0
		sub.w	d0,d3
		bsr.w	sub_203954
		bne.s	locret_2038D6
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.height(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obj.width(a0),d0
		ext.w	d0
		add.w	d0,d3
		bra.w	sub_203954
; ---------------------------------------------------------------------------
locret_2038D6:
		rts
; ---------------------------------------------------------------------------
loc_2038D8:
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.width(a0),d0
		ext.w	d0
		add.w	d0,d3
		move.b	obj.height(a0),d0
		subq.b	#6,d0
		ext.w	d0
		sub.w	d0,d2
		bsr.w	sub_203954
		bne.s	locret_203914
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.width(a0),d0
		ext.w	d0
		add.w	d0,d3
		move.b	obj.height(a0),d0
		ext.w	d0
		add.w	d0,d2
		bra.w	sub_203954
; ---------------------------------------------------------------------------
locret_203914:
		rts
; ---------------------------------------------------------------------------
loc_203916:
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.width(a0),d0
		ext.w	d0
		sub.w	d0,d3
		move.b	obj.height(a0),d0
		subq.b	#6,d0
		ext.w	d0
		sub.w	d0,d2
		bsr.w	sub_203954
		bne.s	locret_203952
		move.w	obj.ypos(a0),d2
		move.w	obj.xpos(a0),d3
		move.b	obj.width(a0),d0
		ext.w	d0
		sub.w	d0,d3
		move.b	obj.height(a0),d0
		ext.w	d0
		add.w	d0,d2
		bra.w	sub_203954
; ---------------------------------------------------------------------------
locret_203952:
		rts
; End of function sub_203826
; =============== S U B R O U T I N E =======================================
sub_203954:
		jsr	(sub_200E0C).l
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$7FF,d0
		beq.s	loc_203994
		moveq	#0,d1
		move.b	(byte_FF123D).l,d1
		cmpi.b	#2,d1
		bne.s	loc_203978
		add.b	(byte_FF127A).l,d1
loc_203978:
		add.w	d1,d1
		move.w	off_203998(pc,d1.w),d1
		lea	off_203998(pc,d1.w),a1
		moveq	#0,d6
		move.w	(a1)+,d6
		moveq	#0,d1
loc_203988:
		cmp.w	(a1,d1.w),d0
		beq.s	loc_203A0C
		addq.w	#2,d1
		dbf	d6,loc_203988

loc_203994:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------
off_203998:
		dc.w word_2039C2-off_203998
		dc.w word_2039A0-off_203998
		dc.w word_2039EA-off_203998
		dc.w word_2039C8-off_203998
word_2039A0:
		dc.w 16-1
		dc.w $13C
		dc.w $146
		dc.w $19B
		dc.w $1AE
		dc.w $83
		dc.w $84
		dc.w $89
		dc.w $8A
		dc.w $77
		dc.w $76
		dc.w $80
		dc.w $7F
		dc.w $7E
		dc.w $7D
		dc.w $7C
		dc.w $82
word_2039C2:
		dc.w 2-1
		dc.w $145
		dc.w $146
word_2039C8:
		dc.w 16-1
		dc.w $13C
		dc.w $146
		dc.w 0
		dc.w 0
		dc.w $83
		dc.w $84
		dc.w $89
		dc.w $8A
		dc.w $77
		dc.w $76
		dc.w $80
		dc.w $7F
		dc.w $7E
		dc.w $7D
		dc.w $7C
		dc.w $82
word_2039EA:
		dc.w 16-1
		dc.w $13C
		dc.w $146
		dc.w $165
		dc.w 0
		dc.w $83
		dc.w $84
		dc.w $89
		dc.w $8A
		dc.w $77
		dc.w $76
		dc.w $80
		dc.w $7F
		dc.w $7E
		dc.w $7D
		dc.w $7C
		dc.w $82
; ---------------------------------------------------------------------------
loc_203A0C:
		move.b	#0,(byte_FF1886).l
		move.w	off_203A2C(pc,d1.w),d0
		jsr	off_203A2C(pc,d0.w)
		tst.b	(byte_FF1886).l
		beq.s	loc_203A28
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------
loc_203A28:
		moveq	#1,d0
		rts
; End of function sub_203954
; ---------------------------------------------------------------------------
off_203A2C:
		dc.w loc_203A4C-off_203A2C
		dc.w loc_203A4C-off_203A2C
		dc.w loc_203ADA-off_203A2C
		dc.w loc_203ADA-off_203A2C
		dc.w loc_203C70-off_203A2C
		dc.w sub_203B2C-off_203A2C
		dc.w sub_203B3E-off_203A2C
		dc.w sub_203B3E-off_203A2C
		dc.w loc_203C4C-off_203A2C
		dc.w sub_203BA4-off_203A2C
		dc.w sub_203BA4-off_203A2C
		dc.w sub_203BA4-off_203A2C
		dc.w sub_203B88-off_203A2C
		dc.w sub_203B2C-off_203A2C
		dc.w sub_203B2C-off_203A2C
		dc.w sub_203B50-off_203A2C
; ---------------------------------------------------------------------------
loc_203A4C:
		andi.w	#$FFF0,d2
		tst.b	d1
		bne.s	loc_203A58
		addi.w	#$10,d2
loc_203A58:
		andi.w	#$FFF0,d3
		btst	#$B,d4
		bne.s	loc_203A66
		addi.w	#$10,d3
loc_203A66:
		move.w	d3,d1
		movem.l d1-d2,-(sp)
		sub.w	obj.xpos(a0),d1
		sub.w	obj.ypos(a0),d2
		jsr	(calcangle).l
		jsr	(calcsine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,obj.xvel(a0)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,obj.yvel(a0)
		bset	#1,obj.status(a0)
		bclr	#4,obj.status(a0)
		bclr	#5,obj.status(a0)
		clr.b	obj.field_3C(a0)
		movem.l (sp)+,d1-d2
		move.w	d2,d4
		move.w	d1,d5
		move.w	#0,d3
		jsr	(sub_202DD2).l
		subi.w	#$10,d5
		jsr	(sub_202DD2).l
		subi.w	#$10,d4
		jsr	(sub_202DD2).l
		addi.w	#$10,d5
		jmp	(sub_202DD2).l
; ---------------------------------------------------------------------------
loc_203ADA:
		andi.w	#$FFF0,d2
		addq.w	#8,d2
		andi.w	#$FFF0,d3
		addq.w	#8,d3
		move.w	d3,d1
		sub.w	obj.xpos(a0),d1
		sub.w	obj.ypos(a0),d2
		jsr	(calcangle).l
		jsr	(calcsine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		asr.l	#1,d1
		move.w	d1,obj.xvel(a0)
		muls.w	#-$700,d0
		asr.l	#8,d0
		asr.l	#1,d0
		move.w	d0,obj.yvel(a0)
loc_203B14:
		bset	#1,obj.status(a0)
		bclr	#4,obj.status(a0)
		bclr	#5,obj.status(a0)
		clr.b	obj.field_3C(a0)
		rts
; =============== S U B R O U T I N E =======================================
sub_203B2C:
		move.w	#$700,d0
		tst.w	obj.yvel(a0)
		bmi.s	loc_203B38
		neg.w	d0
loc_203B38:
		move.w	d0,obj.yvel(a0)
		bra.s	loc_203B14
; End of function sub_203B2C
; =============== S U B R O U T I N E =======================================
sub_203B3E:
		move.w	#$700,d0
		tst.w	obj.xvel(a0)
		bmi.s	loc_203B4A
		neg.w	d0
loc_203B4A:
		move.w	d0,obj.xvel(a0)
		bra.s	loc_203B14
; End of function sub_203B3E
; =============== S U B R O U T I N E =======================================
sub_203B50:
		andi.w	#$FFF0,d2
		addq.w	#8,d2
		andi.w	#$FFF0,d3
		addq.w	#8,d3
		move.w	d3,d1
		sub.w	obj.xpos(a0),d1
		sub.w	obj.ypos(a0),d2
		jsr	(calcangle).l
		jsr	(calcsine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,obj.xvel(a0)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,obj.yvel(a0)
		bra.s	loc_203B14
; End of function sub_203B50
; =============== S U B R O U T I N E =======================================
sub_203B88:
		move.w	d3,d1
		andi.w	#$F,d1
		cmpi.b	#8,d1
		bcc.s	loc_203B9C
		btst	#$B,d4
		bne.s	sub_203B3E
		bra.s	sub_203B2C
; ---------------------------------------------------------------------------
loc_203B9C:
		btst	#$B,d4
		bne.s	sub_203B2C
		bra.s	sub_203B3E
; End of function sub_203B88
; =============== S U B R O U T I N E =======================================
sub_203BA4:
		subi.w	#$12,d1
		bmi.s	loc_203BD6
		move.w	off_203C16(pc,d1.w),d0
		lea	off_203C16(pc,d0.w),a1
		andi.w	#$F,d2
		andi.w	#$F,d3
		btst	#$B,d4
		bne.s	loc_203BC6
		neg.b	d3
		addi.b	#$F,d3
loc_203BC6:
		cmp.b	(a1,d3.w),d2
		bcc.s	loc_203BD6
		move.b	#1,(byte_FF1886).l
		rts
; ---------------------------------------------------------------------------
loc_203BD6:
		move.w	obj.xvel(a0),d1
		move.w	obj.yvel(a0),d2
		jsr	(calcangle).l
		addi.b	#$80,d0
		neg.b	d0
		subi.b	#$20,d0
		btst	#$B,d4
		beq.s	loc_203BF8
		addi.b	#$40,d0
loc_203BF8:
		jsr	(calcsine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,obj.xvel(a0)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,obj.yvel(a0)
		bra.w	loc_203B14
; End of function sub_203BA4
; ---------------------------------------------------------------------------
off_203C16:
		dc.w unk_203C1C-off_203C16
		dc.w unk_203C2C-off_203C16
		dc.w unk_203C3C-off_203C16
unk_203C1C:
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   6
		even

unk_203C2C:
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $B
		even

unk_203C3C:
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b $10
		dc.b $10
		dc.b $10
		even
; ---------------------------------------------------------------------------
loc_203C4C:
		move.w	d3,d1
		andi.w	#$F,d1
		cmpi.b	#8,d1
		bcc.s	loc_203C64
		btst	#$B,d4
		bne.w	sub_203B3E
		bra.w	sub_203BA4
; ---------------------------------------------------------------------------
loc_203C64:
		btst	#$B,d4
		bne.w	sub_203B2C
		bra.w	sub_203BA4
; ---------------------------------------------------------------------------
loc_203C70:
		move.w	d3,d1
		andi.w	#$F,d1
		cmpi.b	#8,d1
		bcc.s	loc_203C88
		btst	#$B,d4
		bne.w	sub_203B2C
		bra.w	sub_203B50
; ---------------------------------------------------------------------------
loc_203C88:
		btst	#$B,d4
		bne.w	sub_203B50
		bra.w	sub_203B2C
; ---------------------------------------------------------------------------
		move.w	d2,d1
		andi.w	#$F,d1
		cmpi.b	#8,d1
		bcc.s	loc_203CAC
		btst	#$C,d4
		bne.w	sub_203B3E
		bra.w	sub_203B50
; ---------------------------------------------------------------------------
loc_203CAC:
		btst	#$C,d4
		bne.w	sub_203B50
		bra.w	sub_203B3E
; ---------------------------------------------------------------------------
loc_203CB8:
		bsr.w	sub_203720
		tst.w	(word_FF13FA).l
		beq.s	loc_203CD6
		btst	#4,(word_FFF604+1).w
		beq.s	loc_203CD6
		move.b	#1,(word_FF1208).l
		rts
; ---------------------------------------------------------------------------
loc_203CD6:
		tst.b	(byte_FFF7CC).w
		bne.s	loc_203CF0
		move.w	(word_FFF604).w,(word_FFF602).w
		_cmpi.b	#objid_01,obj.id(a0)
		beq.s	loc_203CF0
		move.w	(word_FFF606).w,(word_FFF602).w
loc_203CF0:
		btst	#0,obj.field_2C(a0)
		bne.s	loc_203D0E
		moveq	#0,d0
		move.b	obj.status(a0),d0
		andi.w	#6,d0
		move.w	off_203D52(pc,d0.w),d1
		jsr	off_203D52(pc,d1.w)
		bsr.w	sub_203826
loc_203D0E:
		bsr.s	sub_203D60
		tst.b	obj.field_29(a0)
		beq.s	loc_203D1A
		bsr.w	sub_203E5A
loc_203D1A:
		move.b	(byte_FFF768).w,obj.field_36(a0)
		move.b	(byte_FFF76A).w,obj.field_37(a0)
		tst.b	(byte_FFF7C7).w
		beq.s	loc_203D38
		tst.b	obj.ani(a0)
		bne.s	loc_203D38
		move.b	obj.prevani(a0),obj.ani(a0)
loc_203D38:
		bsr.w	sub_204EF4
		tst.b	obj.field_2C(a0)
		bmi.s	loc_203D48
		jsr	(sub_2063B8).l
loc_203D48:
		bsr.w	sub_204E18
		bsr.w	sub_203E16
		rts
; ---------------------------------------------------------------------------
off_203D52:
		dc.w loc_203FB2-off_203D52
		dc.w loc_20401A-off_203D52
		dc.w loc_204048-off_203D52
		dc.w loc_20406C-off_203D52

unk_203D5A:
		dc.b musid_GHZ
		dc.b musid_LZ
		dc.b musid_MZ
		dc.b musid_SLZ
		dc.b musid_SYZ
		dc.b musid_SBZ
		even
; =============== S U B R O U T I N E =======================================
sub_203D60:
		cmpi.w	#$D2,(word_FFF786).w
		bcc.s	loc_203D8C
		move.w	obj.field_30(a0),d0
		beq.s	loc_203D76
		subq.w	#1,obj.field_30(a0)
		lsr.w	#3,d0
		bcc.s	loc_203D8C
loc_203D76:
		tst.b	obj.field_29(a0)
		bne.s	loc_203D86
		btst	#0,(dword_FF120C+3).l
		beq.s	loc_203D8C
loc_203D86:
		jsr	(displaysprite).l
loc_203D8C:
		tst.b	(byte_FF122D).l
		beq.s	loc_203DDC
		tst.w	obj.field_32(a0)
		beq.s	loc_203DDC
		subq.w	#1,obj.field_32(a0)
		bne.s	loc_203DDC
		tst.b	(byte_FFF7AA).w
		bne.s	loc_203DD4
		cmpi.w	#$C,(play_air).l
		bcs.s	loc_203DD4
		moveq	#0,d0
		move.b	(zone).l,d0
		cmpi.w	#zoneact(zoneid_LZ,actid_4),(zone).l
		bne.s	loc_203DC4
		moveq	#5,d0
loc_203DC4:
		lea	(unk_203D5A).l,a1
		move.b	(a1,d0.w),d0
		jsr	(queuesound1).l
loc_203DD4:
		move.b	#0,(byte_FF122D).l
loc_203DDC:
		tst.b	(byte_FF122E).l
		beq.s	locret_203E14
		tst.w	obj.field_34(a0)
		beq.s	locret_203E14
		subq.w	#1,obj.field_34(a0)
		bne.s	locret_203E14
		move.w	#$600,(word_FFF760).w
		move.w	#$C,(word_FFF762).w
		move.w	#$80,(word_FFF764).w
		move.b	#0,(byte_FF122E).l
		move.w	#$E3,d0
		jmp	(queuesound1).l
; ---------------------------------------------------------------------------
locret_203E14:

		rts
; End of function sub_203D60
; =============== S U B R O U T I N E =======================================
sub_203E16:
		tst.b	obj.field_29(a0)
		bne.s	locret_203E58
		move.w	(dword_FFF700).w,d0
		subi.w	#$80,d0
		bcs.s	loc_203E2E
		cmp.w	obj.xpos(a0),d0
		bhi.w	deleteobj
loc_203E2E:
		addi.w	#$240,d0
		cmp.w	obj.xpos(a0),d0
		blt.w	deleteobj
		move.w	(dword_FFF704).w,d0
		subi.w	#$60,d0
		bcs.s	loc_203E4C
		cmp.w	obj.ypos(a0),d0
		bhi.w	deleteobj
loc_203E4C:
		addi.w	#$180,d0
		cmp.w	obj.ypos(a0),d0
		blt.w	deleteobj
locret_203E58:
		rts
; End of function sub_203E16
; =============== S U B R O U T I N E =======================================
sub_203E5A:
		move.w	(word_FFF7A8).w,d0
		lea	(playposiwk).w,a1
		lea	(a1,d0.w),a1
		move.w	obj.xpos(a0),(a1)+
		move.w	obj.ypos(a0),(a1)+
		addq.b	#4,(word_FFF7A8+1).w
		rts
; End of function sub_203E5A
; =============== S U B R O U T I N E =======================================
sub_203E74:
		move.b	(byte_FF1230).l,(byte_FF1255).l
		move.w	obj.xpos(a0),(word_FF1256).l
		move.w	obj.ypos(a0),(word_FF1258).l
		move.b	(byte_FFF742).w,(byte_FF125A).l
		move.b	(byte_FFF64D).w,(byte_FF1270).l
		move.w	(dword_FFF72C+2).w,(word_FF125C).l
		move.w	(dword_FFF700).w,(word_FF125E).l
		move.w	(dword_FFF704).w,(word_FF1260).l
		move.w	(dword_FFF708).w,(word_FF1262).l
		move.w	(dword_FFF70C).w,(word_FF1264).l
		move.w	(dword_FFF710).w,(word_FF1266).l
		move.w	(word_FFF714).w,(word_FF1268).l
		move.w	(dword_FFF718).w,(word_FF126A).l
		move.w	(word_FFF71C).w,(word_FF126C).l
		move.w	(word_FFF648).w,(word_FF126E).l
		move.b	(byte_FFF64D).w,(byte_FF1270).l
		move.b	(byte_FFF64E).w,(byte_FF1271).l
		rts
; End of function sub_203E74
; =============== S U B R O U T I N E =======================================
sub_203F00:
		tst.b	obj.field_2A(a0)
		bne.w	locret_203FB0
		tst.b	(byte_FFF784).w
		beq.w	locret_203FB0
		move.w	(word_FFF760).w,d2
		moveq	#0,d0
		move.w	obj.inertia(a0),d0
		bpl.s	loc_203F1E
		neg.w	d0
loc_203F1E:
		tst.w	(word_FFF786).w
		bne.s	loc_203F2A
		move.w	#1,(word_FFF786).w
loc_203F2A:
		move.w	(word_FFF786).w,d1
		cmpi.w	#$E6,d1
		bcs.s	loc_203F40
		move.b	#1,(lvl_reset).l
		bra.w	loc_205400
; ---------------------------------------------------------------------------
loc_203F40:
		cmpi.w	#$D2,d1
		bcs.s	loc_203F86
		cmpi.b	#2,(byte_FF1230).l
		beq.s	locret_203F84
		move.b	#1,(byte_FFF744).w
		move.b	(byte_FF123D).l,d0
		add.b	(byte_FFF784).w,d0
		bpl.s	loc_203F66
		moveq	#0,d0
		bra.s	loc_203F6E
; ---------------------------------------------------------------------------
loc_203F66:
		cmpi.b	#3,d0
		bcs.s	loc_203F6E
		moveq	#2,d0
loc_203F6E:
		bset	#7,d0
		move.b	d0,(byte_FF123D).l
		bsr.w	sub_203E74
		move.b	#2,(byte_FF1230).l
locret_203F84:
		rts
; ---------------------------------------------------------------------------
loc_203F86:
		cmpi.w	#$5A,d1
		bcc.s	loc_203F9E
		cmp.w	d2,d0
		bcc.w	loc_203676
		clr.w	(word_FFF786).w
		clr.b	(byte_FF122F).l
		rts
; ---------------------------------------------------------------------------
loc_203F9E:
		cmp.w	d2,d0
		bcc.s	locret_203FB0
		clr.w	(word_FFF786).w
		clr.b	(byte_FFF784).w
		clr.b	(byte_FF122F).l
locret_203FB0:
		rts
; End of function sub_203F00
; ---------------------------------------------------------------------------
loc_203FB2:
		tst.b	(byte_FFF75F).w
		beq.s	loc_203FC4
		cmpi.b	#5,obj.ani(a0)
		bne.s	locret_204018
		clr.b	(byte_FFF75F).w
loc_203FC4:
		bsr.w	sub_203558
		cmpi.b	#$2B,obj.ani(a0)
		bne.s	loc_203FF2
		tst.b	(chibi_flag).w
		beq.s	loc_203FE0
		cmpi.b	#playframe.chibihurt,obj.frame(a0)
		bne.s	locret_204018
		bra.s	loc_203FE8
; ---------------------------------------------------------------------------
loc_203FE0:
		cmpi.b	#playframe.outofhere7,obj.frame(a0)
		bne.s	locret_204018
loc_203FE8:
		bsr.w	sub_20477E
		jmp	(sub_20313A).l
; ---------------------------------------------------------------------------
loc_203FF2:
		bsr.w	sub_203F00
		bsr.w	sub_20484C
		bsr.w	sub_2049B0
		bsr.w	sub_20409A
		bsr.w	sub_2047DC
		bsr.w	sub_20477E
		jsr	(sub_203166).l
		bsr.w	sub_200A9E
		bsr.w	sub_204A2E
locret_204018:
		rts
; ---------------------------------------------------------------------------
loc_20401A:
		bsr.w	sub_203F00
		bsr.w	sub_20496E
		bsr.w	sub_2046BC
		bsr.w	sub_20477E
		jsr	(sub_20313A).l
		btst	#6,obj.status(a0)
		beq.s	loc_20403E
		subi.w	#$28,obj.yvel(a0)
loc_20403E:
		bsr.w	sub_204A70
		bsr.w	sub_204A8C
		rts
; ---------------------------------------------------------------------------
loc_204048:
		bsr.w	sub_203F00
		bsr.w	sub_20484C
		bsr.w	sub_2049EC
		bsr.w	sub_20451A
		bsr.w	sub_20477E
		jsr	(sub_203166).l
		bsr.w	sub_200A9E
		bsr.w	sub_204A2E
		rts
; ---------------------------------------------------------------------------
loc_20406C:
		bsr.w	sub_203F00
		bsr.w	sub_20496E
		bsr.w	sub_2046BC
		bsr.w	sub_20477E
		jsr	(sub_20313A).l
		btst	#6,obj.status(a0)
		beq.s	loc_204090
		subi.w	#$28,obj.yvel(a0)
loc_204090:
		bsr.w	sub_204A70
		bsr.w	sub_204A8C
		rts
; =============== S U B R O U T I N E =======================================
sub_20409A:
		move.w	(word_FFF760).w,d6
		move.w	(word_FFF762).w,d5
		move.w	(word_FFF764).w,d4
		tst.b	(byte_FFF7CA).w
		bne.w	loc_204380
		tst.w	obj.field_3E(a0)
		bne.w	loc_204330
		btst	#2,(word_FFF602).w
		beq.s	loc_2040C2
		bsr.w	sub_204410
loc_2040C2:
		btst	#3,(word_FFF602).w
		beq.s	loc_2040CE
		bsr.w	sub_204498
loc_2040CE:
		move.b	obj.angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.w	loc_204330
		tst.w	obj.inertia(a0)
		beq.s	loc_2040EC
		tst.b	obj.field_2A(a0)
		beq.w	loc_204330
loc_2040EC:
		bclr	#5,obj.status(a0)
		move.b	#5,obj.ani(a0)
		btst	#3,obj.status(a0)
		beq.s	loc_204148
		moveq	#0,d0
		move.b	obj.field_3D(a0),d0
		lsl.w	#6,d0
		lea	(actwk).w,a1
		lea	(a1,d0.w),a1
		tst.b	obj.status(a1)
		bmi.s	loc_20417C
		_cmpi.b	#objid_1E,obj.id(a1)
		bne.s	loc_204128
		move.b	#0,obj.ani(a0)
		bra.w	loc_204330
; ---------------------------------------------------------------------------
loc_204128:
		moveq	#0,d1
		move.b	obj.field_19(a1),d1
		move.w	d1,d2
		add.w	d2,d2
		subq.w	#4,d2
		add.w	obj.xpos(a0),d1
		sub.w	obj.xpos(a1),d1
		cmpi.w	#4,d1
		blt.s	loc_20416C
		cmp.w	d2,d1
		bge.s	loc_20415C
		bra.s	loc_20417C
; ---------------------------------------------------------------------------
loc_204148:
		jsr	(sub_20611C).l
		cmpi.w	#$C,d1
		blt.s	loc_20417C
		cmpi.b	#3,obj.field_36(a0)
		bne.s	loc_204164
loc_20415C:
		bclr	#0,obj.status(a0)
		bra.s	loc_204172
; ---------------------------------------------------------------------------
loc_204164:
		cmpi.b	#3,obj.field_37(a0)
		bne.s	loc_20417C
loc_20416C:
		bset	#0,obj.status(a0)
loc_204172:
		move.b	#6,obj.ani(a0)
		bra.w	loc_204330
; ---------------------------------------------------------------------------
loc_20417C:
		tst.b	obj.field_29(a0)
		beq.w	loc_2041E4
		move.b	(byte_FFF788).w,d0
		andi.b	#$F,d0
		beq.s	loc_204198
		addq.b	#1,(byte_FFF788).w
		andi.b	#$CF,(byte_FFF788).w
loc_204198:
		btst	#7,(byte_FFF788).w
		bne.w	loc_204264
		btst	#6,(byte_FFF788).w
		bne.w	loc_20428C
		btst	#1,(word_FFF602).w
		bne.w	loc_20428C
		andi.b	#$F,(byte_FFF788).w
		beq.s	loc_2041D0
		btst	#0,(word_FFF602+1).w
		beq.s	loc_2041E4
		bset	#7,(byte_FFF788).w
		bra.w	loc_204354
; ---------------------------------------------------------------------------
loc_2041D0:
		btst	#0,(word_FFF602+1).w
		beq.w	loc_2041E4
		move.b	#1,(byte_FFF788).w
		bra.w	loc_204354
; ---------------------------------------------------------------------------
loc_2041E4:
		btst	#0,(word_FFF602).w
		beq.s	loc_204224
		move.b	#7,obj.ani(a0)
		tst.b	obj.field_2A(a0)
		beq.s	loc_204210
		move.b	#0,obj.ani(a0)
		moveq	#$19,d0
		btst	#0,obj.status(a0)
		beq.s	loc_20420A
		neg.w	d0
loc_20420A:
		add.w	d0,obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_204210:
		move.b	(word_FFF602+1).w,d0
		andi.b	#$70,d0
		beq.s	loc_204220
		move.b	#1,obj.field_2A(a0)
loc_204220:
		bra.w	loc_204354
; ---------------------------------------------------------------------------
loc_204224:
		cmpi.b	#$3C,obj.field_2A(a0)
		beq.s	loc_20423A
		move.b	#0,obj.field_2A(a0)
		move.w	#0,obj.inertia(a0)
		bra.s	loc_20428C
; ---------------------------------------------------------------------------
loc_20423A:
		move.b	#$3D,obj.field_2A(a0)
		move.w	(word_FFF760).w,d6
		move.w	(word_FFF762).w,d5
		move.w	(word_FFF764).w,d4
		btst	#0,obj.status(a0)
		bne.s	loc_20425C
		bsr.w	sub_204498
		bra.w	loc_204330
; ---------------------------------------------------------------------------
loc_20425C:
		bsr.w	sub_204410
		bra.w	loc_204330
; ---------------------------------------------------------------------------
loc_204264:
		btst	#0,(word_FFF602).w
		beq.s	loc_20428C
		move.b	#7,obj.ani(a0)
		tst.b	obj.field_29(a0)
		beq.w	loc_20430E
		cmpi.w	#200,(word_FFF73E).w
		beq.w	loc_204354
		addq.w	#2,(word_FFF73E).w
		bra.w	loc_204354
; ---------------------------------------------------------------------------
loc_20428C:
		tst.b	obj.field_29(a0)
		beq.s	loc_2042C8
		btst	#6,(byte_FFF788).w
		bne.w	loc_20430E
		andi.b	#$F,(byte_FFF788).w
		beq.s	loc_2042B6
		btst	#1,(word_FFF602+1).w
		beq.s	loc_2042C8
		bset	#6,(byte_FFF788).w
		bra.w	loc_204354
; ---------------------------------------------------------------------------
loc_2042B6:
		btst	#1,(word_FFF602+1).w
		beq.s	loc_2042C8
		move.b	#1,(byte_FFF788).w
		bra.w	loc_204354
; ---------------------------------------------------------------------------
loc_2042C8:
		btst	#1,(word_FFF602).w
		beq.s	loc_204330
		move.b	#8,obj.ani(a0)
		tst.b	obj.field_2A(a0)
		bne.s	loc_20430C
		move.b	(word_FFF602+1).w,d0
		andi.b	#$70,d0
		beq.s	loc_20430C
		move.b	#1,obj.field_2A(a0)
		move.w	#$16,obj.inertia(a0)
		btst	#0,obj.status(a0)
		beq.s	loc_2042FE
		neg.w	obj.inertia(a0)
loc_2042FE:
		move.w	#$9C,d0
		jsr	(queuesound2).l
		bsr.w	sub_204804
loc_20430C:
		bra.s	loc_204354
; ---------------------------------------------------------------------------
loc_20430E:
		btst	#1,(word_FFF602).w
		beq.s	loc_204330
		move.b	#8,obj.ani(a0)
		tst.b	obj.field_29(a0)
		beq.s	loc_204354
		cmpi.w	#8,(word_FFF73E).w
		beq.s	loc_204354
		subq.w	#2,(word_FFF73E).w
		bra.s	loc_204354
; ---------------------------------------------------------------------------
loc_204330:
		cmpi.w	#$60,(word_FFF73E).w
		bne.s	loc_20434A
		move.b	(byte_FFF788).w,d0
		andi.b	#$F,d0
		bne.s	loc_204354
		move.b	#0,(byte_FFF788).w
		bra.s	loc_204354
; ---------------------------------------------------------------------------
loc_20434A:
		bcc.s	loc_204350
		addq.w	#4,(word_FFF73E).w
loc_204350:
		subq.w	#2,(word_FFF73E).w
loc_204354:
		move.b	(word_FFF602).w,d0
		andi.b	#$C,d0
		bne.s	loc_204380
		move.w	obj.inertia(a0),d0
		beq.s	loc_204380
		bmi.s	loc_204374
		sub.w	d5,d0
		bcc.s	loc_20436E
		move.w	#0,d0
loc_20436E:
		move.w	d0,obj.inertia(a0)
		bra.s	loc_204380
; ---------------------------------------------------------------------------
loc_204374:
		add.w	d5,d0
		bcc.s	loc_20437C
		move.w	#0,d0
loc_20437C:
		move.w	d0,obj.inertia(a0)
loc_204380:
		move.b	obj.angle(a0),d0
		jsr	(calcsine).l
		muls.w	obj.inertia(a0),d1
		asr.l	#8,d1
		move.w	d1,obj.xvel(a0)
		muls.w	obj.inertia(a0),d0
		asr.l	#8,d0
		move.w	d0,obj.yvel(a0)
loc_20439E:
		move.b	obj.angle(a0),d0
		addi.b	#$40,d0
		bmi.s	locret_20440E
		move.b	#$40,d1
		tst.w	obj.inertia(a0)
		beq.s	locret_20440E
		bmi.s	loc_2043B6
		neg.w	d1
loc_2043B6:
		move.b	obj.angle(a0),d0
		add.b	d1,d0
		move.w	d0,-(sp)
		bsr.w	sub_205FDC
		move.w	(sp)+,d0
		tst.w	d1
		bpl.s	locret_20440E
		asl.w	#8,d1
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	loc_20440A
		cmpi.b	#$40,d0
		beq.s	loc_2043F8
		cmpi.b	#$80,d0
		beq.s	loc_2043F2
		add.w	d1,obj.xvel(a0)
		bset	#5,obj.status(a0)
		move.w	#0,obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_2043F2:
		sub.w	d1,obj.yvel(a0)
		rts
; ---------------------------------------------------------------------------
loc_2043F8:
		sub.w	d1,obj.xvel(a0)
		bset	#5,obj.status(a0)
		move.w	#0,obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_20440A:
		add.w	d1,obj.yvel(a0)
locret_20440E:
		rts
; End of function sub_20409A
; =============== S U B R O U T I N E =======================================
sub_204410:
		move.w	obj.inertia(a0),d0
		beq.s	loc_204418
		bpl.s	loc_204460
loc_204418:
		tst.b	obj.field_2A(a0)
		beq.s	loc_204434
		cmpi.b	#$3D,obj.field_2A(a0)
		bne.s	locret_204496
		bset	#2,(word_FFF602).w
		lsl.w	#7,d5
		move.b	#0,obj.field_2A(a0)
loc_204434:
		bset	#0,obj.status(a0)
		bne.s	loc_204448
		bclr	#5,obj.status(a0)
		move.b	#1,obj.prevani(a0)
loc_204448:
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_204454
		move.w	d1,d0
loc_204454:
		move.w	d0,obj.inertia(a0)
		move.b	#0,obj.ani(a0)
		rts
; ---------------------------------------------------------------------------
loc_204460:
		sub.w	d4,d0
		bcc.s	loc_204468
		move.w	#-$80,d0
loc_204468:
		move.w	d0,obj.inertia(a0)
		move.b	obj.angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_204496
		cmpi.w	#$400,d0
		blt.s	locret_204496
		move.b	#$D,obj.ani(a0)
		bclr	#0,obj.status(a0)
		move.w	#$90,d0
		jsr	(queuesound2).l
locret_204496:
		rts
; End of function sub_204410
; =============== S U B R O U T I N E =======================================
sub_204498:
		move.w	obj.inertia(a0),d0
		bmi.s	loc_2044E2
		tst.b	obj.field_2A(a0)
		beq.s	loc_2044BA
		cmpi.b	#$3D,obj.field_2A(a0)
		bne.s	locret_204518
		bset	#3,(word_FFF602).w
		lsl.w	#7,d5
		move.b	#0,obj.field_2A(a0)
loc_2044BA:
		bclr	#0,obj.status(a0)
		beq.s	loc_2044CE
		bclr	#5,obj.status(a0)
		move.b	#1,obj.prevani(a0)
loc_2044CE:
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_2044D6
		move.w	d6,d0
loc_2044D6:
		move.w	d0,obj.inertia(a0)
		move.b	#0,obj.ani(a0)
		rts
; ---------------------------------------------------------------------------
loc_2044E2:
		add.w	d4,d0
		bcc.s	loc_2044EA
		move.w	#$80,d0
loc_2044EA:
		move.w	d0,obj.inertia(a0)
		move.b	obj.angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_204518
		cmpi.w	#-$400,d0
		bgt.s	locret_204518
		move.b	#$D,obj.ani(a0)
		bset	#0,obj.status(a0)
		move.w	#$90,d0
		jsr	(queuesound2).l
locret_204518:
		rts
; End of function sub_204498
; =============== S U B R O U T I N E =======================================
sub_20451A:
		move.w	(word_FFF760).w,d6
		asl.w	#1,d6
		move.w	(word_FFF762).w,d5
		asr.w	#1,d5
		move.w	(word_FFF764).w,d4
		asr.w	#2,d4
		tst.b	(byte_FFF7CA).w
		bne.w	loc_204640
		tst.w	obj.field_3E(a0)
		bne.s	loc_204552
		btst	#2,(word_FFF602).w
		beq.s	loc_204546
		bsr.w	sub_204676
loc_204546:
		btst	#3,(word_FFF602).w
		beq.s	loc_204552
		bsr.w	sub_20469A
loc_204552:
		tst.b	obj.field_2A(a0)
		beq.w	loc_2045E8
		move.w	#$19,d0
		move.w	(word_FFF760).w,d1
		asl.w	#1,d1
		btst	#0,obj.status(a0)
		beq.s	loc_204570
		neg.w	d0
		neg.w	d1
loc_204570:
		add.w	d0,obj.inertia(a0)
		move.w	obj.inertia(a0),d0
		cmp.w	d1,d0
		bgt.s	loc_20457E
		move.w	d1,d0
loc_20457E:
		move.w	d0,obj.inertia(a0)
		btst	#1,(word_FFF602).w
		beq.s	loc_2045BA
		move.b	(word_FFF602+1).w,d0
		andi.b	#$70,d0
		beq.s	locret_2045E6
loc_204594:
		move.w	#$AB,d0
		jsr	(queuesound2).l
		move.b	#0,obj.field_2A(a0)
		move.w	#0,obj.inertia(a0)
		move.w	#0,obj.xvel(a0)
		move.w	#0,obj.yvel(a0)
		bra.w	loc_204610
; ---------------------------------------------------------------------------
loc_2045BA:
		cmpi.b	#$3C,obj.field_2A(a0)
		bne.s	loc_204594
		move.b	#0,obj.field_2A(a0)
		move.w	#$91,d0
		jsr	(queuesound2).l
		btst	#0,obj.status(a0)
		bne.s	loc_2045E0
		bsr.w	sub_20469A
		bra.s	loc_2045E8
; ---------------------------------------------------------------------------
loc_2045E0:
		bsr.w	sub_204676
		bra.s	loc_2045E8
; ---------------------------------------------------------------------------
locret_2045E6:
		rts
; ---------------------------------------------------------------------------
loc_2045E8:
		move.w	obj.inertia(a0),d0
		beq.s	loc_20460A
		bmi.s	loc_2045FE
		sub.w	d5,d0
		bcc.s	loc_2045F8
		move.w	#0,d0
loc_2045F8:
		move.w	d0,obj.inertia(a0)
		bra.s	loc_20460A
; ---------------------------------------------------------------------------
loc_2045FE:
		add.w	d5,d0
		bcc.s	loc_204606
		move.w	#0,d0
loc_204606:
		move.w	d0,obj.inertia(a0)
loc_20460A:
		tst.w	obj.inertia(a0)
		bne.s	loc_204640
loc_204610:
		bclr	#2,obj.status(a0)
		tst.b	(chibi_flag).w
		beq.s	loc_20462A
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
		bra.s	loc_20463A
; ---------------------------------------------------------------------------
loc_20462A:
		move.b	#playheight,obj.height(a0)
		move.b	#playwidth,obj.width(a0)
		subq.w	#5,obj.ypos(a0)
loc_20463A:
		move.b	#5,obj.ani(a0)
loc_204640:
		move.b	obj.angle(a0),d0
		jsr	(calcsine).l
		muls.w	obj.inertia(a0),d0
		asr.l	#8,d0
		move.w	d0,obj.yvel(a0)
		muls.w	obj.inertia(a0),d1
		asr.l	#8,d1
		cmpi.w	#$1000,d1
		ble.s	loc_204664
		move.w	#$1000,d1
loc_204664:
		cmpi.w	#-$1000,d1
		bge.s	loc_20466E
		move.w	#-$1000,d1
loc_20466E:
		move.w	d1,obj.xvel(a0)
		bra.w	loc_20439E
; End of function sub_20451A
; =============== S U B R O U T I N E =======================================
sub_204676:
		move.w	obj.inertia(a0),d0
		beq.s	loc_20467E
		bpl.s	loc_20468C
loc_20467E:
		bset	#0,obj.status(a0)
		move.b	#2,obj.ani(a0)
		rts
; ---------------------------------------------------------------------------
loc_20468C:
		sub.w	d4,d0
		bcc.s	loc_204694
		move.w	#-$80,d0
loc_204694:
		move.w	d0,obj.inertia(a0)
		rts
; End of function sub_204676
; =============== S U B R O U T I N E =======================================
sub_20469A:
		move.w	obj.inertia(a0),d0
		bmi.s	loc_2046AE
		bclr	#0,obj.status(a0)
		move.b	#2,obj.ani(a0)
		rts
; ---------------------------------------------------------------------------
loc_2046AE:
		add.w	d4,d0
		bcc.s	loc_2046B6
		move.w	#$80,d0
loc_2046B6:
		move.w	d0,obj.inertia(a0)
		rts
; End of function sub_20469A
; =============== S U B R O U T I N E =======================================
sub_2046BC:
		move.w	(word_FFF760).w,d6
		move.w	(word_FFF762).w,d5
		asl.w	#1,d5
		btst	#4,obj.status(a0)
		bne.s	loc_204706
		move.w	obj.xvel(a0),d0
		btst	#2,(word_FFF602).w
		beq.s	loc_2046EC
		bset	#0,obj.status(a0)
		sub.w	d5,d0
		move.w	d6,d1
		neg.w	d1
		cmp.w	d1,d0
		bgt.s	loc_2046EC
		move.w	d1,d0
loc_2046EC:
		btst	#3,(word_FFF602).w
		beq.s	loc_204702
		bclr	#0,obj.status(a0)
		add.w	d5,d0
		cmp.w	d6,d0
		blt.s	loc_204702
		move.w	d6,d0
loc_204702:
		move.w	d0,obj.xvel(a0)
loc_204706:
		tst.b	obj.field_29(a0)
		beq.s	loc_20471E
		cmpi.w	#$60,(word_FFF73E).w
		beq.s	loc_20471E
		bcc.s	loc_20471A
		addq.w	#4,(word_FFF73E).w
loc_20471A:
		subq.w	#2,(word_FFF73E).w
loc_20471E:
		cmpi.w	#-$400,obj.yvel(a0)
		bcs.s	locret_20474C
		move.w	obj.xvel(a0),d0
		move.w	d0,d1
		asr.w	#5,d1
		beq.s	locret_20474C
		bmi.s	loc_204740
		sub.w	d1,d0
		bcc.s	loc_20473A
		move.w	#0,d0
loc_20473A:
		move.w	d0,obj.xvel(a0)
		rts
; ---------------------------------------------------------------------------
loc_204740:
		sub.w	d1,d0
		bcs.s	loc_204748
		move.w	#0,d0
loc_204748:
		move.w	d0,obj.xvel(a0)
locret_20474C:
		rts
; End of function sub_2046BC
; ---------------------------------------------------------------------------
		move.b	obj.angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		bne.s	locret_20477C
		bsr.w	sub_206216
		tst.w	d1
		bpl.s	locret_20477C
		move.w	#0,obj.inertia(a0)
		move.w	#0,obj.xvel(a0)
		move.w	#0,obj.yvel(a0)
		move.b	#$B,obj.ani(a0)
locret_20477C:
		rts
; =============== S U B R O U T I N E =======================================
sub_20477E:
		move.l	obj.xpos(a0),d1
		move.w	obj.xvel(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(dword_FFF728).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0
		bhi.s	loc_2047C4
		move.w	(dword_FFF728+2).w,d0
		addi.w	#$128,d0
		tst.b	(byte_FFF7AA).w
		bne.s	loc_2047AC
		addi.w	#$40,d0
loc_2047AC:
		cmp.w	d1,d0
		bls.s	loc_2047C4
loc_2047B0:
		move.w	(dword_FFF72C+2).w,d0
		addi.w	#224,d0
		cmp.w	obj.ypos(a0),d0
		blt.s	loc_2047C0
		rts
; ---------------------------------------------------------------------------
loc_2047C0:
		bra.w	loc_206668
; ---------------------------------------------------------------------------
loc_2047C4:

		move.w	d0,obj.xpos(a0)
		move.w	#0,obj.scrypos(a0)
		move.w	#0,obj.xvel(a0)
		move.w	#0,obj.inertia(a0)
		bra.s	loc_2047B0
; End of function sub_20477E
; =============== S U B R O U T I N E =======================================
sub_2047DC:
		tst.b	(byte_FFF7CA).w
		bne.s	locret_204802
		move.w	obj.inertia(a0),d0
		bpl.s	loc_2047EA
		neg.w	d0
loc_2047EA:
		cmpi.w	#$80,d0
		bcs.s	locret_204802
		move.b	(word_FFF602).w,d0
		andi.b	#$C,d0
		bne.s	locret_204802
		btst	#1,(word_FFF602).w
		bne.s	sub_204804
locret_204802:
		rts
; End of function sub_2047DC
; =============== S U B R O U T I N E =======================================
sub_204804:
		btst	#2,obj.status(a0)
		beq.s	loc_20480E
		rts
; ---------------------------------------------------------------------------
loc_20480E:
		bset	#2,obj.status(a0)
		tst.b	(chibi_flag).w
		beq.s	loc_204828
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
		bra.s	loc_204838
; ---------------------------------------------------------------------------
loc_204828:
		move.b	#rollheight,obj.height(a0)
		move.b	#rollwidth,obj.width(a0)
		addq.w	#5,obj.ypos(a0)
loc_204838:
		move.b	#2,obj.ani(a0)
		tst.w	obj.inertia(a0)
		bne.s	locret_20484A
		move.w	#$200,obj.inertia(a0)
locret_20484A:
		rts
; End of function sub_204804
; =============== S U B R O U T I N E =======================================
sub_20484C:
		tst.b	obj.field_2A(a0)
		beq.s	loc_204876
		move.b	(word_FFF602+1).w,d0
		andi.b	#$70,d0
		beq.s	loc_204876
		move.b	#0,obj.field_2A(a0)
		move.w	#0,obj.inertia(a0)
		move.w	#0,obj.xvel(a0)
		move.w	#0,obj.yvel(a0)
		bra.s	loc_204888
; ---------------------------------------------------------------------------
loc_204876:
		move.b	(word_FFF602).w,d0
		andi.b	#3,d0
		beq.s	loc_204888
		tst.w	obj.inertia(a0)
		beq.w	locret_204964
loc_204888:
		move.b	(word_FFF602+1).w,d0
		andi.b	#$70,d0
		beq.w	locret_204964
		btst	#3,obj.status(a0)
		beq.s	loc_2048A4
		jsr	(sub_205394).l
		beq.s	loc_2048D4
loc_2048A4:
		moveq	#0,d0
		move.b	obj.angle(a0),d0
		addi.b	#$80,d0
		bsr.w	sub_206046
		cmpi.w	#6,d1
		blt.w	locret_204964
		move.w	#$680,d2
		btst	#6,obj.status(a0)
		beq.s	loc_2048CA
		move.w	#$380,d2
loc_2048CA:
		moveq	#0,d0
		move.b	obj.angle(a0),d0
		subi.b	#$40,d0
loc_2048D4:
		jsr	(calcsine).l
		muls.w	d2,d1
		asr.l	#8,d1
		add.w	d1,obj.xvel(a0)
		muls.w	d2,d0
		asr.l	#8,d0
		add.w	d0,obj.yvel(a0)
		bset	#1,obj.status(a0)
		bclr	#5,obj.status(a0)
		addq.l	#4,sp
		move.b	#1,obj.field_3C(a0)
		clr.b	obj.field_38(a0)
		move.w	#$92,d0
		jsr	(queuesound2).l
		tst.b	(chibi_flag).w
		beq.s	loc_204920
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
		bra.s	loc_20492C
; ---------------------------------------------------------------------------
loc_204920:
		move.b	#playheight,obj.height(a0)
		move.b	#playwidth,obj.width(a0)
loc_20492C:
		btst	#2,obj.status(a0)
		bne.s	loc_204966
		tst.b	(chibi_flag).w
		beq.s	loc_204948
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
		bra.s	loc_204958
; ---------------------------------------------------------------------------
loc_204948:
		move.b	#rollheight,obj.height(a0)
		move.b	#rollwidth,obj.width(a0)
		addq.w	#5,obj.ypos(a0)
loc_204958:
		bset	#2,obj.status(a0)
		move.b	#2,obj.ani(a0)
locret_204964:
		rts
; ---------------------------------------------------------------------------
loc_204966:
		bset	#4,obj.status(a0)
		rts
; End of function sub_20484C
; =============== S U B R O U T I N E =======================================
sub_20496E:
		tst.b	obj.field_3C(a0)
		beq.s	loc_2049A0
		move.w	#-$400,d1
		btst	#6,obj.status(a0)
		beq.s	loc_204984
		move.w	#-$200,d1
loc_204984:
		cmp.w	obj.yvel(a0),d1
		ble.s	locret_20499E
		move.b	(word_FFF602).w,d0
		andi.b	#$70,d0
		bne.s	locret_20499E
		move.b	#0,obj.field_2A(a0)
		move.w	d1,obj.yvel(a0)
locret_20499E:
		rts
; ---------------------------------------------------------------------------
loc_2049A0:
		cmpi.w	#-$FC0,obj.yvel(a0)
		bge.s	locret_2049AE
		move.w	#-$FC0,obj.yvel(a0)
locret_2049AE:
		rts
; End of function sub_20496E
; =============== S U B R O U T I N E =======================================
sub_2049B0:
		tst.b	obj.field_2A(a0)
		bne.s	locret_2049EA
		move.b	obj.angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bcc.s	locret_2049EA
		move.b	obj.angle(a0),d0
		jsr	(calcsine).l
		muls.w	#$20,d0
		asr.l	#8,d0
		tst.w	obj.inertia(a0)
		beq.s	locret_2049EA
		bmi.s	loc_2049E6
		tst.w	d0
		beq.s	locret_2049E4
		add.w	d0,obj.inertia(a0)
locret_2049E4:
		rts
; ---------------------------------------------------------------------------
loc_2049E6:
		add.w	d0,obj.inertia(a0)
locret_2049EA:
		rts
; End of function sub_2049B0
; =============== S U B R O U T I N E =======================================
sub_2049EC:
		tst.b	obj.field_2A(a0)
		bne.s	locret_204A2C
		move.b	obj.angle(a0),d0
		addi.b	#$60,d0
		cmpi.b	#$C0,d0
		bcc.s	locret_204A2C
		move.b	obj.angle(a0),d0
		jsr	(calcsine).l
		muls.w	#$50,d0
		asr.l	#8,d0
		tst.w	obj.inertia(a0)
		bmi.s	loc_204A22
		tst.w	d0
		bpl.s	loc_204A1C
		asr.l	#2,d0
loc_204A1C:
		add.w	d0,obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_204A22:
		tst.w	d0
		bmi.s	loc_204A28
		asr.l	#2,d0
loc_204A28:
		add.w	d0,obj.inertia(a0)
locret_204A2C:

		rts
; End of function sub_2049EC
; =============== S U B R O U T I N E =======================================
sub_204A2E:
		nop
		tst.b	obj.field_38(a0)
		bne.s	locret_204A68
		tst.w	obj.field_3E(a0)
		bne.s	loc_204A6A
		move.b	obj.angle(a0),d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		beq.s	locret_204A68
		move.w	obj.inertia(a0),d0
		bpl.s	loc_204A52
		neg.w	d0
loc_204A52:
		cmpi.w	#$280,d0
		bcc.s	locret_204A68
		clr.w	obj.inertia(a0)
		bset	#1,obj.status(a0)
		move.w	#30,obj.field_3E(a0)
locret_204A68:
		rts
; ---------------------------------------------------------------------------
loc_204A6A:
		subq.w	#1,obj.field_3E(a0)
		rts
; End of function sub_204A2E
; =============== S U B R O U T I N E =======================================
sub_204A70:
		move.b	obj.angle(a0),d0
		beq.s	locret_204A8A
		bpl.s	loc_204A80
		addq.b	#2,d0
		bcc.s	loc_204A7E
		moveq	#0,d0
loc_204A7E:
		bra.s	loc_204A86
; ---------------------------------------------------------------------------
loc_204A80:
		subq.b	#2,d0
		bcc.s	loc_204A86
		moveq	#0,d0
loc_204A86:
		move.b	d0,obj.angle(a0)
locret_204A8A:
		rts
; End of function sub_204A70
; =============== S U B R O U T I N E =======================================
sub_204A8C:
		move.w	obj.xvel(a0),d1
		move.w	obj.yvel(a0),d2
		jsr	(calcangle).l
		move.b	d0,(byte_FF13EC).l
		subi.b	#$20,d0
		move.b	d0,(byte_FF13ED).l
		andi.b	#$C0,d0
		move.b	d0,(byte_FF13EE).l
		cmpi.b	#$40,d0
		beq.w	loc_204B70
		cmpi.b	#$80,d0
		beq.w	loc_204BD2
		cmpi.b	#$C0,d0
		beq.w	loc_204C2E
		bsr.w	sub_20635C
		tst.w	d1
		bpl.s	loc_204ADE
		sub.w	d1,obj.xpos(a0)
		move.w	#0,obj.xvel(a0)
loc_204ADE:
		bsr.w	sub_2061BE
		tst.w	d1
		bpl.s	loc_204AF0
		add.w	d1,obj.xpos(a0)
		move.w	#0,obj.xvel(a0)
loc_204AF0:
		bsr.w	loc_20606E
		move.b	d1,(byte_FF13EF).l
		tst.w	d1
		bpl.s	locret_204B6E
		move.b	obj.yvel(a0),d2
		addq.b	#8,d2
		neg.b	d2
		cmp.b	d2,d1
		bge.s	loc_204B0E
		cmp.b	d2,d0
		blt.s	locret_204B6E
loc_204B0E:
		add.w	d1,obj.ypos(a0)
		move.b	d3,obj.angle(a0)
		bsr.w	sub_204C90
		move.b	#0,obj.ani(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_204B4C
		move.b	d3,d0
		addi.b	#$10,d0
		andi.b	#$20,d0
		beq.s	loc_204B3E
		asr.w	obj.yvel(a0)
		bra.s	loc_204B60
; ---------------------------------------------------------------------------
loc_204B3E:
		move.w	#0,obj.yvel(a0)
		move.w	obj.xvel(a0),obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_204B4C:
		move.w	#0,obj.xvel(a0)
		cmpi.w	#$FC0,obj.yvel(a0)
		ble.s	loc_204B60
		move.w	#$FC0,obj.yvel(a0)
loc_204B60:
		move.w	obj.yvel(a0),obj.inertia(a0)
		tst.b	d3
		bpl.s	locret_204B6E
		neg.w	obj.inertia(a0)
locret_204B6E:
		rts
; ---------------------------------------------------------------------------
loc_204B70:
		bsr.w	sub_20635C
		tst.w	d1
		bpl.s	loc_204B8A
		sub.w	d1,obj.xpos(a0)
		move.w	#0,obj.xvel(a0)
		move.w	obj.yvel(a0),obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_204B8A:
		bsr.w	sub_206216
		tst.w	d1
		bpl.s	loc_204BA4
		sub.w	d1,obj.ypos(a0)
		tst.w	obj.yvel(a0)
		bpl.s	locret_204BA2
		move.w	#0,obj.yvel(a0)
locret_204BA2:
		rts
; ---------------------------------------------------------------------------
loc_204BA4:
		tst.w	obj.yvel(a0)
		bmi.s	locret_204BD0
		bsr.w	loc_20606E
		tst.w	d1
		bpl.s	locret_204BD0
		add.w	d1,obj.ypos(a0)
		move.b	d3,obj.angle(a0)
		bsr.w	sub_204C90
		move.b	#0,obj.ani(a0)
		move.w	#0,obj.yvel(a0)
		move.w	obj.xvel(a0),obj.inertia(a0)
locret_204BD0:
		rts
; ---------------------------------------------------------------------------
loc_204BD2:
		bsr.w	sub_20635C
		tst.w	d1
		bpl.s	loc_204BE4
		sub.w	d1,obj.xpos(a0)
		move.w	#0,obj.xvel(a0)
loc_204BE4:
		bsr.w	sub_2061BE
		tst.w	d1
		bpl.s	loc_204BF6
		add.w	d1,obj.xpos(a0)
		move.w	#0,obj.xvel(a0)
loc_204BF6:
		bsr.w	sub_206216
		tst.w	d1
		bpl.s	locret_204C2C
		sub.w	d1,obj.ypos(a0)
		move.b	d3,d0
		addi.b	#$20,d0
		andi.b	#$40,d0
		bne.s	loc_204C16
		move.w	#0,obj.yvel(a0)
		rts
; ---------------------------------------------------------------------------
loc_204C16:
		move.b	d3,obj.angle(a0)
		bsr.w	sub_204C90
		move.w	obj.yvel(a0),obj.inertia(a0)
		tst.b	d3
		bpl.s	locret_204C2C
		neg.w	obj.inertia(a0)
locret_204C2C:
		rts
; ---------------------------------------------------------------------------
loc_204C2E:
		bsr.w	sub_2061BE
		tst.w	d1
		bpl.s	loc_204C48
		add.w	d1,obj.xpos(a0)
		move.w	#0,obj.xvel(a0)
		move.w	obj.yvel(a0),obj.inertia(a0)
		rts
; ---------------------------------------------------------------------------
loc_204C48:
		bsr.w	sub_206216
		tst.w	d1
		bpl.s	loc_204C62
		sub.w	d1,obj.ypos(a0)
		tst.w	obj.yvel(a0)
		bpl.s	locret_204C60
		move.w	#0,obj.yvel(a0)
locret_204C60:
		rts
; ---------------------------------------------------------------------------
loc_204C62:
		tst.w	obj.yvel(a0)
		bmi.s	locret_204C8E
		bsr.w	loc_20606E
		tst.w	d1
		bpl.s	locret_204C8E
		add.w	d1,obj.ypos(a0)
		move.b	d3,obj.angle(a0)
		bsr.w	sub_204C90
		move.b	#0,obj.ani(a0)
		move.w	#0,obj.yvel(a0)
		move.w	obj.xvel(a0),obj.inertia(a0)
locret_204C8E:
		rts
; End of function sub_204A8C
; =============== S U B R O U T I N E =======================================
sub_204C90:
		btst	#4,obj.status(a0)
		beq.s	loc_204C9A
		nop
loc_204C9A:
		bclr	#5,obj.status(a0)
		bclr	#1,obj.status(a0)
		bclr	#4,obj.status(a0)
		btst	#2,obj.status(a0)
		beq.s	loc_204CE4
		bclr	#2,obj.status(a0)
		tst.b	(chibi_flag).w
		beq.s	loc_204CCE
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
		bra.s	loc_204CDE
; ---------------------------------------------------------------------------
loc_204CCE:
		move.b	#playheight,obj.height(a0)
		move.b	#playwidth,obj.width(a0)
		subq.w	#5,obj.ypos(a0)
loc_204CDE:
		move.b	#0,obj.ani(a0)
loc_204CE4:
		move.b	#0,obj.field_3C(a0)
		move.w	#0,(word_FFF7D0).w
		rts
; End of function sub_204C90
; ---------------------------------------------------------------------------
loc_204CF2:
		jsr	(sub_203166).l
		addi.w	#$30,obj.yvel(a0)
		btst	#6,obj.status(a0)
		beq.s	loc_204D0C
		subi.w	#$20,obj.yvel(a0)
loc_204D0C:
		bsr.w	sub_204D22
		bsr.w	sub_20477E
		bsr.w	sub_203E5A
		bsr.w	sub_204EF4
		jmp	(displaysprite).l
; =============== S U B R O U T I N E =======================================
sub_204D22:
		move.w	(dword_FFF72C+2).w,d0
		addi.w	#224,d0
		cmp.w	obj.ypos(a0),d0
		bcs.w	loc_206668
		bsr.w	sub_204A8C
		btst	#1,obj.status(a0)
		bne.s	locret_204D5C
		moveq	#0,d0
		move.w	d0,obj.yvel(a0)
		move.w	d0,obj.xvel(a0)
		move.w	d0,obj.inertia(a0)
		move.b	#0,obj.ani(a0)
		subq.b	#2,obj.routine(a0)
		move.w	#120,obj.field_30(a0)
locret_204D5C:
		rts
; End of function sub_204D22
; ---------------------------------------------------------------------------
loc_204D5E:
		bsr.w	sub_204D76
		jsr	(sub_20313A).l
		bsr.w	sub_203E5A
		bsr.w	sub_204EF4
		jmp	(displaysprite).l
; =============== S U B R O U T I N E =======================================
sub_204D76:
		move.w	(dword_FFF72C+2).w,d0
		addi.w	#$100,d0
		cmp.w	obj.ypos(a0),d0
		bcc.w	locret_204DB8
		move.w	#-$38,obj.yvel(a0)
		addq.b	#2,obj.routine(a0)
		clr.b	(byte_FF121E).l
		addq.b	#1,(byte_FF121C).l
		subq.b	#1,(byte_FF1212).l
loc_204DA2:
		move.w	#60,obj.field_3A(a0)
		tst.b	(byte_FF121A).l
		beq.s	locret_204DB8
		move.w	#0,obj.field_3A(a0)
		bra.s	loc_204DA2
; ---------------------------------------------------------------------------
locret_204DB8:
		rts
; End of function sub_204D76
; ---------------------------------------------------------------------------
loc_204DBA:
		tst.w	obj.field_3A(a0)
		beq.s	locret_204E16
		subq.w	#1,obj.field_3A(a0)
		bne.s	locret_204E16
		move.w	#1,(lvl_reset).l
		lea	(byte_FFD040).w,a5
		_cmpi.b	#objid_01,obj.id(a0)
		beq.s	loc_204DDE
		lea	(actwk).w,a5
loc_204DDE:
		_tst.b	obj.id(a5)
		beq.w	loc_204DFA
		move.w	#0,(lvl_reset).l
		eori.b	#1,(byte_FF1219).l
		bra.w	deleteobj
; ---------------------------------------------------------------------------
loc_204DFA:
		clr.l	(dword_FF1880).l
		move.w	#scpu_fadeCDA,d0
		tst.b	(byte_FF1212).l
		beq.s	loc_204E12
		clr.w	(word_FF12F4).l
loc_204E12:
		bra.w	sub_205404
; ---------------------------------------------------------------------------
locret_204E16:
		rts
; =============== S U B R O U T I N E =======================================
sub_204E18:
		cmpi.b	#zoneid_SLZ,(zone).l
		beq.s	loc_204E2C
		tst.b	(zone).l
		bne.w	locret_204EE2
loc_204E2C:
		move.w	obj.ypos(a0),d0
		lsr.w	#1,d0
		andi.w	#$380,d0
		move.b	obj.xpos(a0),d1
		andi.w	#$7F,d1
		add.w	d1,d0
		lea	(lvllayoutwk).w,a1
		move.b	(a1,d0.w),d1
		cmp.b	(dword_FFF7AC+2).w,d1
		bne.s	loc_204E6A
		tst.b	(zone).l
		bne.w	loc_204EE4
		move.w	obj.ypos(a0),d0
		andi.w	#$FF,d0
		cmpi.w	#$90,d0
		bcc.w	loc_204EE4
		bra.s	loc_204E72
; ---------------------------------------------------------------------------
loc_204E6A:
		cmp.b	(dword_FFF7AC+3).w,d1
		beq.w	loc_204EE4
loc_204E72:
		cmp.b	(dword_FFF7AC).w,d1
		beq.s	loc_204E96
		cmp.b	(dword_FFF7AC+1).w,d1
		beq.s	loc_204E86
		bclr	#6,obj.render(a0)
		rts
; ---------------------------------------------------------------------------
loc_204E86:
		btst	#1,obj.status(a0)
		beq.s	loc_204E96
		bclr	#6,obj.render(a0)
		rts
; ---------------------------------------------------------------------------
loc_204E96:
		move.w	obj.xpos(a0),d2
		cmpi.b	#$2C,d2
		bcc.s	loc_204EA8
		bclr	#6,obj.render(a0)
		rts
; ---------------------------------------------------------------------------
loc_204EA8:
		cmpi.b	#$E0,d2
		bcs.s	loc_204EB6
		bset	#6,obj.render(a0)
		rts
; ---------------------------------------------------------------------------
loc_204EB6:
		btst	#6,obj.render(a0)
		bne.s	loc_204ED2
		move.b	obj.angle(a0),d1
		beq.s	locret_204EE2
		cmpi.b	#$80,d1
		bhi.s	locret_204EE2
		bset	#6,obj.render(a0)
		rts
; ---------------------------------------------------------------------------
loc_204ED2:
		move.b	obj.angle(a0),d1
		cmpi.b	#$80,d1
		bls.s	locret_204EE2
		bclr	#6,obj.render(a0)
locret_204EE2:
		rts
; ---------------------------------------------------------------------------
loc_204EE4:
		move.w	#$9C,d0
		jsr	(queuesound2).l
		jmp	(sub_204804).l
; End of function sub_204E18
; =============== S U B R O U T I N E =======================================
sub_204EF4:
		lea	(play_ani).l,a1
		moveq	#0,d0
		move.b	obj.ani(a0),d0
		cmp.b	obj.prevani(a0),d0
		beq.s	loc_204F16
		move.b	d0,obj.prevani(a0)
		move.b	#0,obj.aniframe(a0)
		move.b	#0,obj.time(a0)
loc_204F16:
		bsr.w	sub_205132
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),d0
		bmi.s	loc_204F8E
		move.b	obj.status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,obj.render(a0)
		or.b	d1,obj.render(a0)
		subq.b	#1,obj.time(a0)
		bpl.s	locret_204F5C
		move.b	d0,obj.time(a0)
; End of function sub_204EF4
; =============== S U B R O U T I N E =======================================
sub_204F40:
		moveq	#0,d1
		move.b	obj.aniframe(a0),d1
		move.b	1(a1,d1.w),d0
		beq.s	loc_204F54
		bpl.s	loc_204F54
		cmpi.b	#$FD,d0
		bge.s	loc_204F5E
loc_204F54:
		move.b	d0,obj.frame(a0)
		addq.b	#1,obj.aniframe(a0)
locret_204F5C:
		rts
; ---------------------------------------------------------------------------
loc_204F5E:
		addq.b	#1,d0
		bne.s	loc_204F6E
		move.b	#0,obj.aniframe(a0)
		move.b	1(a1),d0
		bra.s	loc_204F54
; ---------------------------------------------------------------------------
loc_204F6E:
		addq.b	#1,d0
		bne.s	loc_204F82
		move.b	2(a1,d1.w),d0
		sub.b	d0,obj.aniframe(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_204F54
; ---------------------------------------------------------------------------
loc_204F82:
		addq.b	#1,d0
		bne.s	locret_204F8C
		move.b	2(a1,d1.w),obj.ani(a0)
locret_204F8C:
		rts
; End of function sub_204F40
; ---------------------------------------------------------------------------
loc_204F8E:
		subq.b	#1,obj.time(a0)
		bpl.s	locret_204F5C
		addq.b	#1,d0
		bne.w	loc_205016
		tst.b	(chibi_flag).w
		bne.w	loc_2050BC
		moveq	#0,d1
		move.b	obj.angle(a0),d0
		move.b	obj.status(a0),d2
		andi.b	#1,d2
		bne.s	loc_204FB4
		not.b	d0
loc_204FB4:
		addi.b	#$10,d0
		bpl.s	loc_204FBC
		moveq	#3,d1
loc_204FBC:
		andi.b	#$FC,obj.render(a0)
		eor.b	d1,d2
		or.b	d2,obj.render(a0)
		btst	#5,obj.status(a0)
		bne.w	loc_20506A
		lsr.b	#4,d0
		andi.b	#6,d0
		move.w	obj.inertia(a0),d2
		bpl.s	loc_204FE0
		neg.w	d2
loc_204FE0:
		lea	(unk_2051DE).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_204FF8
		lea	(unk_2051D6).l,a1
		move.b	d0,d1
		lsr.b	#1,d1
		add.b	d1,d0
loc_204FF8:
		add.b	d0,d0
		move.b	d0,d3
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_205006
		moveq	#0,d2
loc_205006:
		lsr.w	#8,d2
		move.b	d2,obj.time(a0)
		bsr.w	sub_204F40
		add.b	d3,obj.frame(a0)
		rts
; ---------------------------------------------------------------------------
loc_205016:
		addq.b	#1,d0
		bne.s	loc_205066
		move.w	obj.inertia(a0),d2
		bpl.s	loc_205022
		neg.w	d2
loc_205022:
		lea	(unk_2052B4).l,a1
		tst.b	(chibi_flag).w
		bne.s	loc_205040
		lea	(unk_2051EE).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_205040
		lea	(unk_2051E6).l,a1
loc_205040:
		neg.w	d2
		addi.w	#$400,d2
		bpl.s	loc_20504A
		moveq	#0,d2
loc_20504A:
		lsr.w	#8,d2
		move.b	d2,obj.time(a0)
		move.b	obj.status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,obj.render(a0)
		or.b	d1,obj.render(a0)
		bra.w	sub_204F40
; ---------------------------------------------------------------------------
loc_205066:
		addq.b	#1,d0
		bne.s	loc_2050A8
loc_20506A:
		move.w	obj.inertia(a0),d2
		bmi.s	loc_205072
		neg.w	d2
loc_205072:
		addi.w	#$800,d2
		bpl.s	loc_20507A
		moveq	#0,d2
loc_20507A:
		lsr.w	#6,d2
		move.b	d2,obj.time(a0)
		lea	(unk_2052C6).l,a1
		tst.b	(chibi_flag).w
		bne.s	loc_205092
		lea	(unk_2051F6).l,a1
loc_205092:
		move.b	obj.status(a0),d1
		andi.b	#1,d1
		andi.b	#$FC,obj.render(a0)
		or.b	d1,obj.render(a0)
		bra.w	sub_204F40
; ---------------------------------------------------------------------------
loc_2050A8:
		moveq	#0,d1
		move.b	obj.aniframe(a0),d1
		move.b	1(a1,d1.w),obj.frame(a0)
		move.b	#0,obj.time(a0)
		rts
; ---------------------------------------------------------------------------
loc_2050BC:
		moveq	#0,d1
		move.b	obj.angle(a0),d0
		move.b	obj.status(a0),d2
		andi.b	#1,d2
		bne.s	loc_2050CE
		not.b	d0
loc_2050CE:
		addi.b	#$10,d0
		bpl.s	loc_2050D6
		moveq	#0,d1
loc_2050D6:
		andi.b	#$FC,obj.render(a0)
		or.b	d2,obj.render(a0)
		addi.b	#$30,d0
		cmpi.b	#$60,d0
		bcs.s	loc_205104
		bset	#2,obj.status(a0)
		move.b	#chibiheight,obj.height(a0)
		move.b	#chibiwidth,obj.width(a0)
		move.b	#$FF,d0
		bra.w	loc_205016
; ---------------------------------------------------------------------------
loc_205104:
		move.w	obj.inertia(a0),d2
		bpl.s	loc_20510C
		neg.w	d2
loc_20510C:
		lea	(unk_2052AE).l,a1
		cmpi.w	#$600,d2
		bcc.s	loc_20511E
		lea	(unk_2052A8).l,a1
loc_20511E:
		neg.w	d2
		addi.w	#$800,d2
		bpl.s	loc_205128
		moveq	#0,d2
loc_205128:
		lsr.w	#8,d2
		move.b	d2,$1E(a0)
		bra.w	sub_204F40
; =============== S U B R O U T I N E =======================================
sub_205132:
		tst.b	(chibi_flag).w
		beq.s	locret_20513C
		move.b	byte_20513E(pc,d0.w),d0
locret_20513C:
		rts
; End of function sub_205132
; ---------------------------------------------------------------------------
byte_20513E:
		dc.b $21
		dc.b $18
		dc.b $23
		dc.b $23
		dc.b $27
		dc.b $1F
		dc.b $26
		dc.b $28
		dc.b $20
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b $24
		dc.b  $E
		dc.b  $F
		dc.b $28
		dc.b $11
		dc.b $12
		dc.b $13
		dc.b $14
		dc.b $15
		dc.b $16
		dc.b $17
		dc.b $18
		dc.b $19
		dc.b $25
		dc.b $25
		dc.b $1C
		dc.b $1D
		dc.b $1E
		dc.b $1F
		dc.b $20
		dc.b $21
		dc.b $22
		dc.b $23
		dc.b $24
		dc.b $25
		dc.b $26
		dc.b $27
		dc.b $28
		dc.b $29
		dc.b $2A
		dc.b $30
		dc.b $2C
		dc.b $2D
		dc.b $2E
		dc.b $2F
		even

play_ani:
		dc.w unk_2051D6-play_ani
		dc.w unk_2051DE-play_ani
		dc.w unk_2051E6-play_ani
		dc.w unk_2051EE-play_ani
		dc.w unk_2051F6-play_ani
		dc.w unk_2051FE-play_ani
		dc.w unk_205214-play_ani
		dc.w unk_205218-play_ani
		dc.w unk_20521C-play_ani
		dc.w unk_205220-play_ani
		dc.w unk_205224-play_ani
		dc.w unk_205228-play_ani
		dc.w unk_20522C-play_ani
		dc.w unk_205230-play_ani
		dc.w unk_205234-play_ani
		dc.w unk_205238-play_ani
		dc.w unk_205240-play_ani
		dc.w unk_205244-play_ani
		dc.w unk_205248-play_ani
		dc.w unk_20524E-play_ani
		dc.w unk_205254-play_ani
		dc.w unk_205258-play_ani
		dc.w unk_205260-play_ani
		dc.w unk_205264-play_ani
		dc.w unk_205268-play_ani
		dc.w unk_20526C-play_ani
		dc.w unk_205276-play_ani
		dc.w unk_20527A-play_ani
		dc.w unk_20527E-play_ani
		dc.w unk_205282-play_ani
		dc.w unk_20528A-play_ani
		dc.w unk_20528E-play_ani
		dc.w unk_2052A4-play_ani
		dc.w unk_2052A8-play_ani
		dc.w unk_2052AE-play_ani
		dc.w unk_2052B4-play_ani
		dc.w unk_2052BA-play_ani
		dc.w unk_2052BE-play_ani
		dc.w unk_2052C2-play_ani
		dc.w unk_2052C6-play_ani
		dc.w unk_2052CE-play_ani
		dc.w unk_2052D2-play_ani
		dc.w unk_2052D6-play_ani
		dc.w unk_2052E6-play_ani
		dc.w unk_20530C-play_ani
		dc.w unk_205310-play_ani
		dc.w unk_205318-play_ani
		dc.w unk_205320-play_ani
		dc.w unk_205326-play_ani
		dc.w unk_205310-play_ani
		dc.w unk_205318-play_ani
		dc.w unk_205320-play_ani
unk_2051D6:
		dc.b $FF
		dc.b playframe.walk3
		dc.b playframe.walk4
		dc.b playframe.walk5
		dc.b playframe.walk6
		dc.b playframe.walk1
		dc.b playframe.walk2
		dc.b $FF
		even
unk_2051DE:
		dc.b $FF
		dc.b playframe.run1
		dc.b playframe.run2
		dc.b playframe.run3
		dc.b playframe.run4
		dc.b $FF
		dc.b $FF
		dc.b $FF
		even
unk_2051E6:
		dc.b $FE
		dc.b playframe.roll1
		dc.b playframe.roll2
		dc.b playframe.roll3
		dc.b playframe.roll4
		dc.b playframe.rollball2
		dc.b $FF
		dc.b $FF
		even
unk_2051EE:
		dc.b $FE
		dc.b playframe.roll1
		dc.b playframe.roll2
		dc.b playframe.rollball2
		dc.b playframe.roll3
		dc.b playframe.roll4
		dc.b playframe.rollball2
		dc.b $FF
		even
unk_2051F6:
		dc.b $FD
		dc.b playframe.push1
		dc.b playframe.push2
		dc.b playframe.push3
		dc.b playframe.push4
		dc.b $FF
		dc.b $FF
		dc.b $FF
		even
unk_2051FE:
		dc.b $17
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.stand
		dc.b playframe.wait2
		dc.b playframe.wait1
		dc.b playframe.wait1
		dc.b playframe.wait1
		dc.b playframe.wait2
		dc.b playframe.wait3
		dc.b $FE, 2
		even
unk_205214:
		dc.b $1F
		dc.b playframe.balance1
		dc.b playframe.balance2
		dc.b $FF
		even
unk_205218:
		dc.b $3F
		dc.b playframe.lookup
		dc.b $FF
		even
unk_20521C:
		dc.b $3F
		dc.b playframe.duck
		dc.b $FF
		even
unk_205220:
		dc.b $3F
		dc.b $33
		dc.b $FF
		even
unk_205224:
		dc.b $3F
		dc.b $34
		dc.b $FF
		even
unk_205228:
		dc.b $3F
		dc.b $35
		dc.b $FF
		even
unk_20522C:
		dc.b $3F
		dc.b $36
		dc.b $FF
		even
unk_205230:
		dc.b 7
		dc.b playframe.skid1
		dc.b playframe.skid2
		dc.b $FF
		even
unk_205234:
		dc.b 7
		dc.b $3C
		dc.b $3F
		dc.b $FF
		even
unk_205238:
		dc.b 7
		dc.b $3C
		dc.b $3D
		dc.b $53
		dc.b $3E
		dc.b $54
		dc.b $FF
		even
unk_205240:
		dc.b $2F
		dc.b playframe.spring
		dc.b $FD, 0
		even
unk_205244:
		dc.b 4
		dc.b playframe.polehang1
		dc.b playframe.polehang2
		dc.b $FF
		even
unk_205248:
		dc.b $F
		dc.b $43
		dc.b $43
		dc.b $43
		dc.b $FE, 1
		even
unk_20524E:
		dc.b $F
		dc.b $43
		dc.b $44
		dc.b $FE, 1
		even
unk_205254:
		dc.b $3F
		dc.b $49
		dc.b $FF
		even
unk_205258:
		dc.b $B
		dc.b playframe.getair
		dc.b playframe.getair
		dc.b playframe.walk5
		dc.b playframe.walk6
		dc.b $FD, 0
		even
unk_205260:
		dc.b $20
		dc.b playframe.burnt
		dc.b $FF
		even
unk_205264:
		dc.b $2F
		dc.b playframe.drown
		dc.b $FF
		even
unk_205268:
		dc.b 3
		dc.b playframe.death
		dc.b $FF
		even
unk_20526C:
		dc.b 3
		dc.b $4E
		dc.b $4F
		dc.b $50
		dc.b $51
		dc.b $52
		dc.b 0
		dc.b $FE, 1
		even
unk_205276:
		dc.b 3
		dc.b playframe.hurt
		dc.b $FF
		even
unk_20527A:
		dc.b 7
		dc.b playframe.hurt
		dc.b playframe.waterfall
		dc.b $FF
		even
unk_20527E:
		dc.b $77
		dc.b playframe.empty
		dc.b $FD, 0
		even
unk_205282:
		dc.b 3
		dc.b $3C
		dc.b $3D
		dc.b $53
		dc.b $3E
		dc.b $54
		dc.b $FF
		even
unk_20528A:
		dc.b 3
		dc.b $3C
		dc.b $FD, 0
		even
unk_20528E:
		dc.b $17
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibistand
		dc.b playframe.chibiwait1
		dc.b playframe.chibiwait1
		dc.b playframe.chibiwait1
		dc.b playframe.chibiwait2
		dc.b playframe.chibiwait1
		dc.b playframe.chibiwait2
		dc.b $FE, 2
		even
unk_2052A4:
		dc.b $3F
		dc.b playframe.chibiduck
		dc.b $FF
		even
unk_2052A8:
		dc.b $FF
		dc.b playframe.chibiwalk1
		dc.b playframe.chibiwalk2
		dc.b playframe.chibiwalk3
		dc.b playframe.chibiwalk2
		dc.b $FF
		even
unk_2052AE:
		dc.b $FF
		dc.b playframe.chibirun1
		dc.b playframe.chibirun2
		dc.b $FF
		dc.b $FF
		dc.b $FF
		even
unk_2052B4:
		dc.b $FE
		dc.b playframe.chibirollball
		dc.b playframe.chibiroll1
		dc.b playframe.chibiroll2
		dc.b $FF
		dc.b $FF
		even
unk_2052BA:
		dc.b 7
		dc.b playframe.chibiskid
		dc.b playframe.chibiskid
		dc.b $FF
		even
unk_2052BE:
		dc.b 3
		dc.b playframe.chibihurt
		dc.b $FF
		even
unk_2052C2:
		dc.b $1F
		dc.b playframe.chibibalance1
		dc.b playframe.chibibalance2
		dc.b $FF
		even
unk_2052C6:
		dc.b $FD
		dc.b playframe.chibiwalk1
		dc.b playframe.chibiwalk2
		dc.b playframe.chibiwalk3
		dc.b $FF
		dc.b $FF
		dc.b $FF
		even
unk_2052CE:
		dc.b $3F
		dc.b playframe.chibistand
		dc.b $FF
		even
unk_2052D2:
		dc.b $3F
		dc.b playframe.lookback
		dc.b $FF
		even
unk_2052D6:
		dc.b 3
		dc.b playframe.sneeze1
		dc.b playframe.sneeze1
		dc.b playframe.sneeze1
		dc.b playframe.sneeze1
		dc.b playframe.sneeze1
		dc.b playframe.sneeze3
		dc.b playframe.sneeze3
		dc.b playframe.sneeze2
		dc.b playframe.sneeze2
		dc.b playframe.sneeze2
		dc.b playframe.stand
		dc.b playframe.sneeze4
		dc.b playframe.sneeze4
		dc.b $FD, 5
		even
unk_2052E6:
		dc.b 9
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere1
		dc.b playframe.outofhere2
		dc.b playframe.outofhere2
		dc.b playframe.outofhere2
		dc.b playframe.outofhere2
		dc.b playframe.outofhere3
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere4
		dc.b playframe.outofhere5
		dc.b playframe.outofhere5
		dc.b playframe.outofhere5
		dc.b playframe.outofhere5
		dc.b playframe.outofhere6
		dc.b playframe.outofhere6
		dc.b playframe.outofhere6
		dc.b playframe.outofhere6
		dc.b playframe.outofhere7
		dc.b $FE, 1
		even
unk_20530C:
		dc.b 4
		dc.b playframe.hang1
		dc.b playframe.hang2
		dc.b $FF
		even
unk_205310:
		dc.b $FC
		dc.b playframe.spin1
		dc.b playframe.spin2
		dc.b playframe.spin3
		dc.b playframe.spin6
		dc.b playframe.spin4
		dc.b playframe.spin5
		dc.b $FF
		even
unk_205318:
		dc.b $FF
		dc.b playframe.walkwater3
		dc.b playframe.walkwater4
		dc.b playframe.walkwater5
		dc.b playframe.walkwater6
		dc.b playframe.walkwater1
		dc.b playframe.walkwater2
		dc.b $FF
		even
unk_205320:
		dc.b $FF
		dc.b playframe.watertunnel1
		dc.b playframe.watertunnel2
		dc.b playframe.watertunnel3
		dc.b $FF
		even
unk_205326:
		dc.b $13
		dc.b $70
		dc.b $6F
		dc.b $70
		dc.b $79
		dc.b $FE, 1
		even
; =============== S U B R O U T I N E =======================================
sub_20532E:
		lea	(byte_FFF766).w,a2
		_cmpi.b	#objid_01,obj.id(a0)
		beq.s	loc_20533E
		lea	(byte_FFF75D).w,a2
loc_20533E:
		moveq	#0,d0
		move.b	obj.frame(a0),d0
		cmp.b	(a2),d0
		beq.s	locret_205392
		move.b	d0,(a2)
		lea	(dplc_player).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		subq.b	#1,d1
		bmi.s	locret_205392
		lea	(playwrtwk).w,a3
		move.b	#1,(byte_FFF767).w
loc_205368:
		moveq	#0,d2
		move.b	(a2)+,d2
		move.w	d2,d0
		lsr.b	#4,d0
		lsl.w	#8,d2
		move.b	(a2)+,d2
		lsl.w	#5,d2
		lea	(cg_player).l,a1
		adda.l	d2,a1
loc_20537E:
		movem.l (a1)+,d2-d6/a4-a6
		movem.l d2-d6/a4-a6,(a3)
		lea	$20(a3),a3
		dbf	d0,loc_20537E
		dbf	d1,loc_205368
locret_205392:
		rts
; End of function sub_20532E
; =============== S U B R O U T I N E =======================================
sub_205394:
		moveq	#0,d0
		move.b	obj.field_3D(a0),d0
		lsl.w	#6,d0
		addi.l	#actwk&$FFFFFF,d0
		movea.l d0,a1
		_cmpi.b	#objid_1E,obj.id(a1)
		bne.s	locret_2053FE
		move.b	#1,obj.ani(a1)
		move.w	obj.xpos(a1),d1
		move.w	obj.ypos(a1),d2
		addi.w	#$18,d2
		sub.w	obj.xpos(a0),d1
		sub.w	obj.ypos(a0),d2
		jsr	(calcangle).l
		moveq	#0,d2
		move.b	obj.field_19(a1),d2
		move.w	obj.xpos(a0),d3
		sub.w	obj.xpos(a1),d3
		add.w	d2,d3
		btst	#0,obj.status(a1)
		bne.s	loc_2053EC
		move.w	#$40,d1
		sub.w	d3,d1
		move.w	d1,d3
loc_2053EC:
		move.w	#-$A00,d2
		move.w	d2,d1
		ext.l	d1
		muls.w	d3,d1
		divs.w	#$40,d1
		add.w	d1,d2
		moveq	#0,d1
locret_2053FE:
		rts
; End of function sub_205394