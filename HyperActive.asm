; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Hyper Active - 48K Spectrum.
;
; Design, Code, Art and Fuzz Clik programming by Jonathan Smith.
; Musical Scores by Keith Tinman.
;
; Reverse Engineered by Paul "Paulie" Hughes August, 2024.
;
; SpectrumAnalyser https://colourclash.co.uk/spectrum-analyser/
;
;
;

	device zxspectrum48

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Sprite data structure
;

TYP:					equ		0				; sprite type index  ($FF = inactive)
XNO:					equ		1				; x coord
YNO:					equ		3				; y coord
GNO:					equ		4				; graphic index
CNT1:					equ		5				; general purpose counter 1
CNT2:					equ		6				; general purpose counter 2

SPVARLEN:				equ		CNT2+1			; length of sprite data

; Orbitting POD structure

ORB_TYP					equ 	0	
ORB_XNO					equ		1
ORB_YNO					equ 	2	
ORB_GNO					equ 	3
ORB_FLAG				equ		4
ORB_XSPD				equ		5
ORB_YSPD				equ 	6
ORB_XCOUNT				equ 	7
ORB_YCOUNT				equ 	8

;On screen sprite structure
OSS_TYP 				equ 	0
OSS_XNO 				equ		1	
OSS_YNO 				equ		2
OSS_GNO 				equ		3
OSS_SPRLO				equ		4

;Baddy Bullet structure

BB_FLG 					equ 	0
BB_XNO					equ 	1
BB_YNO					equ 	2
BB_XMV					equ 	3
BB_YMV					equ 	4
BB_INT					equ 	5
BB_COW					equ 	6
BB_BIG					equ 	7
BB_XADD					equ 	8
BB_YADD					equ 	9

; particle system structure

PS_PARTICLEX			equ 	0
PS_XDIR					equ 	1
PS_XVEL 				equ 	2
PS_XCOUNT				equ 	3
PS_PARTICLEY			equ 	4
PS_YDIR					equ 	5
PS_YVEL					equ 	6
PS_YCOUNT				equ 	7


;
; TYPes 
;

TYP_POD					equ 	0
;                    equ 	1
TYP_DRAGONLEFT			equ 	2
TYP_DRAGONRIGHT			equ 	3
TYP_MOVEXALIEN			equ 	4
TYP_HOMINGSAUCERX 		equ 	5
TYP_BONUSPICKUP			equ 	6
TYP_BUBBLEALIEN			equ 	7
TYP_HOMINGSAUCERY 		equ 	8
TYP_THROBBINGSAUCER		equ 	9
TYP_SPINNYALIEN			equ 	10
TYP_ACORNALIENUP		equ 	11
TYP_ACORNALIENDOWN		equ 	12

;
;GNOs 
;

GNO_PLAYERLEFT 			equ 	0
GNO_PLAYERFACING 		equ 	1
GNO_PLAYERRIGHT 		equ 	2
GNO_POD 				equ 	3
GNO_DROPBOMB 			equ 	4
GNO_SAUCER 				equ 	5
GNO_DRAGONHEADLEFT 		equ 	6
GNO_DRAGONHEADRIGHT 	equ 	7
GNO_DRAGONBODY 			equ 	8
GNO_HOMINGALIEN 		equ 	9
GNO_ALIEN2 				equ 	10
GNO_BUBBLE 				equ 	11
GNO_BONUS 				equ 	12
GNO_ACORN 				equ 	13
GNO_SPINNY 				equ 	14

;
; Player Weapon Types
;

WEAPON_BULLET:			equ 0
WEAPON_BOMB				equ 1
WEAPON_LASERBOLTS: 		equ	2

; Attract mode LOGO graphics.

LOGO_HYPERACTIVE		equ 0
LOGO_SPECIALFX			equ 1
LOGO_HYSTERIA			equ 2
LOGO_FIREFLY			equ 3
LOGO_GUTZ				equ 4

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; "Sprint" commands
;

AT:			EQU $00
DIR:		EQU $01
MODE:		EQU $02
TAB:		EQU $03
REP:		EQU $04
PEN:		EQU $05
CHR:		EQU $06
RSET:		EQU $07
JSR:		EQU $08
JSRS:		EQU $09
CLS:		EQU $0a
CLA:		EQU $0b
EXPD:		EQU $0c
RTN:		EQU $0d
CUR:		EQU $0e
FOR:		EQU $0f
NEXT:		EQU $10
TABX:		EQU $11
XTO:		EQU $12
YTO:		EQU $13
EXOFF:		EQU $14

UP:			EQU 0
UP_RIGHT:	EQU 1
RIGHT:		EQU 2
DW_RIGHT:	EQU 3
DOWN:		EQU 4
DOWN_LEFT:	EQU 5
LEFT:		EQU 6
UP_LEFT:	EQU 7

S:			EQU 128
B:			EQU 64

EXPN:		EQU 1
NINK:		EQU 255

NORM:		equ 0
OVER:		equ	1
ORON:		equ 2
INVR:		equ 3

FIN:		equ $ff

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

SCRNADDR:	equ		0x4000			; screen
ATTRADDR:	equ		0x5800			; attributes

; colour attributes

BRIGHT:		equ		0x40			
FLASH:		equ		0x80
PAPER:		equ		0x8				; multply PAPER with inks to get paper colour
WHITE:		equ		0x7				; ink colours
YELLOW:		equ		0x6
CYAN:		equ		0x5
GREEN:		equ		0x4
MAGENTA:	equ		0x3
RED:		equ		0x2
BLUE:		equ		0x1
BLACK:		equ		0x0

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

	org $68d8
	
gfx_Gutz:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3E 
	db $FC 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $C1 
	db $03 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $3C 
	db $3C 
	db $3E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $09 
	db $FE 
	db $7F 
	db $C1 
	db $E0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $17 
	db $C6 
	db $65 
	db $FE 
	db $1E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0F 
	db $80 
	db $17 
	db $3A 
	db $5A 
	db $1F 
	db $E1 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $40 
	db $16 
	db $EA 
	db $6B 
	db $E9 
	db $FE 
	db $30 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $87 
	db $40 
	db $16 
	db $FB 
	db $CB 
	db $FF 
	db $8F 
	db $CE 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $3F 
	db $20 
	db $15 
	db $7A 
	db $5B 
	db $FF 
	db $77 
	db $F1 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $FB 
	db $A0 
	db $15 
	db $7B 
	db $DA 
	db $FF 
	db $9D 
	db $FE 
	db $78 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C1 
	db $E6 
	db $A0 
	db $15 
	db $72 
	db $59 
	db $6D 
	db $E7 
	db $9F 
	db $06 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $03 
	db $33 
	db $7B 
	db $A0 
	db $15 
	db $F6 
	db $7D 
	db $E3 
	db $7F 
	db $E7 
	db $39 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $D2 
	db $BF 
	db $A0 
	db $14 
	db $F6 
	db $6F 
	db $EC 
	db $BF 
	db $FB 
	db $26 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 
	db $33 
	db $3E 
	db $FB 
	db $A0 
	db $14 
	db $77 
	db $EF 
	db $57 
	db $9E 
	db $FD 
	db $F9 
	db $98 
	db $00 
	db $00 
	db $00 
	db $00 
	db $CD 
	db $73 
	db $FB 
	db $A0 
	db $16 
	db $F6 
	db $6F 
	db $6D 
	db $3B 
	db $ED 
	db $3F 
	db $66 
	db $00 
	db $00 
	db $00 
	db $03 
	db $33 
	db $7F 
	db $7D 
	db $A0 
	db $16 
	db $F6 
	db $6F 
	db $B2 
	db $BD 
	db $ED 
	db $37 
	db $F9 
	db $80 
	db $00 
	db $00 
	db $04 
	db $F5 
	db $D3 
	db $BD 
	db $A0 
	db $16 
	db $F6 
	db $16 
	db $FC 
	db $0F 
	db $DD 
	db $3F 
	db $FE 
	db $60 
	db $00 
	db $00 
	db $1B 
	db $E7 
	db $52 
	db $67 
	db $A0 
	db $16 
	db $F2 
	db $E3 
	db $3C 
	db $1F 
	db $FB 
	db $F7 
	db $DF 
	db $90 
	db $00 
	db $00 
	db $27 
	db $47 
	db $52 
	db $AF 
	db $A0 
	db $16 
	db $FA 
	db $9C 
	db $CE 
	db $8E 
	db $3D 
	db $37 
	db $F9 
	db $EC 
	db $00 
	db $00 
	db $D9 
	db $8A 
	db $D2 
	db $E3 
	db $A0 
	db $14 
	db $FA 
	db $83 
	db $2F 
	db $CD 
	db $CF 
	db $3F 
	db $EE 
	db $F2 
	db $00 
	db $01 
	db $34 
	db $37 
	db $5E 
	db $F3 
	db $A0 
	db $15 
	db $FA 
	db $80 
	db $9E 
	db $FD 
	db $F1 
	db $37 
	db $F7 
	db $FD 
	db $80 
	db $06 
	db $CF 
	db $E3 
	db $D2 
	db $F1 
	db $A0 
	db $15 
	db $FA 
	db $80 
	db $AF 
	db $ED 
	db $FF 
	db $33 
	db $9D 
	db $BE 
	db $40 
	db $09 
	db $FF 
	db $D7 
	db $D2 
	db $E1 
	db $A0 
	db $15 
	db $F6 
	db $80 
	db $AE 
	db $D7 
	db $B7 
	db $FD 
	db $EF 
	db $8F 
	db $B0 
	db $17 
	db $BB 
	db $FF 
	db $9F 
	db $F1 
	db $A0 
	db $15 
	db $F6 
	db $80 
	db $AF 
	db $85 
	db $0E 
	db $2F 
	db $FF 
	db $E5 
	db $C8 
	db $2F 
	db $7C 
	db $F7 
	db $33 
	db $AB 
	db $A0 
	db $15 
	db $F2 
	db $80 
	db $AE 
	db $E3 
	db $71 
	db $A7 
	db $FF 
	db $FF 
	db $F4 
	db $2C 
	db $DE 
	db $FC 
	db $E3 
	db $9B 
	db $A0 
	db $16 
	db $FA 
	db $80 
	db $AE 
	db $E7 
	db $4F 
	db $59 
	db $5F 
	db $BF 
	db $9A 
	db $4B 
	db $AB 
	db $FB 
	db $82 
	db $AB 
	db $A0 
	db $16 
	db $FA 
	db $80 
	db $AE 
	db $F7 
	db $40 
	db $47 
	db $33 
	db $7F 
	db $EA 
	db $5B 
	db $F5 
	db $E6 
	db $03 
	db $F7 
	db $A0 
	db $16 
	db $FA 
	db $80 
	db $B7 
	db $AF 
	db $40 
	db $30 
	db $CF 
	db $EF 
	db $F5 
	db $57 
	db $43 
	db $38 
	db $03 
	db $DF 
	db $A0 
	db $14 
	db $72 
	db $80 
	db $B7 
	db $E7 
	db $40 
	db $0E 
	db $32 
	db $FD 
	db $F5 
	db $57 
	db $85 
	db $60 
	db $03 
	db $CF 
	db $A0 
	db $15 
	db $76 
	db $80 
	db $B7 
	db $87 
	db $40 
	db $01 
	db $8F 
	db $AA 
	db $F5 
	db $57 
	db $0E 
	db $80 
	db $03 
	db $AB 
	db $A0 
	db $15 
	db $F6 
	db $80 
	db $AF 
	db $43 
	db $40 
	db $00 
	db $63 
	db $D5 
	db $F5 
	db $5F 
	db $D3 
	db $00 
	db $03 
	db $27 
	db $A0 
	db $15 
	db $F6 
	db $80 
	db $AF 
	db $A3 
	db $40 
	db $00 
	db $11 
	db $C1 
	db $F5 
	db $5D 
	db $CF 
	db $00 
	db $03 
	db $07 
	db $A0 
	db $75 
	db $FE 
	db $80 
	db $AF 
	db $8F 
	db $40 
	db $00 
	db $0D 
	db $A6 
	db $F5 
	db $5D 
	db $F6 
	db $00 
	db $33 
	db $DF 
	db $A3 
	db $86 
	db $FE 
	db $80 
	db $AF 
	db $C3 
	db $40 
	db $00 
	db $09 
	db $D3 
	db $F5 
	db $5E 
	db $EC 
	db $00 
	db $F3 
	db $DF 
	db $AC 
	db $7E 
	db $FE 
	db $80 
	db $B7 
	db $EF 
	db $40 
	db $00 
	db $33 
	db $67 
	db $E5 
	db $56 
	db $EC 
	db $03 
	db $92 
	db $FF 
	db $B3 
	db $FE 
	db $FA 
	db $80 
	db $B7 
	db $FD 
	db $40 
	db $00 
	db $C7 
	db $C2 
	db $ED 
	db $57 
	db $FC 
	db $0F 
	db $7E 
	db $97 
	db $8E 
	db $6E 
	db $FA 
	db $80 
	db $AF 
	db $F5 
	db $40 
	db $03 
	db $1E 
	db $89 
	db $D9 
	db $57 
	db $F8 
	db $1B 
	db $72 
	db $8F 
	db $FD 
	db $EE 
	db $FA 
	db $80 
	db $AF 
	db $FB 
	db $40 
	db $0C 
	db $7F 
	db $DD 
	db $B1 
	db $57 
	db $F8 
	db $3B 
	db $5E 
	db $8B 
	db $FD 
	db $E4 
	db $FA 
	db $80 
	db $AB 
	db $F9 
	db $40 
	db $31 
	db $FA 
	db $6E 
	db $E2 
	db $57 
	db $FC 
	db $7C 
	db $52 
	db $C6 
	db $7A 
	db $F9 
	db $F6 
	db $80 
	db $AB 
	db $F1 
	db $40 
	db $46 
	db $FF 
	db $B5 
	db $C4 
	db $57 
	db $F4 
	db $5C 
	db $D3 
	db $DB 
	db $3A 
	db $FF 
	db $F6 
	db $80 
	db $AB 
	db $79 
	db $40 
	db $49 
	db $7F 
	db $B3 
	db $88 
	db $57 
	db $74 
	db $5F 
	db $F2 
	db $CB 
	db $B9 
	db $FF 
	db $CE 
	db $80 
	db $AB 
	db $D9 
	db $40 
	db $55 
	db $D5 
	db $7F 
	db $10 
	db $56 
	db $EC 
	db $6F 
	db $D2 
	db $83 
	db $5F 
	db $FE 
	db $3C 
	db $80 
	db $AD 
	db $FB 
	db $40 
	db $5D 
	db $EA 
	db $F6 
	db $20 
	db $52 
	db $EC 
	db $6F 
	db $D2 
	db $C5 
	db $DF 
	db $FF 
	db $E1 
	db $00 
	db $AE 
	db $7B 
	db $40 
	db $53 
	db $AB 
	db $EC 
	db $40 
	db $51 
	db $F4 
	db $2F 
	db $D2 
	db $F5 
	db $CF 
	db $FE 
	db $1E 
	db $00 
	db $A7 
	db $FD 
	db $40 
	db $5F 
	db $4A 
	db $D8 
	db $80 
	db $53 
	db $F4 
	db $6F 
	db $D3 
	db $CB 
	db $9F 
	db $E1 
	db $E0 
	db $00 
	db $B8 
	db $7D 
	db $40 
	db $57 
	db $85 
	db $D1 
	db $00 
	db $5F 
	db $B5 
	db $EF 
	db $D3 
	db $BF 
	db $BE 
	db $1E 
	db $00 
	db $00 
	db $87 
	db $8D 
	db $40 
	db $57 
	db $D6 
	db $D2 
	db $00 
	db $5F 
	db $76 
	db $2F 
	db $DF 
	db $5F 
	db $E1 
	db $E0 
	db $00 
	db $00 
	db $78 
	db $3F 
	db $40 
	db $57 
	db $A1 
	db $D3 
	db $00 
	db $5F 
	db $75 
	db $FE 
	db $DF 
	db $FF 
	db $1E 
	db $00 
	db $00 
	db $00 
	db $07 
	db $C1 
	db $40 
	db $57 
	db $E2 
	db $FC 
	db $C0 
	db $5E 
	db $B7 
	db $7D 
	db $D3 
	db $E0 
	db $E0 
	db $00 
	db $00 
	db $10 
	db $00 
	db $3E 
	db $40 
	db $5B 
	db $A1 
	db $55 
	db $20 
	db $5E 
	db $13 
	db $FD 
	db $91 
	db $8F 
	db $00 
	db $00 
	db $00 
	db $10 
	db $00 
	db $01 
	db $80 
	db $5B 
	db $50 
	db $1A 
	db $98 
	db $5E 
	db $82 
	db $7D 
	db $36 
	db $70 
	db $00 
	db $00 
	db $00 
	db $18 
	db $80 
	db $00 
	db $00 
	db $59 
	db $90 
	db $0D 
	db $C4 
	db $5D 
	db $41 
	db $3A 
	db $69 
	db $80 
	db $00 
	db $00 
	db $01 
	db $E8 
	db $80 
	db $00 
	db $00 
	db $5D 
	db $62 
	db $00 
	db $B2 
	db $55 
	db $0B 
	db $79 
	db $C8 
	db $00 
	db $00 
	db $00 
	db $1E 
	db $F8 
	db $80 
	db $00 
	db $00 
	db $5E 
	db $B0 
	db $49 
	db $DA 
	db $5D 
	db $95 
	db $FF 
	db $30 
	db $00 
	db $00 
	db $01 
	db $FF 
	db $DD 
	db $80 
	db $00 
	db $00 
	db $4F 
	db $EC 
	db $E5 
	db $65 
	db $55 
	db $DB 
	db $FC 
	db $C0 
	db $00 
	db $00 
	db $1F 
	db $FB 
	db $BD 
	db $F8 
	db $00 
	db $00 
	db $33 
	db $D5 
	db $77 
	db $B5 
	db $55 
	db $37 
	db $F3 
	db $00 
	db $00 
	db $01 
	db $EF 
	db $C1 
	db $BD 
	db $4F 
	db $00 
	db $00 
	db $0C 
	db $EA 
	db $AA 
	db $F5 
	db $57 
	db $FF 
	db $CC 
	db $00 
	db $00 
	db $1F 
	db $FF 
	db $88 
	db $D8 
	db $FC 
	db $E2 
	db $10 
	db $03 
	db $3F 
	db $F7 
	db $FD 
	db $57 
	db $FF 
	db $30 
	db $00 
	db $00 
	db $E7 
	db $E3 
	db $00 
	db $E0 
	db $EC 
	db $3A 
	db $10 
	db $00 
	db $CC 
	db $FF 
	db $FD 
	db $57 
	db $DC 
	db $C0 
	db $00 
	db $0F 
	db $93 
	db $C1 
	db $00 
	db $F0 
	db $5A 
	db $36 
	db $10 
	db $00 
	db $33 
	db $7F 
	db $F5 
	db $53 
	db $9B 
	db $00 
	db $00 
	db $7B 
	db $01 
	db $C3 
	db $80 
	db $B0 
	db $68 
	db $3E 
	db $1C 
	db $00 
	db $0C 
	db $9D 
	db $F5 
	db $52 
	db $64 
	db $00 
	db $01 
	db $BF 
	db $00 
	db $E7 
	db $80 
	db $B0 
	db $E0 
	db $1C 
	db $17 
	db $00 
	db $03 
	db $25 
	db $F5 
	db $59 
	db $D8 
	db $00 
	db $07 
	db $FE 
	db $00 
	db $F5 
	db $80 
	db $61 
	db $B0 
	db $0C 
	db $0F 
	db $C0 
	db $00 
	db $DE 
	db $F5 
	db $5F 
	db $20 
	db $00 
	db $3F 
	db $E6 
	db $01 
	db $75 
	db $88 
	db $01 
	db $38 
	db $0E 
	db $0F 
	db $F0 
	db $00 
	db $26 
	db $F5 
	db $5E 
	db $C0 
	db $00 
	db $C3 
	db $C7 
	db $01 
	db $33 
	db $00 
	db $01 
	db $18 
	db $16 
	db $0E 
	db $7C 
	db $00 
	db $1B 
	db $6D 
	db $59 
	db $10 
	db $03 
	db $83 
	db $8B 
	db $88 
	db $E0 
	db $00 
	db $00 
	db $98 
	db $17 
	db $06 
	db $7F 
	db $00 
	db $04 
	db $9D 
	db $56 
	db $12 
	db $0F 
	db $01 
	db $93 
	db $88 
	db $00 
	db $00 
	db $00 
	db $70 
	db $13 
	db $07 
	db $33 
	db $C0 
	db $03 
	db $7D 
	db $48 
	db $1C 
	db $3D 
	db $20 
	db $D1 
	db $88 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0E 
	db $1F 
	db $31 
	db $F0 
	db $04 
	db $9D 
	db $50 
	db $0F 
	db $FE 
	db $09 
	db $49 
	db $98 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $23 
	db $79 
	db $FC 
	db $04 
	db $65 
	db $20 
	db $0F 
	db $F6 
	db $09 
	db $67 
	db $38 
	db $00 
	db $10 
	db $00 
	db $04 
	db $00 
	db $26 
	db $BC 
	db $9F 
	db $04 
	db $19 
	db $00 
	db $0F 
	db $26 
	db $11 
	db $E0 
	db $5C 
	db $00 
	db $10 
	db $00 
	db $00 
	db $00 
	db $18 
	db $9C 
	db $CB 
	db $C4 
	db $07 
	db $00 
	db $06 
	db $4E 
	db $00 
	db $C0 
	db $9E 
	db $00 
	db $04 
	db $00 
	db $03 
	db $08 
	db $80 
	db $88 
	db $CF 
	db $FC 
	db $00 
	db $00 
	db $27 
	db $5E 
	db $00 
	db $00 
	db $8E 
	db $21 
	db $00 
	db $00 
	db $01 
	db $80 
	db $00 
	db $70 
	db $6C 
	db $FC 
	db $00 
	db $00 
	db $07 
	db $AC 
	db $00 
	db $00 
	db $4C 
	db $00 
	db $00 
	db $00 
	db $01 
	db $80 
	db $00 
	db $02 
	db $7E 
	db $76 
	db $00 
	db $00 
	db $0B 
	db $BC 
	db $10 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $03 
	db $C0 
	db $00 
	db $00 
	db $22 
	db $32 
	db $00 
	db $00 
	db $09 
	db $98 
	db $10 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $05 
	db $E0 
	db $00 
	db $30 
	db $1C 
	db $3E 
	db $00 
	db $00 
	db $09 
	db $80 
	db $40 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $08 
	db $E0 
	db $00 
	db $00 
	db $00 
	db $2F 
	db $00 
	db $00 
	db $07 
	db $00 
	db $40 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $08 
	db $70 
	db $00 
	db $22 
	db $00 
	db $77 
	db $00 
	db $00 
	db $08 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $08 
	db $00 
	db $00 
	db $28 
	db $B0 
	db $00 
	db $02 
	db $08 
	db $F3 
	db $00 
	db $00 
	db $00 
	db $01 
	db $F0 
	db $00 
	db $01 
	db $04 
	db $00 
	db $10 
	db $06 
	db $60 
	db $C4 
	db $20 
	db $01 
	db $B6 
	db $00 
	db $00 
	db $02 
	db $21 
	db $38 
	db $00 
	db $00 
	db $82 
	db $04 
	db $22 
	db $03 
	db $C0 
	db $00 
	db $00 
	db $11 
	db $B0 
	db $00 
	db $00 
	db $00 
	db $01 
	db $B8 
	db $00 
	db $00 
	db $01 
	db $10 
	db $04 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $90 
	db $08 
	db $00 
	db $08 
	db $10 
	db $08 
	db $00 
	db $01 
	db $00 
	db $04 
	db $01 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $44 
	db $38 
	db $00 
	db $00 
	db $10 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $00 
	db $00 
	db $07 
	db $F0 
	db $00 
	db $7E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $FF 
	db $C0 
	db $7F 
	db $FC 
	db $31 
	db $8F 
	db $9E 
	db $00 
	db $FF 
	db $E0 
	db $00 
	db $3E 
	db $00 
	db $00 
	db $00 
	db $1F 
	db $FF 
	db $FF 
	db $BF 
	db $FF 
	db $FA 
	db $7C 
	db $FF 
	db $FF 
	db $BF 
	db $3F 
	db $83 
	db $FF 
	db $F8 
	db $00 
	db $00 
	db $7E 
	db $3F 
	db $3F 
	db $C3 
	db $DF 
	db $FF 
	db $83 
	db $FF 
	db $FF 
	db $3F 
	db $CF 
	db $FF 
	db $FF 
	db $FE 
	db $00 
	db $00 
	db $61 
	db $00 
	db $07 
	db $FF 
	db $E0 
	db $3B 
	db $FF 
	db $C1 
	db $01 
	db $FB 
	db $FF 
	db $E0 
	db $03 
	db $FB 
	db $00 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $03 
	db $03 
	db $03 
	db $03 
	db $02 
	db $07 
	db $47 
	db $47 
	db $47 
	db $42 
	db $42 
	db $07 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $07 
	db $47 
	db $42 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $47 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $44 
	db $44 
	db $04 
	db $44 
	db $03 
	db $03 
	db $03 
	db $3B 
	db $3B 
	db $03 
	db $03 
	db $03 
	db $03 
	db $04 
	db $04 
	db $04 
	db $06 
	db $04 
	db $04 
	db $06 
	db $06 
	db $04 
	db $44 
	db $43 
	db $03 
	db $03 
	db $03 
	db $04 
	db $04 
	db $04 
	db $06 
	db $44 
	db $04 
	db $04 
	db $44 
	db $44 
	db $44 
	db $44 
	db $44 
	db $04 
	db $04 
	db $03 
	db $04 
	db $04 
	db $44 
	db $44 
	db $44 
	db $44 
	db $44 
	db $44 
	db $44 
	db $44 
	db $06 
	db $04 
	db $44 
	db $06 
	db $06 
	db $44 
	db $47 
	db $04 
	db $04 
	db $46 
	db $06 
	db $06 
	db $06 
	db $44 
	db $04 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $07 
	db $07 
	
gfx_FireflyLogo:
	db $2A 
	db $AA 
	db $AA 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $55 
	db $0A 
	db $A0 
	db $2A 
	db $AA 
	db $A8 
	db $00 
	db $01 
	db $98 
	db $00 
	db $00 
	db $54 
	db $02 
	db $A8 
	db $00 
	db $00 
	db $02 
	db $AA 
	db $A6 
	db $06 
	db $55 
	db $4A 
	db $80 
	db $00 
	db $00 
	db $5F 
	db $FF 
	db $70 
	db $8A 
	db $98 
	db $01 
	db $95 
	db $4A 
	db $1F 
	db $C3 
	db $7C 
	db $3F 
	db $DF 
	db $F0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1E 
	db $81 
	db $F8 
	db $3F 
	db $00 
	db $6D 
	db $BB 
	db $F9 
	db $DE 
	db $5F 
	db $FB 
	db $AF 
	db $82 
	db $FC 
	db $3F 
	db $2A 
	db $CF 
	db $3F 
	db $FD 
	db $FF 
	db $7F 
	db $FB 
	db $CF 
	db $C2 
	db $FC 
	db $1F 
	db $80 
	db $07 
	db $1C 
	db $3C 
	db $E3 
	db $3C 
	db $11 
	db $C7 
	db $C2 
	db $F8 
	db $1F 
	db $FE 
	db $87 
	db $1D 
	db $5D 
	db $EA 
	db $3C 
	db $61 
	db $C7 
	db $E1 
	db $F8 
	db $0F 
	db $FE 
	db $83 
	db $5C 
	db $34 
	db $E0 
	db $3E 
	db $09 
	db $C3 
	db $E9 
	db $F0 
	db $0F 
	db $CD 
	db $07 
	db $1C 
	db $18 
	db $FF 
	db $9F 
	db $F5 
	db $81 
	db $F3 
	db $F0 
	db $05 
	db $C0 
	db $07 
	db $5C 
	db $30 
	db $7F 
	db $9F 
	db $F1 
	db $C0 
	db $FB 
	db $E0 
	db $07 
	db $E4 
	db $17 
	db $1C 
	db $60 
	db $E1 
	db $0E 
	db $21 
	db $C0 
	db $3F 
	db $80 
	db $03 
	db $E4 
	db $67 
	db $5C 
	db $F8 
	db $EA 
	db $8F 
	db $05 
	db $D8 
	db $0F 
	db $C0 
	db $01 
	db $F1 
	db $87 
	db $1D 
	db $BC 
	db $E1 
	db $07 
	db $28 
	db $C4 
	db $2F 
	db $80 
	db $00 
	db $B2 
	db $16 
	db $5F 
	db $5C 
	db $E0 
	db $73 
	db $81 
	db $D3 
	db $97 
	db $00 
	db $00 
	db $38 
	db $07 
	db $0E 
	db $9A 
	db $E0 
	db $E1 
	db $C1 
	db $C7 
	db $1E 
	db $00 
	db $00 
	db $1C 
	db $17 
	db $5D 
	db $5E 
	db $7F 
	db $4C 
	db $E3 
	db $FE 
	db $38 
	db $00 
	db $01 
	db $86 
	db $0F 
	db $B2 
	db $1E 
	db $FF 
	db $DE 
	db $37 
	db $DE 
	db $61 
	db $80 
	db $06 
	db $41 
	db $80 
	db $04 
	db $40 
	db $00 
	db $00 
	db $88 
	db $01 
	db $8A 
	db $60 
	db $08 
	db $A8 
	db $6A 
	db $28 
	db $2A 
	db $AA 
	db $95 
	db $21 
	db $56 
	db $14 
	db $10 
	db $04 
	db $14 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $20 
	db $20 
	db $02 
	db $02 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $50 
	db $40 
	db $01 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $80 

gfx_SpecialFXLogo:
	db $07 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $67 
	db $1E 
	db $18 
	db $E1 
	db $1C 
	db $00 
	db $00 
	db $82 
	db $88 
	db $28 
	db $41 
	db $08 
	db $00 
	db $00 
	db $C2 
	db $8C 
	db $20 
	db $42 
	db $88 
	db $00 
	db $00 
	db $6B 
	db $28 
	db $A2 
	db $4B 
	db $A8 
	db $00 
	db $00 
	db $22 
	db $08 
	db $28 
	db $42 
	db $8A 
	db $00 
	db $00 
	db $C7 
	db $1E 
	db $10 
	db $E4 
	db $5E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $07 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $C0 
	db $07 
	db $00 
	db $03 
	db $01 
	db $F0 
	db $1F 
	db $C0 
	db $07 
	db $FF 
	db $FF 
	db $FF 
	db $7F 
	db $F1 
	db $C0 
	db $07 
	db $00 
	db $02 
	db $80 
	db $A0 
	db $23 
	db $C0 
	db $07 
	db $FF 
	db $FE 
	db $FF 
	db $BF 
	db $E3 
	db $C0 
	db $07 
	db $00 
	db $02 
	db $40 
	db $40 
	db $47 
	db $C0 
	db $07 
	db $FF 
	db $FE 
	db $7F 
	db $FF 
	db $C7 
	db $FE 
	db $07 
	db $00 
	db $02 
	db $20 
	db $00 
	db $8F 
	db $83 
	db $07 
	db $FF 
	db $FE 
	db $3F 
	db $FF 
	db $8C 
	db $0C 
	db $07 
	db $01 
	db $80 
	db $30 
	db $01 
	db $10 
	db $10 
	db $07 
	db $FF 
	db $F0 
	db $3F 
	db $FF 
	db $00 
	db $20 
	db $07 
	db $00 
	db $1F 
	db $F8 
	db $02 
	db $01 
	db $E0 
	db $07 
	db $FF 
	db $F1 
	db $FF 
	db $FF 
	db $07 
	db $C0 
	db $07 
	db $00 
	db $11 
	db $F0 
	db $01 
	db $1F 
	db $C0 
	db $07 
	db $FF 
	db $F1 
	db $FF 
	db $FF 
	db $9F 
	db $C0 
	db $07 
	db $00 
	db $11 
	db $E0 
	db $00 
	db $8F 
	db $C0 
	db $07 
	db $FF 
	db $F1 
	db $FF 
	db $FF 
	db $CF 
	db $C0 
	db $07 
	db $01 
	db $01 
	db $C0 
	db $40 
	db $47 
	db $C0 
	db $07 
	db $FF 
	db $01 
	db $FF 
	db $FF 
	db $E7 
	db $C0 
	db $07 
	db $01 
	db $1F 
	db $80 
	db $A0 
	db $23 
	db $C0 
	db $07 
	db $FF 
	db $1F 
	db $FF 
	db $BF 
	db $F3 
	db $C0 
	db $07 
	db $01 
	db $1F 
	db $01 
	db $10 
	db $11 
	db $C0 
	db $07 
	db $FF 
	db $1D 
	db $FF 
	db $1F 
	db $F9 
	db $C0 
	db $07 
	db $C0 
	db $18 
	db $60 
	db $3C 
	db $00 
	db $C0 
	db $07 
	db $C0 
	db $10 
	db $C0 
	db $3E 
	db $00 
	db $C0 
	db $07 
	db $FF 
	db $E3 
	db $FF 
	db $FF 
	db $FF 
	db $C0 
	db $07 
	db $FF 
	db $CF 
	db $FF 
	db $FF 
	db $FF 
	db $C0 
	db $00 
	db $00 
	db $50 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $A0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

gfx_HyperActiveLogo:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $1E 
	db $F0 
	db $1E 
	db $FE 
	db $FC 
	db $FE 
	db $FE 
	db $FE 
	db $FC 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $1E 
	db $F0 
	db $1E 
	db $F0 
	db $1E 
	db $F0 
	db $00 
	db $F0 
	db $1E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $FE 
	db $FE 
	db $7E 
	db $FE 
	db $FE 
	db $FC 
	db $FE 
	db $FE 
	db $FE 
	db $FC 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $1E 
	db $00 
	db $1E 
	db $F0 
	db $00 
	db $F0 
	db $00 
	db $F0 
	db $1E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F7 
	db $DE 
	db $F0 
	db $1E 
	db $F0 
	db $00 
	db $F0 
	db $00 
	db $F7 
	db $DE 
	db $00 
	db $00 
	db $00 
	db $00 
	db $FF 
	db $FF 
	db $F7 
	db $DE 
	db $7E 
	db $FC 
	db $F0 
	db $00 
	db $FE 
	db $FE 
	db $F7 
	db $DF 
	db $FF 
	db $FE 
	db $00 
	db $00 
	db $00 
	db $00 
	db $04 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $FE 
	db $FF 
	db $FD 
	db $FE 
	db $FF 
	db $FF 
	db $FF 
	db $FE 
	db $FF 
	db $7F 
	db $DE 
	db $FF 
	db $BF 
	db $FF 
	db $80 
	db $01 
	db $86 
	db $FF 
	db $FD 
	db $86 
	db $C0 
	db $00 
	db $00 
	db $06 
	db $C3 
	db $60 
	db $DE 
	db $C1 
	db $B0 
	db $01 
	db $80 
	db $03 
	db $1B 
	db $7F 
	db $FB 
	db $1B 
	db $60 
	db $00 
	db $00 
	db $36 
	db $DB 
	db $63 
	db $6D 
	db $8D 
	db $B0 
	db $06 
	db $C0 
	db $03 
	db $0B 
	db $7F 
	db $FB 
	db $0B 
	db $60 
	db $00 
	db $00 
	db $16 
	db $CB 
	db $61 
	db $6D 
	db $85 
	db $B0 
	db $02 
	db $C0 
	db $06 
	db $01 
	db $BF 
	db $F6 
	db $01 
	db $B0 
	db $00 
	db $00 
	db $06 
	db $C3 
	db $60 
	db $33 
	db $01 
	db $B0 
	db $00 
	db $60 
	db $06 
	db $01 
	db $BF 
	db $F6 
	db $0F 
	db $BF 
	db $FF 
	db $87 
	db $FE 
	db $C3 
	db $7C 
	db $3F 
	db $0F 
	db $B0 
	db $FF 
	db $E0 
	db $0C 
	db $00 
	db $DF 
	db $EC 
	db $10 
	db $40 
	db $01 
	db $86 
	db $00 
	db $C3 
	db $06 
	db $00 
	db $18 
	db $30 
	db $18 
	db $00 
	db $0C 
	db $00 
	db $DF 
	db $EC 
	db $17 
	db $FF 
	db $FD 
	db $86 
	db $FE 
	db $C3 
	db $76 
	db $00 
	db $1B 
	db $B0 
	db $6C 
	db $00 
	db $18 
	db $00 
	db $6F 
	db $D8 
	db $2F 
	db $FF 
	db $FD 
	db $86 
	db $FE 
	db $C3 
	db $7B 
	db $00 
	db $37 
	db $B0 
	db $2C 
	db $00 
	db $18 
	db $00 
	db $60 
	db $58 
	db $20 
	db $00 
	db $01 
	db $86 
	db $FE 
	db $C3 
	db $7B 
	db $00 
	db $37 
	db $B0 
	db $06 
	db $00 
	db $30 
	db $FC 
	db $3F 
	db $B0 
	db $7F 
	db $FF 
	db $FD 
	db $86 
	db $FE 
	db $C3 
	db $7D 
	db $80 
	db $6F 
	db $B0 
	db $FF 
	db $FC 
	db $30 
	db $CC 
	db $01 
	db $B0 
	db $00 
	db $00 
	db $0D 
	db $86 
	db $FE 
	db $C3 
	db $7D 
	db $80 
	db $6F 
	db $B0 
	db $00 
	db $0C 
	db $61 
	db $B6 
	db $1B 
	db $60 
	db $00 
	db $00 
	db $6D 
	db $86 
	db $FE 
	db $C3 
	db $7E 
	db $C0 
	db $DF 
	db $B0 
	db $00 
	db $36 
	db $61 
	db $B6 
	db $0B 
	db $60 
	db $00 
	db $00 
	db $2D 
	db $86 
	db $FE 
	db $C3 
	db $7E 
	db $C0 
	db $DF 
	db $B0 
	db $00 
	db $16 
	db $C3 
	db $7B 
	db $06 
	db $C0 
	db $00 
	db $00 
	db $0D 
	db $86 
	db $FE 
	db $C3 
	db $7F 
	db $61 
	db $BF 
	db $B0 
	db $00 
	db $03 
	db $FF 
	db $03 
	db $FE 
	db $FF 
	db $FF 
	db $FF 
	db $FD 
	db $FE 
	db $00 
	db $FF 
	db $00 
	db $7F 
	db $80 
	db $3F 
	db $FF 
	db $FF 

