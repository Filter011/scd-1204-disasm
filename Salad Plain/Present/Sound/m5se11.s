;********************************************************
;*		$$$SE.S		( SOUND S.E FILE )	*
;*  			ORG. M5SE13.S               	*
;*		'SOUND-SORCE'                           *
;*		 for Mega Drive (Z80)			*
;*			VER  1.31/1989.12.10		*
;*				BY        T.Uwabo       *
;********************************************************
;===========================================
;<<<<<<<< S.E ADDRESS TABLE         >>>>>>>>
;===========================================
SETB:
	DEFW	S90
	DEFW	S91
	DEFW	S92
	DEFW	S93
	DEFW	S94
	DEFW	S95
	DEFW	S96
	DEFW	S97
	DEFW	S98
	DEFW	S99
	DEFW	S9A
	DEFW	S9B
	DEFW	S9C
	DEFW	S9D
	DEFW	S9E
	DEFW	S9F
	DEFW	SA0
	DEFW	SA1
	DEFW	SA2
	DEFW	SA3
	DEFW	SA4
	DEFW	SA5
	DEFW	SA6
	DEFW	SA7
	DEFW	SA8
	DEFW	SA9
	DEFW	SAA


;===========================================
;<<<<<<<<<<< PLIOLTY TABLE >>>>>>>>>>>>>>>>>
;===========================================
PLTB:
	db	1, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
	db	7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
S90:	dw	TIMB90
	db	1,2
	HD	80h,6,TAB900,0F4h,0Ch
	HD	80h,5,byte_B73,0F4h,0Ch
TAB900:
	db	FEV,0
	db	0AFh,1
	db	80h
	db	0AFh
	db	80h,3
byte_B69:
	db	0AFh,1
	db	80h,1
	db	CMREPT,0,0Bh
	dw	byte_B69
	db	CMEND
byte_B73:
	db	FEV,0
	db	80h,1
	db	0ADh
	db	80h
	db	0ADh
	db	80h,3
byte_B7C:
	db	0ADh,1
	db	80h,1
	db	CMREPT,0,0Bh
	dw	byte_B7C
	db	CMEND
TIMB90:
	db	7
	db	8,8,8,8,1Fh,1Fh,1Fh,1Fh,0,0,0,0
	db	0,0,0,0,0Fh,0Fh,0Fh,0Fh,88h,88h,88h,80h
S91:	dw	TIMB91
	db	1,2
	HD	80h,6,byte_BAF,0,0Ah
	HD	80h,5,byte_BC9,0,0
byte_BAF:
	db	FEV,0
	db	FVR,1,1,20h,8
	db	80h,0Ah
byte_BB8:
	db	88h,0Fh
	db	CMREPT,0,3
	dw	byte_BB8
byte_BBF:
	db	88h,0Ah
	db	CMVADD,5
	db	CMREPT,0,6
	dw	byte_BBF
	db	CMEND
byte_BC9:
	db	FEV,1
	db	FVR,1,1,0C5h,1Ah
	db	0CDh,7
	db	CMBIAS,0Ch
	db	CMVADD,9
	db	FEV,2
	db	FVR,3,1,9,0FFh
	db	0CAh,25h
	db	FVR,0,1,0,0
byte_BE4:
	db	CMTAB
	db	CMVADD,1
	db	0CBh,2
	db	CMREPT,0,2Ah
	dw	byte_BE4
	db	CMEND
TIMB91:
	db	0FAh
	db	21h,30h,10h,32h,1Fh,1Fh,1Fh,1Fh,5,18h,9,2
	db	6,0Fh,6,2,1Fh,2Fh,4Fh,2Fh,0Fh,1Ah,0Eh,80h
	db	0FDh
	db	9,3,0,0,1Fh,1Fh,1Fh,1Fh,10h,0Ch,0Ch,0Ch
	db	0Bh,1Fh,10h,5,1Fh,2Fh,4Fh,2Fh,9,80h,8Eh,88h
	db	3Ch
	db	0,44h,2,2,1Fh,1Fh,1Fh,15h,0,1Fh,0,0
	db	0,0,0,0,0Fh,0Fh,0Fh,0Fh,0Dh,80h,28h,80h
S92:	dw	byte_C50
	db	1,1
	HD	80h,6,byte_C44,0EAh,0Eh
byte_C44:
	db	FEV,0
	db	0A4h,5
	db	FVR,2,1,33h,0FFh
	db	0ABh,15h
	db	CMEND
