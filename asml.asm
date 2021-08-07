.MODEL SMALL
.STACK 100H
.DATA


MENU_PRINCIPAL	DB ,0DH,0AH,"			Calculater			",0DH,0AH
				DB ,0DH,0AH,"	Operacoes" ,0DH,0AH
				DB "Aperte 'b' Para Binario",0DH,0AH
				DB "Aperte 'h' Para Hexadecimal",0DH,0AH
				DB "Aperte 'd' Para Decimal",0DH,0AH
				DB "Aperte ''  Para",0DH,0AH
				DB "                       ",0DH,0AH
				DB "                       ",0DH,0AH
				DB"Entre com sua escolha:$",0DH,0AH
				
MAIN_MENU	DB,0DH,0AH,"Aperte '1' Para AND",0DH,0AH
			DB"Aperte '2' Para OR",0DH,0AH
			DB"Aperte '3' Para XOR",0DH,0AH
			DB"Aperte '4' Para NOT",0DH,0AH
			DB"Aperte 'a' Para Adicao",0DH,0AH
			DB"Aperte 's' Para Subtracao",0DH,0AH
			DB"Aperte 'm' Para Multiplicacao",0DH,0AH
			DB"Aperte 'n' Para Multiplicacao por 2",0DH,0AH
			DB"Aperte 'd' Para Divisao",0DH,0AH
			DB"Aperte 'p' Para Divisao por 2",0DH,0AH
			DB"Aperte 'e' Para Saida",0DH,0AH	
			DB "                       ",0DH,0AH
			DB "                       ",0DH,0AH	
			DB"Entre com sua escolha:",0DH,0AH,'$'
	
	NUM1 	DB"Entre com o primeiro numero: ",0DH,0AH,'$'
	NUM2 	DB"Entre com o segundo numero: ",0DH,0AH,'$'
	
	ADD1 	DB ,0DH,0AH,"Para Adicao",0DH,0AH,'$'
	SUB1 	DB ,0DH,0AH,"Para Subtracao",0DH,0AH,'$'
	MUL1 	DB ,0DH,0AH,"Para Multiplicacao",0DH,0AH,'$'
	DIV1 	DB ,0DH,0AH,"Para Divisao",0DH,0AH,'$'
	EX 		DB ,0DH,0AH,"Saida",0DH,0AH,'$'
	MDIV2 	DB ,0DH,0AH,"Deseja dividir quantas vezes?",0DH,0AH,'$'
	MULT2	DB ,0DH,0AH,"Deseja multiplicar quantas vezes?",0DH,0AH,'$'
	ANS 	DB"Resposta: ",'$'
	CONTINUE DB ,0DH,0AH,"Voce quer continuar'y\n': ",'$'
		
		OP1 DB ?
		OP2 DB ?
		Operand DB ?
		CON DB ?
.CODE 
MAIN PROC
START PROC

	MOV AX,@DATA
	MOV DS,AX

	MOV AH,09H
	LEA DX,MENU_PRINCIPAL
	INT 21H

	MOV AH,1
	INT 21H

	MOV Operand,AL
	MOV AL,Operand  

	;CMP AL,73H
	;JE LISTA2

	;;CMP AL,6DH
	;JE LISTA3

	CMP AL,64H
	JE DECIMAL2
	
DECIMAL2: 
	CALL DECIMAL1

START ENDP

DECIMAL1 PROC
	
	MOV AX,@DATA
	MOV DS,AX
	
	MOV AH,09H
	LEA DX,MAIN_MENU
	INT 21H
	
	MOV AH,1
	INT 21H
	
	MOV Operand,AL
	MOV AL,Operand              
	
	CMP AL,61H
	JE LISTA1
	
	CMP AL,73H
	JE LISTA2
	
	CMP AL,6DH
	JE LISTA3
	
	CMP AL,64H
	JE LISTA4
	
	CMP AL,65H
	JE LISTA5
	
	;CMP AL,6EH
	;JE LISTA6
	
	CMP AL,31H
	JE LISTA7
	
	CMP AL,32H
	JE LISTA8
	
	CMP AL,33H
	JE LISTA9
	
	CMP AL,34H
	JE LISTA10
	
	CMP AL,70H
	JE LISTA11
	