gfx_HysteriaLogo:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $7F 
	db $03 
	db $FF 
	db $F0 
	db $3F 
	db $87 
	db $FF 
	db $87 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $F7 
	db $FF 
	db $F8 
	db $3F 
	db $83 
	db $FF 
	db $80 
	db $41 
	db $02 
	db $04 
	db $00 
	db $20 
	db $18 
	db $00 
	db $24 
	db $00 
	db $00 
	db $40 
	db $00 
	db $04 
	db $00 
	db $06 
	db $20 
	db $04 
	db $00 
	db $00 
	db $5D 
	db $02 
	db $ED 
	db $E8 
	db $5E 
	db $A7 
	db $FF 
	db $95 
	db $FF 
	db $FE 
	db $DF 
	db $FF 
	db $D5 
	db $FF 
	db $F9 
	db $2E 
	db $85 
	db $FF 
	db $40 
	db $5D 
	db $02 
	db $E2 
	db $E0 
	db $5C 
	db $2F 
	db $FF 
	db $C5 
	db $FF 
	db $FE 
	db $5F 
	db $FF 
	db $C5 
	db $FF 
	db $FD 
	db $2E 
	db $05 
	db $FF 
	db $00 
	db $5D 
	db $02 
	db $EA 
	db $F4 
	db $BD 
	db $5E 
	db $01 
	db $EC 
	db $07 
	db $80 
	db $DC 
	db $00 
	db $15 
	db $C0 
	db $1E 
	db $AE 
	db $8B 
	db $83 
	db $A0 
	db $5D 
	db $02 
	db $E1 
	db $70 
	db $B8 
	db $5C 
	db $AA 
	db $05 
	db $57 
	db $95 
	db $5C 
	db $AA 
	db $A5 
	db $D5 
	db $4E 
	db $2E 
	db $0B 
	db $BB 
	db $80 
	db $5D 
	db $FE 
	db $E9 
	db $7B 
	db $7A 
	db $5D 
	db $01 
	db $48 
	db $17 
	db $A0 
	db $5C 
	db $00 
	db $05 
	db $C0 
	db $2E 
	db $AE 
	db $8B 
	db $AB 
	db $A0 
	db $5C 
	db $00 
	db $E0 
	db $B9 
	db $70 
	db $5C 
	db $00 
	db $00 
	db $17 
	db $80 
	db $5D 
	db $FF 
	db $F5 
	db $C0 
	db $2E 
	db $2E 
	db $0B 
	db $45 
	db $80 
	db $5F 
	db $FF 
	db $C8 
	db $BE 
	db $F4 
	db $2E 
	db $FF 
	db $80 
	db $17 
	db $A0 
	db $5C 
	db $00 
	db $05 
	db $DF 
	db $EE 
	db $AE 
	db $97 
	db $45 
	db $D0 
	db $5F 
	db $FF 
	db $A0 
	db $58 
	db $E0 
	db $27 
	db $00 
	db $20 
	db $17 
	db $80 
	db $5F 
	db $FF 
	db $D5 
	db $C0 
	db $1C 
	db $2E 
	db $17 
	db $45 
data_7408:
	db $C0 
	db $5F 
	db $F5 
	db $68 
	db $55 
	db $E8 
	db $1B 
	db $FF 
	db $90 
	db $17 
	db $A0 
	db $5F 
	db $FF 
	db $C5 
	db $FF 
	db $FD 
	db $2E 
	db $96 
	db $82 
	db $D0 
	db $5C 
	db $00 
	db $E0 
	db $2F 
	db $C0 
	db $06 
	db $AB 
	db $C0 
	db $17 
	db $80 
	db $5C 
	db $00 
	db $15 
	db $FF 
	db $FE 
	db $2E 
	db $16 
	db $FE 
	db $C0 
	db $5D 
	db $CA 
	db $E8 
	db $2F 
	db $D0 
	db $00 
	db $01 
	db $E8 
	db $17 
	db $A0 
	db $5C 
	db $AA 
	db $A5 
	db $C0 
	db $1E 
	db $AE 
	db $AE 
	db $00 
	db $E8 
	db $5D 
	db $02 
	db $E0 
	db $17 
	db $80 
	db $7F 
	db $02 
	db $E0 
	db $17 
	db $80 
	db $5C 
	db $00 
	db $05 
	db $D5 
	db $4E 
	db $2E 
	db $2F 
	db $FF 
	db $E0 
	db $5D 
	db $02 
	db $E8 
	db $17 
	db $A0 
	db $40 
	db $FC 
	db $E8 
	db $17 
	db $A0 
	db $5D 
	db $FF 
	db $F5 
	db $C0 
	db $2E 
	db $AE 
	db $AF 
	db $FF 
	db $E8 
	db $5D 
	db $02 
	db $E0 
	db $17 
	db $80 
	db $5E 
	db $01 
	db $E0 
	db $17 
	db $80 
	db $5C 
	db $00 
	db $05 
	db $D0 
	db $2E 
	db $2E 
	db $2E 
	db $00 
	db $E0 
	db $5D 
	db $02 
	db $E8 
	db $17 
	db $A0 
	db $2F 
	db $FF 
	db $D0 
	db $17 
	db $A0 
	db $5F 
	db $FF 
	db $D5 
	db $C0 
	db $2E 
	db $AE 
	db $DD 
	db $55 
	db $74 
	db $5C 
	db $02 
	db $E0 
	db $17 
	db $00 
	db $27 
	db $FF 
	db $80 
	db $17 
	db $80 
	db $5F 
	db $FF 
	db $C5 
	db $D0 
	db $2E 
	db $2E 
	db $5C 
	db $01 
	db $70 
	db $42 
	db $02 
	db $08 
	db $10 
	db $20 
	db $10 
	db $00 
	db $20 
	db $10 
	db $20 
	db $40 
	db $00 
	db $14 
	db $00 
	db $20 
	db $A0 
	db $C1 
	db $01 
	db $04 
	db $7C 
	db $03 
	db $A0 
	db $0A 
	db $80 
	db $05 
	db $55 
	db $00 
	db $05 
	db $40 
	db $2A 
	db $AA 
	db $A5 
	db $50 
	db $2A 
	db $2A 
	db $2A 
	db $00 
	db $A8 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

gfx_Panel:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $FF 
	db $FF 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $20 
	db $25 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $07 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $EF 
	db $7E 
	db $EF 
	db $7E 
	db $EF 
	db $7E 
	db $00 
	db $1C 
	db $DA 
	db $41 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0B 
	db $FF 
	db $FF 
	db $D0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $02 
	db $0B 
	db $98 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C5 
	db $BB 
	db $DD 
	db $A3 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $10 
	db $08 
	db $00 
	db $10 
	db $08 
	db $00 
	db $10 
	db $08 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $03 
	db $E0 
	db $03 
	db $E0 
	db $03 
	db $E0 
	db $00 
	db $19 
	db $20 
	db $04 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $EF 
	db $7C 
	db $EF 
	db $7C 
	db $EF 
	db $7C 
	db $00 
	db $0E 
	db $24 
	db $10 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $0E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $19 
	db $FF 
	db $FF 
	db $98 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $45 
	db $58 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0E 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $70 
	db $00 
	db $01 
	db $38 
	db $1C 
	db $00 
	db $38 
	db $1C 
	db $00 
	db $38 
	db $1C 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0D 
	db $F8 
	db $0D 
	db $F8 
	db $0D 
	db $F8 
	db $00 
	db $18 
	db $82 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $46 
	db $78 
	db $46 
	db $78 
	db $46 
	db $78 
	db $00 
	db $07 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $07 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $E0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $42 
	db $00 
	db $42 
	db $00 
	db $42 
	db $00 
	db $38 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $42 
	db $00 
	db $42 
	db $00 
	db $42 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $61 
	db $FF 
	db $FE 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $12 
	db $98 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $70 
	db $00 
	db $00 
	db $0E 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $60 
	db $01 
	db $01 
	db $7F 
	db $FE 
	db $81 
	db $7F 
	db $FE 
	db $81 
	db $7F 
	db $FE 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $17 
	db $FC 
	db $17 
	db $FC 
	db $17 
	db $FC 
	db $00 
	db $1A 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $7C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $E0 
	db $00 
	db $E0 
	db $00 
	db $03 
	db $7F 
	db $FF 
	db $98 
	db $00 
	db $00 
	db $00 
	db $00 
	db $19 
	db $FF 
	db $FC 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1E 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $78 
	db $00 
	db $00 
	db $03 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $70 
	db $00 
	db $00 
	db $0E 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $61 
	db $FF 
	db $FE 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $58 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $42 
	db $00 
	db $42 
	db $00 
	db $42 
	db $00 
	db $38 
	db $00 
	db $00 
	db $1C 
	db $18 
	db $42 
	db $00 
	db $42 
	db $00 
	db $5A 
	db $00 
	db $00 
	db $03 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $2B 
	db $FC 
	db $2B 
	db $FC 
	db $2B 
	db $FC 
	db $00 
	db $19 
	db $48 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $27 
	db $C0 
	db $27 
	db $C0 
	db $27 
	db $C0 
	db $00 
	db $01 
	db $7F 
	db $FF 
	db $98 
	db $00 
	db $00 
	db $00 
	db $00 
	db $19 
	db $FF 
	db $FC 
	db $7C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0E 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $70 
	db $00 
	db $00 
	db $01 
	db $7F 
	db $FE 
	db $81 
	db $7F 
	db $FE 
	db $81 
	db $7F 
	db $FE 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0E 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $3C 
	db $FF 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $10 
	db $05 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $19 
	db $FF 
	db $FF 
	db $98 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $07 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $FF 
	db $7F 
	db $FE 
	db $E0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $10 
	db $FE 
	db $10 
	db $FE 
	db $10 
	db $FE 
	db $00 
	db $1A 
	db $A2 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $2B 
	db $C0 
	db $2B 
	db $C0 
	db $2B 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $38 
	db $1C 
	db $00 
	db $38 
	db $1C 
	db $00 
	db $38 
	db $1C 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C5 
	db $BB 
	db $DD 
	db $A3 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $64 
	db $08 
	db $B4 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $40 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0B 
	db $FF 
	db $FF 
	db $D0 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $0E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $46 
	db $7E 
	db $46 
	db $7E 
	db $46 
	db $7E 
	db $00 
	db $19 
	db $D0 
	db $10 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $17 
	db $80 
	db $17 
	db $80 
	db $17 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $10 
	db $08 
	db $00 
	db $10 
	db $08 
	db $00 
	db $10 
	db $08 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $07 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $01 
	db $0B 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $08 
	db $40 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $FF 
	db $FF 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $AB 
	db $7E 
	db $AB 
	db $7E 
	db $AB 
	db $7E 
	db $00 
	db $01 
	db $A4 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0A 
	db $00 
	db $0A 
	db $00 
	db $0A 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

gfx_Charset:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $47 
	db $47 
	db $47 
	db $47 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $46 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $47 
	db $47 
	db $47 
	db $47 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $46 
	db $07 
	db $07 
	db $07 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $46 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $47 
	db $47 
	db $47 
	db $47 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $46 
	db $07 
	db $07 
	db $07 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $47 
	db $47 
	db $47 
	db $47 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $46 
	db $44 
	db $07 
	db $42 
	db $46 
	db $46 
	db $42 
	db $46 
	db $46 
	db $42 
	db $46 
	db $46 
	db $42 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $07 
	db $07 
	db $07 
	db $47 
	db $42 
	db $43 
	db $44 
	db $45 
	db $47 
	db $47 
	db $07 
	db $46 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $47 
	db $46 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $07 
	db $07 
	db $07 
	db $47 
	db $42 
	db $43 
	db $44 
	db $45 
	db $47 
	db $07 
	db $07 
	db $46 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $07 
	db $46 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $45 
	db $47 
	db $47 
	db $47 
	db $47 
	db $45 
	db $00 
	db $00 
	db $42 
	db $46 
	db $46 
	db $42 
	db $46 
	db $46 
	db $42 
	db $46 
	db $46 
	db $42 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $38 
	db $30 
	db $20 
	db $00 
	db $38 
	db $38 
	db $00 
	db $66 
	db $88 
	db $88 
	db $84 
	db $82 
	db $82 
	db $6C 
	db $00 
	db $66 
	db $88 
	db $88 
	db $44 
	db $22 
	db $22 
	db $CC 
	db $00 
	db $6C 
	db $8A 
	db $8A 
	db $4A 
	db $2C 
	db $28 
	db $C8 
	db $00 
	db $EC 
	db $8A 
	db $8A 
	db $CA 
	db $8A 
	db $8A 
	db $EA 
	db $00 
	db $00 
	db $10 
	db $28 
	db $10 
	db $2A 
	db $44 
	db $3A 
	db $00 
	db $18 
	db $30 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $30 
	db $30 
	db $20 
	db $20 
	db $10 
	db $18 
	db $00 
	db $30 
	db $18 
	db $18 
	db $10 
	db $00 
	db $08 
	db $30 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $7E 
	db $5E 
	db $3C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $10 
	db $10 
	db $7C 
	db $10 
	db $10 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $18 
	db $30 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $00 
	db $02 
	db $04 
	db $08 
	db $10 
	db $20 
	db $00 
	db $7C 
	db $C6 
	db $C6 
	db $84 
	db $00 
	db $C2 
	db $7C 
	db $00 
	db $F0 
	db $38 
	db $30 
	db $20 
	db $08 
	db $18 
	db $FE 
	db $00 
	db $FC 
	db $06 
	db $7C 
	db $80 
	db $00 
	db $40 
	db $FE 
	db $00 
	db $FE 
	db $06 
	db $7E 
	db $04 
	db $00 
	db $02 
	db $FC 
	db $00 
	db $C6 
	db $C6 
	db $7E 
	db $04 
	db $00 
	db $02 
	db $06 
	db $00 
	db $FE 
	db $C0 
	db $FC 
	db $04 
	db $00 
	db $02 
	db $FC 
	db $00 
	db $7E 
	db $C0 
	db $FC 
	db $84 
	db $00 
	db $C2 
	db $7C 
	db $00 
	db $FC 
	db $06 
	db $06 
	db $04 
	db $00 
	db $02 
	db $06 
	db $00 
	db $7C 
	db $C6 
	db $7C 
	db $84 
	db $00 
	db $C2 
	db $7C 
	db $00 
	db $7C 
	db $C6 
	db $7E 
	db $04 
	db $00 
	db $02 
	db $06 
	db $00 
	db $00 
	db $00 
	db $00 
	db $10 
	db $00 
	db $00 
	db $10 
	db $00 
	db $00 
	db $00 
	db $10 
	db $00 
	db $00 
	db $10 
	db $10 
	db $20 
	db $00 
	db $00 
	db $04 
	db $08 
	db $10 
	db $08 
	db $04 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3E 
	db $00 
	db $3E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $10 
	db $08 
	db $04 
	db $08 
	db $10 
	db $00 
	db $7C 
	db $86 
	db $0E 
	db $1C 
	db $18 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $7C 
	db $C6 
	db $FE 
	db $84 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $FC 
	db $C6 
	db $FC 
	db $84 
	db $00 
	db $42 
	db $FC 
	db $00 
	db $7E 
	db $C0 
	db $C0 
	db $80 
	db $00 
	db $C0 
	db $7E 
	db $00 
	db $FC 
	db $C6 
	db $C6 
	db $86 
	db $00 
	db $42 
	db $FC 
	db $00 
	db $FE 
	db $C0 
	db $FC 
	db $80 
	db $00 
	db $40 
	db $FE 
	db $00 
	db $FE 
	db $C0 
	db $FC 
	db $80 
	db $00 
	db $40 
	db $C0 
	db $00 
	db $7E 
	db $C0 
	db $CE 
	db $84 
	db $00 
	db $C2 
	db $7E 
	db $00 
	db $C6 
	db $C6 
	db $FE 
	db $84 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $FE 
	db $38 
	db $30 
	db $20 
	db $08 
	db $18 
	db $FE 
	db $00 
	db $06 
	db $06 
	db $06 
	db $04 
	db $00 
	db $02 
	db $FC 
	db $00 
	db $C6 
	db $CC 
	db $F8 
	db $8C 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $C0 
	db $C0 
	db $C0 
	db $C0 
	db $80 
	db $00 
	db $7E 
	db $00 
	db $6C 
	db $D6 
	db $D6 
	db $84 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $7C 
	db $C6 
	db $C6 
	db $84 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $7C 
	db $C6 
	db $C6 
	db $84 
	db $00 
	db $C2 
	db $7C 
	db $00 
	db $FC 
	db $C6 
	db $FC 
	db $80 
	db $00 
	db $40 
	db $C0 
	db $00 
	db $7C 
	db $C6 
	db $C6 
	db $C6 
	db $80 
	db $0C 
	db $76 
	db $00 
	db $FC 
	db $C6 
	db $FC 
	db $84 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $7E 
	db $C0 
	db $7C 
	db $04 
	db $00 
	db $02 
	db $FC 
	db $00 
	db $FE 
	db $38 
	db $30 
	db $20 
	db $08 
	db $18 
	db $38 
	db $00 
	db $C6 
	db $C6 
	db $C6 
	db $84 
	db $00 
	db $C2 
	db $7C 
	db $00 
	db $C6 
	db $C6 
	db $C6 
	db $84 
	db $00 
	db $6C 
	db $38 
	db $00 
	db $C6 
	db $C6 
	db $C6 
	db $84 
	db $00 
	db $D2 
	db $7C 
	db $00 
	db $C6 
	db $6C 
	db $38 
	db $6C 
	db $00 
	db $42 
	db $C6 
	db $00 
	db $C6 
	db $C6 
	db $7E 
	db $04 
	db $00 
	db $02 
	db $FC 
	db $00 
	db $FE 
	db $0E 
	db $1C 
	db $20 
	db $00 
	db $60 
	db $FE 
	db $00 
	db $7F 
	db $C0 
	db $CF 
	db $9C 
	db $0F 
	db $C0 
	db $7F 
	db $00 
	db $FC 
	db $06 
	db $F6 
	db $04 
	db $F0 
	db $02 
	db $FC 
	db $00 
	db $C0 
	db $C0 
	db $C0 
	db $C0 
	db $80 
	db $00 
	db $7E 
	db $00 
	db $FC 
	db $06 
	db $7C 
	db $80 
	db $00 
	db $C0 
	db $7E 
	db $00 
	db $FE 
	db $06 
	db $7E 
	db $04 
	db $00 
	db $02 
	db $06 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Uncontended RAM
;

	org $8000

JP_PlayGame:
	JP   PlayGame
	
STACK:
	db $20 
	db $48 
	db $59 
	db $50 
	db $45 
	db $52 
	db $20 
	db $41 
	db $43 
	db $54 
	db $49 
	db $56 
	db $45 
	db $20 
	db $28 
	db $63 
	db $29 
	db $31 
	db $39 
	db $38 
	db $38 
	
LSTACK:
	db $20 
	db $53 
	db $50 
	db $45 
	db $43 
	db $49 
	db $41 
	db $4C 
	db $20 
	db $46 
	db $58 
	db $20 
	db $4C 
	db $54 
	db $44 
	db $20 
	
StackPos:
	db $03 
	db $80 
	
LoopStack:
	db $18 
	db $80 
	
KeyTab:
	db $7F 
	db $F7 
	db $7F 
	db $FB 
	db $FB 
	db $FE 
	db $FD 
	db $FE 
	db $DF 
	db $FD 
	db $DF 
	db $FE 

MODE_TAB:	
	db $00 
	db $AE 
	db $B6 
	db $2F 
	
DirTab:
	db $00 
	db $FF 
	db $01 
	db $FF 
	db $01 
	db $00 
	db $01 
	db $01 
	db $00 
	db $01 
	db $FF 
	db $01 
	db $FF 
	db $00 
	db $FF 
	db $FF 
	db $00 
	
ExplosionVelocities:
	db $FC 
	db $02 
	db $FE 
	db $04 
	db $00 
	db $02 
	db $02 
	db $00 
	db $04 
	db $FE 
	db $02 
	db $FC 
	db $00 
	db $FE 
	db $FE 
	db $00 
	db $FE 
	db $04 
	db $FC 
	db $02 
	db $00 
	db $04 
	db $04 
	db $00 
	db $02 
	db $FC 
	db $04 
	db $FE 
	db $00 
	db $FC 
	db $FC 
	
CONT_TAB:			; for SPRINT
	dw COORDS
	dw DIRECTN
	dw PR_MODE
	dw TABULATE
	dw REPEAT
	dw PEN_INK
	dw CHAR_BASE
	dw RESET_PR
	dw JSR_RUTS
	dw JSR_STRING
	dw CLEARSCR
	dw CLEARATTR
	dw SET_XPD
	dw CARRIAGERETURN
	dw BACKSPC
	dw HIT_FOR
	dw HIT_END
	dw TAB_TO_X
	dw X_TO_NUM
	dw Y_TO_NUM
	db $00 
	
ScoreText:
	db $30 
	db $30 
	db $30 
	db $30 
	db $30 
	db $31 
	db $32 
	db $30 
	
PlayerMoveLeftRightTable:
	dw PlayerDoNothing
	dw PlayerMoveRight
	dw PlayerMoveLeft
	dw PlayerDoNothing
	
PlayerMoveUpDownTable:
	dw PlayerMoveDown
	dw PlayerMoveDown
	dw PlayerMoveUp
	dw PlayerMoveDown

PlayerFireTable:
	dw FireBullet
	dw FireDropBomb
	dw FireLaserBolt
	dw DUF

PlayerDrawProjectileTable:
	dw DrawBullet
	dw DrawDropBomb
	dw DrawLaserLine
	dw DrawBullet

PlayerProjectileCollisionTable:
	dw CollideProjectile
	dw CollideProjectile
	dw CollideLaser
	dw DUF

PositiveSpeeds:
	db $01 
	db $02 
	db $03 
	db $04 

NegativeSpeeds:
	db $FF 
	db $FE 
	db $FD 
	db $FC 

ControlMethod:
	db $01 

FrameCounter:
	db $69 

RND1:
	db $F7 

RND2:
	db $87 

RND3:
	db $2C 

Variables_ScrnX:
	db $15 

Variables_ScrnY:
	db $08 

Variables_Direct:
	db $02 

Variables_TabXPos:
	db $00 

Variables_Attr:
	db $FF 

Variables_High:
	db $00 

FUDLR:
	db $04 

OldFUDLR:
	db $04 

BeepFXNum:
	db $00 

ExplosionToggle:
	db $FF 

CurrentVelocity:
	db $00 

PlayerWeaponType:
	db $02 

RadarDamageTime:
	db $00 

PodsToBeCollected:
	db $08 

BeepNum:
	db $00 
PlayerKilled:
	db $00 
BeepPos:
	dw $84E4

Variables_Chars:
	dw gfx_Charset

SP_Store:
	dw $FFEC

MapXPos:
	dw $00DB

MountainMapAddr:
	dw $810D			; address of the first tile that is currently on screen

CollectedPODSprAddr:
	dw $849D

PlayerLives:
	db $03 

GameWave:
	db $00 

PlayAreaColour:			; never written to!
	db $47 

LevelEndCountdown:
	db $00 

DragonsRemaining:
	db $00 

BaddiesLeftToSpawn:
	db $07 

BaddiesToSpawn:
	db $20 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

	org $8100	;pad to page

MountainMap:
	db $04 
	db $02 
	db $06 
	db $06 
	db $02 
	db $04 
	db $02 
	db $04 
	db $02 
	db $04 
	db $02 
	db $04 
	db $02 
	db $04 
	db $06 
	db $00 
	db $00 
	db $04 
	db $04 
	db $06 
	db $04 
	db $02 
	db $02 
	db $02 
	db $02 
	db $04 
	db $06 
	db $04 
	db $02 
	db $06 
	db $02 
	db $06 

MountainTileAddrOffsets:
	dw MountainTile1
	dw MountainTile2
	dw MountainTile3
	dw MountainTile4

MountainTileAddrs:
	dw $0000
	dw $0080
	dw $0100
	dw $0180
	dw $0000
	dw $0020
	dw $0040
	dw $0060

SpriteShiftOffsets:
	dw $0000
	dw $0030
	dw $0060
	dw $0090
	dw $C460
	dw $C468

BulletGFXTable:
	dw gfx_BaddyBull1
	dw gfx_BaddyBull2

GFXTable:
	dw gfx_PlayerLeft
	dw gfx_PlayerFacing
	dw gfx_PlayerRight

PodGFXAddr:
	dw gfx_Pod1
	dw gfx_DropBomb
	dw gfx_Saucer
	dw gfx_DragonHeadLeft
	dw gfx_DragonHeadRight
	dw gfx_DragonBody
	dw gfx_HomingAlien
	dw gfx_Alien2
	dw gfx_Bubble
	dw gfx_Bomb
	dw gfx_Acorn
	dw gfx_Spinny

BaddyRoutines:
	dw DUF						; 0
	dw DUF						; 1
	dw DragonMoveLeft			; 2
	dw DragonMoveRight			; 3
	dw SpriteMoveX				; 4
	dw HomingSaucerX			; 5
	dw UpDownAlien				; 6
	dw UpDownAlien				; 7
	dw HomingSaucerY			; 8
	dw ThrobbingSaucer			; 9
	dw SpinnyAliens				; 10
	dw AcornAlienUp				; 11
	dw AcornAlienDown			; 12
	
BaddySpawnerRoutines:
	dw MoveXSpawner				; 13
	dw SpinnyAlienSpawner		; 14
	dw ThrobbingSaucerSpawner	; 15
	dw AcornAlienSpawner		; 16
	
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

PlayerX:
	db $78 

PlayerY:
	db $26 

PlayerFrame:
	db $02 

OnScreenSprites:			; 5 bytes each
	db $FF 
	db $04 
	db $4F 
	db $05 
	db $3B 
	db $FF 
	db $72 
	db $42 
	db $05 
	db $49 
	db $FF 
	db $78 
	db $40 
	db $0A 
	db $57 
	db $FF 
	db $9A 
	db $3A 
	db $0A 
	db $57 
	db $FF 
	db $06 
	db $3B 
	db $0A 
	db $73 
	db $FF 
	db $08 
	db $44 
	db $05 
	db $81 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 

OnScreenSprites2:			; two more specific sprites
	db $00 
	db $A2 
	db $18 
	db $03 
	db $A4 
	db $FF 
	db $84 
	db $18 
	db $03 
	db $96 


PlayerProjectiles:			; 5 bytes each
	db $FF 
	db $02 
	db $E0 
	db $0C 
	db $00 
	db $FF 
	db $02 
	db $E0 
	db $0C 
	db $00 
	db $FF 
	db $02 
	db $E0 
	db $0C 
	db $00 
	db $FF 
	db $02 
	db $E0 
	db $0C 
	db $00 


CollectedPODSprite:
	db $00 			; typ
CollectedPODXpos:
	db $7A 			; xno
CollectedPODYpos:
	db $00 			; yno
	db $03 			; gno
	db $09 			; FLAG
	db $70 			; XSPD
	db $98 			; YSPD
	db $78 			; XCOUNT
	db $10 			; YCOUNT


BaddyBulletData:	; structure for line drawing bullets - 10 bytes each
	db $FF 			; FLG
	db $FF 			; XPOS L
	db $FF 			; XPOS H
	db $FF 			; XMV
	db $FF 			; YMV
	db $FF 			; INT
	db $FF 			; COW
	db $FF 			; BIG
	db $FF 			; XADD
	db $FF 			; YADD
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 

ExplosionData:
	db $12 
	db $A8 
	db $10 
	db $A8 
	db $1A 
	db $A8 
	db $3E 
	db $A8 
	db $82 
	db $A8 
	db $7C 
	db $4A 
	db $88 
	db $A8 
	db $3E 
	db $0C 

ExplosionData2:
	db $10 
	db $A8 
	db $10 
	db $A8 
	db $10 
	db $A8 
	db $54 
	db $A8 
	db $7A 
	db $A8 
	db $C0 
	db $48 
	db $82 
	db $0A 
	db $46 
	db $A8 

OnScreenSpriteYLoBytes:			; lo byte of 10 onscreensprite data's YNO component - Sorted in ascending Y
	db $29 
	db $2E 
	db $33 
	db $24 
	db $15 
	db $1A 
	db $10 
	db $0B 
	db $1F 
	db $06 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

	org $8300

BeepFXTable:
	dw $0000
	dw FX1
	dw FX2
	dw FX3
	dw FX4
	dw FX5
	dw FX6
	dw FX7
	dw FX8
	dw FX9
	dw FX10
	dw FX11

MainLoopTable:
	dw MainLoop_Survival		; Survival
	dw MainLoop_Dragon			; Dragon
	dw MainLoop_Attack			; Attack
	dw MainLoop_Bonus			; Bonus

ResetLevelFuncs:
	dw ResetSurvivalWave
	dw ResetDragonWave
	dw ResetAttackWave
	dw ResetBonusWave

WaveNameText:
	db "SURVIVAL WAVE  "
	db FIN

WaveNameText2:
	db " DRAGON WAVE   " 
	db FIN

WaveNameText3:
	db " ATTACK WAVE   " 
	db FIN

WaveNameText4:
	db " BONUS  WAVE" 
	db FIN 

SineWave:
	db $00 
	db $02 
	db $04 
	db $06 
	db $08 
	db $0A 
	db $0C 
	db $0E 
	db $10 
	db $12 
	db $12 
	db $14 
	db $14 
	db $14 
	db $16 
	db $16 
	db $16 
	db $16 
	db $16 
	db $14 
	db $14 
	db $14 
	db $12 
	db $12 
	db $10 
	db $0E 
	db $0C 
	db $0A 
	db $08 
	db $06 
	db $04 
	db $02 
	db $00 
	db $FE 
	db $FC 
	db $FA 
	db $F8 
	db $F6 
	db $F4 
	db $F2 
	db $F0 
	db $EE 
	db $EE 
	db $EC 
	db $EC 
	db $EC 
	db $EA 
	db $EA 
	db $EA 
	db $EA 
	db $EA 
	db $EC 
	db $EC 
	db $EC 
	db $EE 
	db $EE 
	db $F0 
	db $F2 
	db $F4 
	db $F6 
	db $F8 
	db $FA 
	db $FC 
	db $FE 
	db $01 
	db $01 

; the four status bar structures

StatusBarRapidFire:			; rapid fire, shield, radar, laser energy - 4 bytes each
	db $10 
	db $70 
	db $02 
	db $01 

StatusBarShield:
	db $0E 
	db $78 
	db $01 
	db $01 

StatusBarRadar:
	db $0E 
	db $80 
	db $01 
	db $01 

StatusBarLaser:
	db $06 
	db $88 
	db $C0 
	db $30 
	db $0C 
	db $03 

; Can a baddy TYP fire bullets? $ff if they can
BaddyFireAbility:	
	db $00 			; 0 - Pod
	db $00 			; 1
	db $FF 			; 2 - Dragon Left
	db $FF 			; 3 - Dragon Right
	db $FF 			; 4 - Move X Alien
	db $FF 			; 5 - Homing Saucer X
	db $00 			; 6 - Bonus Pick Up
	db $00 			; 7 - Bubbld
	db $00 			; 8 - Homing Saucer Y
	db $00 			; 9 - Throbbing Saucer
	db $00 			; 10 - Spinny Alien
	db $FF 			; 11 - Acorn Alien Up
	db $FF 			; 12 - Acorn Alien Down
	db $00 

BaddyScoreTable:
	db $01 
	db $05 
	db $00 
	db $01 
	db $00 
	db $01 
	db $00 
	db $00 
	db $02 
	db $05 
	db $02 
	db $00 
	db $00 
	db $02 
	db $01 
	db $05 
	db $01 
	db $08 
	db $01 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

BitTable:
	db $80 
	db $40 
	db $20 
	db $10 
	db $08 
	db $04 
	db $02 
	db $01 

StarPositions:
	db $E2 
	db $5D 
	db $85 
	db $16 
	db $38 
	db $10 
	db $AA 
	db $51 
	db $44 
	db $3F 
	db $8E 
	db $58 
	db $F6 
	db $06 
	db $F8 
	db $12 


SpriteData:			; 7 bytes per entry
	db $0C 
	db $6E 
	db $01 
	db $2F 
	db $0D 
	db $1A 
	db $23 
	db $09 
	db $47 
	db $00 
	db $4F 
	db $0A 
	db $00 
	db $4F 
	db $0C 
	db $42 
	db $00 
	db $3A 
	db $0D 
	db $18 
	db $2A 
	db $04 
	db $7E 
	db $00 
	db $44 
	db $05 
	db $FF 
	db $FF 
	db $04 
	db $51 
	db $00 
	db $40 
	db $05 
	db $C3 
	db $20 
	db $04 
	db $B9 
	db $00 
	db $4F 
	db $05 
	db $07 
	db $3F 
	db $0C 
	db $1F 
	db $00 
	db $30 
	db $0D 
	db $1B 
	db $26 
	db $09 
	db $FD 
	db $01 
	db $2A 
	db $0A 
	db $14 
	db $3E 
	db $0B 
	db $CB 
	db $01 
	db $13 
	db $0D 
	db $12 
	db $29 
	db $0C 
	db $48 
	db $00 
	db $31 
	db $0D 
	db $07 
	db $23 
	db $0C 
	db $5C 
	db $00 
	db $3A 
	db $0D 
	db $14 
	db $26 
	db $04 
	db $67 
	db $01 
	db $55 
	db $05 
	db $FF 
	db $FF 
	db $0A 
	db $92 
	db $00 
	db $2D 
	db $0E 
	db $A6 
	db $1D 
	db $09 
	db $78 
	db $00 
	db $47 
	db $0A 
	db $1F 
	db $49 
	db $04 
	db $BB 
	db $01 
	db $4A 
	db $05 
	db $1C 
	db $24 
	db $04 
	db $56 
	db $00 
	db $44 
	db $05 
	db $FF 
	db $FF 

SpriteDataPODs:		; continuation of sprite data, specifically for PODs - 7 bytes each
	db $00 
	db $1C 
	db $00 
	db $00 
	db $03 
	db $FF 
	db $FF 
	db $00 
	db $5C 
	db $00 
	db $30 
	db $03 
	db $FF 
	db $FF 
	db $00 
	db $9C 
	db $00 
	db $18 
	db $03 
	db $FF 
	db $FF 
	db $FF 
	db $DC 
	db $00 
	db $70 
	db $03 
	db $FF 
	db $FF 
	db $00 
	db $1C 
	db $01 
	db $18 
	db $03 
	db $FF 
	db $FF 
	db $00 
	db $5C 
	db $01 
	db $40 
	db $03 
	db $FF 
	db $FF 
	db $00 
	db $9C 
	db $01 
	db $08 
	db $03 
	db $FF 
	db $FF 
	db $00 
	db $DC 
	db $01 
	db $70 
	db $03 
	db $FF 
	db $FF 
	
; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Sound effects data
;

FX6:
	db $19 
	db $18 
	db $17 
	db $16 
	db $37 
	db $36 
	db $35 
	db $34 
	db $FF 

FX11:
	db $6F 
	db $78 
	db $83 
	db $8C 
	db $97 
	db $A0 
	db $AB 
	db $B4 
	db $FF 

FX5:
	db $FE 
	db $FD 
	db $FC 
	db $FB 
	db $00 
	db $FA 
	db $F9 
	db $F8 
	db $00 
	db $F7 
	db $F6 
	db $00 
	db $F5 
	db $00 
	db $F4 
	db $F3 
	db $F2 
	db $F1 
	db $FF 

FX7:
	db $8C 
	db $78 
	db $8C 
	db $6E 
	db $00 
	db $0A 
	db $28 
	db $0A 
	db $FF 

FX2:
	db $00 
	db $14 
	db $1E 
	db $32 
	db $32 
	db $1E 
	db $14 
	db $00 
	db $00 
	db $0A 
	db $14 
	db $1E 
	db $28 
	db $32 
	db $32 
	db $28 
	db $1E 
	db $14 
	db $0A 
	db $00 
	db $FF 

FX3:
	db $01 
	db $0B 
	db $01 
	db $33 
	db $01 
	db $65 
	db $01 
	db $97 
	db $01 
	db $C9 
	db $01 
	db $FB 
	db $FF 