byte_C50:
	db	47h
	db	0Ah,0Ah,0Ah,0Ah,1Fh,1Fh,1Fh,1Fh,0,0,0,0
	db	0,0,0,0,0FFh,0FFh,0FFh,0FFh,81h,81h,81h,81h
S93:	dw	byte_C82
	db	1,1
	HD	80h,6,byte_C73,0F4h,0
byte_C73:
	db	FEV,0
	db	0B0h,7
	db	CMTAB,0ADh
byte_C79:
	db	1
	db	CMVADD,1
	db	CMREPT,0,2Fh
	dw	byte_C79
	db	CMEND
byte_C82:
	db	30h
	db	30h,30h,30h,30h,9Eh,0D8h,0DCh,0DCh,0Eh,0Ah,4,5
	db	8,8,8,8,0BFh,0BFh,0BFh,0BFh,14h,3Ch,14h,80h
S94:	dw	byte_CC3
	db	1,2
	HD	80h,5,byte_CAB,0,5
	HD	80h,6,byte_CB7,0,8
byte_CAB:
	db	FEV,0
	db	0C6h,2,5,5,5,5,5,5,3Ah
	db	CMEND
byte_CB7:
	db	FEV,0
	db	80h,2,0C4h,2,5,15h,2,5,32h
	db	CMEND
byte_CC3:
	db	4
	db	37h,72h,77h,49h,1Fh,1Fh,1Fh,1Fh,7,0Ah,7,0Dh
	db	0,0Bh,0,0Bh,1Fh,0Fh,1Fh,0Fh,23h,80h,23h,80h
S95:	dw	byte_CF2
	db	1,1
	HD	80h,6,byte_CE6,0,5
byte_CE6:
	db	0F3h
	db	FEV,0
	db	LRPAN,40h
	db	0C1h,5,0C4h,5,0C9h,1Bh
	db	CMEND
byte_CF2:
	db	4
	db	37h,72h,77h,49h,1Fh,1Fh,1Fh,1Fh,7,0Ah,7,0Dh
	db	0,0Bh,0,0Bh,1Fh,0Fh,1Fh,0Fh,23h,80h,23h,80h
S96:	dw	byte_D2A
	db	1,2
	HD	80h,5,byte_D1B,0,0
	HD	80h,6,byte_D25,0,0Bh
byte_D1B:
	db	FVR,3,1,72h,0Bh
	db	FEV,0
	db	0BAh,16h
	db	CMEND
byte_D25:
	db	FEV,1
	db	0B0h,13h
	db	CMEND
byte_D2A:
	db	3Ch
	db	0Fh,1,3,1,1Fh,1Fh,1Fh,1Fh,19h,12h,19h,0Eh
	db	5,12h,0,0Fh,0Fh,7Fh,0FFh,0FFh,0,80h,0,80h
	db	3Ch
	db	0Fh,0,0,0,1Fh,1Ah,18h,1Ch,17h,11h,1Ah,0Eh
	db	0,0Fh,14h,10h,1Fh,9Fh,9Fh,2Fh,7,80h,26h,80h
S97:	dw	byte_D70
	db	1,1
	HD	80h,6,byte_D66,0Ch,0
byte_D66:
	db	FEV,0
	db	80h,1,0A3h,5,CMTAB,0A4h,26h
	db	CMEND
byte_D70:
	db	30h
	db	30h,30h,30h,30h,9Eh,0A8h,0ACh,0DCh,0Eh,0Ah,4,5
	db	8,8,8,8,0BFh,0BFh,0BFh,0BFh,4,2Ch,14h,80h
S98:	dw	byte_DAC
	db	1,1
	HD	80h,6,byte_D93,0,2
byte_D93:
	db	FEV,0
	db	80h,1
	db	FVR,3,1,5Dh,0Fh
	db	0B0h,0Ah
	db	0F1h
	db	FEV,1
byte_DA1:
	db	0BDh,2
	db	CMVADD,1
	db	CMTAB
	db	CMREPT,0,19h
	dw	byte_DA1
	db	CMEND
byte_DAC:
	db	20h
	db	36h,35h,30h,31h,0DFh,0DFh,9Fh,9Fh,7,6,9,6
	db	7,6,6,8,2Fh,1Fh,1Fh,0FFh,16h,30h,13h,80h
	db	20h
	db	31h,33h,30h,31h,9Fh,9Fh,9Fh,9Fh,7,6,9,6
	db	7,6,6,8,2Fh,1Fh,1Fh,0FFh,19h,23h,11h,80h
