
org 0
	jmp Start
	
org 3
	jmp ExtInt
	
org 7
	jmp TmrInt
	
Start:
	nop
MainLoop:
	nop
	jmp MainLoop
	
ExtInt:
	nop
	retr
	
TmrInt:
	nop
	retr