FX1:
	db $02 
	db $64 
	db $02 
	db $64 
	db $02 
	db $64 
	db $0C 
	db $C8 
	db $0C 
	db $C8 
	db $0C 
	db $C8 
	db $02 
	db $64 
	db $02 
	db $64 
	db $02 
	db $64 
	db $FF 

FX9:
	db $00 
	db $04 
	db $0C 
	db $28 
	db $FF 

FX10:
	db $32 
	db $28 
	db $1E 
	db $8C 
	db $96 
	db $FF 

FX8:
	db $64 
	db $32 
	db $00 
	db $66 
	db $34 
	db $02 
	db $6C 
	db $3A 
	db $08 
	db $74 
	db $42 
	db $10 
	db $FF 

FX4:
	db $65 
	db $15 
	db $C9 
	db $F1 
	db $65 
	db $C9 
	db $29 
	db $79 
	db $1F 
	db $97 
	db $0B 
	db $D3 
	db $FF 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; PlayGame - the game loop
;

PlayGame:
	CALL InitIM2
	DI  
	CALL Sprint
	db RSET 
	db CLA 
	db CLS 
	db FIN 
	
	XOR  A
	LD   (GameWave),A
	
	LD   A,$03
	LD   (PlayerLives),A
	
	LD   A,$FF
	LD   (HomingSaucerWeightingMod+1),A
	LD   (BaddyFireRateMaskMod+1),A
	
	LD   A,$10
	LD   (BaddiesToSpawn),A
	
	LD   HL,ScoreText
	LD   DE,ScoreText+1
	LD   BC,$0007
	LD   (HL),$30
	LDIR
	
	LD   HL,gfx_Panel				; Dump panel graphic
	LD   DE,$5000
	LD   BC,$0800
	LDIR
	
	LD   DE,$5A00					; Dump Panel Attrs
	LD   BC,$0100
	LDIR
	LD   HL,InitialBonusStartTime			; "500"
	LD   DE,BonusStartTime
	LDI
	LDI
	LDI
	CALL DrawScore
	
	CALL Sprint
	db RSET 			
	db JSR 				
	dw FillAttrBlocks
	db $03, $15, $08, $16, WHITE + BRIGHT
	db $03, $15, $03, $16, WHITE 			
	db $05, $15, $05, $16, WHITE 			
	db $07, $15, $07, $16, WHITE 			
	db FIN 			; FIN (FillAttrBlocks)
	db FIN 			; FIN
	
ResetGame:
	XOR  A
	LD   (RadarDamageTime),A
	LD   (PlayerKilled),A
	LD   (CurrentVelocity),A
	LD   (ScrollDirection),A
	LD   (ScrollInertia),A
	LD   (BeepNum),A
	LD   (LevelEndCountdown),A
	LD   (BeepFXNum),A
	LD   (PlayerY),A
	DEC  A
	LD   (CollectedPODSprite),A
	
	LD   HL,$00CC
	LD   (MapXPos),HL
	
	CALL ResetWave			; wave specific reset
	CALL Baddies
	CALL FindOnScreenSprites
	CALL ResetExplosions
	CALL ResetBaddyBullets
	CALL ResetLasers
	
	LD   A,(GameWave)
	PUSH AF
	AND  $03
	ADD  A,A				; 16 characters per string
	ADD  A,A
	ADD  A,A
	ADD  A,A
	ADD  A,low WaveNameText
	LD   L,A
	LD   H,high WaveNameText			; $8328 - WaveNameText WaveNameText
	LD   (WaveNameMod),HL
	
	XOR  A
	CALL ColourPlayArea
	CALL Sprint
	db RSET 		; RSET
	db AT 			; AT
	db $0A 			; 10
	db $0A 			; 10
	db JSRS 		; JSRS - "JSR String"
WaveNameMod:
	dw $8228 		; MODed addr of the Wave Name string to print 
	db AT 			; AT
	db $0C 			; 12
	db $08 			; 8
	db "LEVEL " 
	db FIN 			; FIN

	POP  AF
	INC  A			; a = level number
	CALL PrintLevelNumber
	CALL FadeUpText
	
	LD   B,$96		; b - number of random bleeps!
RandomTones:
	PUSH BC
	CALL Rand
	LD   A,(RND1)
	OR   $01
	LD   C,A
	LD   B,$00
	LD   A,$01
	CALL PlayTone
	POP  BC
	DJNZ RandomTones
	
	CALL RotateOutPlayArea
	LD   A,(PlayAreaColour)
	CALL ColourPlayArea

StartWave:
	LD   HL,StatusBarRapidFire
	LD   B,$04				; 4 bars
NxtBar:
	LD   (HL),$00			; reset bar
	CALL DrawStatusBars
	LD   A,L
	ADD  A,$04				; 4 bytes per status bar
	LD   L,A
	DJNZ NxtBar

	CALL PlayGameMainLoop

	PUSH AF					; returns A==NZ if player was killed in that game loop
	XOR  A
	LD   (RadarDamageTime),A
	CALL DrawScore
	CALL ClearRadar
	POP  AF
	JP   NZ,LoseLife

	CALL WaitForBeepFXDone	; Wave Complete - on to next level
	CALL RotateOutPlayArea
	XOR  A
	CALL ColourPlayArea
	CALL Sprint
	db RSET
	db AT 
	db $09
	db $08
	db "LEVEL COMPLETED"
	db AT 
	db $0B 
	db $0A 
	db "BONUS X 100" 
	db FIN 
	CALL FadeUpText

	LD   B,$32
	CALL HaltB

	LD   HL,StatusBarRapidFire
	LD   B,$04					; 4 status bars - awards points for energy left in each one
	
CountBarBonus:
	LD   A,B
	EXX 
	CALL PlayBeepFX
	EXX 
CalcBonusLp:
	LD   A,(HL)
	OR   A
	JR   Z,BarCounted
	
	PUSH HL
	CALL ReduceAndDrawBar
	EXX 
	CALL UpdateBeepFX
	LD   DE,$0105
	CALL AddPoints
	CALL DrawScore
	EXX 
	POP  HL
	JR   CalcBonusLp

BarCounted:
	LD   A,L
	ADD  A,$04
	LD   L,A
	DJNZ CountBarBonus

	CALL WaitForBeepFXDone
	LD   B,$64
	CALL HaltB

	CALL RotateOutPlayArea

	LD   A,(GameWave)
	INC  A
	LD   (GameWave),A
	LD   A,(FrameCounter)
	AND  $03
	JR   NZ,NoRandomWeightChanges

	LD   A,(HomingSaucerWeightingMod+1)
	SRL  A
	OR   $01
	LD   (HomingSaucerWeightingMod+1),A
	LD   A,(BaddyFireRateMaskMod+1)
	SRL  A
	OR   $01
	LD   (BaddyFireRateMaskMod+1),A

NoRandomWeightChanges:
	JP   ResetGame

LoseLife:					; Brown bread! Lose a life!
	LD   A,(PlayerLives)
	DEC  A
	LD   (PlayerLives),A
	
	PUSH AF
	LD   HL,$5AA3			; flash screen
	LD   DE,$0020
	ADD  A,A
	ADD  A,L
	LD   L,A
	XOR  A
	LD   (PlayerKilled),A
	LD   (HL),A
	INC  L
	LD   (HL),A
	ADD  HL,DE
	LD   (HL),A
	DEC  L
	LD   (HL),A

	LD   A,$08
	LD   BC,$003F
	CALL PlayTone
	
	LD   A,(PlayAreaColour)
	PUSH AF
	XOR  $3F
	CALL ColourPlayArea
	LD   A,$08
	LD   BC,$00FB
	CALL PlayTone
	POP  AF
	CALL ColourPlayArea
	POP  AF
	JP   NZ,StartWave
	
	CALL ExplodePlayer				; Kabloom!  You're dead!
	JP   RotateOutPlayArea

ResetWave:
	CALL ClearSpriteData
	LD   A,(GameWave)
	AND  $03
	ADD  A,A
	ADD  A,low ResetLevelFuncs
	LD   L,A
	LD   H,high ResetLevelFuncs			; $8320 - ResetLevelFuncs ResetLevelFuncs
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)
	
PlayGameMainLoop:
	LD   A,(GameWave)
	AND  $03
	ADD  A,A
	ADD  A,low MainLoopTable
	LD   L,A
	LD   H,high MainLoopTable			; $8318 - MainLoopTable MainLoopTable
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)							; Run this wave's MainLoop


; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Survival wave MAIN LOOP
;

MainLoop_Survival:
	CALL UpdateBeepFX
	DI  
	CALL DrawExplosions
	CALL DrawBaddyBullets
	CALL SortOnScreenSprites
	CALL OrbitPod
	CALL DropOffPod
	CALL CollidePlayerProjectiles
	CALL Keys
	CALL WaveUpdateSurvival
	CALL UpdateLineDrawBullets
	
	LD   B,$96
SurvivalDelay:
	DJNZ SurvivalDelay
	
	CALL ClearScreen
	CALL DrawScoreDigit
	CALL DrawStars
	CALL ScrollMountains
	CALL DrawProjectiles
	CALL DrawPlayer
	CALL DrawOrbittingPod
	CALL DrawBaddies
	CALL DrawOnScreenPods
	CALL ClearRadar
	CALL DrawRadar
	CALL PlayerControl
	CALL UpdateAndCollideOnScreenSprites
	CALL Baddies
	CALL FindOnScreenSprites
	CALL PauseGame

	LD   A,(PlayerKilled)
	OR   A
	RET  NZ
	
	LD   A,(PodsToBeCollected)
	OR   A
	JR   NZ,MainLoop_Survival
	
	LD   A,(LevelEndCountdown)
	OR   A
	JR   Z,MainLoop_Survival
	
	DEC  A
	LD   (LevelEndCountdown),A
	RET  Z							; ...and we're done with this wave
	JR   MainLoop_Survival

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Dragon wave MAIN LOOP
;

MainLoop_Dragon:
	CALL UpdateBeepFX
	DI  
	CALL DrawExplosions
	CALL DrawBaddyBullets
	CALL SortOnScreenSprites
	CALL CollidePlayerProjectiles
	CALL Keys
	
	LD   B,$00
DragonDelay:
	DJNZ DragonDelay
	
	CALL ClearScreen
	CALL DrawScoreDigit
	CALL DrawStars
	CALL ScrollMountains
	CALL DrawProjectiles
	CALL DrawPlayer
	CALL DrawOrbittingPod
	CALL DrawBaddies
	CALL ClearRadar
	CALL DrawRadar
	CALL PlayerControl
	CALL UpdateAndCollideOnScreenSprites
	CALL UpdateLineDrawBullets
	CALL Baddies
	CALL FindOnScreenSprites
	CALL PauseGame

	LD   A,(PlayerKilled)
	OR   A
	RET  NZ
	
	LD   A,(LevelEndCountdown)
	OR   A
	JR   Z,MainLoop_Dragon
	
	DEC  A
	LD   (LevelEndCountdown),A
	RET  Z
	
	JR   MainLoop_Dragon

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Attack wave MAIN LOOP
;

MainLoop_Attack:
	CALL UpdateBeepFX
	DI  
	CALL DrawExplosions
	CALL DrawBaddyBullets
	CALL SortOnScreenSprites
	CALL CollidePlayerProjectiles
	CALL Keys

	LD   B,$96
AttackDelay:
	DJNZ AttackDelay

	CALL ClearScreen
	CALL DrawScoreDigit
	CALL DrawStars
	CALL ScrollMountains
	CALL DrawProjectiles
	CALL DrawPlayer
	CALL DrawOrbittingPod
	CALL DrawBaddies
	CALL ClearRadar
	CALL DrawRadar
	CALL PlayerControl
	CALL UpdateAndCollideOnScreenSprites
	CALL UpdateLineDrawBullets
	CALL Baddies
	CALL FindOnScreenSprites
	CALL WaveUpdateAttack
	CALL PauseGame

	LD   A,(PlayerKilled)
	OR   A
	RET  NZ

	LD   A,(BaddiesLeftToSpawn)
	OR   A
	JR   NZ,MainLoop_Attack

	LD   A,(LevelEndCountdown)
	OR   A
	JR   Z,MainLoop_Attack

	DEC  A
	LD   (LevelEndCountdown),A
	RET  Z

	JR   MainLoop_Attack

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Bonus wave MAIN LOOP
;

MainLoop_Bonus:
	CALL UpdateBeepFX
	DI  
	CALL DrawExplosions
	CALL SortOnScreenSprites
	CALL Keys
	CALL WaveUpdateBonus
	CALL CollidePlayerProjectiles

	LD   B,$00
BonusDelay:
	DJNZ BonusDelay

	CALL ClearScreen
	CALL DrawScoreDigit
	CALL DrawStars
	CALL ScrollMountains
	CALL DrawBonusCountdown
	CALL DrawProjectiles
	CALL DrawPlayer
	CALL DrawBaddies
	CALL ClearRadar
	CALL DrawRadar
	CALL PlayerControl
	CALL UpdateAndCollideOnScreenSprites
	CALL Baddies
	CALL FindOnScreenSprites
	CALL PauseGame
	LD   A,(PlayerKilled)
	OR   A
	RET  NZ

	LD   A,(LevelEndCountdown)
	OR   A
	JR   Z,MainLoop_Bonus

	DEC  A
	LD   (LevelEndCountdown),A
	RET  Z

	JR   MainLoop_Bonus

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ResetSurvivalWave:
	CALL Sprint
	db RSET
	db AT 
	db $02 
	db $17 
	db PEN 
	db $45 
	db REP 
	db "*" 
	db $08 
	db FIN 
	
	LD   A,WEAPON_LASERBOLTS			; laser bolts
	LD   (PlayerWeaponType),A
	LD   A,$08
	LD   (PodsToBeCollected),A
	LD   A,(BaddiesToSpawn)
	ADD  A,$10
	JR   NC,SetSpawn

	LD   A,$FF
SetSpawn:
	LD   (BaddiesToSpawn),A
	LD   (BaddiesLeftToSpawn),A
	JP   InitPODs
	
ResetDragonWave:
	XOR  A								; 0 = Projectile Bullets
	LD   (PlayerWeaponType),A
	CALL ClearSpriteData
	JP   InitialiseDragons

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ResetAttackWave:
	LD   A,WEAPON_LASERBOLTS			; Laser Bolts
	LD   (PlayerWeaponType),A
	LD   A,(BaddiesToSpawn)
	ADD  A,$10
	JR   NC,SetSpawnLimit

	LD   A,$FF
SetSpawnLimit:
	LD   (BaddiesToSpawn),A
	LD   (BaddiesLeftToSpawn),A
	RET 

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ResetBonusWave:
	LD   A,WEAPON_BOMB					; Drop Bombs
	LD   (PlayerWeaponType),A
	LD   HL,BonusStartTime
	LD   DE,BonusCountDown
	LDI
	LDI
	LDI
	LD   A,(BonusStartTime)
	CP   $30
	RET  Z

	LD   B,$32
PrepTimeLp:
	LD   HL,BonusStartTime+2
	CALL DecBonusTime
	DJNZ PrepTimeLp
	RET 

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PauseGame:
	LD   A,(FUDLR)
	AND  $20
	RET  Z
	LD   A,$10
	LD   BC,$00E0
	CALL PlayTone			; Booop!

WaitDown:
	CALL Keys
	OR   A
	JR   NZ,WaitDown

WaitUp:
	HALT
	CALL Keys
	OR   A
	JR   Z,WaitUp

	LD   A,$10
	LD   BC,$0279
	JP   PlayTone			; Beeeeep!

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

InitPODs:
	LD   IY,SpriteDataPODs
	LD   B,$08
	LD   HL,$001C				; POD XPOS
SetNextPOD:
	LD   (IY+TYP),TYP_POD		; TYP - POD
	LD   (IY+XNO),L				; XNO
	LD   (IY+XNO+1),H
	LD   DE,$0040				; XPOS += 40
	ADD  HL,DE
	EXX 
	LD   B,$10
Randomise:
	CALL Rand
	DJNZ Randomise

	EXX 
	LD   A,(RND1)
	AND  $78					; 01111000
	LD   (IY+YNO),A				; YNO
	LD   (IY+GNO),GNO_POD		; GNO - POD
	LD   DE,$0007
	ADD  IY,DE
	DJNZ SetNextPOD

	RET 

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ClearSpriteData:
	LD   HL,SpriteData
	LD   DE,$0007
	LD   B,$18			; 24 sprites
	LD   A,$FF
ClrLoop:
	LD   (HL),A
	ADD  HL,DE
	DJNZ ClrLoop
	RET 

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ResetLasers:
	LD   B,$04
	LD   HL,PlayerProjectiles
	LD   DE,$0005
ResLasLp:
	LD   (HL),$FF
	ADD  HL,DE
	DJNZ ResLasLp
	RET 

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

UpdateAndCollideOnScreenSprites:
	LD   B,$0C						; 12 on screen
	LD   IX,OnScreenSprites

NxtOSSprite:
	LD   A,(IX+OSS_TYP)
	OR   A
	CALL P,OnScreenActive
	CALL Rand
	LD   DE,$0005
	ADD  IX,DE
	DJNZ NxtOSSprite
	RET 

OnScreenActive:
	LD   L,(IX+OSS_SPRLO)			; SPR-LOW
	LD   H,high SpriteData			; $84xx Hi byte of SpriteData SpriteData
	LD   A,(HL)
	ADD  A,low BaddyFireAbility
	LD   L,A
	LD   H,high BaddyFireAbility	; $83b9 BaddyFireAbility BaddyFireAbility
	LD   A,(HL)						; can this sprite shoot bullets
	INC  L
	OR   A
	JP   P,NoFire
	LD   A,(RND1)					; we can fire at the player, but should we?

BaddyFireRateMaskMod:
	AND  $FF
	JR   NZ,NoFire
	EXX 
	CALL FindFreeBullet
	JP   P,NoFreeSlot
	LD   E,(IX+OSS_XNO)			; XNO
	LD   D,(IX+OSS_YNO)			; YNO
	CALL FindLineForBullet
	LD   A,$06
	CALL PlayBeepFX

NoFreeSlot:
	EXX 

NoFire:						; has baddy hit the player?
	LD   A,(IX+OSS_XNO)			; XNO
	CP   $70				; < 112
	RET  C
	CP   $88
	RET  NC					; > 136
	LD   A,(PlayerY)		; if X > 112 and < 136
	ADD  A,$08
	LD   L,A				; L = x
	LD   H,$10				; 10 pixels wide
	LD   E,(IX+OSS_YNO)		; e = Y
	LD   D,H				; 10 pixels high
	CALL HitA
	RET  C
	LD   L,(IX+OSS_SPRLO)			; l = spr lo
	LD   H,high SpriteData			; h = high $84xx SpriteData SpriteData
	LD   A,(HL)						; TYP
	OR   A
	JR   NZ,SpriteIsActive

	LD   A,(CollectedPODSprite)			; already carrying a POD?
	OR   A
	RET  P
	
	XOR  A
	LD   (CollectedPODSprite),A
	LD   (HL),$FF
	LD   (CollectedPODSprAddr),HL
	LD   L,(IX+XNO)
	LD   H,(IX+XNO+1)
	LD   (CollectedPODXpos),HL
	LD   A,$07
	JP   PlayBeepFX

SpriteIsActive:
	CP   TYP_BONUSPICKUP				; TYPE 6???
	JR   Z,HitBonusPickUp
	AND  $FE
	CP   $02
	JR   Z,PlayerHitDragon
	LD   (HL),$FF				; free up sprite

PlayerHitDragon:
	EXX 
	LD   E,(IX+OSS_XNO)			; XNO
	LD   D,(IX+OSS_YNO)			; YNO
	LD   C,$08					; X/Y offset
DoExplode:
	CALL ExplodeBaddy
	LD   A,$05
	CALL PlayBeepFX
	LD   A,(RadarDamageTime)
	OR   A
	JR   NZ,SetDamageTime

	LD   A,$19
SetDamageTime:
	LD   (RadarDamageTime),A
	CALL DepleteHealthBars
	EXX 
	RET


HitBonusPickUp:
	LD   (HL),$FF
	EXX 
	LD   DE,$0105
	CALL AddPoints
	LD   A,$02
	CALL PlayBeepFX
	EXX 
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

Baddies:
	LD   B,$10
	LD   IX,SpriteData
BadLp:
	LD   A,(IX+TYP)			; TYP
	ADD  A,A
	CALL NC,UpdateBaddy
	LD   DE,$0007
	ADD  IX,DE
	DJNZ BadLp
	RET 

UpdateBaddy:
	ADD  A,low BaddyRoutines
	LD   L,A
	LD   H,high BaddyRoutines			; $8166 - BaddyRoutines BaddyRoutines
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

AcornAlienUp:
	CALL SpriteMoveX
	LD   A,(IX+CNT1)		; CNT1 0..31
	INC  A
	AND  $1F
	LD   (IX+CNT1),A
	JR   NZ,NotEnd
	INC  (IX+$00)			; move to next TYP

NotEnd:
	ADD  A,low SineWave
	LD   L,A
	LD   H,high SineWave	; $8365 - SineWave SineWave
	LD   A,(IX+CNT2)		;  CNT2
	SUB  (HL)				; sub sinewwave value
	LD   (IX+YNO),A			; YNO
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

AcornAlienDown:
	LD   A,(FrameCounter)
	AND  $01
	JR   NZ,NoXMve
	LD   A,B				; b = sprite number - odd/even controls X Dir with dir flipped
	RRCA
	CPL
	CALL SpriteMoveXFlipped
NoXMve:
	LD   A,(IX+CNT1)		; CNT1 0..31
	DEC  A
	AND  $1F
	LD   (IX+CNT1),A
	JR   NZ,NotEnd2
	DEC  (IX+TYP)			; previous TYP
NotEnd2:
	ADD  A,low SineWave
	LD   L,A
	LD   H,high SineWave	; $8365 SineWave SineWave
	LD   A,(IX+CNT2)		; CNT2
	ADD  A,(HL)				; add sinewave value
	LD   (IX+YNO),A			; YNO
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

ThrobbingSaucer:

	CALL SpriteMoveX
	LD   A,(IX+CNT1)			; CNT1
	INC  A
	AND  $1F
	LD   (IX+CNT1),A
	ADD  A,low SineWave
	LD   L,A
	LD   H,high SineWave		; $8365 SineWave SineWave
	LD   A,(IX+CNT2)			; CNT2
	SUB  (HL)					; sub sinewave value
	LD   (IX+YNO),A				; YNO
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

HomingSaucerY:
	LD   A,(PlayerY)
	ADD  A,$08
	CP   (IX+YNO)			; YNO
	LD   A,$FE				; -2
	JR   C,PlayerAbove

	NEG  					; +2
PlayerAbove:
	ADD  A,(IX+YNO)
	LD   (IX+YNO),A			; YNO
	DEC  (IX+CNT1)
	RET  NZ

	LD   A,(RND1)
	AND  $1C
	INC  A
	LD   (IX+CNT1),A
	LD   (IX+TYP),TYP_HOMINGSAUCERX			; Homing Saucer X
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

HomingSaucerX:

	LD   HL,(MapXPos)
	LD   DE,$002E
	ADD  HL,DE
	LD   E,(IX+XNO)
	LD   D,(IX+XNO+1)
	OR   A
	SBC  HL,DE
	LD   A,H
	AND  $01
	JR   NZ,HomeLeft

	INC  DE
	INC  DE
	INC  DE
	INC  DE
	JR   HomeIn

HomeLeft:
	DEC  DE
	DEC  DE
	DEC  DE
	DEC  DE

HomeIn:
	LD   A,D				; wrap x coord
	AND  $01
	LD   (IX+XNO),E
	LD   (IX+XNO+1),A
	DEC  (IX+CNT1)			; change of direction counter
	RET  NZ

	LD   A,(RND1)			; random 1..29 for the next direction change
	AND  $1C
	INC  A
	LD   (IX+CNT1),A
	LD   A,TYP_HOMINGSAUCERY
	LD   (IX+TYP),A			; TYP = Homing Saucer Y
	JP   PlayBeepFX

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

SpriteMoveX:
	LD   A,B			; b = sprite number; odd/even controls X Dir
	RRCA

SpriteMoveXFlipped:
	LD   E,(IX+XNO)		; de = XNO
	LD   D,(IX+XNO+1)
	OR   A
	JP   M,MovingLeft

	INC  DE				; move to the right
	LD   A,D
	AND  $01			; wrap X
	LD   (IX+XNO),E
	LD   (IX+XNO+1),A
	RET 

MovingLeft:
	DEC  DE			; move to the left
	LD   A,D
	AND  $01			; wrap x
	LD   (IX+XNO),E
	LD   (IX+XNO+1),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

DragonMoveLeft:
	LD   E,(IX+XNO)			; XNO
	LD   D,(IX+XNO+1)
	DEC  DE					; Move to the left
	JR   DragonMover

DragonMoveRight:
	LD   E,(IX+XNO)			; XNO
	LD   D,(IX+XNO+1)
	INC  DE					; Move to the right

DragonMover:
	LD   A,D				; wrap XNO around the map
	AND  $01
	LD   (IX+XNO),E			; store XNO
	LD   (IX+XNO+1),A
	LD   A,(IX+CNT1)		; CNT1 is the sine wave index
	ADD  A,$02
	AND  $3F				; wrap it 0..63
	LD   (IX+CNT1),A
	ADD  A,low SineWave			
	LD   L,A
	LD   H,high SineWave	; $8365 SineWave
	LD   A,$38				; base line (56) to add sine onto
	ADD  A,(HL)				; add on sinewave

SineMoveMOD:
	ADD  A,(HL)				; NOP / add a,(hl)
	LD   (IX+YNO),A			; yno
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

SpinnyAliens:
	CALL SpriteMoveX

UpDownAlien:
	LD   A,(IX+CNT1)		; CNT1
	OR   A
	LD   C,A
	LD   A,(IX+YNO)			; YNO
	JP   M,AlienMoveUp
	
	ADD  A,$02
	CP   $5A				; reached the bottom of play area?
	JR   NC,FlipAlienDir

	LD   (IX+YNO),A			; YNO
	RET 

AlienMoveUp:
	SUB  $02
	JR   C,FlipAlienDir
	LD   (IX+YNO),A
	RET 

FlipAlienDir:
	LD   A,C
	CPL
	LD   (IX+CNT1),A			; CNT1
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

WaveUpdateBonus:
	CALL FindFreeSprite
	RET  P
	LD   L,TYP_BUBBLEALIEN	; TYP Bubble
	LD   H,GNO_BUBBLE		; GNO Bubble
	LD   A,(RND3)
	AND  $01
	JR   Z,SetBonusAlienType

	DEC  L					; TYP Bonus
	INC  H					; GNO Bonus

SetBonusAlienType:
	LD   (IY+TYP),L			; TYP
	LD   (IY+GNO),H			; GNO
	CALL GetRandomMapPos
	LD   (IY+XNO),L			; XNO l
	LD   (IY+XNO+1),H		; XNO h
	LD   A,(RND1)
	AND  $7F
	CP   $58
	JR   C,SetBonusY
	SUB  $58			; y 0..88

SetBonusY:
	LD   (IY+YNO),A
	LD   A,(RND2)
	LD   (IY+CNT1),A			; CNT1
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

TryRandomHomingSaucer:
	LD   A,(RND3)

HomingSaucerWeightingMod:
	AND  $FF
	RET  NZ
	CALL FindFreeSprite
	RET  P

	LD   (IY+TYP),TYP_HOMINGSAUCERX		; TYP Homing Saucer X
	CALL GetRandomMapPos
	LD   (IY+XNO),L						; XNO L
	LD   (IY+XNO+1),H					; XNO H
	LD   A,(RND1)						; Random Y  ranged 0 - 112
	AND  $7F
	CP   $70
	JR   C,SetSaucerY
	SUB  $70

SetSaucerY:
	LD   (IY+YNO),A
	LD   (IY+GNO),GNO_HOMINGALIEN
	LD   (IY+CNT1),$01

	LD   A,$01
	JP   PlayBeepFX						; "Here comes a Saucer!" sound

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

WaveUpdateSurvival:
	LD   A,(LevelEndCountdown)
	OR   A
	JR   NZ,TryRandomHomingSaucer

	LD   A,(BaddiesLeftToSpawn)
	OR   A
	JR   NZ,SpawnBaddy

	LD   HL,SpriteData
	LD   DE,$0007
	LD   B,$10
NxtSP:
	LD   A,(HL)
	OR   A
	JP   M,SPNotActive
	
	CP   $05					; exclude Homing Saucer X
	JR   Z,SPNotActive

	CP   $08					; exclude Homing Saucer Y
	JR   NZ,TryRandomHomingSaucer

SPNotActive:
	ADD  HL,DE
	DJNZ NxtSP

	LD   A,$32					; no baddies left, end of level
	LD   (LevelEndCountdown),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

SpawnBaddy:
	CALL FindFreeSprite
	RET  P

	LD   A,(BaddiesLeftToSpawn)
	DEC  A
	LD   (BaddiesLeftToSpawn),A
	LD   A,(FrameCounter)
	AND  $03
	ADD  A,A
	ADD  A,low BaddySpawnerRoutines
	LD   L,A
	LD   H,high BaddySpawnerRoutines
	LD   A,(HL)			; $8180 BaddySpawnerRoutines BaddySpawnerRoutines
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)			; call one of four baddy spawners

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

WaveUpdateAttack:
	LD   A,(LevelEndCountdown)
	OR   A
	JR   NZ,TryRandomHomingSaucer

	LD   A,(BaddiesLeftToSpawn)
	OR   A
	JR   NZ,TrySpawning

	LD   HL,SpriteData				; $8418 SpriteData SpriteData
	LD   DE,$0007
	LD   B,$10

UpdateAttackLoop:
	LD   A,(HL)						; TYP
	OR   A
	JP   M,FindNext

	CP   TYP_HOMINGSAUCERX			; Homing Saucer X
	JP   Z,FindNext

	CP   TYP_HOMINGSAUCERY			; Homing Saucer Y
	JP   NZ,TryRandomHomingSaucer

FindNext:
	ADD  HL,DE
	DJNZ UpdateAttackLoop
	
	LD   A,$32						; Wave over...
	LD   (LevelEndCountdown),A
	RET 

TrySpawning:
	CALL FindFreeSprite
	RET  P

	LD   A,(BaddiesLeftToSpawn)
	DEC  A
	LD   (BaddiesLeftToSpawn),A

	LD   A,(GameWave)
	AND  $0C			; 0000 1100
	SRL  A
	ADD  A,low BaddySpawnerRoutines
	LD   L,A
	LD   H,high BaddySpawnerRoutines			; $8180 BaddySpawnerRoutines BaddySpawnerRoutines
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

MoveXSpawner:
	LD   (IY+TYP),TYP_MOVEXALIEN		; TYP - MOVEX Alien
	CALL GetRandomMapPos
	LD   (IY+XNO),L
	LD   (IY+XNO+1),H
	LD   A,(RND1)
	AND  $1F
	ADD  A,$38
	LD   (IY+YNO),A						; YNO
	LD   (IY+GNO),GNO_SAUCER			; GNO - Saucer
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

ThrobbingSaucerSpawner:
	LD   (IY+TYP),TYP_THROBBINGSAUCER	; TYP - Throbbing Saucer
	CALL GetRandomMapPos
	LD   (IY+XNO),L
	LD   (IY+XNO+1),H
	LD   A,(RND1)
	AND  $1F
	ADD  A,$38
	LD   (IY+YNO),A						; YNO
	LD   (IY+CNT2),A
	LD   (IY+GNO),GNO_ALIEN2			; GNO - Alien2
	LD   A,(RND2)
	LD   (IY+CNT1),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

SpinnyAlienSpawner:
	LD   (IY+TYP),TYP_SPINNYALIEN			; TYP - Spinny Alien
	CALL GetRandomMapPos
	LD   (IY+XNO),L
	LD   (IY+XNO+1),H
	LD   A,(RND1)
	AND  $1F
	ADD  A,$10
	LD   (IY+YNO),A							; YNO
	LD   (IY+CNT2),A
	LD   (IY+GNO),GNO_SPINNY				; GNO - Spinny
	LD   A,(RND2)
	LD   (IY+CNT1),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

AcornAlienSpawner:
	LD   (IY+TYP),TYP_ACORNALIENDOWN	; TYP - Acorn Alien Down
	CALL GetRandomMapPos
	LD   (IY+XNO),L
	LD   (IY+XNO+1),H
	LD   A,(RND1)
	AND  $1F
	ADD  A,$20
	LD   (IY+YNO),A						; YNO
	LD   (IY+CNT2),A
	LD   (IY+GNO),GNO_ACORN				; GNO - Acorn
	LD   A,(RND2)
	LD   (IY+CNT1),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

InitialiseDragons:
	LD   A,(GameWave)
	AND  $04
	JR   Z,SetMoveMOD

	LD   A,$86			; add a, (hl) instruction, otherwise NOP
SetMoveMOD:
	LD   (SineMoveMOD),A
	LD   A,$04
	LD   (DragonsRemaining),A
	LD   HL,$002E					; XNO
	LD   B,$02
	LD   C,$08
DragonPairLoop:
	PUSH BC
	LD   E,TYP_DRAGONLEFT				; TYP DragonLeft
	LD   D,GNO_DRAGONHEADLEFT			; GNO DragonHeadLeft
	CALL CreateDragonSegment
	LD   B,$03
NextBodySegmentR:
	LD   A,L			; XNO + 8
	ADD  A,$08
	LD   L,A
	JR   NC,NoHigh1

	LD   A,H
	INC  A
	AND  $01			; wrap XNO
	LD   H,A

NoHigh1:
	CALL CreateDragonSegment
	DJNZ NextBodySegmentR

	LD   DE,$0080		; move next dragon down 128 pixels
	ADD  HL,DE
	LD   A,H
	AND  $01
	LD   H,A			; Wrap XNO
	POP  BC
	LD   A,C
	ADD  A,$10
	LD   C,A
	PUSH BC
	LD   E,TYP_DRAGONRIGHT			; TYP Dragon Right
	LD   D,GNO_DRAGONHEADRIGHT		; GNO DRagonHeadRight
	CALL CreateDragonSegment
	LD   B,$03

NextBodySegmentL:
	LD   A,L			; XNO - 8
	SUB  $08
	LD   L,A
	JR   NC,NoHigh2

	LD   A,H
	DEC  A
	AND  $01
	LD   H,A			; wrap XNO

NoHigh2:
	CALL CreateDragonSegment
	DJNZ NextBodySegmentL

	POP  BC
	LD   DE,$0080
	ADD  HL,DE
	LD   A,H
	AND  $01
	LD   H,A
	LD   A,C			; bump Sine index on + 16
	ADD  A,$10
	LD   C,A
	DJNZ DragonPairLoop
	
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

CreateDragonSegment:		; e=typ,d=gno,hl=xno,c=sine index
	EXX 
	CALL FindFreeSprite
	EXX 
	LD   (IY+TYP),E			; TYP
	LD   (IY+XNO),L			; XNO
	LD   (IY+XNO+1),H
	LD   (IY+GNO),D			; GNO
	LD   (IY+CNT1),C		; CNT1 Sine Index
	LD   (IY+YNO),$40		; YNO
	LD   A,(GameWave)
	SRL  A
	ADD  A,$0A
	LD   (IY+CNT2),A		; CNT2
	DEC  C
	DEC  C
	LD   D,GNO_DRAGONBODY	; GNO = DragonBody
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

DrawBitmap:
	PUSH HL
	CALL PixAddr
	POP  DE
	LD   A,B
	EX   AF,AF'

NextByte:
	LD   A,(DE)
	LD   (HL),A
	INC  L
	INC  DE
	DJNZ NextByte

	EX   AF,AF'
	LD   B,A
	EX   AF,AF'
	LD   A,L
	SUB  B
	LD   L,A
	CALL DownLine
	DEC  C
	JR   NZ,NextByte
	
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
;

DrawAttributes:
	EX   DE,HL
	CALL AttrAddr
	LD   A,B
	EX   AF,AF'

NextAttrByte:
	LD   A,(DE)
	LD   (HL),A
	INC  L
	INC  DE
	DJNZ NextAttrByte
	
	EX   AF,AF'
	LD   B,A
	EX   AF,AF'
	LD   A,$20
	SUB  B
	ADD  A,L
	LD   L,A
	LD   A,H
	ADC  A,$00
	LD   H,A
	DEC  C
	JR   NZ,NextAttrByte

	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Sort the sprites on Y for plotting whilst "racing the beam"
;
;

SortOnScreenSprites:			
	LD   H,high (OnScreenSpriteYLoBytes+9)
	LD   D,H
	LD   A,$09
NextPass:
	EX   AF,AF'
	LD   B,$09
	LD   L,low (OnScreenSpriteYLoBytes+9)			; HL $82d6, OnScreenSpriteYLoBytes+9 OnScreenSpriteLoBytes+9
SortLoop:
	LD   E,(HL)			; DE = which OnscreenSprite addr $82xx, e = xx part of address
	DEC  L
	LD   A,(DE)			; YNO
	ADD  A,$20
	LD   C,A
	LD   E,(HL)			; DE = previous OnScreenSprite addr
	LD   A,(DE)			; YNO
	ADD  A,$20
	CP   C
	JR   C,NoSwap

	LD   C,(HL)
	INC  L
	LD   A,(HL)			; Swap sprite order
	LD   (HL),C
	DEC  L
	LD   (HL),A
	JR   NoSwap