DECIMAL1 ENDP
RETORNO PROC
	
	MOV AH,09H
	MOV DX,OFFSET CONTINUE
	INT 21H
	
	MOV AH,1H
	INT 21H
	
	MOV CON,AL
	MOV AL,CON
	
	CMP AL,79H
	JE START
	
	CMP AL,6EH
	JE EXIT

RETORNO ENDP

LISTA1:
	CALL AD

LISTA2:
	CALL SU

LISTA3 : 
	CALL MU

LISTA4 : 
	CALL DI1

LISTA5 : 
	CALL EXIT

;LISTA6 : 
;	CALL MUL2

LISTA7:
	CALL AND1

LISTA8:
	CALL OR1
	
LISTA9:
	CALL XOR1

LISTA10:
	CALL NOT1

LISTA11:
	CALL DIV2
	
EXIT PROC

	MOV AH,4CH
	INT 21H
	
EXIT ENDP
AD PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	
	MOV AH,09H
	MOV DX,OFFSET NUM1
	INT 21H
	
	CALL SOMAENTRADA
	MOV BX,AX
	
	MOV AH,09H
	MOV DX,OFFSET NUM2
	INT 21H
	
	CALL SOMAENTRADA
	MOV CX,AX
	
		
	MOV AH,09H
	MOV DX,OFFSET ANS
	INT 21H
	
	ADD BX,CX
	MOV	AX,BX
	
	CALL SOMASAIDA
	CALL RETORNO
	
AD ENDP

SU PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	
	MOV AH,09H
	MOV DX,OFFSET NUM1
	INT 21H
	
	CALL SOMAENTRADA
	MOV BX,AX
	
	MOV AH,09H
	MOV DX,OFFSET NUM2
	INT 21H
	
	CALL SOMAENTRADA
	MOV CX,AX
	
	MOV AH,09H
	MOV DX,OFFSET ANS
	INT 21H
	
	SUB BX,CX
	MOV AX,BX
	
	CALL SOMASAIDA
	CALL RETORNO

SU ENDP
MU PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	
	MOV AH,09H
	MOV DX,OFFSET NUM1
	INT 21H
	
	CALL SOMAENTRADA
	MOV BX,AX
	PUSH BX
	
	MOV AH,09H
	MOV DX,OFFSET NUM2
	INT 21H
		
	CALL SOMAENTRADA
	POP BX
	IMUL BX
	PUSH AX
	
	MOV AH,09H
	MOV DX,OFFSET ANS
	INT 21H
	
	POP AX
	CALL SOMASAIDA
	CALL RETORNO

MU ENDP
DI1 PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	
	MOV AH,09H
	MOV DX,OFFSET NUM1
	INT 21H
	
	CALL SOMAENTRADA
	MOV BX,AX
	PUSH BX
	
	MOV AH,09H
	MOV DX,OFFSET NUM2
	INT 21H
		
	CALL SOMAENTRADA
	POP BX
	XCHG AX,BX
	XOR DX,DX
	IDIV BX
	PUSH AX
	
	MOV AH,09H
	MOV DX,OFFSET ANS
	INT 21H
	
	POP AX
	CALL SOMASAIDA
	CALL RETORNO

DI1 ENDP
AND1 PROC
	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	
	CALL SOMAENTRADA
	MOV BX,AX
	
	CALL SOMAENTRADA
	AND AX,BX
	
	CALL SOMASAIDA
	CALL RETORNO

AND1 ENDP
OR1 PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	CALL SOMAENTRADA
	MOV BX,AX
	CALL SOMAENTRADA
	OR AX,BX
	CALL SOMASAIDA
	CALL RETORNO

OR1 ENDP

XOR1 PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	LEA DX,NUM1
	MOV AH,09H
	INT 21H
	CALL SOMAENTRADA
	MOV BX,AX
	LEA DX,NUM2
	MOV AH,09H
	INT 21H
	CALL SOMAENTRADA
	XOR AX,BX
	CALL SOMASAIDA
	CALL RETORNO