S99:	dw	byte_DED
	db	1,1
	HD	80h,6,byte_DE8,0,0
byte_DE8:
	db	FEV,0
	db	0B5h,2
	db	CMEND
byte_DED:
	db	7
	db	0Ah,0Ah,0Ah,0Ah,1Fh,1Fh,1Fh,1Fh,0,0,0,0
	db	0,0,0,0,0Fh,0Fh,0Fh,0Fh,88h,88h,88h,88h
S9A:	dw	byte_E36
	db	1,3
	HD	80h,2,byte_E2C,0F5h,8
	HD	80h,5,byte_E25,0,0
	HD	80h,6,byte_E1C,0,0
byte_E1C:
	db	FEV,0
	db	8Ah,8,80h,2,8Ah,8
	db	CMEND
byte_E25:
	db	FEV,1
	db	80h,12h,0C6h,55h
	db	CMEND
byte_E2C:
	db	FEV,2
	db	80h,2,0C2h,5,4,5,4
	db	CMEND
byte_E36:
	db	3Bh
	db	3,2,3,6,18h,1Ah,1Ah,96h,17h,0Eh,0Ah,10h
	db	0,0,0,0,0FFh,0FFh,0FFh,0FFh,0,28h,39h,80h
	db	4
	db	37h,72h,77h,49h,1Fh,1Fh,1Fh,1Fh,7,0Ah,7,0Dh
	db	0,0Bh,0,0Bh,1Fh,0Fh,1Fh,0Fh,23h,80h,23h,80h
	db	3Ch
	db	0Fh,0,0,0,1Fh,1Ah,18h,1Ch,17h,11h,1Ah,0Eh
	db	0,0Fh,14h,10h,1Fh,9Fh,9Fh,2Fh,7,80h,26h,8Ch
S9B:	dw	byte_EA2
	db	1,1
	HD	80h,6,byte_E8B,0,5
byte_E8B:
	db	FEV,0
	db	80h,1
	db	FVR,3,1,9,0FFh
	db	0CAh,25h
	db	0F1h
byte_E97:
	db	CMTAB
	db	CMVADD,1
	db	0D1h,2
	db	CMREPT,0,2Ah
	dw	byte_E97
	db	CMEND
byte_EA2:
	db	3Ch
	db	0,44h,2,2,1Fh,1Fh,1Fh,15h,0,1Fh,0,0
	db	0,0,0,0,0Fh,0Fh,0Fh,0Fh,0Dh,80h,28h,80h
S9C:	dw	byte_EDA
	db	1,1
	HD	80h,6,byte_EC5,0,5
byte_EC5:
	db	FEV,0
	db	80h,1
	db	FVR,3,1,6,0FFh
	db	0CAh,39h
	db	0F1h
	db	CMVADD,2
byte_ED3:
	db	CMTAB
	db	0D1h,2
	db	CMJUMP
	dw	byte_ED3
	db	CMEND
byte_EDA:
	db	3Ch
	db	0,44h,2,2,1Fh,1Fh,1Fh,15h,0,1Fh,0,0
	db	0,0,0,0,0Fh,0Fh,0Fh,0Fh,0Dh,80h,28h,80h
S9D:	dw	byte_F11
	db	1,2
	HD	80h,5,byte_F03,27h,3
	HD	80h,6,byte_F05,27h,0
byte_F03:
	db	80h,4
byte_F05:
	db	FEV,0
byte_F07:
	db	0B4h,5
	db	CMVADD,4
	db	CMREPT,0,8
	dw	byte_F07
	db	CMEND
byte_F11:
	db	0F4h
	db	6,4,0Fh,0Eh,1Fh,1Fh,1Fh,1Fh,0,0,0Bh,0Bh
	db	0,0,5,8,0Fh,0Fh,0FFh,0FFh,0Ch,85h,0,80h
S9E:	dw	byte_F50
	db	1,2
	HD	80h,5,byte_F3A,10h,2
	HD	80h,6,byte_F4B,0,2
byte_F3A:
	db	FEV,0
	db	FVR,3,1,20h,4
byte_F41:
	db	81h,0Eh
	db	CMVADD,0Eh
	db	CMREPT,0,4
	dw	byte_F41
	db	CMEND
byte_F4B:
	db	FEV,1
	db	0B0h,13h
	db	CMEND