NoSwap:
	DJNZ SortLoop
	
	EX   AF,AF'
	DEC  A
	JR   NZ,NextPass
	
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

Sprint:
	EX   (SP),HL
	CALL Print
	EX   (SP),HL
	RET 

Print:
	LD   A,(HL)
	INC  HL
	CP   $FF
	RET  Z
	EXX 
	LD   HL,Print
	PUSH HL
	CP   $20
	JR   NC,PRChars

	ADD  A,A
	ADD  A,low CONT_TAB
	LD   L,A
	LD   H,high CONT_TAB			; $806c - CONT_TAB CONT_TAB
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
JPHL:
	JP   (HL)

PRChars:
	EXX 
PRChar:
	PUSH HL
	EX   AF,AF'
	LD   DE,(Variables_ScrnX)			; SCRNX
	CALL Lowad
	EX   AF,AF'
	CALL CharAddr
	LD   A,(Variables_High)
	OR   A
	JR   NZ,Expand

	LD   B,$08
PR_LOOP:
	LD   A,(DE)

Mode0Mod:
	NOP 
	LD   (HL),A
	INC  H
	INC  DE
	DJNZ PR_LOOP

	DEC  H
	CALL Colour
PR_OUT:
	POP  HL
	LD   A,(Variables_Direct)
	JP   MOVECUR

Expand:
	LD   C,A
	LD   A,$08

Expand2:
	LD   B,C
	PUSH AF

Expand0:
	CALL Colour
	LD   A,(DE)
Mode1Mod:
	NOP 
	LD   (HL),A
	CALL DownLine
	DJNZ Expand0

	INC  DE
	POP  AF
	DEC  A
	JR   NZ,Expand2
	JR   PR_OUT

Colour:
	LD   A,(Variables_Attr)
	INC  A
	RET  Z
	PUSH HL
	DEC  A
	EX   AF,AF'
	CALL PixToAttr
	EX   AF,AF'
	LD   (HL),A
	POP  HL
	RET 

COORDS:
	EXX 
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	INC  HL
	LD   (Variables_ScrnX),DE
	RET 

DIRECTN:
	EXX 
	LD   A,(HL)
	INC  HL
	LD   (Variables_Direct),A
	RET 

PR_MODE:
	EXX 
	LD   A,(HL)
	INC  HL
	ADD  A,low MODE_TAB
	LD   E,A
	LD   D,high MODE_TAB
	LD   A,(DE)
	LD   (Mode0Mod),A
	LD   (Mode1Mod),A
	RET 

SET_XPD:
	EXX 
	LD   A,(HL)
	INC  HL
	LD   (Variables_High),A
	RET 

RESET_PR:
	EXX 
	PUSH HL
	LD   HL,STACK
	LD   (StackPos),HL
	LD   HL,LSTACK
	LD   (LoopStack),HL
	CALL Sprint
	db MODE, NORM 
	db DIR, RIGHT 
	db PEN, $FF 
	db AT, $00, $00 
	db TABX 
	db EXPD, $00 
	db CHR 
	dw gfx_Charset
	db FIN 
	POP  HL
	RET 
	
TABULATE:
	EXX 
	LD   A,(HL)
	LD   (Variables_TabXPos),A
	INC  HL
	RET 

REPEAT:
	EXX 
	LD   A,(HL)
	INC  HL
	LD   B,(HL)
	INC  HL

REPEATL:
	PUSH AF
	PUSH BC
	PUSH HL
	CALL PRChar
	POP  HL
	POP  BC
	POP  AF
	DJNZ REPEATL
	RET 

PEN_INK:
	EXX 
	LD   A,(HL)
	INC  HL
	LD   (Variables_Attr),A
	RET 

CHAR_BASE:
	EXX 
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	INC  HL
	LD   (Variables_Chars),DE
	RET 

JSR_RUTS:
	EXX 
	PUSH IX
	LD   A,(HL)
	INC  HL
	PUSH HL
	LD   H,(HL)
	LD   L,A
	POP  IX
	INC  IX
	CALL JPHL
	PUSH IX
	POP  HL
	POP  IX
	RET 

JSR_STRING:
	EXX 
	LD   A,(HL)
	INC  HL
	PUSH HL
	LD   H,(HL)
	LD   L,A
	CALL Print
	POP  HL
	INC  HL
	RET 

CLEARSCR:
	LD   BC,$17FF
	LD   HL,$4000

CLEARMEM:
	LD   E,$01
	LD   D,H
	LD   (HL),L
	LDIR
	EXX 
	RET 

CLEARATTR:
	LD   HL,$5800
	LD   BC,$02FF
	JR   CLEARMEM

CARRIAGERETURN:
	EXX 
	LD   A,(Variables_TabXPos)
	LD   (Variables_ScrnX),A
	LD   A,(Variables_ScrnY)
	INC  A
	LD   (Variables_ScrnY),A
	RET 

BACKSPC:
	EXX 
	LD   A,(HL)
	INC  HL

MOVECUR:
	EXX 
	ADD  A,A
	ADD  A,low DirTab
	LD   L,A
	LD   H,high DirTab			; $803c DirTab
	LD   DE,(Variables_ScrnX)
	LD   A,E
	ADD  A,(HL)
	AND  $1F
	LD   E,A
	INC  L
	LD   A,D
	ADD  A,(HL)
	LD   D,A
	LD   (Variables_ScrnX),DE			; SCRNX/SCRNY
	EXX 
	RET 

HIT_FOR:
	EXX 
	LD   A,(HL)			; counter
	INC  HL
	EXX 
	LD   HL,(LoopStack)
	LD   (HL),A
	INC  L
	LD   (LoopStack),HL
	EXX 
	LD   E,L
	LD   D,H
	JR   PUTSTACK

HIT_END:
	LD   HL,(LoopStack)
	DEC  L
	DEC  (HL)
	JR   Z,HASENDLOP
	EXX 
	CALL GETSTACK
	LD   E,L
	LD   D,H
	JR   PUTSTACK

HASENDLOP:
	LD   (LoopStack),HL
	CALL GETSTACK
	EXX 
	RET 

GETSTACK:
	LD   HL,(StackPos)
	DEC  L
	LD   D,(HL)
	DEC  L
	LD   E,(HL)
	LD   (StackPos),HL
	EX   DE,HL
	RET 

PUTSTACK:
	PUSH HL
	LD   HL,(StackPos)
	LD   (HL),E
	INC  L
	LD   (HL),D
	INC  L
	LD   (StackPos),HL
	POP  HL
	RET 

TAB_TO_X:
	EXX 
	LD   A,(Variables_ScrnX)
	LD   (Variables_TabXPos),A
	RET 

X_TO_NUM:
	EXX 
	LD   A,(HL)
	INC  HL
	LD   (Variables_ScrnX),A			; SCRNX
	RET 

Y_TO_NUM:
	EXX 
	LD   A,(HL)
	INC  HL
	LD   (Variables_ScrnY),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

Rand:
	LD   HL,RND1
	LD   C,(HL)
	INC  L
	LD   A,(HL)
	SRL  C
	SRL  C
	SRL  C
	XOR  C
	INC  L
	RRA
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

CharAddr:
	LD   DE,(Variables_Chars)
	PUSH HL
	LD   L,A
	LD   H,$00
	ADD  HL,HL
	ADD  HL,HL
	ADD  HL,HL
	ADD  HL,DE
	EX   DE,HL
	POP  HL
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PixAddr:			; DE = X,Y pixel positions, returns HL screen address
	LD   A,D
	AND  $C0
	SRL  A
	SRL  A
	SRL  A
	OR   $40
	LD   H,A
	LD   A,D
	AND  $38
	ADD  A,A
	ADD  A,A
	LD   L,A
	LD   A,D
	AND  $07
	OR   H
	LD   H,A
	LD   A,E
	AND  $F8
	SRL  A
	SRL  A
	SRL  A
	OR   L
	LD   L,A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; D = Y pixel pos, E = character X position $00..$1f
;
; Returns Screen address for D, E in HL.
;

Lowad:
	LD   A,D
	RRCA
	RRCA
	RRCA
	AND  $E0
	OR   E
	LD   L,A
	LD   A,D
	AND  $18
	OR   $40
	LD   H,A
	RET

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

AttrAddr:
	EX   AF,AF'
	LD   A,H
	RRCA
	RRCA
	RRCA
	LD   H,A
	AND  $E0
	OR   L
	LD   L,A
	LD   A,H
	AND  $1F
	OR   $58
	LD   H,A
	EX   AF,AF'
	RET

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PixToAttr:
	LD   A,H
	RRCA
	RRCA
	RRCA
	AND  $03
	OR   $58
	LD   H,A
	RET

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DownLine:
	INC  H
	LD   A,H
	AND  $07
	RET  NZ
	LD   A,L
	ADD  A,$20
	LD   L,A
	RET  C
	LD   A,H
	SUB  $08
	LD   H,A
	RET 
	
; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
HitA:			; H = X1LEN, L = X1, D = X2LEN, E = X2
	LD   A,H
	ADD  A,L
	CP   E
	RET  C
	LD   A,D
	ADD  A,E
	CP   L
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
FillAttrBlocks:
	LD   L,(IX+$00)
	LD   H,(IX+$01)
	LD   C,(IX+$02)
	LD   B,(IX+$03)
	INC  IX
	LD   A,L
	CP   FIN			; FIN
	RET  Z
	LD   A,(IX+$03)
	PUSH IX
	CALL FillAttrBlock
	POP  IX
	LD   DE,$0004
	ADD  IX,DE
	JR   FillAttrBlocks

FillAttrBlock:			; hl = x,y, bc = width, height, a = colour
	LD   E,L
	LD   D,H
	CALL AttrAddr
	EX   AF,AF'
	LD   A,C
	SUB  E
	LD   C,A
	LD   A,B
	SUB  D
	LD   D,A
	EX   AF,AF'
	INC  C
	INC  D

BlkD:
	PUSH HL
	LD   B,C

Blk1:
	LD   (HL),A
	INC  HL
	DJNZ Blk1
	LD   B,D
	LD   DE,$0020
	POP  HL
	ADD  HL,DE
	LD   D,B
	DEC  D
	JR   NZ,BlkD
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

Keys:
	LD   A,(FUDLR)
	LD   (OldFUDLR),A
	LD   A,(ControlMethod)
	DEC  A
	JR   Z,KeyR
	DEC  A
	JR   Z,Kempston
	LD   BC,$0500
	CALL JoyR

JoyA:
	LD   A,$7F
	IN   A,($FE)
	OR   $E0
	INC  A
	LD   A,C
	JR   Z,JOut
	ADD  A,$20
	JR   JOut

Kempston:
	XOR  A
	IN   A,($1F)
	AND  $1F
	LD   C,A
	JR   JoyA

KeyR:
	LD   BC,$0600

JoyR:
	LD   HL,KeyTab

KeyIn:
	LD   A,(HL)
	INC  L
	IN   A,($FE)
	OR   (HL)
	INC  L
	ADD  A,$01
	CCF
	RL   C
	DJNZ KeyIn
	LD   A,C

JOut:
	LD   (FUDLR),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

AddPoints:
	LD   A,E
	ADD  A,low ScoreText
	LD   L,A
	LD   H,high ScoreText; $8095 - ScoreText ScoreText
	LD   A,D
	ADD  A,(HL)

NextDigit:
	LD   B,A
	SUB  $3A
	JR   NC,NotDone

	LD   (HL),B
	RET 

NotDone:
	ADD  A,$30
	LD   (HL),A
	DEC  L
	LD   A,(HL)
	OR   A
	RET  Z
	INC  A
	JR   NextDigit

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawScoreDigit:
	LD   A,(FrameCounter)
	INC  A
	LD   (FrameCounter),A
	AND  $07
	LD   C,A
	LD   HL,gfx_Pod1
	SRL  A
	JR   C,SetPodGFX
	LD   HL,gfx_Pod2

SetPodGFX:
	LD   (PodGFXAddr),HL
	LD   A,C				; update digit C
	LD   DE,$50B6			; screen pos of score
	ADD  A,E
	LD   E,A
	LD   A,C
	ADD  A,low ScoreText
	LD   L,A
	LD   H,high ScoreText	; $8095 - ScoreText ScoreText

DrawOneDigit:
	LD   L,(HL)
	LD   H,$00
	ADD  HL,HL
	ADD  HL,HL
	ADD  HL,HL
	ADD  HL,HL
	LD   BC,gfx_BigDigitsOffset			; gfx_BigDigits - $30 * $10 = $300
	ADD  HL,BC
	LD   (SP_Store),SP
	LD   SP,HL
	EX   DE,HL

	LD   B,$02			; 2 chars high
Next8:
	POP  DE
	LD   (HL),E
	INC  H
	LD   (HL),D
	INC  H
	POP  DE
	LD   (HL),E
	INC  H
	LD   (HL),D
	INC  H
	POP  DE
	LD   (HL),E
	INC  H
	LD   (HL),D
	INC  H
	POP  DE
	LD   (HL),E
	INC  H
	LD   (HL),D
	INC  H
	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,NextDigLine
	
	LD   A,H
	SUB  $08
	LD   H,A

NextDigLine:
	DJNZ Next8
	LD   SP,(SP_Store)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

InitIM2:
	DI  
	IM   2
	LD   HL,data_FD00
	LD   DE,data_FD00+1
	LD   BC,$0100
	LD   (HL),$FF
	LDIR

	LD   A,high data_FD00
	LD   I,A
	LD   HL,IM2_Handler
	LD   DE,$FFF4
	LD   BC,$000C
	LDIR
	EI  
	RET 

IM2_Handler:
	JP   InterruptHandler
	db $45 
	db $52 
	db $41 
	db $53 
	db $55 
	db $52 
	db $45 
	db $21 
	db $18 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

InterruptHandler:
	EI  
	PUSH AF
	LD   A,$FF
	LD   R,A
	POP  AF
	RETI

	db $F3 
	db $3E 
	db $3F 
	db $ED 
	db $56 
	db $ED 
	db $47 
	db $21 
	db $58 
	db $27 
	db $D9 
	db $FD 
	db $21 
	db $3A 
	db $5C 
	db $FB 
	db $C9 
	db $ED 
	db $53 
	db $D2 
	db $80 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PrintLevelNumber:
	LD   L,A
	LD   H,$00
	LD   DE,$0064			; hundreds
	CALL PrintLevelDigit
	LD   DE,$000A			; tens
	CALL PrintLevelDigit
	LD   DE,$0001			; units

PrintLevelDigit:
	LD   A,$2F

UnitRange:
	INC  A
	OR   A
	SBC  HL,DE
	JR   NC,UnitRange
	ADD  HL,DE
	PUSH HL
	CALL PRChar
	POP  HL
	RET 
	db $0B 
	db $78 
	db $B1 
	db $20 
	db $FB 
	db $C9 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

HaltB:
	HALT
	DJNZ HaltB
DUF:
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

WaitForBeepFXDone:
	EI  

BeepWait:
	CALL UpdateBeepFX
	LD   A,(BeepFXNum)
	OR   A
	JR   NZ,BeepWait
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayBeepFX:
	LD   C,A
	LD   A,(BeepFXNum)
	OR   A
	JR   Z,CanBeep
	CP   C
	RET  C			; already playing

CanBeep:
	LD   A,C
	LD   (BeepNum),A
	LD   (BeepFXNum),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

UpdateBeepFX:
	LD   A,(BeepNum)
	OR   A
	JR   Z,UpdateBeeper

	ADD  A,A
	LD   L,A
	LD   H,high BeepFXTable			; $8300 BeepFXTable BeepFXTable
	LD   E,(HL)
	INC  L
	LD   D,(HL)
	LD   (BeepPos),DE

UpdateBeeper:
	XOR  A
	LD   (BeepNum),A
	LD   R,A
	EI  
	LD   A,(BeepFXNum)
	OR   A
	JR   Z,DB2
	LD   HL,(BeepPos)
	LD   A,(HL)
	INC  HL
	CP   FIN			; FIN
	JR   Z,EndBeep

	LD   (BeepPos),HL
	LD   C,A
	SRL  A
	JR   C,WhiteNoise

DoNote:
	LD   A,$18
	OUT  ($FE),A
	LD   B,C
DB0:
	LD   A,R
	RET  M
	DJNZ DB0
	
	LD   A,$00
	OUT  ($FE),A
	LD   B,C
DB1:
	LD   A,R
	RET  M
	DJNZ DB1
	
	INC  C
	JR   DoNote

;

EndBeep:
	INC  A
	LD   (BeepFXNum),A
DB2:
	LD   A,R
	RET  M
	JR   DB2

DoWhiteNoise:
	LD   A,$00
	OUT  ($FE),A
	LD   A,(RND1)
	LD   B,A
BE0:
	LD   A,R
	RET  M
	DJNZ BE0

	LD   A,$18
	OUT  ($FE),A
BeatMOD:
	LD   B,$00
BE1:
	LD   A,R
	RET  M
	DJNZ BE1

	CALL Rand
	JR   DoWhiteNoise

WhiteNoise:
	LD   A,(BeatMOD+1)
	PUSH AF
	LD   A,C
	LD   (BeatMOD+1),A
	CALL DoWhiteNoise
	POP  AF
	LD   (BeatMOD+1),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ClearScreen:
	LD   (SP_Store),SP
	LD   DE,$0000
	LD   HL,$401E			; start screen address of play area to clear
	LD   C,$0C
NextRow:
	LD   B,$08

ClearCharacter:
	LD   SP,HL
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	INC  H
	DJNZ ClearCharacter

	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,InSegment

	LD   A,H
	SUB  $08
	LD   H,A

InSegment:
	DEC  C
	JR   NZ,NextRow

	LD   SP,(SP_Store)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawPlayer:
	LD   HL,PlayerX
	LD   E,(HL)
	INC  L
	LD   D,(HL)			; PlayerY
	INC  L
	LD   C,(HL)			; Player Frame
	LD   B,$10			; 16 pixels high
	CALL PixAddr
	LD   A,C
	ADD  A,A
	ADD  A,low GFXTable
	EXX 
	LD   L,A
	LD   H,high GFXTable			; $8148 GFXTable GFXTable
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	LD   (SP_Store),SP
	LD   SP,HL
	EXX 

PlayerSPLoop:
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  L
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  L
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  H
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	DEC  L
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	DEC  L
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  H
	LD   A,H
	AND  $06
	JR   NZ,NextPLSpriteLine
	
	LD   A,L
	ADD  A,$20			; down one screen row
	LD   L,A
	JR   C,NextPLSpriteLine			; if c we're in the same segment
	
	LD   A,H
	SUB  $08			; otherwise sub 8 from H to keep in the same segment
	LD   H,A

NextPLSpriteLine:
	DJNZ PlayerSPLoop

	LD   SP,(SP_Store)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawBaddies:
	LD   B,$0A			; 10 baddies on screen
	LD   C,$08
	LD   HL,OnScreenSpriteYLoBytes

DBLoop:
	PUSH BC
	PUSH HL
	LD   L,(HL)
	DEC  L			; HL = OnScreenSprite+YNO
	DEC  L
	LD   A,(HL)			; TYP
	INC  L
	OR   A
	LD   B,C
	CALL P,DrawBaddy
	POP  HL
	POP  BC
	INC  L
	DJNZ DBLoop

	RET 

DrawBaddy:
	LD   A,(HL)			; XNO
	LD   E,A			; e = XNO
	EX   AF,AF'
	INC  L
	LD   A,(HL)			; a = YNO
	AND  $FE
	RET  M

	LD   D,A			; d = YNO
	INC  L
	LD   C,(HL)			; c = GNO

	LD   B,$08			; 8 loops of 2 Pixels high = 16 pixels tall
	CALL PixAddr
	LD   A,C
	ADD  A,A
	ADD  A,low GFXTable
	EXX 
	LD   L,A
	LD   H,high GFXTable	; $8148 - GFXTable GFXTable
	LD   E,(HL)
	INC  L
	LD   D,(HL)			; DE - Graphic Addr
	EX   AF,AF'
	AND  $06			; XNO & 0110
	ADD  A,low SpriteShiftOffsets
	LD   L,A
	LD   A,(HL)			; HL $8138 SpriteShiftOffsets SpriteShiftOffsets
	INC  L
	LD   H,(HL)
	LD   L,A
	ADD  HL,DE			; GFX data addr to correct pre-shift
	LD   (SP_Store),SP
	LD   SP,HL
	EXX 

NxtTwoLines:
	POP  DE			; OR in 3 bytes wide LtoR and then 3 bytes wide RtoL on the next line
	LD   A,E
	OR   (HL)
	LD   (HL),A
	INC  L
	LD   A,D
	OR   (HL)
	LD   (HL),A
	INC  L
	POP  DE
	LD   A,E
	OR   (HL)
	LD   (HL),A
	INC  H
	LD   A,D
	OR   (HL)
	LD   (HL),A
	DEC  L
	POP  DE
	LD   A,E
	OR   (HL)
	LD   (HL),A
	DEC  L
	LD   A,D
	OR   (HL)
	LD   (HL),A
	INC  H
	LD   A,H
	AND  $06
	JR   NZ,SpNext
	LD   A,L
	ADD  A,$20			; next screen line
	LD   L,A
	JR   C,SpNext			; still in segment
	LD   A,H
	SUB  $08			; move into next segment
	LD   H,A

SpNext:
	DJNZ NxtTwoLines
	LD   SP,(SP_Store)
	RET

DrawOnScreenPods:
	LD   B,$02			; two on screen pods max
	LD   C,$05			; 5 bytes each
	LD   HL,OnScreenSprites2
DrawOSPLp:
	PUSH BC
	PUSH HL
	LD   A,(HL)
	INC  L
	OR   A
	CALL P,DrawOrbSprite
	POP  HL
	POP  BC
	LD   A,L
	ADD  A,C
	LD   L,A
	DJNZ DrawOSPLp
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawOrbittingPod:
	LD   HL,CollectedPODSprite
	LD   A,(HL)
	OR   A
	RET  M
	INC  L

DrawOrbSprite:
	LD   E,(HL)			; xno
	INC  L
	LD   A,(HL)			; yno
	AND  $FE
	RET  M
	LD   D,A			; yno
	INC  L
	LD   C,(HL)			; gno
	LD   A,E
	EX   AF,AF'
	CALL PixAddr
	LD   A,C
	ADD  A,A
	ADD  A,low GFXTable
	EXX 
	LD   L,A
	LD   H,high GFXTable			; $8148 GFXTable GFXTable
	LD   E,(HL)
	INC  L
	LD   D,(HL)
	EX   AF,AF'
	AND  $06
	ADD  A,$30
	LD   L,A
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	ADD  HL,DE
	LD   (SP_Store),SP
	LD   SP,HL
	EXX 
	LD   B,$04
NextOrbLine:
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  L
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  H
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	DEC  L
	POP  DE
	LD   A,E
	AND  (HL)
	OR   D
	LD   (HL),A
	INC  H
	LD   A,H
	AND  $06
	JR   NZ,NxtOrbLn
	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,NxtOrbLn
	LD   A,H
	SUB  $08
	LD   H,A
NxtOrbLn:
	DJNZ NextOrbLine
	
	LD   SP,(SP_Store)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ScrollMountains:
	LD   HL,(MapXPos)
	LD   A,L
	CPL
	AND  $03
	ADD  A,A
	ADD  A,low MountainTileAddrs
	LD   E,A
	LD   D,high MountainTileAddrs			; DE $8128 MountainTileAddrs MountainTileAddrs
	LD   A,(DE)
	EX   AF,AF'
	INC  E
	LD   A,(DE)
	LD   D,A
	EX   AF,AF'
	LD   E,A
	SRL  H
	RR   L
	SRL  L
	LD   A,L
	EXX 
	LD   HL,$4880			; screen address of mountains
	CPL
	AND  $03
	ADD  A,L
	LD   L,A
	EXX 
	SRL  L
	SRL  L
	LD   H,high MountainMap			; hl = $8100 MountainMap MountainMap
	LD   (MountainMapAddr),HL

	LD   B,$08
MountainMapLoop:
	PUSH BC
	PUSH DE
	PUSH HL
	LD   A,(HL)			; first on screen tile addr in HL
	ADD  A,low MountainTileAddrOffsets
	LD   L,A
	LD   A,(HL)			; $8120 MountainTileAddrOffsets MountainTileAddrOffsets
	INC  L
	LD   H,(HL)
	LD   L,A
	LD   (SP_Store),SP
	ADD  HL,DE
	LD   SP,HL			; HL = address of the preshifted, zig-zagged triple
	EXX 
	LD   A,L
	EX   AF,AF'
	LD   C,$04			; 4 characters high

NextMountLine:
	LD   B,$04			; 4 sets of 2 lines per character

NextLinePair:
	POP  DE				; zig-zag 3 bytes right, down a line and then 3 bytes left
	LD   (HL),E
	INC  L
	LD   (HL),D
	INC  L
	POP  DE
	LD   (HL),E
	INC  L
	LD   (HL),D
	INC  H
	POP  DE
	LD   (HL),E
	DEC  L
	LD   (HL),D
	DEC  L
	POP  DE
	LD   (HL),E
	DEC  L
	LD   (HL),D
	INC  H
	DJNZ NextLinePair

	LD   A,L
	ADD  A,$20			; next screen row
	LD   L,A
	JR   C,InSeg1		; still in current segment
	LD   A,H
	SUB  $08			; move into next segment
	LD   H,A

InSeg1:
	DEC  C
	JR   NZ,NextMountLine

	EX   AF,AF'			; move 4 bytes across the screen for the next block
	ADD  A,$04
	LD   L,A
	LD   H,$48
	EXX 
	LD   SP,(SP_Store)
	POP  HL				; move across the mountain map (wrapping)
	LD   A,L
	AND  $E0			; 11100000
	LD   C,A
	LD   A,L
	INC  A
	AND  $1F			; 00011111
	ADD  A,C
	LD   L,A
	POP  DE
	POP  BC
	DJNZ MountainMapLoop

	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawStars:
	LD   A,(FrameCounter)
	LD   L,A
	LD   H,high StarPositions
	AND  $01
	JR   NZ,NoPosChange
	LD   A,L			; A - which star to update
	AND  $0E
	ADD  A,low StarPositions
	LD   L,A			; $8408 - StarPositions StarPositions
	LD   A,(RND1)
	LD   (HL),A			; random X pos
	INC  L
	LD   A,(RND2)
	AND  $7F
	CP   $60
	JR   C,SetStarY
	SUB  $60			; range Y from 0..96
SetStarY:
	LD   (HL),A
NoPosChange:
	LD   L,low StarPositions			; $8408 - StarPositions StarPositions
	LD   A,(CurrentVelocity)
	LD   C,A

	LD   B,$08			; 8 stars to draw
NxtStar:
	LD   A,(HL)
	SUB  C
	LD   (HL),A
	LD   E,A			; xpos
	INC  L
	LD   D,(HL)			; ypos
	INC  L
	PUSH HL
	CALL PixAddr
	LD   A,(HL)
	OR   A
	JR   NZ,SkipStar		; only plot in a blank space
	LD   A,E				; bit position from x pos
	AND  $07
	LD   E,A
	LD   D,high BitTable	; $8400 - BitTable BitTable
	LD   A,(DE)
	OR   (HL)
	LD   (HL),A				; plot star

SkipStar:
	POP  HL
	DJNZ NxtStar

	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ExplodeBaddy:
	LD   A,E
	ADD  A,C
	LD   E,A
	LD   A,D
	ADD  A,C
	LD   D,A
	LD   B,$08
	LD   HL,ExplosionData
	LD   A,(ExplosionToggle)
	CPL
	LD   (ExplosionToggle),A
	OR   A
	JR   Z,SetExplLoop
	LD   HL,ExplosionData2

SetExplLoop:
	LD   (HL),E
	INC  L
	LD   (HL),D
	INC  L
	DJNZ SetExplLoop
	RET 

PartYOffScreen:
	INC  L
PartOffScreen:
	LD   (HL),$A8
	DEC  L
	EXX 
	LD   DE,$0000
	JR   PlotParticle

DrawExplosions:
	LD   B,$0F
	LD   HL,ExplosionData+1			; $82ae ExplosionData+1

NxtParticle:
	CALL DrawExplParticle
	INC  L
	INC  L
	DJNZ NxtParticle

DrawExplParticle:
	LD   A,B
	ADD  A,A
	ADD  A,low ExplosionVelocities
	LD   E,A
	LD   D,high ExplosionVelocities			; $804d - ExplosionVelocities ExplosionVelocities
	LD   A,(DE)
	ADD  A,(HL)
	JP   M,PartOffScreen

	LD   (HL),A
	EX   AF,AF'
	DEC  L
	DEC  E
	LD   A,(CurrentVelocity)
	LD   C,A
	LD   A,(DE)
	ADD  A,(HL)
	SUB  C
	SUB  C
	CP   $10
	JR   C,PartYOffScreen
	
	LD   (HL),A
	EXX 
	LD   E,A
	EX   AF,AF'
	AND  $FE
	LD   D,A

PlotParticle:
	CALL PixAddr
	LD   A,E
	AND  $06
	SRL  A
	ADD  A,$B5
	LD   E,A
	LD   D,$83
	LD   A,(DE)
	XOR  (HL)
	LD   (HL),A
	INC  H
	LD   A,(DE)
	XOR  (HL)
	LD   (HL),A
	EXX 
	INC  L
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ResetExplosions:
	LD   B,$10
	LD   HL,ExplosionData+1			; $82ae ExplosionData+1
RsetExpl:
	LD   (HL),$A0
	INC  L
	INC  L
	DJNZ RsetExpl
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

OrbitPod:
	LD   A,(CollectedPODSprite)
	OR   A
	RET  M
	LD   A,(PlayerX)
	ADD  A,$08
	LD   E,A
	LD   A,(RND1)
	AND  $07
	LD   C,A
	LD   A,(PlayerY)
	ADD  A,C
	LD   D,A
	LD   IX,CollectedPODSprite
	PUSH DE
	CALL Orbit
	POP  DE
	CALL Orbit
	LD   A,(CollectedPODYpos)			; YNO
	CP   $78
	RET  C
	
	CP   $C0
	LD   A,$78			; for $78 < yno < $c0 a = $78, else 0 
	JR   C,SetOrbY
	XOR  A
SetOrbY:
	LD   (CollectedPODYpos),A			; store in YNO
	RET 

Orbit:
	LD   L,(IX+ORB_XNO)			; IX+XNO
	LD   C,(IX+ORB_FLAG)			; IX+FLAG
	LD   B,(IX+ORB_XSPD)			; IX+XSPD
	CALL LRS
	LD   (IX+ORB_XSPD),B			; IX+XSPD
	LD   A,C
	AND  $03
	EX   AF,AF'
	LD   L,(IX+ORB_YNO)			; IX+YNO
	LD   E,D
	LD   B,(IX+ORB_YSPD)			; IX+YSPD
	SRL  C
	SRL  C
	CALL LRS
	LD   A,(IX+ORB_YCOUNT)			; IX+YCOUNT
	ADD  A,B
	LD   (IX+ORB_YCOUNT),A			; IX+YCOUNT
	LD   A,L
	CALL C,YMOVE

	LD   (IX+ORB_YNO),A			; IX+YNO
	LD   (IX+ORB_YSPD),B			; IX+YSPD
	EX   AF,AF'
	SLA  C
	SLA  C
	ADD  A,C
	LD   (IX+ORB_FLAG),A			; IX+FLAG
	LD   A,(IX+ORB_XCOUNT)			; IX+XCOUNT
	ADD  A,(IX+ORB_XSPD)			; IX+XSPD
	LD   (IX+ORB_XCOUNT),A			; IX+XCOUNT
	RET  NC
	LD   C,(IX+ORB_FLAG)			; IX+FLAG
	LD   A,(IX+ORB_XNO)				; IX+XNO
	CALL YMOVE
	LD   (IX+ORB_XNO),A				; IX+XNO
	RET 

YMOVE:
	ADD  A,$02
	BIT  0,C
	RET  NZ

	SUB  $04
	RET 

LRS:
	LD   A,L
	CP   E
	LD   A,B
	JR   C,HMR
	BIT  0,C
	JR   Z,UPSR
	JR   DWSR
HMR:
	BIT  1,C
	JR   Z,UPSR

DWSR:
	SUB  $08			; 8 ORBSPD
	LD   B,A
	RET  NC
	ADD  A,$08			; 8 ORBSPD
	LD   B,A
	LD   A,C
	XOR  $03
	LD   C,A
	RET 

UPSR:
	ADD  A,$08			; 8 ORBSPD
	LD   B,A
	RET  NC
	SUB  $08			; 8 ORBSPD
	LD   B,A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ClearRadar:
	LD   A,(RadarDamageTime)
	OR   A
	JR   Z,SetFill

	DEC  A
	LD   (RadarDamageTime),A
	AND  $01
	JR   Z,SetFill

	LD   A,(RND1)			; random pattern when damaged
SetFill:
	LD   E,A
	LD   D,E
	LD   (SP_Store),SP
	LD   HL,$5053			; screen pos of radar
	LD   C,$02

ClearNextChar:
	LD   B,$08

ClearNextRow:
	LD   SP,HL
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	PUSH DE
	INC  H
	DJNZ ClearNextRow

	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,SkipSeg2
	LD   A,H
	SUB  $08
	LD   H,A
SkipSeg2:
	DEC  C
	JR   NZ,ClearNextChar
	LD   SP,(SP_Store)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawRadar:
	LD   A,(StatusBarRadar)
	OR   A
	RET  Z					; radar knackered!

	LD   E,$57			; e=xpos
	LD   A,(PlayerY)
	SRL  A
	SRL  A
	SRL  A
	ADD  A,$91			; d=145+(ypos/8)
	LD   D,A
	CALL PixAddr
	LD   E,$01
	LD   D,$80
	LD   A,E
	XOR  (HL)
	LD   (HL),A
	INC  L
	LD   A,D
	XOR  (HL)
	LD   (HL),A
	INC  H
	LD   A,H
	AND  $07
	JR   NZ,DRInSeg
	
	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,DRInSeg
	
	LD   A,H
	SUB  $08
	LD   H,A
DRInSeg:
	LD   A,D
	XOR  (HL)
	LD   (HL),A
	DEC  L
	LD   A,E
	XOR  (HL)
	LD   (HL),A
	LD   HL,(MapXPos)
	LD   A,L
	SRL  H
	RR   A
	SRL  A
	ADD  A,$4C
	LD   C,A			; c=76 + (xpos / 4)
	LD   B,$0F
	LD   HL,SpriteData
	CALL PlotRadarPoints
	LD   A,(FrameCounter)
	AND  $01
	RET  NZ
	
	LD   B,$07
PlotRadarPoints:
	CALL PlotRPoint
	DJNZ PlotRadarPoints

PlotRPoint:
	LD   A,(HL)
	OR   A
	JP   M,InactiveRSprite
	PUSH HL
	INC  L
	LD   A,(HL)			; a=XNO Low
	INC  L
	LD   D,(HL)			; d=XNO high
	INC  L
	SRL  D
	RR   A
	SRL  A
	SUB  C				; radar map xpos
	AND  $7F
	ADD  A,$18			; + 24
	EX   AF,AF'
	LD   A,(HL)			; yno
	INC  L
	SRL  A
	SRL  A
	SRL  A				; /8
	ADD  A,$90			; + 144 = radar Y pos
	EXX 
	LD   D,A
	EX   AF,AF'
	LD   E,A
	EX   AF,AF'
	CALL PixAddr
	EX   AF,AF'
	AND  $07
	LD   E,A
	LD   D,$84
	LD   A,(DE)
	XOR  (HL)
	LD   (HL),A
	EXX 
	POP  HL

InactiveRSprite:
	LD   A,L
	ADD  A,$07
	LD   L,A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayTone:
	DI  
	LD   HL,(IntVec_FFF4+1)
	PUSH HL							; store INTVEC
	LD   HL,PlayToneInterrupt
	LD   (IntVec_FFF4+1),HL
	LD   L,A
	CALL DoPlayTone
	POP  HL							; retrieve INTVEC
	LD   (IntVec_FFF4+1),HL
	RET 

DoPlayTone:
	EI  
	XOR  A
	EX   AF,AF'
	LD   E,C
	LD   D,B
	DEC  DE
	LD   (operand_96CF+1),BC
	LD   (operand_96E1+1),DE
	SRL  D
	RR   E

PTDelay1:
	DEC  BC
	LD   A,B
	OR   C
	JP   NZ,PTDelay2

operand_96CF:
	LD   BC,$0279
	EX   AF,AF'
	XOR  $18
	OUT  ($FE),A
	EX   AF,AF'
	JP   PTDelay2

PTDelay2:
	DEC  DE
	LD   A,D
	OR   E
	JP   NZ,PTDelay1

operand_96E1:
	LD   DE,$0278
	EX   AF,AF'
	XOR  $18
	OUT  ($FE),A
	EX   AF,AF'
	JP   PTDelay1

PlayToneInterrupt:
	DEC  L
	JR   NZ,PTExit
	POP  AF
PTExit:
	EI  
	RETI

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DepleteHealthBars:
	CALL DepleteBar
DepleteBar:
	LD   B,$04
	LD   A,(RND1)			; initial random bar
	LD   E,A