XOR1 ENDP
NOT1 PROC

	MOV AH,2 ;funcao para exibir caracter
	MOV DL,0DH ;caracter <CR> - return
	INT 21H ;executando
	MOV DL,0AH ;caracter <LF> - linefeed
	INT 21H ;executando exibindo na TELA
	CALL SOMAENTRADA
	NOT AX
	CALL SOMASAIDA
	CALL RETORNO

NOT1 ENDP	
DIV2 PROC
	
	CALL PRINT_ENTER
	
	MOV AH,09H
	MOV DX,OFFSET MDIV2
	INT 21H
	
	CALL SOMAENTRADA
	
	MOV AH,09H
	MOV DX,OFFSET MDIV2
	INT 21H
	
	MOV CL,AL
	CALL SOMAENTRADA
	
	CBW	
	MOV BX,2D
	
DIVISAO:
	DIV BL
	XOR AH,AH
	DEC CL
	CMP CL,0
	JE PRINT
	JMP DIVISAO
	
 PRINT:
 
	MOV AH,09H
	MOV DX,OFFSET ANS
	INT 21H
	
	CALL SOMASAIDA
	CALL RETORNO

DIV2 ENDP

PRINT_ENTER PROC
	MOV AH,2H
	MOV DL,0AH
	INT 21H
	MOV DL,0DH
	INT 21H
	RET
PRINT_ENTER ENDP

BINARIO1 PROC

	MOV CX,16	;inicializa contador dos dígitos
	MOV AH,1h	;função DOS para entrada pelo teclado
	XOR BX,BX	;zera BX -> terá o resultado
	INT 21H		;entra, caracter está no AL
;while	
TOPO:	CMP AL, 0DH ;é CR?
		;JE EXIT		;se sim, termina o while
		AND AL, 0Fh	;se não, elimina 30h do caracter
		
		SHL BX,1	;abre espaço para o novo dígito
		OR BL,AL	;insere o dígito no LSB de BL
		INT 21H		;entra novo caracter
		LOOP TOPO	;controla o máximo de 16 dígitos
		
;end_while

		MOV CX,16	;inicializa contador de bits
		MOV AH,02h	;prepara para exibir no monitor
		
P1:	ROL BX,1	;desloca BX 1 casa à esquerda
;if CF = 1 
		JNC P2		;salta se CF = 0
;then
		MOV DL,31h	;como CF = 1
		INT 21H		;exibe na tela "1" = 31h
;else	
		JMP LOOP1
P2:
		MOV DL,30h	;como CF = 0
		INT 21h 	;exibe na tela "0"= 30h
;end_if
LOOP1: 
	LOOP P1 ;repete 16 vezes

;end_for

BINARIO1 ENDP

HEXADECIMAL1 PROC
	...
		XOR BX,BX ;inicializa BX com zero
		MOV CL,4 ;inicializa contador com 4
		MOV AH,1h ;prepara entrada pelo teclado
		INT 21h ;entra o primeiro caracter
;while

TOPO: 	CMP AL,0Dh ;é o CR ?
		JE FIM
		CMP AL, 39h ;caracter número ou letra?
		JG LETRA ;caracter já está na faixa ASCII
		AND AL,OFh ;número: retira 30h do ASCII
		JMP DESLOC
LETRA: 	SUB AL,37h ;converte letra para binário
DESLOC: SHL BX,CL ;desloca BX 4 casas à esquerda
		OR BL,AL ;insere valor nos bits 0 a 3 de BX
		INT 21h ;entra novo caracter
		JMP TOPO ;faz o laço até que haja CR
;end_while
FIM: ...

... ;BX já contem número binário
		MOV CH,4 ;CH contador de caracteres hexa
		MOV CL,4 ;CL contador de delocamentos
		MOV AH,2h ;prepara exibição no monitor
;for 4 vezes do
TOPO: 	MOV DL,BH ;captura em DL os oito bits mais
;significativos de BX
		SHR DL,CL ;resta agora em DL somente os 4
;bits mais significativos de BX
;if DL , 10
		CMP DL, 0Ah ;testa se é letra ou número
		JAE LETRA
;then
		ADD DL,30h ;é número: soma-se 30h
		JMP PT1
