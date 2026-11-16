dma68k:	macro	src,ram,type=0
	lea	vdp_cmd,a6
	move.l	#($9300|((src_end-src)/2)&$FF)<<16|$9400|(((src_end-src)/2)>>8)&$FF,(a6)
	move.l	#($9500|((src/2)&$FF))<<16|$9600|((src/2)>>8)&$FF,(a6)
	move.w	#$9700|((src/2)&$7F0000)>>16,(a6)
	move.w	#ram<<12|((type)&$3FFF),(a6)
	move.w	#$80|(((type)&$C000)>>14),-(sp)
	move.w	(sp)+,(a6)
	endm

dmawrt:	macro	ram,type,adr=vdp_cmd
	move.l	#(type<<28)|(((ram)&$3FFF)<<16)|(((ram)&$C000)>>14),adr
	endm

; ---------------------------------------------------------------------------
; incbin compatibility macro for AS
; ---------------------------------------------------------------------------

incbin:	macro path
	binclude path
	endm