NextBar:
	LD   A,E				; random bar MOD 4
	AND  $03
	ADD  A,A
	ADD  A,A				; x4
	ADD  A,low StatusBarRapidFire
	LD   L,A
	LD   H,high StatusBarRapidFire			; $83a7 - StatusBarRapidFire StatusBarRapidFire
	LD   A,(HL)
	OR   A
	JR   NZ,HasHealthLeft
	INC  E			; cycle around the bars
	DJNZ NextBar
	DEC  A
	LD   (PlayerKilled),A
	RET 

HasHealthLeft:
	DEC  L
	DEC  L
	LD   C,(HL)
	INC  L
	DEC  (HL)
	RET  NZ
	LD   (HL),C
	INC  L
	LD   A,(HL)
	OR   A
	RET  Z

ReduceAndDrawBar:
	DEC  (HL)			; decrement bar energy
	LD   A,$B7			; 183 - energy
	SUB  (HL)
	LD   D,A			; d=y
	INC  L
	LD   E,(HL)			; e=x
	CALL PixAddr
	LD   A,(HL)
	AND  $C3			; 11000011
	LD   (HL),A			; remove a chunk of the bar
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawStatusBars:
	PUSH HL
	CALL DrawStatusBar
	POP  HL
	JR   NZ,DrawStatusBars
	RET 

DrawStatusBar:
	LD   A,(HL)			; Status bar length
	CP   $10
	RET  Z				; max 16 pixels high

	INC  (HL)
	CP   $03
	JR   NZ,DrawBar
	OR   A
	RET 

DrawBar:
	LD   A,$B8			; 184 - 
	SUB  (HL)
	LD   D,A			; Bar Y
	INC  L
	LD   E,(HL)			; Bar X
	CALL PixAddr
	LD   A,(HL)
	OR   $3C			; OR bar into screen 00111100
	LD   (HL),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawScore:
	LD   B,$08
DigitLp:
	PUSH BC
	CALL DrawScoreDigit
	POP  BC
	DJNZ DigitLp
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawBaddyBullets:
	LD   B,$08
	LD   C,low BaddyBulletData
NxtDrawBB:
	LD   H,high BaddyBulletData			; $825d - BaddyBulletData BaddyBulletData
	LD   L,C
	PUSH BC
	LD   A,(HL)
	OR   A
	CALL P,BulletIsLive

	POP  BC
	LD   A,C
	ADD  A,$0A
	LD   C,A
	DJNZ NxtDrawBB

	RET 

BulletIsLive:
	INC  L
	LD   A,(HL)
	CP   $10
	JR   C,KillBullet
	CP   $F0
	JR   NC,KillBullet
	
	LD   E,A
	EX   AF,AF'
	INC  L
	LD   A,(HL)
	OR   A
	JP   P,DrawThisBullet
	DEC  L
KillBullet:
	DEC  L
	LD   (HL),$FF
	RET 

DrawThisBullet:
	LD   D,A
	CALL PixAddr
	EX   DE,HL
	EX   AF,AF'								; xno & 6 - can only be one of two indexes 4 or 6
	AND  $06
	ADD  A,low (BulletGFXTable-4)
	LD   L,A
	LD   H,high (BulletGFXTable-4)			;  High byte BulletGFXTable
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	LD   (SP_Store),SP
	LD   SP,HL
	EX   DE,HL
	POP  DE
	POP  BC
	LD   A,E
	OR   (HL)
	LD   (HL),A
	INC  L
	LD   A,D
	OR   (HL)
	LD   (HL),A
	INC  H
	LD   A,C
	OR   (HL)
	LD   (HL),A
	DEC  L
	LD   A,B
	OR   (HL)
	LD   (HL),A
	INC  H
	LD   A,H
	AND  $07
	JR   NZ,NextBulLine

	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,NextBulLine

	LD   A,H
	SUB  $08
	LD   H,A
NextBulLine:
	LD   A,B
	OR   (HL)
	LD   (HL),A
	INC  L
	LD   A,C
	OR   (HL)
	LD   (HL),A
	INC  H
	LD   A,D
	OR   (HL)
	LD   (HL),A
	DEC  L
	LD   A,E
	OR   (HL)
	LD   (HL),A
	LD   SP,(SP_Store)
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FindLineForBullet:
	LD   A,E
	ADD  A,$06
	LD   E,A
	LD   A,D
	ADD  A,$02
	AND  $FE
	LD   D,A
	LD   (HL),$00		; FLG
	INC  L
	LD   (HL),E			; XNO
	INC  L
	LD   (HL),D			; YNO
	INC  L
	LD   A,L
	EX   AF,AF'			; low byte offset to XMV in structure
	EX   DE,HL
	LD   A,(PlayerX)
	ADD  A,$0A
	LD   E,A
	LD   A,(PlayerY)
	ADD  A,$0E
	LD   D,A
	LD   C,$FE			; LMVEC (-2)
	LD   B,C
	LD   A,L
	SUB  E
	JR   NC,AngLeft
	NEG  
	LD   C,$02			; LPVEC +2

AngLeft:
	LD   E,A
	LD   A,H
	SUB  D
	JR   NC,AngUp
	NEG  
	LD   B,$02			; LPVEC +2

AngUp:
	LD   D,A
	EX   AF,AF'
	LD   L,A							; Low offset to bulletdata+3 (XMV)
	LD   H,high BaddyBulletData			; $82 Hi byte BaddyBulletData BaddyBulletData
	LD   A,E
	SUB  D
	JR   C,YBGA
	LD   (HL),C			; XMV
	INC  L
	LD   (HL),$00		; YMV
	INC  L
	LD   (HL),D			; INT
	INC  L
	LD   (HL),E			; COW
	INC  L
	LD   (HL),E			; BIG
	INC  L
	LD   (HL),$00		; XADD
	INC  L
	LD   (HL),B			; YADD
	RET

YBGA:
	LD   (HL),$00		; XMV
	INC  L
	LD   (HL),B			; YMV
	INC  L
	LD   (HL),E			; INT
	INC  L
	LD   (HL),D			; COW
	INC  L
	LD   (HL),D			; BIG
	INC  L
	LD   (HL),C			; XADD
	INC  L
	LD   (HL),$00		; YADD
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

UpdateLineDrawBullets:
	LD   HL,BaddyBulletData
	LD   B,$08
NextBaddyBullet:
	LD   A,(HL)
	INC  L
	OR   A
	CALL P,UpdateBaddyBullet
	LD   A,L
	ADD  A,$09
	LD   L,A
	DJNZ NextBaddyBullet
	RET 

UpdateBaddyBullet:			; "line draw" bullets
	LD   A,L
	EX   AF,AF'
	LD   A,(CurrentVelocity)
	ADD  A,A
	NEG  
	ADD  A,(HL)			; add XNO
	INC  L
	LD   D,(HL)			; d = YNO
	INC  L
	ADD  A,(HL)			; add XMV
	LD   E,A
	INC  L
	LD   A,D
	ADD  A,(HL)			; add YMV
	LD   D,A
	INC  L
	LD   C,(HL)			; C = INT
	INC  L
	LD   A,(HL)			; A = COW
	SUB  C				; - INT
	LD   (HL),A			; COW =
	JR   NC,Line1
	INC  L
	ADD  A,(HL)			; + BIG
	DEC  L
	LD   (HL),A			; COW =
	INC  L
	INC  L
	LD   A,(HL)			; XADD
	ADD  A,E
	LD   E,A
	INC  L
	LD   A,(HL)			; YADD
	ADD  A,D
	LD   D,A

Line1:
	EX   AF,AF'
	INC  A
	LD   L,A
	LD   (HL),D			; YNO
	DEC  L
	LD   (HL),E			; XNO
	LD   C,$0E
	LD   A,(PlayerX)
	ADD  A,C
	SUB  E				; -bulx
	CP   C
	RET  NC
	LD   A,(PlayerY)
	SLA  C
	ADD  A,C
	SUB  D				; buly
	CP   C
	RET  NC
	LD   (HL),$FF		; HIT! mark bullet as free
	PUSH DE
	EXX 
	POP  DE				; position of explosion
	LD   C,$00			; explosion offset
	JP   DoExplode

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ExplodePlayer:
	LD   B,$80			; 128 particles
	LD   DE,$0008
	LD   IX,gfx_Panel	; use the panel gfx memory temporarily

InitParticleLp:
	CALL Rand
	AND  $0F
	LD   C,A
	LD   A,(PlayerY)
	ADD  A,$08
	ADD  A,C
	LD   (IX+PS_PARTICLEY),A			; particle y
	LD   (IX+PS_PARTICLEX),$84			; particle x
	CALL Rand
	AND  $01
	JR   NZ,SetXdir
	DEC  A						; -1
SetXdir:
	LD   (IX+PS_XDIR),A			; x dir
	LD   (IX+PS_YDIR),$FF		; y dir
	LD   A,(RND2)
	LD   (IX+PS_XVEL),A			; x vel
	LD   A,(RND3)
	LD   (IX+PS_YVEL),A			; y vel
	ADD  IX,DE
	DJNZ InitParticleLp

	LD   A,$01
	LD   (RandParticleMaskMOD+1),A
	LD   B,$80					; 128 particles
	LD   C,$1E					; time between random mask changes
	CALL DoPlayerParticles
	LD   HL,$5000				; copy the on screen panel back to memory
	LD   DE,gfx_Panel
	LD   BC,$0800
	LDIR
	RET 

DoPlayerParticles:
	LD   HL,$01E0				; 480 frames of explosion
UpdateParticles:
	PUSH HL
	LD   IX,gfx_Panel			; temp particle data
	PUSH BC

NextParticle:
	CALL UpdateParticle
	CALL DrawParticle
	CALL ExplosionSound
	LD   DE,$0008
	ADD  IX,DE
	DJNZ NextParticle
	POP  BC
	DEC  C
	JR   NZ,NoChange
	LD   C,$1E					; reset c to 30
	LD   A,(RandParticleMaskMOD+1)
	ADD  A,A
	INC  A
	LD   (RandParticleMaskMOD+1),A
NoChange:
	POP  HL
	DEC  HL
	LD   A,H
	OR   L
	RET  Z
	JR   UpdateParticles

UpdateParticle:
	LD   A,(IX+PS_XCOUNT)		; xcount
	SUB  (IX+PS_XVEL)			; - xvel
	LD   (IX+PS_XCOUNT),A		; store xcount
	JR   NC,DoYDir
	LD   A,(IX+PS_PARTICLEX)	; part x
	ADD  A,(IX+PS_XDIR)			; +xdir
	LD   (IX+PS_PARTICLEX),A	; store part x
	LD   A,(IX+PS_XVEL)			; xvel
	SUB  $02					; -2
	JR   C,DoYDir
	LD   (IX+PS_XVEL),A			; store xvel

DoYDir:
	LD   A,(IX+PS_YDIR)			; ydir
	LD   C,A
	OR   A
	LD   A,(IX+PS_YVEL)			; yvel
	JP   P,PosYvel
	SUB  $02
	JR   NC,UpdateYvel
	LD   A,C
	NEG  
	LD   (IX+PS_YDIR),A			; store ydir
	XOR  A
	JR   UpdateYvel
PosYvel:
	ADD  A,$02
	JR   NC,UpdateYvel
	LD   A,$FF					; -1
UpdateYvel:
	LD   (IX+PS_YVEL),A			; store yvel
	LD   A,(IX+PS_YCOUNT)		; ycount
	SUB  (IX+PS_YVEL)			; -yvel
	LD   (IX+PS_YCOUNT),A		; store ycount
	RET  NC
	LD   A,(IX+PS_PARTICLEY)	; particle Y
	ADD  A,C
	LD   (IX+PS_PARTICLEY),A
	RET 
DrawParticle:
	LD   E,(IX+PS_PARTICLEX)	; e=x
	LD   A,(IX+PS_PARTICLEY)
	OR   A
	RET  M
	LD   D,A					; d=y
	CALL PixAddr
	LD   A,E
	AND  $07
	LD   E,A
	LD   D,high BitTable		; $84xx high byte BitTable BitTable
	LD   A,(DE)
	OR   (HL)
	LD   (HL),A					; write to screen
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ExplosionSound:
	CALL Rand
	LD   A,(RND1)

RandParticleMaskMOD:
	AND  $01
	RET  NZ
	LD   A,(RND2)
	AND  $18
	OUT  ($FE),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ScrollInertia:
	db $00 

ScrollDirection:
	db $00 

PlayerYInertia:
	db $97 

PlayerYDir:
	db $02 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayerControl:
	LD   A,(FUDLR)
	PUSH AF
	PUSH AF
	ADD  A,A
	AND  $06
	ADD  A,low PlayerMoveLeftRightTable			; $9d low byte of PlayerMoveLeftRightTable
	CALL DoPlayerMoveFunc						; handle left/right movement
	POP  AF
	SRL  A
	AND  $06
	ADD  A,low PlayerMoveUpDownTable			; $a5 low byte of PlayerMoveUpDownTable
	CALL DoPlayerMoveFunc						; handle up/down movement
	POP  AF
	BIT  4,A
	CALL NZ,FireProjectile

	LD   A,(ScrollDirection)
	OR   A
	JR   Z,UpdateMapPos
	LD   L,low PositiveSpeeds			; PositiveSpeeds
	JP   P,AddVelocity
	LD   L,low NegativeSpeeds			; NegativeSpeeds

AddVelocity:
	LD   A,(ScrollInertia)
	RLCA
	RLCA
	AND  $03
	ADD  A,L
	LD   L,A
	LD   H,high PositiveSpeeds			; $80c5/$80c9
	LD   A,(HL)
UpdateMapPos:
	LD   (CurrentVelocity),A			; update map position
	LD   HL,(MapXPos)
	LD   E,A
	LD   D,$00
	OR   A
	JP   P,PosVel
	DEC  D

PosVel:
	ADD  HL,DE			; add velocity to MapXPos
	LD   A,H			; Wrap Map
	AND  $01
	LD   H,A
	LD   (MapXPos),HL
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DoPlayerMoveFunc:
	LD   L,A
	LD   H,high PlayerMoveLeftRightTable
	LD   A,(HL)			; PlayerMoveLeftRightTable / PlayerMoveUpDownTable
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayerMoveRight:
	LD   A,$02
	LD   (PlayerFrame),A
	LD   A,(ScrollDirection)
	OR   A
	JP   M,PlayerDoNothing
	LD   A,$01
	LD   (ScrollDirection),A
	JR   IncreaseScrollInertia

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayerMoveLeft:
	XOR  A
	LD   (PlayerFrame),A
	LD   A,(ScrollDirection)
	CP   $01
	JR   Z,PlayerDoNothing
	LD   A,$FF
	LD   (ScrollDirection),A

IncreaseScrollInertia:
	LD   A,(ScrollInertia)
	ADD  A,$10
	JR   NC,SetScrollInertia
	LD   A,$FF

SetScrollInertia:
	LD   (ScrollInertia),A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayerDoNothing:
	LD   A,(ScrollInertia)			; decrease intertia
	SUB  $10
	JR   NC,SetScrollInertia
	XOR  A			; stop the scroll
	LD   (ScrollDirection),A
	JR   SetScrollInertia

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayerMoveDown:
	LD   A,(PlayerYDir)
	OR   A
	JP   M,MovingOppositeDir
	LD   A,$02
	LD   (PlayerYDir),A
	JR   IncreaseYInertia

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlayerMoveUp:
	LD   A,(PlayerYDir)
	CP   $02
	JR   Z,MovingOppositeDir
	LD   A,$FE
	LD   (PlayerYDir),A

IncreaseYInertia:
	LD   A,(PlayerYInertia)
	ADD  A,$20
	JR   NC,SetYIntertia
	LD   A,$FE

SetYIntertia:
	LD   (PlayerYInertia),A
	RLCA
	RLCA
	AND  $03
	LD   C,A
	LD   A,(PlayerYDir)
	OR   A
	JP   P,AddYVel
	LD   A,C			; -ve vel, make Inertia value -ve
	CPL
	LD   C,A

AddYVel:
	LD   A,(PlayerY)
	ADD  A,C			; add on +/- double intertia
	ADD  A,C
	CP   $62
	JR   C,SetY
	EX   AF,AF'			; reached the bottom of play area
	LD   A,(PlayerYDir)
	CPL
	LD   (PlayerYDir),A			; flip YDir
	XOR  A					; clear flags in A
	LD   A,(PlayerYInertia)
	SRL  A
	LD   (PlayerYInertia),A
	EX   AF,AF'
	LD   A,$60			; Y Pos at bottom of play area
	JP   P,SetY
	XOR  A				; Y Pos at top of play area
SetY:
	LD   (PlayerY),A
	RET 

MovingOppositeDir:
	LD   A,(PlayerYInertia)
	SUB  $20
	JR   NC,SetYIntertia
	XOR  A
	LD   (PlayerYDir),A
	JR   SetYIntertia

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FireProjectile:
	LD   A,(StatusBarRapidFire)			; any rapid fire energy left?
	OR   A
	JR   NZ,HasRapidFire
	LD   A,(OldFUDLR)
	BIT  4,A
	RET  NZ								; holding fire down

HasRapidFire:
	CALL FindFreeProjectile
	RET  P								; no free bolts
	
	EX   DE,HL
	LD   A,(PlayerWeaponType)
	ADD  A,A
	ADD  A,low PlayerFireTable
	LD   L,A
	LD   H,high PlayerFireTable			; $80ad PlayerFireTable
	
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FireBullet:
	EX   DE,HL
	LD   (HL), WEAPON_BULLET
	INC  L
	LD   (HL),$80		; xpos
	INC  L
	LD   A,(PlayerY)
	ADD  A,$0C
	LD   (HL),A			; ypos
	INC  L
	LD   A,(PlayerFrame)
	OR   A
	LD   A,$08			; +8
	JR   NZ,SetBulXVel
	LD   A,$F8			; -8
SetBulXVel:
	LD   (HL),A			; xvel
	LD   A,$0A
	JP   PlayBeepFX

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FireDropBomb:
	EX   DE,HL
	LD   (HL),WEAPON_BOMB
	INC  L
	LD   (HL),$80		; xpos
	INC  L
	LD   A,(PlayerY)
	ADD  A,$0C
	LD   (HL),A			; ypos
	INC  L
	LD   (HL),$04		; yvel
	INC  L
	LD   (HL),$00		; xvel
	LD   A,$0B
	JP   PlayBeepFX

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FireLaserBolt:
	EX   DE,HL
	LD   (HL),WEAPON_LASERBOLTS			; LaserBolt Type
	INC  L
	LD   A,(PlayerFrame)
	OR   A
	JR   NZ,SetBoltDir
	XOR  A

SetBoltDir:
	LD   (HL),A			; LaserBolt Direction
	INC  L
	LD   (HL),$80			; LaserBolt X
	INC  L
	LD   A,(PlayerY)
	ADD  A,$0C
	LD   (HL),A			; LaserBolt Y
	INC  L
	LD   (HL),$00
	LD   A,$09
	JP   PlayBeepFX			; ??something

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FindFreeProjectile:
	LD   B,$04			; max 4 projectiles
	LD   HL,PlayerProjectiles
	LD   DE,$0005

NextBolt:
	LD   A,(HL)
	OR   A
	RET  M			; found free bolt
	ADD  HL,DE
	DJNZ NextBolt

	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawProjectiles:
	LD   B,$04
	LD   HL,PlayerProjectiles
NxtProj:
	LD   A,(HL)
	OR   A
	CALL P,DrawProjectile
	LD   A,$05
	ADD  A,L
	LD   L,A
	DJNZ NxtProj
	RET 

DrawProjectile:
	PUSH HL
	EXX 
	ADD  A,A
	ADD  A,low PlayerDrawProjectileTable
	LD   L,A
	LD   H,high PlayerDrawProjectileTable		; $80b5 - PlayerDrawProjectileTable
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)			; call the projectile function

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawBullet:
	EXX 
	INC  L
	LD   E,(HL)				; xno
	INC  L
	LD   D,(HL)				; yno
	INC  L
	LD   A,(HL)				; xvel
	DEC  L
	DEC  L
	ADD  A,E				; x + xvel
	CP   $08
	JR   NC,BulOnScreen

	DEC  L
	POP  HL
	LD   (HL),$FF			; kill bullet
	RET 

BulOnScreen:
	LD   (HL),A				; xno
	CALL PixAddr
	LD   E,$7E			; 01111110 top bullet bit pattern
	LD   (HL),E
	INC  H
	LD   (HL),$C3		; 11000011 middle bullet bit pattern
	INC  H
	LD   A,H
	AND  $07
	JR   NZ,LastBulLine
	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,LastBulLine
	LD   A,H
	SUB  $08
	LD   H,A

LastBulLine:
	LD   (HL),E			; 01111110 bottom bullet bit pattern
	POP  HL
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawDropBomb:
	EXX 
	LD   A,(CurrentVelocity)
	LD   E,A
	INC  L
	LD   A,(HL)		; xno
	SUB  E			; - 2* plaeyr velocity
	SUB  E
	LD   (HL),A		; xno
	INC  L
	INC  L
	INC  L
	INC  (HL)		; yvel++
	LD   A,(HL)
	DEC  L
	DEC  L
	ADD  A,(HL)		; yno
	LD   (HL),A		; yno
	DEC  L
	CP   $80
	JR   C,CanDraw

	POP  HL
	LD   (HL),$FF	; Mark Bomb as free
	RET 

CanDraw:
	PUSH BC
	CALL DrawOrbSprite
	POP  BC
	POP  HL
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawLaserLine:
	EXX 
	INC  L
	LD   A,(HL)
	INC  L
	OR   A
	LD   A,(HL)			; Laser X
	JR   Z,LaserLeft
	ADD  A,$10			; move right
	CP   $F0
	LD   C,$FE			; -1
	JR   Z,RightEdge

	LD   C,$01			; +1
	LD   (HL),A			; update Laser X

RightEdge:
	INC  L
	LD   E,A			; E = Laser X
	LD   D,(HL)			; D = Laser Y
	INC  L
	LD   A,(HL)			; Laser Length
	ADD  A,C
	JP   M,StopLaser

	LD   (HL),A			; Update Length
	INC  A
	LD   C,A			; C = Length of Laser
	CALL PixAddr
	LD   A,$FF
LasLp1:
	LD   (HL),A
	DEC  L
	DEC  C
	JR   NZ,LasLp1
	POP  HL
	RET 
StopLaser:
	POP  HL
	LD   (HL),$FF			; Flag as done.
	RET 

LaserLeft:
	SUB  $10			; move left
	CP   $08
	LD   C,$FE			; -1
	JR   C,LeftEdge
	LD   C,$01			; +1
	LD   (HL),A			; Update Laser X

LeftEdge:
	INC  L
	LD   E,A			; E = Laser X
	LD   D,(HL)			; D = Laser Y
	INC  L
	LD   A,(HL)			; Laser Length
	ADD  A,C
	JP   M,StopLaser

	LD   (HL),A
	INC  A
	LD   C,A
	CALL PixAddr
	LD   A,$FF
LasLp2:
	LD   (HL),A
	INC  L
	DEC  C
	JR   NZ,LasLp2
	POP  HL
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

HitDragon:
	LD   A,C			; GNO
	AND  $FE
	CP   $06			; Dragon's Head
	JR   NZ,DestroyProjectile

	LD   A,L
	ADD  A,$06
	LD   L,A			; offset to CNT2
	DEC  (HL)			; decrement num hits to the dragon head
	JR   NZ,DestroyProjectile
	
	SUB  $06
	LD   L,A			; back to the TYP of sprite data
	LD   A,(DragonsRemaining)
	DEC  A
	LD   (DragonsRemaining),A
	JR   NZ,ExplodeDragon
	
	LD   A,$32			; ...wave is done, all dragons are dead
	LD   (LevelEndCountdown),A

ExplodeDragon:
	LD   B,$04
ExpLoop:
	LD   (HL),$FF
	LD   A,L
	ADD  A,$07
	LD   L,A
	DJNZ ExpLoop
	LD   C,$08
	CALL ExplodeBaddy
	CALL ExplodeBaddy
	LD   E,$05			; de score for killing a dragon
	LD   D,E
	JR   AddOnExtraPoints

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

CollidePlayerProjectiles:
	LD   B,$04
	LD   HL,PlayerProjectiles
NxtProjCol:
	LD   A,(HL)
	OR   A
	CALL P,ProjectileActive
	LD   A,L
	ADD  A,$05
	LD   L,A
	DJNZ NxtProjCol
	RET 

ProjectileActive:
	EXX 
	ADD  A,A
	ADD  A,low PlayerProjectileCollisionTable
	LD   L,A
	LD   H,high PlayerProjectileCollisionTable			; $80bd PlayerProjectileCollisionTable
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)			; call collision specific to this projectile

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

CollisionOccured:
	INC  L
	LD   E,(HL)			; e = xno
	INC  L
	LD   D,(HL)			; d = yno
	INC  L
	LD   C,(HL)			; c = gno
	INC  L
	LD   L,(HL)				; Low byte index into SpriteData
	LD   H,high SpriteData	; $84xx - High byte of SpriteData
	LD   A,(HL)			; TYP
	AND  $FE
	CP   $02			; Dragon Left/Right has bit 2 set
	JR   Z,HitDragon

	LD   (HL),$FF			; free up this sprite

DestroyProjectile:
	EXX 			; switch to projectile structure
	LD   (HL),$FF
	EXX 			; switch to SpriteData structure
	LD   A,C
	EX   AF,AF'
	LD   C,$08
	CALL ExplodeBaddy
	EX   AF,AF'
	SUB  $05
	ADD  A,A
	ADD  A,low BaddyScoreTable
	LD   L,A
	LD   H,high BaddyScoreTable			; $83c7 BaddyScoreTable
	LD   D,(HL)
	LD   E,$05
	INC  L
	LD   A,(HL)
	EX   AF,AF'
	CALL AddPoints
	EX   AF,AF'
	LD   D,A
	LD   E,$06
AddOnExtraPoints:
	CALL AddPoints
	POP  AF
	LD   A,$03
	JP   PlayBeepFX

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

CollideProjectile:
	EXX 
	INC  L
	LD   A,(HL)
	EX   AF,AF'
	INC  L
	LD   A,(HL)
	DEC  L
	DEC  L
	EXX 
	LD   D,A
	EX   AF,AF'
	LD   E,A
	LD   B,$0A
	LD   HL,OnScreenSprites

ProjectileLoop:
	LD   A,(HL)
	OR   A
	JP   M,NextProjectile

	INC  L
	LD   A,(HL)
	SUB  E
	DEC  L
	ADD  A,$08
	CP   $10
	JR   NC,NextProjectile

	INC  L
	INC  L
	LD   A,D
	ADD  A,$1C
	LD   C,A
	LD   A,(HL)
	ADD  A,$20
	SUB  C
	DEC  L
	DEC  L
	ADD  A,$08
	CP   $10
	JP   C,CollisionOccured

NextProjectile:
	LD   A,L
	ADD  A,$05
	LD   L,A
	DJNZ ProjectileLoop
	EXX 
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

CollideLaser:
	EXX 
	LD   C,L
	INC  L
	INC  L
	LD   A,(HL)
	EX   AF,AF'
	INC  L
	LD   A,(HL)
	LD   L,C
	EXX 
	LD   D,A
	EX   AF,AF'
	LD   E,A
	LD   B,$0A
	LD   HL,OnScreenSprites
LaserBoltLoop:
	LD   A,(HL)
	OR   A
	JP   M,NextProjectile

	INC  L
	LD   A,(HL)
	SUB  E
	DEC  L
	ADD  A,$10
	CP   $20
	JR   NC,NextLaserBolt

	INC  L
	INC  L
	LD   A,D
	ADD  A,$1C
	LD   C,A
	LD   A,(HL)
	ADD  A,$20
	SUB  C
	DEC  L
	DEC  L
	ADD  A,$08
	CP   $10
	JP   C,CollisionOccured

NextLaserBolt:
	LD   A,L
	ADD  A,$05
	LD   L,A
	DJNZ LaserBoltLoop
	EXX 
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DropOffPod:
	LD   A,(CollectedPODSprite)
	OR   A
	RET  M

	LD   A,(CollectedPODYpos)		; YNO
	CP   $60
	RET  C							; See if Orb is at bottom of screen area

	LD   HL,(MountainMapAddr)
	LD   A,L
	ADD  A,$03						; middle blocks of the map on screen
	AND  $1F						; map wrap
	LD   L,A
	LD   A,(HL)
	OR   A				; if the tile no is 0 - this is the drop off point
	RET  NZ

	LD   DE,$0205
	CALL AddPoints
	LD   A,$FF						; Disable orbitting sprite
	LD   (CollectedPODSprite),A		; TYP
	LD   A,$08
	CALL PlayBeepFX
	LD   A,(PodsToBeCollected)
	DEC  A
	LD   (PodsToBeCollected),A
	LD   HL,$5AE2					; attr address for pods on the panel
	ADD  A,L
	LD   L,A
	LD   (HL),$00					; write a black attribute over the panel pod graphic
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FindOnScreenSprites:
	LD   HL,OnScreenSprites			; reset all pods
	LD   DE,$0005
	LD   B,$0C
	LD   A,$FF

ClrLp:
	LD   (HL),A
	ADD  HL,DE
	DJNZ ClrLp

	LD   HL,(MapXPos)
	LD   DE,$0070
	ADD  HL,DE
	LD   A,H
	AND  $01
	LD   H,A			; wrap map around
	LD   (MapXMOD+1),HL
	LD   B,$0B
	LD   HL,OnScreenSprites
	EXX 

	LD   A,$10			; 16 sprites
	LD   HL,SpriteData
	CALL SprLoop

	LD   B,$03
	LD   HL,OnScreenSprites2
	EXX 
	LD   A,$08			; 8 sprites
	LD   HL,SpriteDataPODs

SprLoop:
	EX   AF,AF'
	LD   A,(HL)			; TYP
	OR   A
	CALL P,SprActive

	LD   A,L
	ADD  A,$07			; sprite data 7 bytes per entry
	LD   L,A
	EX   AF,AF'
	DEC  A
	JR   NZ,SprLoop

	RET 

SprActive:
	PUSH HL
	INC  L
	LD   C,(HL)			; XNO L
	INC  L
	LD   B,(HL)			; XNO H
	INC  L
	EX   DE,HL

MapXMOD:
	LD   HL,$014B
	OR   A
	SBC  HL,BC
	ADD  HL,HL
	EX   DE,HL
	LD   A,D
	AND  $03
	JR   Z,SprOnScreen
	POP  HL
	RET 

SprOnScreen:
	LD   A,E
	NEG  
	EXX 
	DJNZ SetUpOnScreenSpr

	INC  B
	EXX 
	POP  HL
	RET 

SetUpOnScreenSpr:
	LD   (HL),$00		; OnscreenSprite+TYP
	INC  L
	LD   (HL),A			; OnscreenSprite+XNO
	INC  L
	EXX 
	LD   A,(HL)			; SpriteData+YNO
	INC  L
	EXX 
	LD   (HL),A			; OnscreenSprite+YNO
	INC  L
	EXX 
	LD   A,(HL)			; SpriteData+GNO
	EXX 
	LD   (HL),A			; OnscreenSprite+GNO
	INC  L
	EXX 
	POP  HL
	LD   A,L			; low byte offset to SpriteData
	EXX 
	LD   (HL),A			; OnscreenSprite+SPR LOW
	INC  L
	EXX 
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ResetBaddyBullets:
	LD   HL,BaddyBulletData
	LD   DE,$000A
	LD   B,$08
RsetLP:
	LD   (HL),$FF
	ADD  HL,DE
	DJNZ RsetLP
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FindFreeSprite:
	LD   IY,SpriteData
	LD   DE,$0007
	LD   B,$10
FFSLoop:
	LD   A,(IY+$00)
	OR   A
	RET  M

	ADD  IY,DE
	DJNZ FFSLoop
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FindFreeBullet:
	LD   HL,BaddyBulletData
	LD   DE,$000A
	LD   B,$08
FindBBul:
	LD   A,(HL)
	OR   A
	RET  M
	ADD  HL,DE
	DJNZ FindBBul
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

GetRandomMapPos:			; returns 16 bit XPOS in HL
	CALL Rand
	LD   A,(RND1)
	LD   L,A
	LD   A,(RND2)
	AND  $7F
	LD   E,A
	LD   H,$00
	LD   D,H
	ADD  HL,DE
	LD   E,$80
	ADD  HL,DE
	LD   DE,(MapXPos)
	ADD  HL,DE
	LD   A,H
	AND  $01
	LD   H,A
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

RotateOutPlayArea:
	EI  
	LD   E,$08			; 8 rotates in total
NextRotate:
	HALT
	LD   HL,$4003			; screen pos
	LD   D,$10
NextCharRow:
	LD   C,$08			; 8 lines per character
NextPixelRow:
	LD   B,$0E			; 14 characters wide (two chars at a time - 28 wide)
	LD   A,L
RotateOneLine:
	OR   A
	RR   (HL)
	INC  L
	OR   A
	RL   (HL)
	INC  L
	DJNZ RotateOneLine

	LD   L,A
	CALL DownLine
	DEC  C
	JR   NZ,NextPixelRow

	LD   A,L
	XOR  $01
	LD   L,A
	DEC  D
	JR   NZ,NextCharRow

	DEC  E
	JR   NZ,NextRotate
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ColourPlayArea:			; a = attr to fill
	LD   HL,$0003			; y, x
	LD   BC,$0F1D			; height, width
	JP   FillAttrBlock
FadeUpText:
	EI  
	LD   B,$08			; fade through 8 colours
	LD   C,$40			; attribute colour
NextCol:
	PUSH BC
	LD   B,$04
	CALL HaltB
	LD   A,C
	CALL ColourPlayArea
	POP  BC
	INC  C
	DJNZ NextCol
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

InitialBonusStartTime:
	db "500" 
	db $00 

BonusStartTime:
	db "500" 
	db $00 

BonusCountDown:
	db "BUM"				; blame Joff!

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawBonusCountdown:
	LD   B,$03
	LD   DE,$400F			; Screen position for countdown timer
	LD   HL,BonusCountDown

BonusDigitLoop:
	PUSH BC
	PUSH DE
	PUSH HL
	CALL DrawOneDigit
	POP  HL
	POP  DE
	POP  BC
	INC  HL
	INC  E
	DJNZ BonusDigitLoop

	LD   HL,BonusCountDown+2
DecBonusTime:
	LD   A,(HL)
	DEC  A
	JP   M,BonusDone
	
	LD   (HL),A
	CP   $2F			; < "0"
	RET  NZ
	LD   (HL),$39			; "9"
	DEC  HL
	JR   DecBonusTime

BonusDone:
	POP  HL
	XOR  A
	RET 

	db $2F 
	db $C0 
	db $36 
	db $39 
	db $2B 
	db $18 
	db $F2 
	db $E1 
	db $AF 
	db $C9 
	db $7E 
	db $3D 
	db $FA 
	db $5E 
	db $9E 
	db $77 
	db $FE 
	db $2F 
	db $C0 
	db $36 
	db $39 
	db $2B 
	db $18 
	db $F2 
	db $E1 
	db $AF 
	db $C9 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
	org $9f00

NOTES:
	db $C3 
	db $7B 
	db $A0 
	db $EE 
	db $E1 
	db $D4 
	db $C8 
	db $BD 
	db $B2 
	db $A8 
	db $9F 
	db $96 
	db $8E 
	db $86 
	db $7E 
	db $77 
	db $70 
	db $6A 
	db $64 
	db $5E 
	db $59 
	db $54 
	db $4F 
	db $4B 
	db $47 
	db $43 
	db $3F 
	db $3B 
	db $38 
	db $35 
	db $32 
	db $2F 
	db $2C 
	db $2A 
	db $27 
	db $25 
	db $23 
	db $21 
	db $1F 
	db $1D 
	db $1C 
	db $1B 
	db $19 
	db $17 
	db $16 
	db $15 
	db $13 
	db $12 
	db $11 
	db $10 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

GOCHAN1:
	INC  HL
	PUSH HL
	AND  $7F
	CALL JUMPHL
	dw RTS1
	dw MUTE1
	dw SETFADE1

GOCHAN2:
	INC  HL
	PUSH HL
	AND  $7F
	CALL JUMPHL
	dw RTS2
	dw MUTE2
	dw SETFADE2

DRUMHL:
	LD   HL,$A6D9		;self modified
	LD   A,(HL)
	INC  HL
	LD   C,(HL)
	INC  HL
	LD   (DRUMHL+1),HL
	AND  $7F
	CALL JUMPHL
	dw RTSD
	dw DRUM1
	dw DRUM2
	dw DRUM3
	dw DRUMDONE

TRANSCOUNTDOWN:
	dw $0105

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

MenuRoutines:
	dw Menu_Keyboard
	dw Menu_Kempston
	dw Menu_Sinclair
	dw Menu_Cursor
	dw DefineKeys

HSInputJumpTable:
	dw HSWaitForKey
	dw IncrementHSChar
	dw DecrementHSChar
	dw HSWaitForKey
	
LogoData:
	db $10 						; 16 characters wide
	db $18 						; 24 pixels high
	dw gfx_HyperActiveLogo		; gfx_HyperActiveLogo
	
	db $07 						; 7
	db $28 						; 40
	dw gfx_SpecialFXLogo		; gfx_SpecialFXLogo
	
	db $13 
	db $16 
	dw gfx_HysteriaLogo

	db $0B 
	db $18 
	dw gfx_FireflyLogo

	db $10 
	db $60 
	dw gfx_Gutz

GutzColours:
	db $01 
	db $02 
	db $05 
	db $07 