;else
LETRA: 	ADD DL,37h ;ao valor soma-se 37h -> ASCII
;end_if
PT1: 	INT 21h ;exibe
	ROL BX,CL ;roda BX 4 casas para a direita
	DEC CH
	JNZ TOPO ;faz o FOR 4 vezes
;end_for
... ;programa continua
HEXADECIMAL1 ENDP


MAIN ENDP

SOMAENTRADA PROC ;le um numero decimal da faixa de -32768 a +32767
;variaveis de entrada: nehuma (entrada de digitos pelo teclado)
;variaveis de saida: AX -> valor binario equivalente do numero decimal
	
	PUSH BX
	PUSH CX
	PUSH DX ;salvando registradores que serão usados
	XOR BX,BX ;BX acumula o total, valor inicial 0
	XOR CX,CX ;CX indicador de sinal (negativo = 1), inicial = 0
	MOV AH,1h
	INT 21h ;le caracter no AL
	CMP AL, '-' ;sinal negativo?
	JE MENOS
	CMP AL,'+' ;sinal positivo?
	JE MAIS
	JMP NUM ;se nao é sinal, então vá processar o caracter
	
MENOS: 
	MOV CX,1 ;negativo = verdadeiro
	
MAIS: 
	INT 21h ;le um outro caracter
	
NUM: 
	AND AX,000Fh ;junta AH a AL, converte caracter para binário
	PUSH AX ;salva AX (valor binário) na pilha
	MOV AX,10 ;prepara constante 10
	MUL BX ;AX = 10 x total, total está em BX
	POP BX ;retira da pilha o valor salvo, vai para BX
	ADD BX,AX ;total = total x 10 + valor binário
	MOV AH,1h
	INT 21h ;le um caracter
	CMP AL,0Dh ;é o CR ?
	JNE NUM ;se não, vai processar outro dígito em NUM
	MOV AX,BX ;se é CR, então coloca o total calculado em AX
	CMP CX,1 ;o numero é negativo?
	JNE SAIDA ;não
	NEG AX ;sim, faz-se seu complemento de 2
	
SAIDA: 
	POP DX
	POP CX
	POP BX ;restaura os conteúdos originais
	RET ;retorna a rotina que chamou
SOMAENTRADA ENDP

SOMASAIDA PROC ;exibe o conteudo de AX como decimal inteiro com sinal
;variaveis de entrada: AX -> valor binario equivalente do número decimal
;variaveis de saida: nehuma (exibição de dígitos direto no monitor de video)
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX ;salva na pilha os registradores usados
	OR AX,AX ;prepara comparação de sinal
	JGE PT1 ;se AX maior ou igual a 0, vai para PT1
	PUSH AX ;como AX menor que 0, salva o número na pilha
	MOV DL,'-' ;prepara o caracter ' - ' para sair
	MOV AH,2h ;prepara exibição
	INT 21h ;exibe ' - '
	POP AX ;recupera o número
	NEG AX ;troca o sinal de AX (AX = - AX)
	;obtendo dígitos decimais e salvando-os temporariamente na pilha
	
PT1:XOR CX,CX ;inicializa CX como contador de dígitos
	MOV BX,10 ;BX possui o divisor
	
PT2:XOR DX,DX ;inicializa o byte alto do dividendo em 0; restante é AX
	DIV BX ;após a execução, AX = quociente; DX = resto
	PUSH DX ;salva o primeiro dígito decimal na pilha (1o. resto)
	INC CX ;contador = contador + 1
	OR AX,AX ;quociente = 0 ? (teste de parada)
	JNE PT2 ;não, continuamos a repetir o laço
	;exibindo os dígitos decimais (restos) no monitor, na ordem inversa
	MOV AH,2h ;sim, termina o processo, prepara exibição dos restos
	
PT3:POP DX ;recupera dígito da pilha colocando-o em DL (DH = 0)
	ADD DL,30h ;converte valor binário do dígito para caracter ASCII
	INT 21h ;exibe caracter
	LOOP PT3 ;realiza o loop ate que CX = 0
	POP DX ;restaura o conteúdo dos registros
	POP CX
	POP BX
	POP AX ;restaura os conteúdos dos registradores
	RET ;retorna à rotina que chamou
	
SOMASAIDA ENDP



END MAIN
