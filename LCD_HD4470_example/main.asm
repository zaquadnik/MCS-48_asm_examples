;--------------------------------
; Demo program for MCS-48 ev kit
; XTAL 10 MHz
; Machine cycle is 1.5 us
;--------------------------------


.org 0
	jmp Start
	
.org 3
	jmp ExtInt
	
.org 7
	jmp TmrInt

;----------------------------------	
; RO Data Section
;----------------------------------		
.org 15
Text: .db 0x38,0x30,0x34,0x38
	
.org 32	
Start:
	call LCDinit
	mov R0,#Text
Display:
	mov A,R0
	movp A,@A
	mov R2,A
	call LCDchar
	inc R0
	mov A,R0
	xrl A,#Text + 4
	jnz Display
	
MainLoop:
	nop
	jmp MainLoop
	
ExtInt:
	nop
	retr
	
TmrInt:
	nop
	retr
	
;----------------------------------	
; LCD HD44780 control
; Pin map:
; D4 - P1.0
; D5 - P1.1
; D6 - P1.2
; D7 - P1.3
; E  - P1.4
; RS - P1.5	
;----------------------------------	

;=============================	
LCDdel:
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#01h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h	
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	orl P1,#020h ; Set RS
	anl P1,#0E0h
	orl P1,#020h ; Set RS	
	orl P1,#02h		
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0E0h
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	ret
;=============================

;=============================	
LCDshiftLeft:
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#01h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h	
	orl P1,#08h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	orl P1,#020h ; Set RS
	ret
;=============================

;=============================	
LCDshiftRight: 
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#01h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h	
	orl P1,#0Ch
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	ret
;=============================

;=============================
LCDinit:			
	mov A,#3Ch	
	call Wait
	
	anl P1,#0C0h ; Clear RS, E, D4-D8
	orl P1,#03h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	
	anl P1,#0F0h	
	orl P1,#03h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait
		
	anl P1,#0F0h
	orl P1,#03h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait

	anl P1,#0F0h		
	orl P1,#02h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait
	
	anl P1,#0F0h
	orl P1,#02h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h
	orl P1,#08h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait

	anl P1,#0F0h
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h
	orl P1,#06h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait
	
	anl P1,#0F0h
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h
	orl P1,#0Eh
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait
	
	anl P1,#0F0h
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0F0h	
	orl P1,#03h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#01h
	call Wait

	orl P1,#020h ; Set RS
	ret
;=================================

;=================================	
LCDclear:
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0E0h
	orl P1,#01h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	orl P1,#020h ; Set RS
	ret
;=================================

;=================================	
LCDhome:
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0E0h
	orl P1,#01h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	orl P1,#020h ; Set RS
	ret
;================================

;================================
LCDsecondline:
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#0Ch
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0E0h
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	orl P1,#020h ; Set RS
	ret
;===============================

;================================
LCDfirstline:
	anl P1,#0E0h
	anl P1,#0DFh ; Clear RS
	orl P1,#08h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	anl P1,#0E0h
	orl P1,#00h
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#14h
	call Wait
	orl P1,#020h ; Set RS
	ret
;===============================
	
;===============================
LCDchar:
	sel RB1
	anl P1,#0E0h
	mov A,R2
	anl A,#0F0h
	swap A
	mov R1,A
	in A,P1
	orl A,R1
	outl P1,A
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,R2
	anl A,#0Fh
	mov R1,A
	in A,P1
	anl A,#0F0h
	orl A,R1
	outl P1,A
	orl P1,#010h ; Set E
	anl P1,#0EFh ; Clear E
	mov A,#02h
	call Wait
	sel RB0
	ret
;==============================

;==============================	
Wait:
	mov R1,A
  InLoop:
  	mov R0,#053h	;2 cycles
  	djnz R0,$	    ;2 cycles This should give approx A*250us of delay
  	djnz R1,InLoop	;2 cycles
  	ret
;==============================