AttractModeFuncs:
	dw CreditsPage
	dw HysteriaPage
	dw FireflyPage
	dw GutzPage

RDPortAscii:
	db $24 
	db $23 
	db $4D 
	db $4E 
	db $42 
	db $25 
	db $4C 
	db $4B 
	db $4A 
	db $48 
	db $50 
	db $4F 
	db $49 
	db $55 
	db $59 
	db $30 
	db $39 
	db $38 
	db $37 
	db $36 
	db $31 
	db $32 
	db $33 
	db $34 
	db $35 
	db $51 
	db $57 
	db $45 
	db $52 
	db $54 
	db $41 
	db $53 
	db $44 
	db $46 
	db $47 
	db $22 
	db $5A 
	db $58 
	db $43 
	db $56 
	
RedefinedKeys:
	db $FB 
	db $FE 
	db $FD 
	db $FE 
	db $DF 
	db $FD 
	db $DF 
	db $FE 
	db $7F 
	db $FB 
	db $7F 
	db $F7 
	
CursorKeys:
	db $EF 
	db $FE 
	db $EF 
	db $F7 
	db $EF 
	db $EF 
	db $F7 
	db $EF 
	db $EF 
	db $FB
	
SinclairKeys:
	db $EF 
	db $FE 
	db $EF 
	db $FD 
	db $EF 
	db $FB 
	db $EF 
	db $EF 
	db $EF 
	db $F7 
	
MenuKeyTable:
	db $EF 
	db $FE 
	db $F7 
	db $FE 
	db $F7 
	db $FD 
	db $F7 
	db $FB 
	db $F7 
	db $F7 
	db $F7 
	db $EF 
	db $EF 
	db $EF 
	db $EF 
	db $F7 
	db $EF 
	db $FB 
	db $EF 
	db $FD 
	
HighScoreTable:
	db "COL  00352170", RTN, RTN 
	db "KAZ  00273540", RTN, RTN
	db "ROS  00212050", RTN, RTN
	db "POL  00161230", RTN, RTN
	db "RAY  00139460", RTN, RTN
	db "RAB  00081890", RTN, RTN
	db "DUG  00024320", RTN, RTN
	db "JOF  0000416"
HighScoreTableEnd:
	db "0", FIN, FIN 
	db "BASTARD FACED"

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Start - The Game entry point...
;
	
Start:
	DI  
	LD   SP,$FFF2
	XOR  A
	OUT  ($FE),A
	LD   (ScrollCounter),A
	LD   HL,ScrollingText-1		
	LD   (ScrollingTextAddr),HL
	CALL Sprint
	db RSET
	db CLA 
	db CLS 
	db FIN 
	
	CALL InitIM2
	LD   BC,$00FB
	LD   A,$19
	CALL PlayTone
	CALL DoAttractSequence

GameLoop:
	CALL InitIM2
	CALL WaitForKeyUp
	CALL Sprint
	db RSET
	db CLA 
	db CLS 
	db FIN 
	CALL FrontEnd
	CALL JP_PlayGame
	CALL InitIM2
	CALL DoHighScoreTable
	JR   GameLoop

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FrontEnd:
	LD   DE,$3040			; de=YYXX
	XOR  A					; Hyper Active Logo
	CALL DrawBitmapA
	
	LD   DE,$7808
	LD   A,$01				; Special FX Logo
	CALL DrawBitmapA

	LD   DE,$78C0
	LD   A,$01				; Special FX Logo
	CALL DrawBitmapA
	
	CALL Sprint
	db RSET
	db AT
	db $0B 			; 11
	db $0B 			; 11
	db TABX
	db "- SELECT -" 
	db RTN,RTN
	db "1 KEYBOARD"  
	db RTN
	db "2 KEMPSTON" 
	db RTN
	db "3 SINCLAIR"
	db RTN
	db "4 CURSOR  " 
	db RTN
	db "5 NEW KEYS" 
	db RTN
	db AT
	db $00 			; 0
	db $17 			; 23
	db $5B, $5C," 1988 SPECIAL FX SOFTWARE LTD."
	db JSR
	dw FillAttrBlocks 
	db $0B, $0B, $14, $0B, WHITE 			; x,y,w,h,A
	db $0D, $0B, $12, $0B, WHITE + BRIGHT 			
	db $01, $0E, $07, $0F, WHITE + BRIGHT 			
	db $01, $10, $07, $13, CYAN  + BRIGHT 			
	db $18, $0E, $1E, $0F, WHITE + BRIGHT 
	db $18, $10, $1E, $13, CYAN  + BRIGHT 
	db $08,	$06, $17, $07, WHITE + BRIGHT
	db $08,	$08, $17, $08, WHITE
	db $0B,	$0D, $0B, $11, WHITE + BRIGHT
	db $0D, $0D, $14, $11, WHITE
	db $00,	$17, $1F, $17, WHITE 
	db FIN 							; FIN (DrawAttrBlocks)
	db FIN 							; FIN (SPRINT)
	
	LD   HL, ATTRADDR+(6 * 32)+10 	 
	LD   A, WHITE					
	LD   B, 5
AtrLp:
	INC  L
	INC  L
	LD   (HL),A
	DJNZ AtrLp
	INC  L
	LD   (HL),A
	INC  L
	LD   (HL),A

	CALL WaitForKeyUp
	CALL PlayMusic

	LD   DE,$0BB8
TimeOutLoop:
	HALT
	DEC  DE
	LD   A,D
	OR   E
	JP   Z,Start			; back to attract sequence

	CALL GetMenuKeys
	OR   A
	JR   Z,TimeOutLoop

	CP   $06
	JR   NC,TimeOutLoop

	PUSH AF
	LD   BC,$003F			; Beeeep!
	LD   A,$0C
	CALL PlayTone

	POP  AF
	LD   (ControlMethod),A
	ADD  A,A
	ADD  A,low (MenuRoutines-2)
	LD   L,A
	LD   H,high (MenuRoutines-2)			
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	CALL JPHL
	JP   FrontEnd
	
Menu_Keyboard:
	LD   HL,RedefinedKeys
	LD   DE,KeyTab+4
	LD   BC,$0008
	LDIR
	LD   DE,KeyTab+2
	LDI
	LDI
	LD   DE,KeyTab
	LDI
	LDI
	
Menu_Kempston:
	POP  HL
	RET 
	
Menu_Sinclair:
	LD   HL,SinclairKeys
	JR   SetJoy

Menu_Cursor:
	LD   HL,CursorKeys
SetJoy:
	LD   DE,KeyTab
	LD   BC,$000A
	LDIR
	POP  HL
	RET 


DefineKeys:
	EI  
	CALL BlankScreenOut
	LD   HL,UserKeys
	LD   DE,UserKeys+1
	LD   BC,$0005
	LD   (HL),"?"			; '?'
	LDIR
	CALL Sprint
	db PEN, WHITE 
	db AT, $0B, $0D 
	db TABX 
	db "UP", RTN 
	db "DOWN", RTN 
	db "LEFT", RTN 
	db "RIGHT", RTN 
	db "FIRE", RTN 
	db "HOLD", RTN 
	db DIR, DOWN 
	db PEN, WHITE + BRIGHT
ShowKeys:	 
	db AT, $14, $0D 
UserKeys:
	db "JOFFA!" 
	db FIN

	LD   B,$06
	LD   HL,RedefinedKeys
	LD   IX,UserKeys

RedefineNxtKey:
	PUSH BC
	PUSH HL
	CALL WaitForKeyUp
	CALL SelectUniqueKey
	LD   (IX+$00),A
	PUSH BC
	CALL Sprint
	db JSRS 
	dw ShowKeys 
	db FIN 			;
	LD   A,$01			; sound effect 1
	CALL PlaySoundUntilDone
	CALL WaitForKeyUp
	POP  BC
	POP  HL
	LD   A,C
	LD   (HL),A
	INC  HL
KeyPressed_1:
	LD   A,$80
	OR   $E0
	LD   (HL),A
	INC  HL
	POP  BC
	INC  IX
	DJNZ RedefineNxtKey

	LD   B,$64
	CALL HaltB
BlankScreenOut:
	LD   HL,$0D0B
	LD   BC,$1214
	XOR  A
	JP   FillAttrBlock

SelectUniqueKey:
	HALT
	CALL ScanKeyboard
	JR   NZ,SelectUniqueKey
	LD   A,B
	DEC  A
	LD   B,E
	LD   C,D
	LD   HL,$9F95			; RDPortAscii-5 RDPortAscii
	LD   DE,$0005
UnqLp:
	ADD  HL,DE
	DJNZ UnqLp

	ADD  A,L
	LD   L,A
	LD   A,(HL)
	LD   B,$06
	LD   HL,UserKeys
NxtKey:
	CP   (HL)
	JR   Z,SelectUniqueKey
	INC  HL
	DJNZ NxtKey
	RET 

;
;
;

ScanKeyboard:
	LD   DE,$FE08			; D bitmask ($fe), E = 8 rows to read
ReadQuad:
	LD   B,$05			; 5 possible presses per row
ReadRow:
	LD   A,B
	DEC  A
	ADD  A,A
	ADD  A,A
	ADD  A,A
	ADD  A,$47
	LD   (ModBit+1),A
	LD   A,D
	IN   A,($FE)
	LD   (KeyPressed_1+1),A
ModBit:
	BIT  0,A
	RET  Z
	DJNZ ReadRow
	SLA  D
	INC  D
	DEC  E
	JR   NZ,ReadQuad
	INC  E
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DoHighScoreTable:

	CALL WaitKey
	CALL TryInsertScore
	CALL PrintHighScores
	LD   HL,$02EE

HSCountDownLoop:
	HALT
	HALT
	PUSH HL
	CALL CycleHighScoreColours
	CALL Keys
	POP  HL
	OR   A
	RET  NZ
	DEC  HL
	LD   A,L
	OR   H
	JR   NZ,HSCountDownLoop
	RET 

CycleHighScoreColours:
	LD   HL,$580A			; Attribute line
	LD   DE,$0033

AttrValueMOD:
	LD   A,$00
	DEC  A
	LD   (AttrValueMOD+1),A
	LD   C,$07			; cycle through 7 scores
NextScoreAttr:
	CALL ColourScoreLine
	ADD  HL,DE
	DEC  C
	JR   NZ,NextScoreAttr

ColourScoreLine:
	LD   B,$03			; set ATTRs on three characters
	PUSH AF
	CPL
	CALL FillAttrB
	LD   B,$0A			; set ATTRs on 10 characters
	POP  AF
	INC  A

FillAttrB:
	AND  $07
	ADD  A,$40
FillNextAttr:
	LD   (HL),A
	INC  L
	DJNZ FillNextAttr
	RET 


TryInsertScore:
	LD   B,$08
	LD   HL,HighScoreTable+5

SearchTable:
	PUSH BC
	PUSH HL
	LD   DE,ScoreText
	LD   B,$08
	EX   DE,HL
	CALL StrCmp
	POP  HL
	POP  BC
	JR   C,InsertScore
	LD   DE,$000F
	ADD  HL,DE
	DJNZ SearchTable
	RET 

StrCmp:
	LD   A,(DE)
	CP   (HL)
	RET  NZ
	INC  HL
	INC  DE
	DJNZ StrCmp
	OR   A
	RET 

PrintHighScores:
	HALT
	CALL Sprint
	db RSET 
	db AT, $0A, $00 
	db TABX 
	db JSRS 			
	dw HighScoreTable
	db JSR 
	dw FillAttrBlocks 
	db $0A, $00, $0D, $0E, CYAN + BRIGHT
	db $0F, $00, $16, $0E, WHITE + BRIGHT 
	db FIN 
	db PEN, CYAN
	db FIN 

	RET 

InsertScore:
	PUSH BC
	LD   C,B
	PUSH HL
	LD   HL,HighScoreTableEnd
	LD   DE,HighScoreTableEnd+15
	XOR  A

ShiftScoreLoop:
	INC  A
	PUSH BC
	LD   BC,$000D			; 13 chars per highscore entry
	LDDR
	DEC  HL
	DEC  HL
	DEC  DE
	DEC  DE
	POP  BC
	CP   C
	JR   Z,InsertionPoint
	CP   $08
	JR   NZ,ShiftScoreLoop

InsertionPoint:
	POP  HL
	PUSH HL
	EX   DE,HL
	LD   HL,ScoreText
	LD   BC,$0008
	LDIR			; insert score into table

	POP  HL
	DEC  HL
	DEC  HL
	DEC  HL
	LD   A,$20			; clear name at this position
	LD   (HL),A
	DEC  HL
	LD   (HL),A
	DEC  HL
	LD   (HL),A
	LD   (NamePositionMOD+1),HL
	CALL PrintHighScores
	POP  BC
	LD   A,$10
	SUB  B
	SUB  B
	LD   L,$0A						; x=10
	LD   H,A						; y = 16 - position in table
	LD   C,$16						; 22 wide
	LD   B,H
	LD   (Variables_ScrnX),HL		; SCRNX, SCRNY
	LD   A,$07
	CALL FillAttrBlock
	LD   A,$41			; "A"

PrintHSChar:
	PUSH AF
	CALL PRChar
	LD   A,(Variables_ScrnX)			; SCRNX
	DEC  A
	LD   (Variables_ScrnX),A
	LD   A,$0A
	CALL PlaySoundUntilDone
	POP  AF
	LD   HL,$05DC
	LD   (CountDownTimeMOD+1),HL

HSWaitForKey:
	HALT
	EX   AF,AF'
CountDownTimeMOD:
	LD   HL,$0000
	DEC  HL
	LD   (CountDownTimeMOD+1),HL
	LD   A,L
	OR   H
	RET  Z
	EX   AF,AF'
	PUSH AF
	CALL Keys
	BIT  4,A
	JR   NZ,InsertLetter

	AND  $03
	ADD  A,A
	ADD  A,low HSInputJumpTable
	LD   L,A
	LD   H,high HSInputJumpTable			; $9f72 HSInputJumpTable HSInputJumpTable
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	POP  AF
	JP   (HL)

IncrementHSChar:
	INC  A
	CP   $5B
	JR   NZ,PrintHSChar
	LD   A,$40
	JR   PrintHSChar

DecrementHSChar:
	DEC  A
	CP   $3F
	JR   NZ,PrintHSChar
	LD   A,$5A
	JR   PrintHSChar

InsertLetter:
	POP  AF
NamePositionMOD:
	LD   HL,$0000
	LD   (HL),A
	INC  HL
	LD   (NamePositionMOD+1),HL
	PUSH AF
	CALL WaitKey
	LD   A,$0B
	CALL PlaySoundUntilDone
	POP  AF
	LD   C,A
	LD   A,(Variables_ScrnX)			; SCRNX
	INC  A
	LD   (Variables_ScrnX),A
	CP   $0D
	LD   A,C
	JR   NZ,PrintHSChar
	LD   A,$02
	JP   PlaySoundUntilDone

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

WaitKey:
	CALL Keys
	OR   A
	JR   NZ,WaitKey
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

WaitForKeyUp:
	CALL Rand
	XOR  A
	IN   A,($FE)
	OR   $E0
	INC  A
	JR   NZ,WaitForKeyUp
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

WaitForKeyDown:
	CALL Rand
	XOR  A
	IN   A,($FE)
	OR   $E0
	INC  A
	JR   Z,WaitForKeyDown
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

GetMenuKeys:
	LD   BC,$0A00
	LD   HL,MenuKeyTable

ScanKeys:
	LD   A,(HL)
	INC  HL
	IN   A,($FE)
	OR   (HL)
	INC  A
	JR   NZ,KeyPressed
	INC  HL
	INC  C
	DJNZ ScanKeys
	OR   A
	RET 

KeyPressed:
	LD   A,C
	SCF
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

PlaySoundUntilDone:
	PUSH BC
	PUSH HL
	LD   (BeepNum),A
	LD   (BeepFXNum),A
	CALL WaitForBeepFXDone
	POP  HL
	POP  BC
	RET

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Fuzz-Click Music Player
;	

MUS_S              EQU  128
MUS_REP            EQU  0

MUS_RTS            EQU  MUS_S+0
MUS_END            EQU  MUS_RTS
MUS_REST           EQU  MUS_S+1
MUS_FAD            EQU  MUS_S+2
MUS_TRN            EQU  MUS_S+3


PlayMusic:
	DI  
	LD   (Saved_SP+1),SP
	LD   HL,HA_Music_1
	LD   (WORKC1+1),HL
	LD   HL,HA_Music_2
	LD   (WORKC2+1),HL
	LD   HL,HA_Music_3
	LD   (WORKDR+1),HL

	LD   HL,$0180
	LD   (TRANSCOUNTDOWN),HL

	LD   HL,INTERMUS
	LD   (IntVec_FFF4+1),HL			; INTVEC

	XOR  A
	LD   (APK1+1),A
	LD   (APK2+1),A
	LD   (APK3+1),A
	LD   (APK4+1),A
	LD   (TRANS+1),A
	CALL WORKC1
	CALL WORKC2
	CALL WORKDR
	LD   C,$01
	EXX 
	LD   BC,$0101
	EI  
	HALT

MUSIC:
	CALL C,FADE
	LD   A,B
	OR   A
	JR   NZ,MEG1

CHANHL1:
	LD   HL,$A6F0

GETC_1:
	LD   A,(HL)
	OR   A
	JP   M,GOCHAN1
	CALL GET_NOTE

	LD   (DPK1+1),A
	SRL  A
	SRL  A
	SRL  A
	LD   D,A
	LD   (APK1A+1),A
	XOR  A
	LD   (FADE+1),A
	INC  A
	LD   (APK0+1),A
	LD   A,(APK1+1)
	OR   $18
	LD   (APK1+1),A
	INC  HL

GETD1:
	LD   A,(HL)
	LD   (TIME0+1),A
	INC  HL
	LD   (CHANHL1+1),HL

TIME0:
	LD   B,$0C
	JR   MEG2
MEG1:
	LD   A,$03
M1:
	DEC  A
	JR   NZ,M1
MEG2:
	DEC  D
	JR   NZ,MEG3
DPK1:
	LD   D,$70
APK0:
	LD   A,$01
M2:
	DEC  A
	JR   NZ,M2
APK1:
	LD   A,$18
	OUT  ($FE),A
APK1A:
	LD   A,$0E
M3:
	DEC  A
	JR   NZ,M3
APK2:
	LD   A,$00
	OUT  ($FE),A
MEG3:
	LD   A,C
	OR   A
	JR   NZ,AVALX

CHANHL2:
	LD   HL,$A785

GETC_2:
	LD   A,(HL)
	OR   A
	JP   M,GOCHAN2
	CALL GET_NOTE
	LD   (EPK1+1),A
	SRL  A
	SRL  A
	LD   (APK3A+1),A
	LD   E,A
	XOR  A
	LD   (FADE2+1),A
	INC  A
	LD   (APK2A+1),A
	LD   A,(APK3+1)
	OR   $18
	LD   (APK3+1),A
	INC  HL

GETD2:
	LD   A,(HL)
	LD   (CPK1+1),A
	INC  HL
	LD   (CHANHL2+1),HL

CPK1:
	LD   C,$06
	JR   OVER2

AVALX:
	LD   A,$03
M4:
	DEC  A
	JR   NZ,M4
OVER2:
	DEC  E
	JP   NZ,MUSIC

EPK1:
	LD   E,$3F
APK2A:
	LD   A,$01
M5:
	DEC  A
	JR   NZ,M5
APK3:
	LD   A,$18
	OUT  ($FE),A
APK3A:
	LD   A,$0F
M6:
	DEC  A
	JR   NZ,M6
APK4:
	LD   A,$00
	OUT  ($FE),A
	JP   MUSIC

SETFADE1:
	POP  HL
	LD   A,(HL)
	LD   (FADECP1+1),A
	INC  HL
	JP   GETC_1

SETFADE2:
	POP  HL
	LD   A,(HL)
	LD   (FADECP2+1),A
	INC  HL
	JP   GETC_2

MUTE1:
	POP  HL
	LD   A,(APK1+1)
	AND  $07
	LD   (APK1+1),A
	JP   GETD1

MUTE2:
	POP  HL
	LD   A,(APK3+1)
	AND  $07
	LD   (APK3+1),A
	JP   GETD2

RTS1:
	POP  HL
	CALL WORKC1
	JP   CHANHL1

RTS2:
	POP  HL
	CALL WORKC2
	JP   CHANHL2

FADE:
	LD   A,$02
	INC  A
	LD   (FADE+1),A

FADECP1:
	CP   $FF
	JR   C,FADE2
	XOR  A
	LD   (FADE+1),A
	LD   HL,APK1A+1
	DEC  (HL)
	JR   Z,FADE1
	LD   HL,APK0+1
FADE1:
	INC  (HL)
FADE2:
	LD   A,$00
	INC  A
	LD   (FADE2+1),A
FADECP2:
	CP   $02
	RET  C
	XOR  A
	LD   (FADE2+1),A
	LD   HL,APK3A+1
	DEC  (HL)
	JR   Z,FADE3
	LD   HL,APK2A+1
FADE3:
	INC  (HL)
	RET

WORKC1:
	LD   HL,$A681
WRKC1:
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	INC  HL
	LD   A,E
	OR   D
	JR   NZ,NORES1
	
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	EX   DE,HL
	JR   WRKC1

NORES1:
	LD   (WORKC1+1),HL
	LD   (CHANHL1+1),DE
	RET 

WORKC2:
	LD   HL,$A6B9
WRKC2:
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	INC  HL
	LD   A,E
	OR   D
	JR   NZ,NORES2
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	EX   DE,HL
	JR   WRKC2
NORES2:
	LD   (WORKC2+1),HL
	LD   (CHANHL2+1),DE
DRUMDONE:
	RET 

WORKDR:
	LD   HL,$A6CF
WRKDR:
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	INC  HL
	LD   (WORKDR+1),HL
	LD   (DRUMHL+1),DE
	LD   A,E
	OR   D
	RET  NZ
	LD   E,(HL)
	INC  HL
	LD   D,(HL)
	EX   DE,HL
	JR   WRKDR

RTSD:
	CALL WORKDR
	JP   DRUMHL

DRUM1:
	LD   E,$23
	XOR  A
	LD   HL,$0100

DRUM1NOISE:
	XOR  $18
	OUT  ($FE),A
	LD   B,(HL)

DRUM1LOOP:
	DJNZ DRUM1LOOP
	INC  HL
	DEC  E
	JR   NZ,DRUM1NOISE
	RET 

DRUM2:
	LD   HL,$005A
DRUM2LOOP:
	LD   A,(HL)
	OR   A
	RET  Z
	AND  $18
	OR   $00
	OUT  ($FE),A
	INC  HL
	JR   DRUM2LOOP

DRUM3:
	LD   HL,$0F18
	LD   D,$10
DRUM3LOOP3:
	LD   B,(HL)
DRUM3LOOP:
	DJNZ DRUM3LOOP

	LD   A,$18
	OUT  ($FE),A
	INC  HL
	LD   B,(HL)
DRUM3LOOP2:
	DJNZ DRUM3LOOP2

	LD   A,$00
	OUT  ($FE),A
	INC  HL
	DEC  D
	JR   NZ,DRUM3LOOP3
	RET 

JUMPHL:
	POP  HL
	ADD  A,A
	ADD  A,L
	LD   L,A
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   (HL)

GET_NOTE:
	PUSH HL
TRANS:
	ADD  A,$00
	ADD  A,low (NOTES+3)
	LD   L,A
	LD   H,high (NOTES+3)			; $9f00 NOTES NOTES
	LD   A,(HL)
	POP  HL
	RET 

INTERMUS:
	PUSH AF
	PUSH DE
	PUSH HL
	DEC  C
	DEC  B
	EXX 
	DEC  C
	CALL Z,DRUMHL

	LD   HL,(TRANSCOUNTDOWN)
	DEC  HL
	LD   A,H
	OR   L
	JR   NZ,COUNTDOWN
	
	LD   A,(TRANS+1)
	XOR  $02
	LD   (TRANS+1),A
	LD   HL,$0180

COUNTDOWN:
	LD   (TRANSCOUNTDOWN),HL
	XOR  A
	IN   A,($FE)
	CPL
	AND  $1F
	JR   NZ,MUSICRET

	EXX 
	POP  HL
	POP  DE
	POP  AF
	SCF
	EI  
	RETI

MUSICRET:
	LD   HL,InterruptHandler
	LD   (IntVec_FFF4+1),HL			; INTVEC

Saved_SP:
	LD   SP,$FFEE
	EI  
	RETI

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Music Data
;

HA_Music_1:
	dw SEQ1
	dw SEQ1
	dw SEQ1
	dw SEQ1
	dw SEQ1
	dw SEQ1
	dw SEQ1
	dw SEQ2
	dw SEQ2
	dw SEQ2
	dw SEQ2
	dw SEQ2
	dw SEQ2
	dw SEQ2
	dw SEQ2
	dw MUS_REP
	dw HA_Music_1

HA_Music_2:
	dw SEQ3
	dw SEQ3
	dw SEQ3
	dw SEQ3
	dw SEQ3
	dw SEQ3
	dw SEQ3
	dw SEQ3
	dw SEQ4
	dw SEQ4
	dw SEQ5
	dw SEQ5
	dw SEQ6
	dw SEQ6
	dw SEQ6
	dw SEQ6
	dw SEQ6
	dw SEQ6
	dw SEQ6
	dw SEQ6
	dw SEQ7
	dw SEQ7
	dw MUS_REP
	dw HA_Music_2

HA_Music_3:
	dw SEQ8
	dw MUS_REP
	dw HA_Music_3

SEQ8:
	db $81 
	db $0C 
	db $82 
	db $0C 
	db $81 
	db $0C 
	db $82 
	db $06 
	db $82 
	db $06 
	db $81 
	db $0C 
	db $82 
	db $0C 
	db $81 
	db $06 
	db $83 
	db $06 
	db $82 
	db $06 
	db $82 
	db $06 
	db $80 

SEQ1:
	db $82 
	db $FF 
	db $01 
	db $12 
	db $0D 
	db $0C 
	db $01 
	db $06 
	db $0D 
	db $0C 
	db $04 
	db $0C 
	db $03 
	db $06 
	db $04 
	db $0C 
	db $03 
	db $06 
	db $04 
	db $06 
	db $03 
	db $06 
	db $80 

SEQ2:
	db $01 
	db $0C 
	db $0D 
	db $0C 
	db $01 
	db $0C 
	db $0D 
	db $06 
	db $0D 
	db $06 
	db $01 
	db $0C 
	db $0D 
	db $0C 
	db $01 
	db $0C 
	db $0D 
	db $06 
	db $0D 
	db $06 
	db $80 

SEQ3:
	db $82 
	db $02 
	db $0D 
	db $06 
	db $14 
	db $06 
	db $19 
	db $06 
	db $0D 
	db $06 
	db $12 
	db $06 
	db $14 
	db $06 
	db $0D 
	db $06 
	db $12 
	db $06 
	db $14 
	db $06 
	db $0D 
	db $06 
	db $12 
	db $06 
	db $14 
	db $06 
	db $0D 
	db $06 
	db $10 
	db $06 
	db $0F 
	db $06 
	db $0B 
	db $06 
	db $80 

SEQ4:
	db $0D 
	db $06 
	db $19 
	db $0C 
	db $0D 
	db $06 
	db $17 
	db $0C 
	db $0D 
	db $06 
	db $14 
	db $0C 
	db $14 
	db $0C 
	db $10 
	db $0C 
	db $12 
	db $06 
	db $14 
	db $0C 
	db $0D 
	db $06 
	db $19 
	db $0C 
	db $0D 
	db $06 
	db $17 
	db $0C 
	db $0D 
	db $06 
	db $14 
	db $36 
	db $80 

SEQ5:
	db $81 
	db $0C 
	db $0D 
	db $0C 
	db $14 
	db $0C 
	db $0D 
	db $0C 
	db $17 
	db $0C 
	db $0D 
	db $06 
	db $19 
	db $0C 
	db $0D 
	db $06 
	db $17 
	db $0C 
	db $81 
	db $0C 
	db $0D 
	db $0C 
	db $14 
	db $0C 
	db $0D 
	db $12 
	db $13 
	db $12 
	db $12 
	db $0C 
	db $10 
	db $0C 
	db $80 

SEQ6:
	db $17 
	db $06 
	db $0D 
	db $06 
	db $14 
	db $06 
	db $0D 
	db $06 
	db $17 
	db $06 
	db $0D 
	db $06 
	db $14 
	db $06 
	db $0D 
	db $06 
	db $17 
	db $06 
	db $0D 
	db $06 
	db $14 
	db $06 
	db $0D 
	db $06 
	db $17 
	db $06 
	db $14 
	db $06 
	db $12 
	db $06 
	db $14 
	db $06 
	db $80 

SEQ7:
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $12 
	db $06 
	db $12 
	db $06 
	db $12 
	db $06 
	db $12 
	db $06 
	db $10 
	db $06 
	db $10 
	db $06 
	db $17 
	db $06 
	db $17 
	db $06 
	db $17 
	db $06 
	db $17 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $14 
	db $06 
	db $80 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ScrollCounter:
	db $4B 

ScrollingTextAddr:
	dw $AC62

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DoAttractSequence:
	LD   (SP_Store),SP
	LD   HL,DoScrollTextINT
	LD   (IntVec_FFF4+1),HL
	XOR  A

AttractLoop:
	PUSH AF
	AND  $03
	ADD  A,A
	ADD  A,low AttractModeFuncs
	LD   L,A
	LD   H,high AttractModeFuncs			; $9f92 - AttractModeFuncs AttractModeFuncs
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	CALL JPHL

	CALL WipeScreen
	POP  AF
	INC  A
	JR   AttractLoop

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DoScrollTextINT:
	PUSH AF
	EX   AF,AF'
	PUSH AF
	PUSH BC
	PUSH DE
	PUSH HL
	LD   A,(ScrollCounter)
	INC  A
	LD   (ScrollCounter),A
	AND  $07
	JR   NZ,NotTime
	LD   HL,(ScrollingTextAddr)
	INC  HL
	LD   A,(HL)
	OR   A
	JP   P,NotDoneText

	LD   A,$20
	LD   HL,ScrollingText+68

NotDoneText:
	LD   (ScrollingTextAddr),HL
	CALL CharAddr
	LD   HL,$50DF					; Start screen line for scrolling message
	LD   C,$02
NextCharHalf:
	LD   B,$04
NextCharLine:
	LD   A,(DE)
	LD   (HL),A
	INC  H
	LD   (HL),A
	INC  H
	INC  E
	DJNZ NextCharLine
	DEC  H
	CALL DownLine
	DEC  C
	JR   NZ,NextCharHalf

NotTime:
	CALL ScrollText

	XOR  A
	IN   A,($FE)
	OR   $E0
	INC  A
	JR   NZ,AttractDone

	POP  HL
	POP  DE
	POP  BC
	POP  AF
	EX   AF,AF'
	POP  AF
	EI  
	RETI


AttractDone:
	LD   SP,(SP_Store)
	EI  
	RETI

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

ScrollText:					; scrolling text
	LD   HL,$50DF			; screen address of scrolling text
	CALL ScrollText8
	LD   A,L
	ADD  A,$20
	LD   L,A
	JR   C,ScrollText8
	LD   A,H
	SUB  $08
	LD   H,A

ScrollText8:
	LD   B,$08			; 8 lines
NextScrollLine:
	LD   A,L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	DEC  L
	RL   (HL)
	LD   L,A
	INC  H
	DJNZ NextScrollLine
	RET

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

CreditsPage:
	CALL Sprint
	db AT, $0B, $00 
	db "SPECIAL FX"
	db AT, $0A, $01 
	db "SOFTWARE LTD"
	db AT, $0C, $03 
	db "PRESENTS" 
	db AT, $04, $0A 
	db "BYE BYE MR SPRCTRUM MIX" 
	db AT, $05, $0E 
	db "MUSIC BY  KEITH TINMAN" 
	db AT, $0A, $10 
	db "GAME  CODING" 
	db AT, $09, $11 
	db "GRAPHIC DESIGN" 
	db AT, $05, $12 
	db "FUZZ-CLICK PROGRAMMING" 
	db AT, $0F, $13 
	db "BY" 
	db AT, $08, $14 
	db "___MI^  NATHANO]" 
	db EXPD, $02 
	db AT, $08, $07 
	db "- HYPER ACTIVE -" 
	db RSET 
	db JSR 
	dw FillAttrBlocks 
	db $0A, $00, $15, $02, WHITE 
	db $0A, $03, $15, $03, WHITE + BRIGHT 
	db $08, $07, $17, $07, WHITE + BRIGHT 
	db $08, $08, $17, $08, WHITE 
	db $04, $0A, $1B, $0A, WHITE 
	db $05, $0E, $1A, $0E, GREEN 
	db $05, $10, $1A, $14, GREEN + BRIGHT 
	db $01, $16, $1E, $16, WHITE + BRIGHT 
	db $01, $17, $1E, $17, WHITE 
	db FIN 
	db FIN

	LD   BC,$01F4
	JP   WaitBCFrames

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

HysteriaPage:
	CALL Sprint
	db JSR 
	dw FillAttrBlocks 
	db $01, $00, $1E, $15, WHITE
	db $15, $0E, $1D, $14, BLACK 
	db $16, $0F, $1C, $0F, WHITE + BRIGHT 
	db $16, $10, $1C, $13, CYAN + BRIGHT 
	db FIN 
	db FIN 
	LD   BC,$01F4
HysteriaLoop:
	PUSH BC
	HALT
	CALL Rand
	LD   A,(RND1)
	AND  $7F
	CP   $60
	JR   C,SetHystX
	SUB  $40
SetHystX:
	ADD  A,$08
	LD   E,A
	LD   A,(RND2)
	CP   $98
	JR   C,SetHystY
	SUB  $98

SetHystY:
	LD   D,A
	LD   A,LOGO_HYSTERIA			; Hysteria Logo
	CALL DrawBitmapA
	LD   DE,$78B0					; Special FX Logo pos
	LD   A,LOGO_SPECIALFX			; Special FX Logo
	CALL DrawBitmapA
	POP  BC
	DEC  BC
	LD   A,B
	OR   C
	JR   NZ,HysteriaLoop
	RET 

SineIndex:
	db $01 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

FireflyPage:
	LD   A,$45
	CALL ClearAttributes
	LD   BC,$0400
FireflyLoop:
	PUSH BC
	LD   A,(SineIndex)
	INC  A
	LD   (SineIndex),A
	HALT
	LD   E,$88			; e = XPOS
	CALL DrawFireFlyLogo
	ADD  A,$20			; second logo out of phase with the first
	LD   E,$20			; e = XPOS
	CALL DrawFireFlyLogo
	CALL Rand
	LD   A,(RND1)
	LD   E,A			; x
	LD   A,(RND2)
	CP   $A8
	JR   C,SetFFY
	SUB  $A8
SetFFY:			; Y from 0 to A8
	
	LD   D,A
	CALL PixAddr
	LD   A,(RND3)
	AND  $07
	LD   E,A
	LD   D,high BitTable	; $84xx - BitTable BitTable
	LD   A,(DE)
	OR   (HL)
	LD   (HL),A				; write a random star to the screen
	POP  BC
	DEC  BC
	LD   A,B
	OR   C
	JR   NZ,FireflyLoop
	RET 

DrawFireFlyLogo:
	PUSH AF
	AND  $3F
	ADD  A,low SineWave
	LD   L,A
	LD   H,high SineWave		; $8365 SineWave SineWave
	LD   A,(HL)
	ADD  A,$68					; sinewave + 104
	LD   D,A
	PUSH DE
	SUB  $02
	LD   D,A
	CALL PixAddr
	CALL ClearTwoLines
	POP  DE
	LD   A,LOGO_FIREFLY			; Firefly Logo
	CALL DrawBitmapA
	CALL ClearTwoLines
	POP  AF
	RET 

ClearTwoLines:			; clears two lines at HL
	LD   E,L
	LD   D,$00			; blank pixels
	LD   C,$02			; 2 full lines
ClrLine:
	LD   B,$0B			; 11 bytes wide
ClrRow:
	LD   (HL),D
	INC  L
	DJNZ ClrRow
	LD   L,E
	CALL DownLine
	DEC  C
	JR   NZ,ClrLine
	RET

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

GutzPage:
	LD   DE,$2040
	LD   A,LOGO_GUTZ			; Gutz Logo
	CALL DrawBitmapA
	HALT
	EX   DE,HL
	LD   DE,$0408
	LD   BC,$100C
	CALL DrawAttributes
	LD   B,$10
FlashGutzLoop:
	PUSH BC
	LD   A,B
	AND  $03
	ADD  A,low GutzColours
	LD   L,A
	LD   H,high GutzColours			; $9f8e - GutzColours GutzColours
	LD   D,(HL)
	LD   E,$03
	CALL ColourGutzLogo
	POP  BC
	DJNZ FlashGutzLoop

	LD   A,$41
	JP   ClearAttributes

ColourGutzLogo:
	LD   A,$32
NextGutzFlash:
	EX   AF,AF'
	HALT
	LD   HL,$5888			; attribute file address for Logo
	LD   BC,$0130
GutzLoop:
	LD   A,(HL)
	AND  $07
	CP   E
	JR   NZ,SkipAttr
	LD   A,(HL)
	AND  $F8			; 11111000
	OR   D
	LD   (HL),A