byte_F50:
	db	0F9h
	db	21h,30h,10h,32h,1Fh,1Fh,1Fh,1Fh,5,18h,9,2
	db	0Bh,1Fh,10h,5,1Fh,2Fh,4Fh,2Fh,0Eh,6,4,80h
	db	3Ch
	db	0Fh,0,0,0,1Fh,1Ah,18h,1Ch,17h,11h,1Ah,0Eh
	db	0,0Fh,14h,10h,1Fh,9Fh,9Fh,2Fh,7,80h,26h,80h
S9F:	dw	byte_F9C
	db	1,2
	HD	80h,5,byte_F92,0,3
	HD	80h,6,byte_F97,0,5
byte_F92:
	db	FEV,0
	db	0BAh,15h
	db	CMEND
byte_F97:
	db	FEV,1
	db	0BAh,10h
	db	CMEND
byte_F9C:
	db	7
	db	3,3,2,0,6Fh,4Fh,6Fh,3Fh,12h,11h,14h,0Eh
	db	1Ah,3,0Ah,0Dh,0FFh,0FFh,0FFh,0FFh,83h,86h,86h,80h
	db	3Ch
	db	0Fh,0,0,0,1Fh,1Ah,18h,1Ch,17h,11h,1Ah,0Eh
	db	0,0Fh,14h,10h,1Fh,9Fh,9Fh,2Fh,7,80h,16h,80h
SA0:	dw	byte_FDD
	db	1,1
	HD	80h,6,byte_FD8,0,0
byte_FD8:
	db	FEV,0
	db	97h,15h
	db	CMEND
byte_FDD:
	db	3Ch
	db	5,0,0,0,1Fh,1Fh,1Fh,1Fh,0,0Fh,15h,11h
	db	0,0Ch,0,0Ah,0Fh,0EFh,0FFh,0EFh,5,80h,0,80h
SA1:	dw	byte_100B
	db	1,1
	HD	80h,6,byte_1000,10h,0Ah
byte_1000:
	db	FEV,0
	db	0C0h,3,80h,2
	db	0D0h,3,80h,2
	db	CMEND
byte_100B:
	db	0F9h
	db	21h,30h,10h,32h,1Fh,1Fh,1Fh,1Fh,5,18h,9,2
	db	0Bh,1Fh,10h,5,1Fh,2Fh,4Fh,2Fh,0Ch,6,4,80h
SA2:	dw	byte_104D
	db	1,2
	HD	80h,5,byte_1034,10h,8
	HD	80h,6,byte_1047,0,0
byte_1034:
	db	FEV,0
	db	FVR,3,1,20h,4
	db	81h,6
byte_103D:
	db	81h,0Eh
	db	CMVADD,0Eh
	db	CMREPT,0,4
	dw	byte_103D
	db	CMEND
byte_1047:
	db	FEV,1
	db	0A6h,6,14h
	db	CMEND
byte_104D:
	db	0F9h
	db	21h,30h,10h,32h,1Ch,1Fh,1Fh,10h,5,18h,9,2
	db	0Bh,1Fh,10h,5,1Fh,2Fh,4Fh,2Fh,0Ch,6,4,80h
	db	0
	db	0,3,2,0,0D9h,0DFh,1Fh,1Fh,12h,11h,14h,0Fh
	db	0Ah,0,0Ah,0Dh,0FFh,0FFh,0FFh,0FFh,22h,7,27h,80h
SA3:	dw	byte_10B1
	db	1,3
	HD	80h,2,byte_1095,10h,5
	HD	80h,5,byte_109C,10h,5
	HD	80h,6,byte_10A0,0,5
byte_1095:
	db	LRPAN,40h
	db	80h,2
	db	CMJUMP
	dw	byte_10A0
byte_109C:
	db	LRPAN,80h
	db	80h,1
byte_10A0:
	db	FEV,0
	db	FVR,3,1,20h,4
byte_10A7:
	db	81h,18h
	db	CMVADD,0Ah
	db	CMREPT,0,6
	dw	byte_10A7
	db	CMEND
byte_10B1:
	db	0F9h
	db	21h,30h,10h,32h,1Fh,1Fh,1Fh,1Fh,5,18h,9,2
	db	0Bh,1Fh,10h,5,1Fh,2Fh,4Fh,2Fh,0Eh,7,4,80h
SA4:	dw	byte_10DC
	db	1,1
	HD	80h,6,byte_10D4,0F4h,0
byte_10D4:
	db	FEV,0
	db	9Bh,4,80h,0A0h,6
	db	CMEND
