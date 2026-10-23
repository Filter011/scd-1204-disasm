dma68k:	macro	src,ram,type
	lea	vdp_cmd,a5
	move.l	#($9400+(((src_end-src)/2)&$FF00)>>8)<<16+$9300+((src_end-src)/2)&$FF,(a5)
	move.l	#($9600+((src/2)&$FF00)>>8)<<16+$9500+(src/2)&$FF,(a5)
	move.w	#$9700+((src/2)&$7F0000)>>16,(a5)
	move.w	#ram<<12+((type)&$3FFF),(a5)
	move.w	#$80+(((type)&$C000)>>14),dmastack.w
	move.w	dmastack.w,(a5)
	endm

; ---------------------------------------------------------------------------
; incbin compatibility macro for AS
; ---------------------------------------------------------------------------

incbin:	macro path
	binclude path
	endm