SkipAttr:
	INC  HL
	DEC  BC
	LD   A,B
	OR   C
	JR   NZ,GutzLoop
	LD   A,D
	LD   D,E
	LD   E,A
	EX   AF,AF'
	DEC  A
	JR   NZ,NextGutzFlash
	RET 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

WipeScreen:
	LD   A,$B0			; 176 lines
	LD   HL,$4000		; start of the screen
WipeLoop:
	EX   AF,AF'
	HALT
	LD   C,L
	XOR  A
	LD   B,$20			; 32 bytes wide
WipeLine:
	LD   (HL),A
	INC  L
	DJNZ WipeLine

	LD   L,C
	CALL DownLine
	EX   AF,AF'
	DEC  A
	JR   NZ,WipeLoop

	XOR  A
ClearAttributes:			; set the full screen to black attributes
	LD   HL,$0000
	LD   BC,$151F
	JP   FillAttrBlock

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

DrawBitmapA:					; A is the index into LogoData table for which bitmap to draw
	ADD  A,A
	ADD  A,A
	ADD  A,low LogoData
	LD   L,A
	LD   H,high LogoData		; $9f7a - LogoData LogoData
	LD   B,(HL)
	INC  L
	LD   C,(HL)
	INC  L
	LD   A,(HL)
	INC  L
	LD   H,(HL)
	LD   L,A
	JP   DrawBitmap

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

WaitBCFrames:
	HALT
	DEC  BC
	LD   A,B
	OR   C
	JR   NZ,WaitBCFrames
	RET 
	
; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;
	
ScrollingText:

	db "     TO COLIN - WHO MADE ME SEE LIFE FROM A NEW ANGLE..."
	db "                        "
	db $5b, $5c, " 1988 SPECIAL FX SOFTWARE LIMITED"
	db "                     "
	db "DON'T DARE MISS OUT ON ALL THE FUN - SEE OUR RANGE OF CLASSIC "
	db "GAMES AVAILABLE NOW ON THE SPECTRUM AND COMMODORE 64...        "
	db "HYSTERIA - OUR FUTURE DEPENDS ON YOU BEING TRANSPORTED BY MOLECULAR DISRUPTION "
	db "TO COMBAT A PRIMEVIL ENTITY AS IT LEAPS CLOSER TO OUR DESTINY...       "
	db "FIREFLY - BEAT THE SYSTEM! CREW THE SPACESHIP FIREFLY IN A MIGHTY BATTLE "
	db "TO SAVE OUR HOME FROM THE MECHANISED ALIENS...       "
	db "GUTZ - A NIGHTMARE COME TRUE! EATEN ALIVE BY A TEN MILLION TONNE MEGA-BEING "
	db "THE SIZE OF A SMALL MOON, ON A JOURNEY TO EAFRTH FOR THE MAIN COURSE...       "
	db "WATCH OUT FOR THE UP AND COMING RELEASES!"
	db "                      "
	db "HI TO ALL AT THE DOCK - PAM, JEAN, KARUN, TONY POMFRET, ROBBIT, BILL, FRANK THE DRUNK,"
	db "AMOS, BAGOOLY, CHUCK AND RALF       "
	db "LOTS OF THANKS TO TOMMY LANIGAN FOR THE LOAN OF THE INTERFACE        "
	db "NO THANKS TO MR OWENS FOR CLAIMS ABOUT MY SCROLLY BITS!        "
	db "HELLO ALL AT OSL...                    "
	db "HYPER ACTIVE WAS SPECIALLY PRODUCED FOR 'SINCLAIR USER'        "
	db FIN   

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Sprite data
;
;

	org $BFC0

gfx_BigDigitsOffset:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 

gfx_PlayerLeft:
	db $FC 
	db $00 
	db $1F 
	db $00 
	db $BF 
	db $00 
	db $1F 
	db $40 
	db $0F 
	db $E0 
	db $F8 
	db $02 
	db $F0 
	db $00 
	db $07 
	db $70 
	db $1F 
	db $40 
	db $1F 
	db $40 
	db $07 
	db $38 
	db $E0 
	db $0B 
	db $C0 
	db $17 
	db $00 
	db $B8 
	db $0F 
	db $00 
	db $07 
	db $70 
	db $00 
	db $BB 
	db $C0 
	db $17 
	db $E0 
	db $0B 
	db $00 
	db $3A 
	db $03 
	db $F8 
	db $03 
	db $78 
	db $00 
	db $70 
	db $E0 
	db $00 
	db $E0 
	db $0B 
	db $00 
	db $C7 
	db $03 
	db $38 
	db $03 
	db $B8 
	db $00 
	db $8F 
	db $F0 
	db $05 
	db $F8 
	db $00 
	db $00 
	db $0F 
	db $03 
	db $98 
	db $03 
	db $D8 
	db $00 
	db $6F 
	db $F8 
	db $02 
	db $F0 
	db $07 
	db $00 
	db $EF 
	db $03 
	db $D8 
	db $03 
	db $D8 
	db $00 
	db $E7 
	db $F0 
	db $07 
	db $F0 
	db $06 
	db $00 
	db $D1 
	db $03 
	db $D8 
	db $03 
	db $98 
	db $00 
	db $A3 
	db $F0 
	db $02 
	db $E0 
	db $09 
	db $00 
	db $57 
	db $07 
	db $B0 
	db $07 
	db $30 
	db $00 
	db $3F 
	db $C0 
	db $18 
	db $C0 
	db $1C 
	db $00 
	db $3C 
	db $0F 
	db $A0 
	db $1F 
	db $80 
	db $00 
	db $1B 
	db $E0 
	db $0D 
	db $F0 
	db $02 
	db $00 
	db $67 
	db $3F 
	db $80 
	db $7F 
	db $00 
	db $00 
	db $FF 
	db $F0 
	db $04 
	db $F0 
	db $04 
	db $00 
	db $F8 
	db $FF 
	db $00 
	db $FF 
	db $00 
	db $00 
	db $FC 
	db $F0 
	db $04 
	db $F8 
	db $02 
	db $00 
	db $7B 
	db $7F 
	db $00 
	db $3F 
	db $80 
	db $00 
	db $97 
	db $FC 
	db $00 
	db $FF 
	db $00 
	db $00 
	db $23 
	db $1F 
	db $C0 
	db $1F 
	db $C0 
	db $00 
	db $D7 
	db $FE 
	db $00 
	db $FC 
	db $01 
	db $00 
	db $AF 
	db $3F 
	db $80 
	db $7F 
	db $00 
	db $00 
	db $EF 
	db $FC 
	db $01 
	db $FC 
	db $01 
	db $00 
	db $8C 
	db $FF 
	db $00 
	db $FF 
	db $00 
	db $73 
	db $00 
	db $FE 
	db $00 


gfx_PlayerFacing:
	db $FF 
	db $00 
	db $C3 
	db $00 
	db $FF 
	db $00 
	db $FF 
	db $00 
	db $81 
	db $2C 
	db $FF 
	db $00 
	db $FF 
	db $00 
	db $00 
	db $00 
	db $FF 
	db $00 
	db $7F 
	db $00 
	db $00 
	db $5E 
	db $FE 
	db $00 
	db $FC 
	db $00 
	db $00 
	db $BF 
	db $3F 
	db $00 
	db $1F 
	db $40 
	db $00 
	db $BF 
	db $F8 
	db $02 
	db $F0 
	db $06 
	db $00 
	db $5E 
	db $0F 
	db $60 
	db $0F 
	db $00 
	db $00 
	db $81 
	db $F0 
	db $00 
	db $E0 
	db $0C 
	db $00 
	db $5E 
	db $07 
	db $30 
	db $03 
	db $78 
	db $00 
	db $2D 
	db $C0 
	db $1E 
	db $C0 
	db $1E 
	db $00 
	db $83 
	db $03 
	db $78 
	db $03 
	db $B8 
	db $00 
	db $FF 
	db $C0 
	db $1D 
	db $C0 
	db $1D 
	db $00 
	db $FF 
	db $03 
	db $B8 
	db $07 
	db $B0 
	db $00 
	db $FF 
	db $E0 
	db $0D 
	db $F0 
	db $00 
	db $00 
	db $E7 
	db $0F 
	db $00 
	db $07 
	db $30 
	db $00 
	db $00 
	db $E0 
	db $0C 
	db $C0 
	db $1E 
	db $00 
	db $42 
	db $03 
	db $78 
	db $03 
	db $F8 
	db $00 
	db $18 
	db $C0 
	db $1F 
	db $C0 
	db $1F 
	db $00 
	db $5A 
	db $03 
	db $F8 
	db $07 
	db $70 
	db $00 
	db $E7 
	db $E0 
	db $0E 
	db $F0 
	db $01 
	db $00 
	db $FF 
	db $0F 
	db $80 
	db $1F 
	db $C0 
	db $00 
	db $E7 
	db $F8 
	db $03 
	db $F8 
	db $03 
	db $00 
	db $E7 
	db $1F 
	db $C0 
	db $1F 
	db $C0 
	db $00 
	db $C3 
	db $F8 
	db $03 
	db $F8 
	db $03 
	db $00 
	db $E7 
	db $1F 
	db $C0 
	db $3F 
	db $80 
	db $00 
	db $C3 
	db $FC 
	db $01 
	db $FE 
	db $00 
	db $00 
	db $34 
	db $7F 
	db $00 
	db $FF 
	db $00 
	db $00 
	db $76 
	db $FF 
	db $00 
	db $FE 
	db $00 
	db $00 
	db $F7 
	db $7F 
	db $00 
	db $3F 
	db $80 
	db $00 
	db $E7 
	db $FC 
	db $01 
	db $FC 
	db $01 
	db $18 
	db $C3 
	db $3F 
	db $80 
	db $7F 
	db $00 
	db $3C 
	db $00 
	db $FE 
	db $00 


gfx_PlayerRight:
	db $FD 
	db $00 
	db $F8 
	db $00 
	db $3F 
	db $00 
	db $1F 
	db $40 
	db $F0 
	db $07 
	db $F8 
	db $02 
	db $F8 
	db $02 
	db $E0 
	db $0E 
	db $0F 
	db $00 
	db $07 
	db $D0 
	db $E0 
	db $1C 
	db $F8 
	db $02 
	db $F0 
	db $00 
	db $00 
	db $1D 
	db $03 
	db $E8 
	db $03 
	db $E8 
	db $00 
	db $DD 
	db $E0 
	db $0E 
	db $C0 
	db $1F 
	db $00 
	db $5C 
	db $07 
	db $D0 
	db $07 
	db $00 
	db $00 
	db $0E 
	db $C0 
	db $1E 
	db $C0 
	db $1C 
	db $00 
	db $E3 
	db $07 
	db $D0 
	db $0F 
	db $A0 
	db $00 
	db $F1 
	db $C0 
	db $1D 
	db $C0 
	db $19 
	db $00 
	db $F0 
	db $1F 
	db $00 
	db $1F 
	db $40 
	db $00 
	db $F6 
	db $C0 
	db $1B 
	db $C0 
	db $1B 
	db $00 
	db $F7 
	db $0F 
	db $E0 
	db $0F 
	db $E0 
	db $00 
	db $E7 
	db $C0 
	db $1B 
	db $C0 
	db $1B 
	db $00 
	db $8B 
	db $0F 
	db $60 
	db $0F 
	db $40 
	db $00 
	db $C5 
	db $C0 
	db $19 
	db $E0 
	db $0D 
	db $00 
	db $EA 
	db $07 
	db $90 
	db $03 
	db $18 
	db $00 
	db $FC 
	db $E0 
	db $0C 
	db $F0 
	db $05 
	db $00 
	db $3C 
	db $03 
	db $38 
	db $07 
	db $B0 
	db $00 
	db $D8 
	db $F8 
	db $01 
	db $FC 
	db $01 
	db $00 
	db $E6 
	db $0F 
	db $40 
	db $0F 
	db $20 
	db $00 
	db $FF 
	db $FE 
	db $00 
	db $FF 
	db $00 
	db $00 
	db $1F 
	db $0F 
	db $20 
	db $0F 
	db $20 
	db $00 
	db $3F 
	db $FF 
	db $00 
	db $FE 
	db $00 
	db $00 
	db $DE 
	db $1F 
	db $40 
	db $3F 
	db $00 
	db $00 
	db $E9 
	db $FC 
	db $01 
	db $F8 
	db $03 
	db $00 
	db $C4 
	db $FF 
	db $00 
	db $7F 
	db $00 
	db $00 
	db $EB 
	db $F8 
	db $03 
	db $FC 
	db $01 
	db $00 
	db $F5 
	db $3F 
	db $80 
	db $3F 
	db $80 
	db $00 
	db $F7 
	db $FE 
	db $00 
	db $FF 
	db $00 
	db $00 
	db $31 
	db $3F 
	db $80 
	db $7F 
	db $00 
	db $CE 
	db $00 
	db $FF 
	db $00 


gfx_DropBomb:
	db $C0 
	db $00 
	db $FF 
	db $00 
	db $7F 
	db $00 
	db $80 
	db $2F 
	db $80 
	db $00 
	db $7F 
	db $00 
	db $3F 
	db $80 
	db $00 
	db $5F 
	db $00 
	db $5F 
	db $3F 
	db $80 
	db $7F 
	db $00 
	db $80 
	db $00 
	db $80 
	db $2F 
	db $7F 
	db $00 
	db $FF 
	db $00 
	db $C0 
	db $00 
	db $F0 
	db $00 
	db $3F 
	db $00 
	db $1F 
	db $C0 
	db $E0 
	db $0B 
	db $E0 
	db $00 
	db $1F 
	db $00 
	db $0F 
	db $E0 
	db $C0 
	db $17 
	db $C0 
	db $17 
	db $0F 
	db $E0 
	db $1F 
	db $00 
	db $E0 
	db $00 
	db $E0 
	db $0B 
	db $1F 
	db $C0 
	db $3F 
	db $00 
	db $F0 
	db $00 
	db $FC 
	db $00 
	db $0F 
	db $00 
	db $07 
	db $F0 
	db $F8 
	db $02 
	db $F8 
	db $00 
	db $07 
	db $00 
	db $03 
	db $F8 
	db $F0 
	db $05 
	db $F0 
	db $05 
	db $03 
	db $F8 
	db $07 
	db $00 
	db $F8 
	db $00 
	db $F8 
	db $02 
	db $07 
	db $F0 
	db $0F 
	db $00 
	db $FC 
	db $00 
	db $FF 
	db $00 
	db $03 
	db $00 
	db $01 
	db $BC 
	db $FE 
	db $00 
	db $FE 
	db $00 
	db $01 
	db $00 
	db $00 
	db $7E 
	db $FC 
	db $01 
	db $FC 
	db $01 
	db $00 
	db $7E 
	db $01 
	db $00 
	db $FE 
	db $00 
	db $FE 
	db $00 
	db $01 
	db $BC 
	db $03 
	db $00 
	db $FF 
	db $00 


gfx_BigDigits:
	db $00 
	db $3C 
	db $66 
	db $66 
	db $66 
	db $66 
	db $64 
	db $40 
	db $02 
	db $26 
	db $66 
	db $66 
	db $66 
	db $66 
	db $3C 
	db $00 
	db $00 
	db $18 
	db $38 
	db $18 
	db $18 
	db $18 
	db $10 
	db $00 
	db $08 
	db $18 
	db $18 
	db $18 
	db $18 
	db $18 
	db $18 
	db $00 
	db $00 
	db $3C 
	db $66 
	db $06 
	db $3C 
	db $60 
	db $40 
	db $00 
	db $20 
	db $60 
	db $66 
	db $66 
	db $66 
	db $66 
	db $7E 
	db $00 
	db $00 
	db $7E 
	db $66 
	db $06 
	db $1E 
	db $06 
	db $04 
	db $00 
	db $02 
	db $06 
	db $66 
	db $66 
	db $66 
	db $66 
	db $3C 
	db $00 
	db $00 
	db $66 
	db $66 
	db $66 
	db $3E 
	db $06 
	db $04 
	db $00 
	db $02 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $00 
	db $00 
	db $7E 
	db $66 
	db $60 
	db $3C 
	db $06 
	db $04 
	db $00 
	db $02 
	db $06 
	db $66 
	db $66 
	db $66 
	db $66 
	db $3C 
	db $00 
	db $00 
	db $3C 
	db $66 
	db $60 
	db $7C 
	db $66 
	db $44 
	db $00 
	db $22 
	db $66 
	db $66 
	db $66 
	db $66 
	db $66 
	db $3C 
	db $00 
	db $00 
	db $7E 
	db $66 
	db $06 
	db $06 
	db $06 
	db $04 
	db $00 
	db $02 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $00 
	db $00 
	db $3C 
	db $66 
	db $66 
	db $3C 
	db $66 
	db $44 
	db $00 
	db $22 
	db $66 
	db $66 
	db $66 
	db $66 
	db $66 
	db $3C 
	db $00 
	db $00 
	db $3C 
	db $66 
	db $66 
	db $3E 
	db $06 
	db $04 
	db $00 
	db $02 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $06 
	db $00 


gfx_Pod1:
	db $C0 
	db $00 
	db $FF 
	db $00 
	db $7F 
	db $00 
	db $80 
	db $00 
	db $00 
	db $1F 
	db $3F 
	db $00 
	db $3F 
	db $80 
	db $00 
	db $3F 
	db $00 
	db $3F 
	db $3F 
	db $80 
	db $3F 
	db $00 
	db $00 
	db $1F 
	db $80 
	db $00 
	db $7F 
	db $00 
	db $FF 
	db $00 
	db $C0 
	db $00 
	db $F0 
	db $00 
	db $3F 
	db $00 
	db $1F 
	db $00 
	db $E0 
	db $00 
	db $C0 
	db $07 
	db $0F 
	db $C0 
	db $0F 
	db $E0 
	db $C0 
	db $0F 
	db $C0 
	db $0F 
	db $0F 
	db $E0 
	db $0F 
	db $C0 
	db $C0 
	db $07 
	db $E0 
	db $00 
	db $1F 
	db $00 
	db $3F 
	db $00 
	db $F0 
	db $00 
	db $FC 
	db $00 
	db $0F 
	db $00 
	db $07 
	db $00 
	db $F8 
	db $00 
	db $F0 
	db $01 
	db $03 
	db $F0 
	db $03 
	db $F8 
	db $F0 
	db $03 
	db $F0 
	db $03 
	db $03 
	db $F8 
	db $03 
	db $F0 
	db $F0 
	db $01 
	db $F8 
	db $00 
	db $07 
	db $00 
	db $0F 
	db $00 
	db $FC 
	db $00 
	db $FF 
	db $00 
	db $03 
	db $00 
	db $01 
	db $00 
	db $FE 
	db $00 
	db $FC 
	db $00 
	db $00 
	db $7C 
	db $00 
	db $FE 
	db $FC 
	db $00 
	db $FC 
	db $00 
	db $00 
	db $FE 
	db $00 
	db $7C 
	db $FC 
	db $00 
	db $FE 
	db $00 
	db $01 
	db $00 
	db $03 
	db $00 
	db $FF 
	db $00 


gfx_Pod2:
	db $C0 
	db $00 
	db $FF 
	db $00 
	db $7F 
	db $00 
	db $80 
	db $3F 
	db $00 
	db $6B 
	db $3F 
	db $80 
	db $3F 
	db $80 
	db $00 
	db $55 
	db $00 
	db $4A 
	db $3F 
	db $80 
	db $3F 
	db $80 
	db $00 
	db $61 
	db $80 
	db $3F 
	db $7F 
	db $00 
	db $FF 
	db $00 
	db $C0 
	db $00 
	db $F0 
	db $00 
	db $3F 
	db $00 
	db $1F 
	db $C0 
	db $E0 
	db $0F 
	db $C0 
	db $1A 
	db $0F 
	db $E0 
	db $0F 
	db $60 
	db $C0 
	db $15 
	db $C0 
	db $12 
	db $0F 
	db $A0 
	db $0F 
	db $60 
	db $C0 
	db $18 
	db $E0 
	db $0F 
	db $1F 
	db $C0 
	db $3F 
	db $00 
	db $F0 
	db $00 
	db $FC 
	db $00 
	db $0F 
	db $00 
	db $07 
	db $F0 
	db $F8 
	db $03 
	db $F0 
	db $06 
	db $03 
	db $B8 
	db $03 
	db $58 
	db $F0 
	db $05 
	db $F0 
	db $04 
	db $03 
	db $A8 
	db $03 
	db $18 
	db $F0 
	db $06 
	db $F8 
	db $03 
	db $07 
	db $F0 
	db $0F 
	db $00 
	db $FC 
	db $00 
	db $FF 
	db $00 
	db $03 
	db $00 
	db $01 
	db $FC 
	db $FE 
	db $00 
	db $FC 
	db $01 
	db $00 
	db $AE 
	db $00 
	db $56 
	db $FC 
	db $01 
	db $FC 
	db $01 
	db $00 
	db $2A 
	db $00 
	db $86 
	db $FC 
	db $01 
	db $FE 
	db $00 
	db $01 
	db $FC 
	db $03 
	db $00 
	db $FF 
	db $00 
	db $60 
	db $00 
	db $00 
	db $90 
	db $90 
	db $00 
	db $00 
	db $60 
	db $18 
	db $00 
	db $00 
	db $3C 
	db $3C 
	db $00 
	db $00 
	db $18 

gfx_BaddyBull1:
	db $06 
	db $00 
	db $00 
	db $09 
	db $09 
	db $00 
	db $00 
	db $06 

gfx_BaddyBull2:
	db $01 
	db $80 
	db $40 
	db $02 
	db $02 
	db $40 
	db $80 
	db $01 

gfx_DragonHeadLeft:
	db $00 
	db $00 
	db $00 
	db $00 
	db $F8 
	db $01 
	db $06 
	db $FE 
	db $00 
	db $00 
	db $FF 
	db $0B 
	db $15 
	db $FF 
	db $00 
	db $80 
	db $7F 
	db $08 
	db $23 
	db $3F 
	db $80 
	db $80 
	db $BF 
	db $55 
	db $77 
	db $BF 
	db $00 
	db $00 
	db $BF 
	db $77 
	db $23 
	db $3C 
	db $00 
	db $00 
	db $70 
	db $00 
	db $13 
	db $E0 
	db $00 
	db $00 
	db $C0 
	db $15 
	db $0B 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $7E 
	db $00 
	db $01 
	db $BF 
	db $80 
	db $C0 
	db $FF 
	db $02 
	db $05 
	db $7F 
	db $C0 
	db $E0 
	db $1F 
	db $02 
	db $00 
	db $0F 
	db $E0 
	db $E0 
	db $CF 
	db $08 
	db $15 
	db $6F 
	db $C0 
	db $C0 
	db $CF 
	db $08 
	db $00 
	db $0F 
	db $00 
	db $00 
	db $1C 
	db $00 
	db $04 
	db $F8 
	db $00 
	db $00 
	db $70 
	db $05 
	db $02 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $1F 
	db $00 
	db $00 
	db $6F 
	db $E0 
	db $F0 
	db $BF 
	db $00 
	db $01 
	db $5F 
	db $F0 
	db $F8 
	db $87 
	db $00 
	db $00 
	db $03 
	db $F8 
	db $F8 
	db $03 
	db $00 
	db $02 
	db $33 
	db $F0 
	db $F0 
	db $03 
	db $00 
	db $00 
	db $03 
	db $C0 
	db $00 
	db $07 
	db $00 
	db $01 
	db $3E 
	db $00 
	db $00 
	db $5C 
	db $01 
	db $00 
	db $B0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $07 
	db $00 
	db $00 
	db $1B 
	db $F8 
	db $FC 
	db $2F 
	db $00 
	db $00 
	db $57 
	db $FC 
	db $FE 
	db $21 
	db $00 
	db $00 
	db $00 
	db $FE 
	db $FE 
	db $8C 
	db $00 
	db $01 
	db $DE 
	db $FC 
	db $FC 
	db $8C 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $C0 
	db $01 
	db $00 
	db $00 
	db $4F 
	db $80 
	db $00 
	db $57 
	db $00 
	db $00 
	db $2C 
	db $00 
	db $00 
	db $00 
	db $00 


gfx_DragonHeadRight:
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $07 
	db $1F 
	db $D8 
	db $00 
	db $00 
	db $F4 
	db $3F 
	db $3F 
	db $EA 
	db $00 
	db $00 
	db $84 
	db $7F 
	db $7F 
	db $00 
	db $00 
	db $00 
	db $31 
	db $7F 
	db $3F 
	db $7B 
	db $80 
	db $00 
	db $31 
	db $3F 
	db $0F 
	db $00 
	db $00 
	db $00 
	db $80 
	db $03 
	db $01 
	db $F2 
	db $00 
	db $00 
	db $EA 
	db $00 
	db $00 
	db $34 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F8 
	db $01 
	db $07 
	db $F6 
	db $00 
	db $00 
	db $FD 
	db $0F 
	db $0F 
	db $FA 
	db $80 
	db $00 
	db $E1 
	db $1F 
	db $1F 
	db $C0 
	db $00 
	db $00 
	db $C0 
	db $1F 
	db $0F 
	db $CC 
	db $40 
	db $00 
	db $C0 
	db $0F 
	db $03 
	db $C0 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $7C 
	db $80 
	db $80 
	db $3A 
	db $00 
	db $00 
	db $0D 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $7E 
	db $00 
	db $01 
	db $FD 
	db $80 
	db $40 
	db $FF 
	db $03 
	db $03 
	db $FE 
	db $A0 
	db $40 
	db $F8 
	db $07 
	db $07 
	db $F0 
	db $00 
	db $10 
	db $F3 
	db $07 
	db $03 
	db $F6 
	db $A8 
	db $10 
	db $F3 
	db $03 
	db $00 
	db $F0 
	db $00 
	db $00 
	db $38 
	db $00 
	db $00 
	db $1F 
	db $20 
	db $A0 
	db $0E 
	db $00 
	db $00 
	db $03 
	db $40 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $1F 
	db $00 
	db $00 
	db $7F 
	db $60 
	db $D0 
	db $FF 
	db $00 
	db $00 
	db $FF 
	db $A8 
	db $10 
	db $FE 
	db $01 
	db $01 
	db $FC 
	db $C4 
	db $AA 
	db $FD 
	db $01 
	db $00 
	db $FD 
	db $EE 
	db $EE 
	db $FD 
	db $00 
	db $00 
	db $3C 
	db $C4 
	db $00 
	db $0E 
	db $00 
	db $00 
	db $07 
	db $C8 
	db $A8 
	db $03 
	db $00 
	db $00 
	db $00 
	db $D0 
	db $00 
	db $00 
	db $00 


gfx_DragonBody:
	db $00 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $03 
	db $0D 
	db $7C 
	db $00 
	db $00 
	db $FE 
	db $13 
	db $25 
	db $FF 
	db $00 
	db $00 
	db $FF 
	db $23 
	db $47 
	db $FF 
	db $80 
	db $80 
	db $FF 
	db $45 
	db $43 
	db $FF 
	db $80 
	db $80 
	db $7F 
	db $41 
	db $20 
	db $FD 
	db $00 
	db $00 
	db $5F 
	db $21 
	db $10 
	db $26 
	db $00 
	db $00 
	db $0C 
	db $0C 
	db $03 
	db $F0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $FC 
	db $00 
	db $03 
	db $5F 
	db $00 
	db $80 
	db $FF 
	db $04 
	db $09 
	db $7F 
	db $C0 
	db $C0 
	db $FF 
	db $08 
	db $11 
	db $FF 
	db $E0 
	db $E0 
	db $7F 
	db $11 
	db $10 
	db $FF 
	db $E0 
	db $E0 
	db $5F 
	db $10 
	db $08 
	db $3F 
	db $40 
	db $C0 
	db $57 
	db $08 
	db $04 
	db $09 
	db $80 
	db $00 
	db $03 
	db $03 
	db $00 
	db $FC 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3F 
	db $00 
	db $00 
	db $D7 
	db $C0 
	db $E0 
	db $3F 
	db $01 
	db $02 
	db $5F 
	db $F0 
	db $F0 
	db $3F 
	db $02 
	db $04 
	db $7F 
	db $F8 
	db $F8 
	db $5F 
	db $04 
	db $04 
	db $3F 
	db $F8 
	db $F8 
	db $17 
	db $04 
	db $02 
	db $0F 
	db $D0 
	db $F0 
	db $15 
	db $02 
	db $01 
	db $02 
	db $60 
	db $C0 
	db $C0 
	db $00 
	db $00 
	db $3F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C0 
	db $0F 
	db $00 
	db $00 
	db $35 
	db $F0 
	db $F8 
	db $4F 
	db $00 
	db $00 
	db $97 
	db $FC 
	db $FC 
	db $8F 
	db $00 
	db $01 
	db $1F 
	db $FE 
	db $FE 
	db $17 
	db $01 
	db $01 
	db $0F 
	db $FE 
	db $FE 
	db $05 
	db $01 
	db $00 
	db $83 
	db $F4 
	db $7C 
	db $85 
	db $00 
	db $00 
	db $40 
	db $98 
	db $30 
	db $30 
	db $00 
	db $00 
	db $0F 
	db $C0 
	db $00 
	db $00 
	db $00 


gfx_Alien2:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $FE 
	db $17 
	db $4F 
	db $FF 
	db $80 
	db $80 
	db $FF 
	db $4F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F7 
	db $3B 
	db $11 
	db $E2 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $30 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $FF 
	db $05 
	db $13 
	db $FF 
	db $E0 
	db $E0 
	db $FF 
	db $13 
	db $00 
	db $00 
	db $00 
	db $80 
	db $FD 
	db $06 
	db $06 
	db $FD 
	db $80 
	db $00 
	db $79 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $E0 
	db $7F 
	db $01 
	db $04 
	db $FF 
	db $F8 
	db $F8 
	db $FF 
	db $04 
	db $00 
	db $00 
	db $00 
	db $40 
	db $BF 
	db $00 
	db $00 
	db $BF 
	db $40 
	db $40 
	db $BF 
	db $00 
	db $00 
	db $BF 
	db $40 
	db $80 
	db $5E 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $03 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F8 
	db $5F 
	db $00 
	db $01 
	db $3F 
	db $FE 
	db $FE 
	db $3F 
	db $01 
	db $00 
	db $00 
	db $00 
	db $D8 
	db $6F 
	db $00 
	db $00 
	db $6F 
	db $D8 
	db $D8 
	db $6F 
	db $00 
	db $00 
	db $37 
	db $B0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 


gfx_HomingAlien:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $01 
	db $02 
	db $C0 
	db $00 
	db $00 
	db $C0 
	db $02 
	db $09 
	db $F0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $25 
	db $FC 
	db $00 
	db $00 
	db $00 
	db $00 
	db $4B 
	db $FE 
	db $00 
	db $00 
	db $FE 
	db $4B 
	db $25 
	db $FC 
	db $00 
	db $00 
	db $F0 
	db $08 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $00 
	db $00 
	db $38 
	db $01 
	db $01 
	db $78 
	db $00 
	db $00 
	db $B0 
	db $00 
	db $02 
	db $7C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $09 
	db $7F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $12 
	db $FF 
	db $80 
	db $80 
	db $FF 
	db $12 
	db $09 
	db $7F 
	db $00 
	db $00 
	db $3C 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3C 
	db $00 
	db $00 
	db $5E 
	db $00 
	db $00 
	db $5E 
	db $00 
	db $00 
	db $2C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $9F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $5F 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $04 
	db $BF 
	db $E0 
	db $E0 
	db $BF 
	db $04 
	db $02 
	db $5F 
	db $C0 
	db $00 
	db $8F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $0B 
	db $00 
	db $00 
	db $17 
	db $80 
	db $00 
	db $0B 
	db $00 
	db $00 
	db $27 
	db $C0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $97 
	db $F0 
	db $00 
	db $00 
	db $00 
	db $01 
	db $2F 
	db $F8 
	db $F8 
	db $2F 
	db $01 
	db $00 
	db $97 
	db $F0 
	db $C0 
	db $23 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 


gfx_Saucer:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $01 
	db $02 
	db $C0 
	db $00 
	db $00 
	db $C0 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F0 
	db $0B 
	db $27 
	db $FC 
	db $00 
	db $00 
	db $FE 
	db $4F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C0 
	db $02 
	db $01 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $B0 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $FC 
	db $02 
	db $09 
	db $FF 
	db $00 
	db $80 
	db $FF 
	db $13 
	db $00 
	db $00 
	db $00 
	db $00 
	db $B0 
	db $00 
	db $00 
	db $B0 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $BF 
	db $00 
	db $02 
	db $7F 
	db $C0 
	db $E0 
	db $FF 
	db $04 
	db $00 
	db $00 
	db $00 
	db $00 
	db $2C 
	db $00 
	db $00 
	db $2C 
	db $00 
	db $00 
	db $2C 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $0B 
	db $00 
	db $00 
	db $00 
	db $00 
	db $C0 
	db $2F 
	db $00 
	db $00 
	db $9F 
	db $F0 
	db $F8 
	db $3F 
	db $01 
	db $00 
	db $00 
	db $00 
	db $00 
	db $0B 
	db $00 
	db $00 
	db $0B 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 


gfx_Bomb:
	db $00 
	db $E0 
	db $00 
	db $00 
	db $F8 
	db $00 
	db $00 
	db $FC 
	db $00 
	db $00 
	db $1E 
	db $00 
	db $07 
	db $CE 
	db $00 
	db $00 
	db $6F 
	db $06 
	db $06 
	db $6F 
	db $00 
	db $00 
	db $CF 
	db $07 
	db $F6 
	db $60 
	db $00 
	db $00 
	db $60 
	db $F6 
	db $F6 
	db $60 
	db $00 
	db $00 
	db $C0 
	db $77 
	db $70 
	db $00 
	db $00 
	db $00 
	db $00 
	db $3F 
	db $1F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $07 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $04 
	db $0E 
	db $07 
	db $00 
	db $80 
	db $07 
	db $1C 
	db $1D 
	db $F3 
	db $80 
	db $C0 
	db $9B 
	db $3D 
	db $3D 
	db $9B 
	db $C0 
	db $C0 
	db $F3 
	db $3D 
	db $3D 
	db $9B 
	db $C0 
	db $C0 
	db $9B 
	db $3D 
	db $3D 
	db $9B 
	db $C0 
	db $80 
	db $F3 
	db $1D 
	db $1C 
	db $07 
	db $80 
	db $00 
	db $07 
	db $0E 
	db $04 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $00 
	db $00 
	db $F0 
	db $01 
	db $03 
	db $F0 
	db $00 
	db $00 
	db $00 
	db $07 
	db $07 
	db $7C 
	db $00 
	db $00 
	db $66 
	db $0F 
	db $0F 
	db $66 
	db $00 
	db $00 
	db $7C 
	db $0F 
	db $00 
	db $66 
	db $F0 
	db $F0 
	db $66 
	db $00 
	db $00 
	db $66 
	db $F0 
	db $E0 
	db $7C 
	db $00 
	db $00 
	db $01 
	db $E0 
	db $C0 
	db $0F 
	db $00 
	db $00 
	db $0F 
	db $80 
	db $00 
	db $0E 
	db $00 
	db $00 
	db $1F 
	db $80 
	db $E0 
	db $7F 
	db $00 
	db $00 
	db $FF 
	db $F0 
	db $60 
	db $40 
	db $00 
	db $00 
	db $1F 
	db $00 
	db $80 
	db $19 
	db $00 
	db $00 
	db $19 
	db $80 
	db $00 
	db $1F 
	db $00 
	db $00 
	db $19 
	db $80 
	db $80 
	db $19 
	db $00 
	db $00 
	db $19 
	db $80 
	db $00 
	db $1F 
	db $00 
	db $00 
	db $40 
	db $60 
	db $F0 
	db $FF 
	db $00 
	db $00 
	db $7F 
	db $E0 
	db $80 
	db $1F 
	db $00 


gfx_Bubble:
	db $07 
	db $E0 
	db $00 
	db $00 
	db $38 
	db $1C 
	db $32 
	db $CC 
	db $00 
	db $00 
	db $76 
	db $65 
	db $42 
	db $FA 
	db $00 
	db $00 
	db $7B 
	db $D0 
	db $85 
	db $75 
	db $00 
	db $00 
	db $29 
	db $80 
	db $A0 
	db $95 
	db $00 
	db $00 
	db $21 
	db $80 
	db $C0 
	db $0B 
	db $00 
	db $00 
	db $02 
	db $40 
	db $60 
	db $26 
	db $00 
	db $00 
	db $0C 
	db $30 
	db $1C 
	db $38 
	db $00 
	db $00 
	db $E0 
	db $07 
	db $01 
	db $F8 
	db $00 
	db $00 
	db $0E 
	db $07 
	db $0C 
	db $B3 
	db $00 
	db $80 
	db $5D 
	db $19 
	db $10 
	db $BE 
	db $80 
	db $C0 
	db $1E 
	db $34 
	db $21 
	db $5D 
	db $40 
	db $40 
	db $0A 
	db $20 
	db $28 
	db $25 
	db $40 
	db $40 
	db $08 
	db $20 
	db $30 
	db $02 
	db $C0 
	db $80 
	db $00 
	db $10 
	db $18 
	db $09 
	db $80 
	db $00 
	db $03 
	db $0C 
	db $07 
	db $0E 
	db $00 
	db $00 
	db $F8 
	db $01 
	db $00 
	db $7E 
	db $00 
	db $80 
	db $C3 
	db $01 
	db $03 
	db $2C 
	db $C0 
	db $60 
	db $57 
	db $06 
	db $04 
	db $2F 
	db $A0 
	db $B0 
	db $07 
	db $0D 
	db $08 
	db $57 
	db $50 
	db $90 
	db $02 
	db $08 
	db $0A 
	db $09 
	db $50 
	db $10 
	db $02 
	db $08 
	db $0C 
	db $00 
	db $B0 
	db $20 
	db $00 
	db $04 
	db $06 
	db $02 
	db $60 
	db $C0 
	db $00 
	db $03 
	db $01 
	db $C3 
	db $80 
	db $00 
	db $7E 
	db $00 
	db $00 
	db $1F 
	db $80 
	db $E0 
	db $70 
	db $00 
	db $00 
	db $CB 
	db $30 
	db $D8 
	db $95 
	db $01 
	db $01 
	db $0B 
	db $E8 
	db $EC 
	db $41 
	db $03 
	db $02 
	db $15 
	db $D4 
	db $A4 
	db $00 
	db $02 
	db $02 
	db $82 
	db $54 
	db $84 
	db $00 
	db $02 
	db $03 
	db $00 
	db $2C 
	db $08 
	db $00 
	db $01 
	db $01 
	db $80 
	db $98 
	db $30 
	db $C0 
	db $00 
	db $00 
	db $70 
	db $E0 
	db $80 
	db $1F 
	db $00 


