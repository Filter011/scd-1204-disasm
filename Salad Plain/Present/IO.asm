sw_init:				;port initial
	bsr.w	z80bus_on
	moveq	#$40,d0			;set TH out
	move.b	d0,cont_1
	move.b	d0,cont_2
	move.b	d0,cont_3
	bra.w	z80bus_off

read_sw:
	lea	swdata1.w,a0		;switch data store address
	lea	port_1,a1		;port for p1
	bsr.s	.rs_0
	addq.w	#2,a1			;a1 = port_2

;
.rs_0:
	move.b	#$0,(a1)		;set TH = 0
	nop
	nop
	move.b	(a1),d0			;input data when TH = 0
	lsl.b	#2,d0			;chane data when TH = 0 & wait
	andi.b	#%11000000,d0		;chane data when TH = 0 & wait
	move.b	#$40,(a1)		;set TH = 1
	nop
	nop
	move.b	(a1),d1			;input data when TH = 1
	andi.b	#%00111111,d1
	or.b	d1,d0
	not.b	d0			;push -> 1
	move.b	(a0),d1			;copy
	eor.b	d0,d1
	move.b	d0,(a0)+		; switch data
	and.b	d0,d1
	move.b	d1,(a0)+		;switch edge data
	rts