byte_10DC:
	db	3Ch
	db	0,0,0,0,1Fh,1Fh,1Fh,1Fh,0,16h,0Fh,0Fh
	db	0,0,0,0,0Fh,0AFh,0FFh,0FFh,0,80h,0Ah,80h
SA5:	dw	byte_1104
	db	1,1
	HD	80h,6,byte_10FF,0,8
byte_10FF:
	db	FEV,0
	db	0C0h,0Bh
	db	CMEND
byte_1104:
	db	3Dh
	db	1,3,3,3,14h,0Eh,0Eh,0Dh,8,35h,2,91h
	db	0,50h,60h,56h,1Fh,1Fh,1Fh,1Fh,18h,82h,97h,80h
SA6:	dw	byte_113E
	db	1,1
	HD	80h,4,byte_1127,0,0Dh
byte_1127:
	db	FEV,0
	db	0D0h,2
	db	CMTAB,1
	db	TIMER_ADD,2Bh,11h
byte_1130:
	db	CMTAB,1
	db	CMVADD,1
	db	CMREPT,0,22h
	dw	byte_1130
	db	80h,1
	db	SET_TFLG,0
	db	CMEND
byte_113E:
	db	38h
	db	0Fh,0Fh,0Fh,0Fh,1Fh,1Fh,1Fh,0Eh,0,0,0,0
	db	0,0,0,0,0Fh,0Fh,0Fh,1Fh,0,0,0,80h
SA7:	dw	byte_1167
	db	1,1
	HD	80h,6,byte_1161,0,3
byte_1161:
	db	FEV,0
	db	0BAh,6,15h
	db	CMEND
byte_1167:
	db	2
	db	3,0,0,0,0Fh,0Fh,0Fh,12h,12h,11h,14h,0Fh
	db	0FAh,0F3h,0FAh,0FDh,0FFh,0FFh,0FFh,0FFh,5,19h,5,83h
SA8:	dw	byte_1195
	db	1,1
	HD	80h,6,byte_118A,0,5
byte_118A:
	db	FEV,0
	db	LRPAN,80h
	db	0C1h,5
	db	0C4h,5
	db	0C9h,1Bh
	db	CMEND
byte_1195:
	db	4
	db	37h,72h,77h,49h,1Fh,1Fh,1Fh,1Fh,7,0Ah,7,0Dh
	db	0,0Bh,0,0Bh,1Fh,0Fh,1Fh,0Fh,23h,80h,23h,80h
SA9:	dw	byte_11FD
	db	1,2
	HD	80h,1,byte_11BE,0,9
	HD	80h,2,byte_11D7,5,6
byte_11BE:
	db	FEV,0
	db	FVR,1,1,0Ah,7
	db	0AFh,60h
	db	CMTAB
	db	TIMER_ADD,0C5h,11h
byte_11CB:
	db	1
	db	CMVADD,1,CMTAB
	db	CMREPT,0,14h
	dw	byte_11CB
	db	SET_TFLG,0
	db	CMEND
byte_11D7:
	db	FEV,1
	db	0C8h,7,0C9h,0CAh,0CBh,0CCh,0CBh,0CAh,0C9h
	db	TIMER_ADD,0D9h,11h
	db	0C8h
	db	7
	db	CMVADD
	db	2
	db	0C9h
	db	CMVADD
	db	2
	db	0CAh
	db	CMVADD
	db	2
	db	0CBh
	db	CMVADD
	db	2
	db	0CCh
	db	CMVADD
	db	2
	db	0CBh
	db	CMVADD
	db	2
	db	0CAh
	db	CMVADD
	db	2
	db	0C9h
	db	CMEND
byte_11FD:
	db	8
	db	0Ah,70h,30h,0,0Bh,0Ah,4Fh,3Fh,3,3,3,3
	db	0,0,0,1,0Fh,0Fh,0Fh,0Fh,21h,2Dh,11h,80h
	db	24h
	db	4,31h,11h,52h,1Ah,9Ch,95h,98h,4,6,0Eh,18h
	db	1,4,0,3,4Fh,8Fh,2Fh,1Fh,19h,8Ah,16h,8Ah
SAA:	dw	byte_1242
	db	1,1
	HD	80h,6,byte_1239,0FDh,0
byte_1239:
	db	FEV,0
	db	0B0h,4,80h,1,0C1h,3
	db	CMEND
byte_1242:
	db	83h
	db	0Ch,10h,13h,1Fh,1Fh,1Fh,1Fh,1Fh,0,0,0,0
	db	2,2,2,2,2Fh,2Fh,0FFh,3Fh,5,10h,34h,85h