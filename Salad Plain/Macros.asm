dma68k:	macro	src,ram,type=0
	lea	vdp_cmd,a5
	move.l	#($9400|(((src_end-src)/2)&$FF00)>>8)<<16|$9300|((src_end-src)/2)&$FF,(a5)
	move.l	#($9600|((src/2)&$FF00)>>8)<<16|$9500|(src/2)&$FF,(a5)
	move.w	#$9700|((src/2)&$7F0000)>>16,(a5)
	move.w	#ram<<12|((type)&$3FFF),(a5)
	move.w	#$80|(((type)&$C000)>>14),dmastack
	move.w	dmastack,(a5)
	endm

dmawrt:	macro	ram,type,adr=vdp_cmd
	move.l	#(type<<28)|(((ram*tile_size)&$3FFF)<<16)|(((ram*tile_size)&$C000)>>14),adr
	endm

dmaclr:	macro	len,ram,type
	lea	vdp_cmd,a5
	move.w	#$8F00|%00000001,(a5)
	move.l	#($9400|((len-1)&$FF00)>>8)<<16|$9300|(len-1)&$FF,(a5)
	move.w	#$9700|%10000000,(a5)
	move.l	#(type<<28)|(((ram)&$3FFF)<<16)|(((ram)&$C000)>>14)|%10000000,(a5)
	move.w	#0,vdp_dat

.loop:
	move.w	(a5),d1
	btst	#1,d1
	bne.s	.loop
	move.w	#$8F00|%00000010,(a5)
	endm

; ---------------------------------------------------------------------------
; incbin compatibility macro for AS
; ---------------------------------------------------------------------------

incbin:	macro path
	binclude path
	endm