gfx_Acorn:
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $01 
	db $06 
	db $E0 
	db $00 
	db $00 
	db $F0 
	db $09 
	db $0A 
	db $F0 
	db $00 
	db $00 
	db $F8 
	db $11 
	db $12 
	db $F8 
	db $00 
	db $00 
	db $78 
	db $11 
	db $10 
	db $A8 
	db $00 
	db $00 
	db $10 
	db $08 
	db $06 
	db $60 
	db $00 
	db $00 
	db $90 
	db $11 
	db $02 
	db $00 
	db $00 
	db $00 
	db $A0 
	db $00 
	db $04 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $01 
	db $B8 
	db $00 
	db $00 
	db $7C 
	db $02 
	db $02 
	db $BC 
	db $00 
	db $00 
	db $7E 
	db $04 
	db $04 
	db $BE 
	db $00 
	db $00 
	db $5E 
	db $04 
	db $04 
	db $2A 
	db $00 
	db $00 
	db $04 
	db $02 
	db $01 
	db $98 
	db $00 
	db $00 
	db $62 
	db $02 
	db $00 
	db $20 
	db $00 
	db $00 
	db $00 
	db $01 
	db $00 
	db $44 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $6E 
	db $00 
	db $00 
	db $9F 
	db $00 
	db $00 
	db $AF 
	db $00 
	db $80 
	db $1F 
	db $01 
	db $01 
	db $2F 
	db $80 
	db $80 
	db $17 
	db $01 
	db $01 
	db $0A 
	db $80 
	db $00 
	db $81 
	db $00 
	db $00 
	db $66 
	db $00 
	db $00 
	db $1A 
	db $01 
	db $00 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $08 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $1B 
	db $80 
	db $C0 
	db $27 
	db $00 
	db $00 
	db $2B 
	db $C0 
	db $E0 
	db $47 
	db $00 
	db $00 
	db $4B 
	db $E0 
	db $E0 
	db $45 
	db $00 
	db $00 
	db $42 
	db $A0 
	db $40 
	db $20 
	db $00 
	db $00 
	db $19 
	db $80 
	db $20 
	db $06 
	db $00 
	db $00 
	db $21 
	db $00 
	db $00 
	db $04 
	db $00 
	db $00 
	db $40 
	db $40 
	db $00 
	db $00 
	db $00 


gfx_Spinny:
	db $07 
	db $E0 
	db $00 
	db $00 
	db $18 
	db $06 
	db $00 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $01 
	db $80 
	db $00 
	db $00 
	db $C0 
	db $03 
	db $02 
	db $C0 
	db $00 
	db $00 
	db $80 
	db $01 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $40 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $30 
	db $18 
	db $60 
	db $00 
	db $00 
	db $E0 
	db $07 
	db $01 
	db $68 
	db $00 
	db $00 
	db $00 
	db $06 
	db $0C 
	db $00 
	db $00 
	db $00 
	db $00 
	db $18 
	db $18 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $F0 
	db $00 
	db $00 
	db $B0 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $01 
	db $00 
	db $00 
	db $01 
	db $80 
	db $00 
	db $03 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $68 
	db $01 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $02 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $04 
	db $00 
	db $00 
	db $30 
	db $00 
	db $08 
	db $08 
	db $18 
	db $30 
	db $10 
	db $3C 
	db $08 
	db $08 
	db $2C 
	db $10 
	db $10 
	db $18 
	db $0C 
	db $0C 
	db $00 
	db $10 
	db $20 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $40 
	db $00 
	db $00 
	db $00 
	db $01 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 
	db $70 
	db $08 
	db $00 
	db $00 
	db $00 
	db $00 
	db $08 
	db $04 
	db $00 
	db $02 
	db $00 
	db $06 
	db $00 
	db $04 
	db $0F 
	db $02 
	db $02 
	db $0B 
	db $04 
	db $00 
	db $06 
	db $00 
	db $02 
	db $00 
	db $04 
	db $00 
	db $00 
	db $01 
	db $01 
	db $80 
	db $00 
	db $00 
	db $E0 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $00 
	db $00 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
; Mountain tile graphics
;
	org $F500

MountainTile1:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $32 
	db $75 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $E4 
	db $D9 
	db $03 
	db $00 
	db $80 
	db $40 
	db $00 
	db $07 
	db $AA 
	db $8C 
	db $0F 
	db $3F 
	db $20 
	db $10 
	db $5E 
	db $87 
	db $06 
	db $23 
	db $A2 
	db $21 
	db $11 
	db $03 
	db $4D 
	db $B0 
	db $22 
	db $30 
	db $B8 
	db $2D 
	db $06 
	db $08 
	db $4D 
	db $BC 
	db $1C 
	db $27 
	db $80 
	db $2D 
	db $00 
	db $1F 
	db $80 
	db $7E 
	db $08 
	db $0E 
	db $7D 
	db $9E 
	db $2F 
	db $10 
	db $33 
	db $03 
	db $1F 
	db $07 
	db $7B 
	db $A5 
	db $27 
	db $17 
	db $A1 
	db $7B 
	db $03 
	db $23 
	db $03 
	db $33 
	db $20 
	db $0A 
	db $9E 
	db $55 
	db $1D 
	db $3F 
	db $2A 
	db $00 
	db $95 
	db $80 
	db $2D 
	db $80 
	db $3F 
	db $1B 
	db $8C 
	db $4D 
	db $C8 
	db $C4 
	db $2D 
	db $89 
	db $E7 
	db $FB 
	db $91 
	db $4D 
	db $E2 
	db $F1 
	db $21 
	db $A3 
	db $DC 
	db $FE 
	db $87 
	db $4A 
	db $F8 
	db $7C 
	db $15 
	db $0F 
	db $FD 
	db $F2 
	db $3F 
	db $00 
	db $3F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $08 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $0C 
	db $1D 
	db $00 
	db $00 
	db $40 
	db $20 
	db $00 
	db $00 
	db $39 
	db $F6 
	db $00 
	db $00 
	db $60 
	db $90 
	db $00 
	db $01 
	db $EA 
	db $E3 
	db $C3 
	db $0F 
	db $08 
	db $84 
	db $17 
	db $A1 
	db $C1 
	db $88 
	db $68 
	db $48 
	db $C4 
	db $80 
	db $D3 
	db $6C 
	db $08 
	db $0C 
	db $6E 
	db $8B 
	db $01 
	db $02 
	db $13 
	db $6F 
	db $07 
	db $09 
	db $60 
	db $0B 
	db $C0 
	db $07 
	db $E0 
	db $1F 
	db $82 
	db $43 
	db $9F 
	db $E7 
	db $8B 
	db $C4 
	db $0C 
	db $C0 
	db $C7 
	db $C1 
	db $5E 
	db $E9 
	db $C9 
	db $C5 
	db $E8 
	db $5E 
	db $C0 
	db $C8 
	db $C0 
	db $0C 
	db $C8 
	db $42 
	db $A7 
	db $95 
	db $47 
	db $8F 
	db $0A 
	db $40 
	db $E5 
	db $E0 
	db $0B 
	db $60 
	db $0F 
	db $06 
	db $63 
	db $13 
	db $F2 
	db $F1 
	db $0B 
	db $62 
	db $79 
	db $7E 
	db $64 
	db $93 
	db $F8 
	db $3C 
	db $48 
	db $68 
	db $F7 
	db $FF 
	db $A1 
	db $12 
	db $BE 
	db $5F 
	db $05 
	db $43 
	db $FF 
	db $FC 
	db $0F 
	db $C0 
	db $8F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $03 
	db $07 
	db $00 
	db $00 
	db $50 
	db $48 
	db $00 
	db $00 
	db $0E 
	db $3D 
	db $00 
	db $00 
	db $98 
	db $A4 
	db $00 
	db $00 
	db $7A 
	db $F8 
	db $F0 
	db $03 
	db $C2 
	db $61 
	db $05 
	db $E8 
	db $70 
	db $22 
	db $1A 
	db $12 
	db $31 
	db $20 
	db $34 
	db $DB 
	db $02 
	db $83 
	db $DB 
	db $62 
	db $00 
	db $C0 
	db $84 
	db $DB 
	db $C1 
	db $02 
	db $D8 
	db $02 
	db $70 
	db $81 
	db $F8 
	db $07 
	db $E0 
	db $D0 
	db $E7 
	db $F9 
	db $E2 
	db $F1 
	db $03 
	db $30 
	db $31 
	db $B0 
	db $57 
	db $7A 
	db $72 
	db $31 
	db $7A 
	db $17 
	db $B0 
	db $32 
	db $30 
	db $03 
	db $32 
	db $D0 
	db $A9 
	db $E5 
	db $51 
	db $A3 
	db $02 
	db $50 
	db $F9 
	db $F8 
	db $02 
	db $D8 
	db $03 
	db $C1 
	db $D8 
	db $84 
	db $BC 
	db $7C 
	db $42 
	db $D8 
	db $9E 
	db $1F 
	db $D9 
	db $24 
	db $BE 
	db $CF 
	db $12 
	db $1A 
	db $3D 
	db $7F 
	db $A8 
	db $84 
	db $EF 
	db $D7 
	db $C1 
	db $50 
	db $FF 
	db $FF 
	db $03 
	db $F0 
	db $23 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $C8 
	db $00 
	db $00 
	db $00 
	db $01 
	db $00 
	db $00 
	db $D4 
	db $92 
	db $00 
	db $00 
	db $03 
	db $0F 
	db $00 
	db $00 
	db $66 
	db $A9 
	db $00 
	db $00 
	db $1E 
	db $3E 
	db $FC 
	db $80 
	db $30 
	db $18 
	db $41 
	db $7A 
	db $1C 
	db $88 
	db $86 
	db $44 
	db $8C 
	db $88 
	db $0D 
	db $36 
	db $C0 
	db $E0 
	db $B6 
	db $18 
	db $C0 
	db $70 
	db $21 
	db $36 
	db $F0 
	db $00 
	db $B6 
	db $00 
	db $9C 
	db $20 
	db $7E 
	db $01 
	db $F8 
	db $F4 
	db $79 
	db $BE 
	db $38 
	db $7C 
	db $40 
	db $CC 
	db $0C 
	db $EC 
	db $95 
	db $9E 
	db $1C 
	db $0C 
	db $5E 
	db $85 
	db $EC 
	db $0C 
	db $CC 
	db $80 
	db $8C 
	db $74 
	db $2A 
	db $79 
	db $54 
	db $A8 
	db $00 
	db $54 
	db $FE 
	db $FE 
	db $00 
	db $B6 
	db $00 
	db $30 
	db $36 
	db $21 
	db $6F 
	db $9F 
	db $10 
	db $B6 
	db $27 
	db $47 
	db $36 
	db $89 
	db $EF 
	db $73 
	db $C4 
	db $86 
	db $8F 
	db $1F 
	db $2A 
	db $E1 
	db $FB 
	db $F5 
	db $F0 
	db $54 
	db $3F 
	db $FF 
	db $00 
	db $FC 
	db $C8 


MountainTile2:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $32 
	db $75 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $64 
	db $99 
	db $00 
	db $00 
	db $80 
	db $C0 
	db $00 
	db $01 
	db $2A 
	db $0C 
	db $01 
	db $00 
	db $C0 
	db $D0 
	db $04 
	db $06 
	db $06 
	db $23 
	db $09 
	db $0E 
	db $60 
	db $72 
	db $37 
	db $08 
	db $22 
	db $B0 
	db $84 
	db $27 
	db $7C 
	db $38 
	db $C7 
	db $89 
	db $5C 
	db $A7 
	db $58 
	db $0B 
	db $07 
	db $88 
	db $01 
	db $F1 
	db $48 
	db $8E 
	db $C0 
	db $01 
	db $50 
	db $22 
	db $03 
	db $A3 
	db $1F 
	db $07 
	db $91 
	db $01 
	db $17 
	db $0B 
	db $C0 
	db $19 
	db $03 
	db $E3 
	db $23 
	db $E1 
	db $81 
	db $D1 
	db $F6 
	db $D7 
	db $DD 
	db $FF 
	db $FF 
	db $F7 
	db $F2 
	db $F5 
	db $FB 
	db $FF 
	db $FF 
	db $9B 
	db $DF 
	db $FC 
	db $86 
	db $C7 
	db $7E 
	db $ED 
	db $27 
	db $7B 
	db $5E 
	db $FE 
	db $0F 
	db $1F 
	db $DF 
	db $3D 
	db $9C 
	db $3E 
	db $1E 
	db $FE 
	db $DF 
	db $6F 
	db $FE 
	db $04 
	db $3D 
	db $32 
	db $38 
	db $3E 
	db $7F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $08 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $0C 
	db $1D 
	db $00 
	db $00 
	db $40 
	db $20 
	db $00 
	db $00 
	db $19 
	db $26 
	db $00 
	db $00 
	db $60 
	db $B0 
	db $00 
	db $00 
	db $4A 
	db $43 
	db $00 
	db $00 
	db $30 
	db $B4 
	db $01 
	db $01 
	db $81 
	db $48 
	db $82 
	db $03 
	db $D8 
	db $9C 
	db $8D 
	db $C2 
	db $08 
	db $2C 
	db $E1 
	db $09 
	db $1F 
	db $0E 
	db $31 
	db $E2 
	db $57 
	db $29 
	db $D6 
	db $C2 
	db $C1 
	db $22 
	db $00 
	db $7C 
	db $52 
	db $23 
	db $70 
	db $00 
	db $94 
	db $C8 
	db $80 
	db $E8 
	db $C7 
	db $41 
	db $64 
	db $C0 
	db $C5 
	db $C2 
	db $F0 
	db $06 
	db $40 
	db $F8 
	db $48 
	db $78 
	db $E0 
	db $74 
	db $7D 
	db $B5 
	db $F7 
	db $FF 
	db $FF 
	db $BD 
	db $FC 
	db $FD 
	db $7E 
	db $FF 
	db $FF 
	db $E6 
	db $37 
	db $BF 
	db $E1 
	db $F1 
	db $DF 
	db $BB 
	db $49 
	db $9E 
	db $97 
	db $FF 
	db $C3 
	db $07 
	db $F7 
	db $CF 
	db $67 
	db $8F 
	db $87 
	db $FF 
	db $B7 
	db $5B 
	db $FF 
	db $81 
	db $0F 
	db $0C 
	db $8E 
	db $CF 
	db $9F 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $03 
	db $07 
	db $00 
	db $00 
	db $50 
	db $48 
	db $00 
	db $00 
	db $06 
	db $09 
	db $00 
	db $00 
	db $98 
	db $AC 
	db $00 
	db $00 
	db $12 
	db $10 
	db $00 
	db $00 
	db $CC 
	db $6D 
	db $00 
	db $40 
	db $60 
	db $92 
	db $E0 
	db $00 
	db $36 
	db $27 
	db $23 
	db $70 
	db $82 
	db $4B 
	db $78 
	db $C2 
	db $07 
	db $C3 
	db $8C 
	db $78 
	db $95 
	db $8A 
	db $B5 
	db $70 
	db $70 
	db $88 
	db $80 
	db $1F 
	db $14 
	db $08 
	db $1C 
	db $00 
	db $E5 
	db $F2 
	db $20 
	db $3A 
	db $31 
	db $10 
	db $19 
	db $70 
	db $71 
	db $30 
	db $BC 
	db $01 
	db $90 
	db $3E 
	db $12 
	db $1E 
	db $38 
	db $DD 
	db $1F 
	db $6D 
	db $7D 
	db $FF 
	db $7F 
	db $2F 
	db $FF 
	db $FF 
	db $5F 
	db $BF 
	db $FF 
	db $F9 
	db $CD 
	db $6F 
	db $B8 
	db $7C 
	db $77 
	db $EE 
	db $D2 
	db $E7 
	db $E5 
	db $FF 
	db $B0 
	db $C1 
	db $FD 
	db $F3 
	db $D9 
	db $E3 
	db $E1 
	db $FF 
	db $ED 
	db $D6 
	db $FF 
	db $E0 
	db $43 
	db $83 
	db $E3 
	db $F3 
	db $27 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $C8 
	db $00 
	db $00 
	db $00 
	db $01 
	db $00 
	db $00 
	db $D4 
	db $92 
	db $00 
	db $00 
	db $01 
	db $02 
	db $00 
	db $00 
	db $66 
	db $AB 
	db $00 
	db $00 
	db $04 
	db $04 
	db $00 
	db $00 
	db $33 
	db $1B 
	db $40 
	db $10 
	db $18 
	db $24 
	db $38 
	db $80 
	db $8D 
	db $89 
	db $C8 
	db $DC 
	db $20 
	db $12 
	db $9E 
	db $F0 
	db $C1 
	db $70 
	db $E3 
	db $1E 
	db $25 
	db $62 
	db $2D 
	db $1C 
	db $9C 
	db $22 
	db $20 
	db $07 
	db $C5 
	db $02 
	db $07 
	db $40 
	db $39 
	db $7C 
	db $88 
	db $0E 
	db $8C 
	db $44 
	db $06 
	db $5C 
	db $1C 
	db $0C 
	db $2F 
	db $00 
	db $64 
	db $8F 
	db $84 
	db $07 
	db $8E 
	db $77 
	db $47 
	db $DB 
	db $5F 
	db $FF 
	db $DF 
	db $CB 
	db $FF 
	db $FF 
	db $D7 
	db $EF 
	db $FF 
	db $7E 
	db $F3 
	db $1B 
	db $6E 
	db $9F 
	db $1D 
	db $FB 
	db $B4 
	db $79 
	db $F9 
	db $3F 
	db $EC 
	db $70 
	db $7F 
	db $7C 
	db $F6 
	db $78 
	db $F8 
	db $7F 
	db $FB 
	db $F5 
	db $BF 
	db $F8 
	db $10 
	db $E0 
	db $F8 
	db $FC 
	db $C9 

MountainTile3:
	db $00 
	db $01 
	db $80 
	db $00 
	db $00 
	db $80 
	db $02 
	db $00 
	db $00 
	db $05 
	db $80 
	db $40 
	db $A0 
	db $C0 
	db $05 
	db $00 
	db $00 
	db $04 
	db $E0 
	db $B2 
	db $35 
	db $E1 
	db $09 
	db $00 
	db $80 
	db $11 
	db $F2 
	db $24 
	db $59 
	db $D8 
	db $23 
	db $80 
	db $E9 
	db $45 
	db $E1 
	db $2A 
	db $0C 
	db $FB 
	db $E3 
	db $72 
	db $A4 
	db $B9 
	db $7F 
	db $86 
	db $E3 
	db $FF 
	db $22 
	db $08 
	db $30 
	db $04 
	db $FB 
	db $E2 
	db $F0 
	db $78 
	db $21 
	db $58 
	db $86 
	db $02 
	db $5C 
	db $5C 
	db $27 
	db $BF 
	db $40 
	db $09 
	db $02 
	db $00 
	db $4E 
	db $08 
	db $4E 
	db $D3 
	db $82 
	db $00 
	db $00 
	db $00 
	db $E9 
	db $9F 
	db $C7 
	db $72 
	db $01 
	db $00 
	db $C4 
	db $42 
	db $B0 
	db $C3 
	db $63 
	db $5C 
	db $81 
	db $ED 
	db $FB 
	db $E0 
	db $18 
	db $1D 
	db $3F 
	db $28 
	db $F4 
	db $FA 
	db $F8 
	db $FC 
	db $0C 
	db $BF 
	db $DB 
	db $49 
	db $5E 
	db $F2 
	db $6C 
	db $77 
	db $C6 
	db $67 
	db $3B 
	db $E6 
	db $B7 
	db $96 
	db $67 
	db $63 
	db $D8 
	db $1C 
	db $3E 
	db $F1 
	db $83 
	db $83 
	db $05 
	db $D3 
	db $FE 
	db $FD 
	db $F2 
	db $CD 
	db $F9 
	db $01 
	db $00 
	db $00 
	db $60 
	db $00 
	db $00 
	db $A0 
	db $00 
	db $00 
	db $00 
	db $01 
	db $60 
	db $10 
	db $28 
	db $70 
	db $01 
	db $00 
	db $80 
	db $01 
	db $38 
	db $2C 
	db $4D 
	db $78 
	db $02 
	db $40 
	db $20 
	db $04 
	db $7C 
	db $89 
	db $16 
	db $F6 
	db $08 
	db $60 
	db $BA 
	db $51 
	db $78 
	db $4A 
	db $C3 
	db $FE 
	db $B8 
	db $1C 
	db $A9 
	db $2E 
	db $5F 
	db $E1 
	db $F8 
	db $BF 
	db $08 
	db $C2 
	db $8C 
	db $01 
	db $3E 
	db $F8 
	db $3C 
	db $5E 
	db $08 
	db $16 
	db $21 
	db $80 
	db $97 
	db $17 
	db $C9 
	db $2F 
	db $50 
	db $C2 
	db $00 
	db $80 
	db $13 
	db $82 
	db $D3 
	db $B4 
	db $20 
	db $80 
	db $C0 
	db $00 
	db $3A 
	db $67 
	db $B1 
	db $5C 
	db $00 
	db $C0 
	db $F1 
	db $10 
	db $AC 
	db $30 
	db $18 
	db $57 
	db $60 
	db $FB 
	db $7E 
	db $F8 
	db $06 
	db $07 
	db $0F 
	db $0A 
	db $BD 
	db $FE 
	db $FE 
	db $3F 
	db $03 
	db $2F 
	db $76 
	db $92 
	db $97 
	db $FC 
	db $DB 
	db $1D 
	db $F1 
	db $99 
	db $8E 
	db $F9 
	db $AD 
	db $E5 
	db $19 
	db $D8 
	db $F6 
	db $07 
	db $4F 
	db $FC 
	db $E0 
	db $A0 
	db $41 
	db $74 
	db $FF 
	db $BF 
	db $7C 
	db $73 
	db $7E 
	db $80 
	db $00 
	db $00 
	db $18 
	db $00 
	db $00 
	db $28 
	db $00 
	db $00 
	db $00 
	db $00 
	db $58 
	db $04 
	db $0A 
	db $5C 
	db $00 
	db $00 
	db $20 
	db $00 
	db $4E 
	db $0B 
	db $13 
	db $9E 
	db $00 
	db $50 
	db $48 
	db $01 
	db $1F 
	db $22 
	db $85 
	db $3D 
	db $02 
	db $98 
	db $AE 
	db $94 
	db $5E 
	db $12 
	db $B0 
	db $3F 
	db $2E 
	db $C7 
	db $6A 
	db $4B 
	db $97 
	db $F8 
	db $FE 
	db $2F 
	db $82 
	db $30 
	db $23 
	db $00 
	db $4F 
	db $BE 
	db $8F 
	db $17 
	db $82 
	db $05 
	db $C8 
	db $60 
	db $25 
	db $C5 
	db $F2 
	db $0B 
	db $94 
	db $70 
	db $80 
	db $20 
	db $04 
	db $E0 
	db $34 
	db $2D 
	db $08 
	db $E0 
	db $F0 
	db $00 
	db $0E 
	db $99 
	db $2C 
	db $17 
	db $00 
	db $70 
	db $3C 
	db $44 
	db $2B 
	db $0C 
	db $C6 
	db $15 
	db $D8 
	db $3E 
	db $DF 
	db $BE 
	db $01 
	db $81 
	db $83 
	db $42 
	db $AF 
	db $FF 
	db $FF 
	db $8F 
	db $C0 
	db $CB 
	db $9D 
	db $E4 
	db $25 
	db $BF 
	db $76 
	db $C7 
	db $7C 
	db $66 
	db $63 
	db $7E 
	db $6B 
	db $B9 
	db $C6 
	db $76 
	db $3D 
	db $81 
	db $13 
	db $3F 
	db $38 
	db $E8 
	db $D0 
	db $5D 
	db $3F 
	db $EF 
	db $DF 
	db $9C 
	db $1F 
	db $20 
	db $00 
	db $00 
	db $06 
	db $00 
	db $00 
	db $0A 
	db $00 
	db $00 
	db $00 
	db $00 
	db $16 
	db $01 
	db $02 
	db $17 
	db $00 
	db $80 
	db $C8 
	db $00 
	db $13 
	db $82 
	db $84 
	db $27 
	db $00 
	db $D4 
	db $92 
	db $00 
	db $47 
	db $C8 
	db $61 
	db $8F 
	db $00 
	db $66 
	db $AB 
	db $A5 
	db $17 
	db $84 
	db $EC 
	db $8F 
	db $CB 
	db $31 
	db $1A 
	db $92 
	db $E5 
	db $FE 
	db $FF 
	db $8B 
	db $20 
	db $8C 
	db $88 
	db $C0 
	db $13 
	db $EF 
	db $E3 
	db $85 
	db $60 
	db $C1 
	db $72 
	db $18 
	db $09 
	db $71 
	db $FC 
	db $02 
	db $25 
	db $9C 
	db $20 
	db $08 
	db $01 
	db $38 
	db $4D 
	db $0B 
	db $02 
	db $38 
	db $7C 
	db $00 
	db $03 
	db $A6 
	db $CB 
	db $05 
	db $00 
	db $1C 
	db $0F 
	db $11 
	db $0A 
	db $C3 
	db $71 
	db $05 
	db $B6 
	db $8F 
	db $77 
	db $EF 
	db $80 
	db $60 
	db $A0 
	db $D0 
	db $EB 
	db $FF 
	db $FF 
	db $E3 
	db $F0 
	db $32 
	db $27 
	db $79 
	db $C9 
	db $6F 
	db $9D 
	db $B1 
	db $DF 
	db $19 
	db $98 
	db $DF 
	db $5A 
	db $EE 
	db $71 
	db $9D 
	db $8F 
	db $60 
	db $C4 
	db $0F 
	db $0E 
	db $FA 
	db $F4 
	db $17 
	db $4F 
	db $FB 
	db $37 
	db $E7 
	db $07 
	db $C8 


MountainTile4:
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $32 
	db $75 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $64 
	db $59 
	db $00 
	db $00 
	db $80 
	db $80 
	db $00 
	db $00 
	db $AA 
	db $8C 
	db $00 
	db $00 
	db $80 
	db $C0 
	db $00 
	db $00 
	db $86 
	db $23 
	db $01 
	db $00 
	db $C0 
	db $40 
	db $00 
	db $01 
	db $22 
	db $30 
	db $01 
	db $00 
	db $20 
	db $20 
	db $00 
	db $01 
	db $1C 
	db $27 
	db $01 
	db $03 
	db $30 
	db $20 
	db $07 
	db $81 
	db $08 
	db $8E 
	db $82 
	db $1B 
	db $08 
	db $3C 
	db $25 
	db $C2 
	db $1F 
	db $07 
	db $C4 
	db $87 
	db $7B 
	db $FF 
	db $D0 
	db $E8 
	db $03 
	db $23 
	db $98 
	db $E6 
	db $FF 
	db $FF 
	db $19 
	db $60 
	db $1D 
	db $BF 
	db $42 
	db $E5 
	db $FC 
	db $FB 
	db $0F 
	db $00 
	db $7F 
	db $9B 
	db $01 
	db $1F 
	db $F4 
	db $48 
	db $5F 
	db $90 
	db $27 
	db $3B 
	db $E1 
	db $0F 
	db $30 
	db $4C 
	db $1F 
	db $E4 
	db $5C 
	db $FE 
	db $D8 
	db $0F 
	db $0E 
	db $03 
	db $3F 
	db $FD 
	db $7D 
	db $32 
	db $FE 
	db $9F 
	db $03 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $08 
	db $00 
	db $00 
	db $00 
	db $80 
	db $00 
	db $00 
	db $0C 
	db $1D 
	db $00 
	db $00 
	db $40 
	db $20 
	db $00 
	db $00 
	db $19 
	db $16 
	db $00 
	db $00 
	db $60 
	db $A0 
	db $00 
	db $00 
	db $2A 
	db $23 
	db $00 
	db $00 
	db $20 
	db $B0 
	db $00 
	db $00 
	db $21 
	db $48 
	db $00 
	db $00 
	db $F0 
	db $90 
	db $00 
	db $00 
	db $48 
	db $4C 
	db $00 
	db $00 
	db $08 
	db $08 
	db $00 
	db $00 
	db $47 
	db $49 
	db $C0 
	db $00 
	db $CC 
	db $08 
	db $01 
	db $E0 
	db $42 
	db $A3 
	db $E0 
	db $06 
	db $82 
	db $CF 
	db $09 
	db $70 
	db $87 
	db $01 
	db $F1 
	db $E1 
	db $DE 
	db $FF 
	db $F4 
	db $3A 
	db $00 
	db $08 
	db $A6 
	db $F9 
	db $FF 
	db $7F 
	db $C6 
	db $58 
	db $07 
	db $AF 
	db $50 
	db $39 
	db $FF 
	db $FE 
	db $C3 
	db $C0 
	db $1F 
	db $66 
	db $C0 
	db $07 
	db $FD 
	db $D2 
	db $17 
	db $E4 
	db $09 
	db $4E 
	db $F8 
	db $03 
	db $CC 
	db $13 
	db $07 
	db $F9 
	db $17 
	db $3F 
	db $F6 
	db $83 
	db $83 
	db $40 
	db $CF 
	db $FF 
	db $5F 
	db $8C 
	db $FF 
	db $E7 
	db $80 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $02 
	db $00 
	db $00 
	db $00 
	db $20 
	db $00 
	db $00 
	db $03 
	db $07 
	db $00 
	db $00 
	db $50 
	db $48 
	db $00 
	db $00 
	db $06 
	db $05 
	db $00 
	db $00 
	db $98 
	db $A8 
	db $00 
	db $00 
	db $0A 
	db $08 
	db $00 
	db $00 
	db $C8 
	db $6C 
	db $00 
	db $00 
	db $08 
	db $12 
	db $00 
	db $00 
	db $3C 
	db $24 
	db $00 
	db $00 
	db $12 
	db $13 
	db $00 
	db $00 
	db $02 
	db $C2 
	db $00 
	db $00 
	db $11 
	db $12 
	db $30 
	db $00 
	db $73 
	db $82 
	db $00 
	db $78 
	db $10 
	db $28 
	db $B8 
	db $81 
	db $E0 
	db $F3 
	db $C2 
	db $5C 
	db $21 
	db $40 
	db $7C 
	db $B8 
	db $77 
	db $3F 
	db $FD 
	db $0E 
	db $80 
	db $82 
	db $69 
	db $FE 
	db $3F 
	db $DF 
	db $F1 
	db $96 
	db $01 
	db $2B 
	db $54 
	db $CE 
	db $FF 
	db $FF 
	db $B0 
	db $F0 
	db $07 
	db $19 
	db $F0 
	db $41 
	db $BF 
	db $74 
	db $85 
	db $F9 
	db $02 
	db $13 
	db $FE 
	db $00 
	db $B3 
	db $C4 
	db $C1 
	db $FE 
	db $45 
	db $8F 
	db $FD 
	db $E0 
	db $E0 
	db $D0 
	db $33 
	db $FF 
	db $D7 
	db $E3 
	db $FF 
	db $39 
	db $20 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $80 
	db $C8 
	db $00 
	db $00 
	db $00 
	db $01 
	db $00 
	db $00 
	db $D4 
	db $92 
	db $00 
	db $00 
	db $01 
	db $01 
	db $00 
	db $00 
	db $66 
	db $AA 
	db $00 
	db $00 
	db $02 
	db $02 
	db $00 
	db $00 
	db $32 
	db $1B 
	db $00 
	db $00 
	db $02 
	db $04 
	db $00 
	db $00 
	db $8F 
	db $89 
	db $00 
	db $00 
	db $04 
	db $04 
	db $00 
	db $80 
	db $C0 
	db $70 
	db $80 
	db $00 
	db $04 
	db $04 
	db $0C 
	db $C0 
	db $9C 
	db $20 
	db $80 
	db $1E 
	db $04 
	db $0A 
	db $6E 
	db $20 
	db $38 
	db $7C 
	db $F0 
	db $97 
	db $08 
	db $10 
	db $1F 
	db $EE 
	db $1D 
	db $0F 
	db $FF 
	db $43 
	db $A0 
	db $60 
	db $9A 
	db $FF 
	db $8F 
	db $77 
	db $FC 
	db $65 
	db $80 
	db $0A 
	db $95 
	db $F3 
	db $FF 
	db $FF 
	db $EC 
	db $3C 
	db $01 
	db $06 
	db $7C 
	db $D0 
	db $6F 
	db $9D 
	db $21 
	db $7E 
	db $40 
	db $84 
	db $3F 
	db $C0 
	db $EC 
	db $71 
	db $30 
	db $7F 
	db $91 
	db $63 
	db $3F 
	db $38 
	db $F8 
	db $F4 
	db $0C 
	db $FF 
	db $F5 
	db $F8 
	db $7F 
	db $0E 
	db $C8 

; xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;
;
;

	org $fd00
data_FD00:
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $FF 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $00 
	db $F3 
	db $0D 
	db $CE 
	db $0B 
	db $E3 
	db $50 
	db $CE 
	db $0B 
	db $E4 
	db $50 
	db $1D 
	db $17 
	db $DC 
	db $0A 
	db $CE 
	db $0B 
	db $E7 
	db $50 
	db $1A 
	db $17 
	db $DC 
	db $0A 
	db $D7 
	db $18 
	db $38 
	db $00 
	db $38 
	db $00 
	db $0D 
	db $19 
	db $DB 
	db $02 
	db $4D 
	db $00 
	db $0E 
	db $46 
	db $F2 
	db $00 
	db $0D 
	db $46 
	db $DB 
	db $02 
	db $4D 
	db $00 
	db $A8 
	db $10 
	db $4B 
	db $00 
	db $BA 
	db $5C 
	db $F3 
	db $0D 
	db $21 
	db $17 
	db $C6 
	db $1E 
	db $D7 
	db $68 
	db $76 
	db $1B 
	db $03 
	db $13 
	db $00 
	db $3E 
	db $00 
	db $3C 
	db $42 
	db $42 
	db $7E 
	db $42 
	db $42 
	db $00 
	db $00 
	db $7C 
	db $42 
	db $7C 
	db $42 
	db $42 
	db $7C 
	db $00 
	db $00 
	db $3C 
	db $42 
	db $40 
	db $40 
	db $42 
	db $3C 
	db $00 
	db $00 
	db $78 
	db $44 
	db $42 
	db $42 
	db $44 
	db $78 
	db $00 
	db $00 
	db $7E 
	db $40 
	db $7C 
	db $40 
	db $40 
	db $7E 
	db $00 
	db $00 
	db $7E 
	db $40 
	db $7C 
	db $40 
	db $40 
	db $40 
	db $00 
	db $00 
	db $3C 
	db $42 
	db $40 
	db $4E 
	db $42 
	db $3C 
	db $00 
	db $00 
	db $42 
	db $42 
	db $7E 
	db $42 
	db $42 
	db $42 
	db $00 
	db $00 
	db $3E 
	db $08 
	db $08 
	db $08 
	db $08 
	db $3E 
	db $00 
	db $00 
	db $02 
	db $02 
	db $02 
	db $42 
	db $42 
	db $3C 
	db $00 
	db $00 
	db $44 
	db $48 
	db $70 
	db $48 
	db $44 
	db $42 
	db $00 
	db $00 
	db $40 
	db $40 
	db $40 
	db $40 
	db $40 
	db $7E 
	db $00 
	db $00 
	db $42 
	db $66 
	db $5A 
	db $42 
	db $42 
	db $42 
	db $00 
	db $00 
	db $42 
	db $62 
	db $52 
	db $4A 
	db $46 
	db $42 
	db $00 
	db $00 
	db $3C 
	db $42 
	db $42 
	db $42 
	db $42 
	db $3C 
	db $00 
	dw $A89E
	dw $A880
	dw $4809
	dw $7E04
	dw $8E9F
	dw $57E9
	dw $4858
	dw $8E76
	dw $8337
	dw $76A0
	dw $9693
	dw $9993
	dw $999D
	dw $89C1
	dw $87A1
	dw $8651
	dw $A0B3
	db $10 
	db $10 
IntVec_FFF4:
	JP   InterruptHandler


	SAVESNA "HyperActive.sna", Start
