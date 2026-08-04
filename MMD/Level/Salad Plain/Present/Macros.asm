DMA68K		macro	src,len,ram,type
		lea	(vdpctrl).l,a5
		move.l	#($9400+((len/2)&$FF00)>>8)<<16+$9300+(len/2)&$FF,(a5)
		move.l	#($9600+((src/2)&$FF00)>>8)<<16+$9500+(src/2)&$FF,(a5)
		move.w	#$9700+((src/2)&$7F0000)>>16,(a5)
		move.w	#ram<<12+((type)&$3FFF),(a5)
		move.w	#$80+(((type)&$C000)>>14),(word_FFF640).w
		move.w	(word_FFF640).w,(a5)
		endm

; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdpctrl).l)
; ---------------------------------------------------------------------------

writeVRAM:	macro loc,controlport=(vdpctrl).l
		move.l	#($40000000+(((loc)&$3FFF)<<16)+(((loc)&$C000)>>14)),controlport
		endm

; ---------------------------------------------------------------------------
; Set a CRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdpctrl).l)
; ---------------------------------------------------------------------------

writeCRAM:	macro loc=0,controlport=(vdpctrl).l
		move.l	#$C0000000+(loc<<16),controlport
		endm

; ---------------------------------------------------------------------------
; Set a VSRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is (vdpctrl).l)
; ---------------------------------------------------------------------------

writeVSRAM:	macro loc=0,controlport=(vdpctrl).l
		move.l	#$40000010+(loc<<16),controlport
		endm

; ---------------------------------------------------------------------------
; incbin compatibility macro for AS
; ---------------------------------------------------------------------------

incbin:		macro path
		binclude path
		endm