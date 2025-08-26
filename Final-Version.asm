.text
main:
    lui $8, 0x1001

    addi $9, $0, 0xFF # Azul - Céu
    addi $10, $0, 0x006400 # Verde - Campo
    addi $11, $0, 0xFFFFFF # Branco - Carro
    addi $12, $0, 0xFFD700 # Amarelo - Faixas da Pista
    addi $13, $0, 0x2F2F2F # Cinza Escuro - Pista
    addi $14, $0, 0xFFFFFE # Borda da pista
    addi $24, $24, 0xA0522D # Siena - Montanha
    addi $25, $25, 0xFF5555 # Vermelho - Carros Inimigos

########### -- Elementos do Mapa -- ###########
    addi $15, $0, 6272 # Tamanho da área do campo (era $12)
    addi $16, $0, 1920 # Tamanho da área do céu (era $11)
Ceu:	
    beq $16, $0, Campo # Loop colorindo o céu
    sw $9, 0($8)
    addi $8, $8, 4
    addi $16, $16, -1
    j Ceu

Campo:	
    beq $15, $0, CurvaturaCampoEsq # Loop colorindo o campo
    sw $10, 0($8)
    addi $8, $8, 4
    addi $15, $15, -1
    j Campo	

CurvaturaCampoEsq:
    li $17,  7680
    lui $8, 0x1001
    add $4, $8, $17
    
    # Lado Esquerdo
    sw $9, 0($4)
    sw $9, 4($4)
    sw $9, 8($4)
    sw $9, 12($4)
    sw $9, 16($4)
    sw $9, 20($4)
    sw $9, 24($4)
    sw $9, 28($4)
    sw $9, 512($4)
    sw $9, 516($4)
    sw $9, 520($4)
    sw $9, 524($4)
    sw $9, 1024($4)
    sw $9, 1028($4)

    # Lado Direito
    sw $9, 480($4)
    sw $9, 484($4)
    sw $9, 488($4)
    sw $9, 492($4)
    sw $9, 496($4)
    sw $9, 500($4)
    sw $9, 504($4)
    sw $9, 508($4)
    sw $9, 1020($4)
    sw $9, 1016($4)
    sw $9, 1012($4)
    sw $9, 1008($4)
    sw $9, 1528($4)
    sw $9, 1532($4)
    
########### -- Rua Refatorada -- ###########
Rua:	
    lui $8, 0x1001 # Colorir o 1° pixel da rua
    addi $8, $8, 7936	
    sw $14, 0($8)
	
    addi $17, $0, 516
    addi $18, $0, 508
    addi $19, $0, 48 # i = = 48
Lado_P1:	
    beq $19, $0, Reset 
    add $8, $8, $18
    sw $14, 0($8)
    addi $19, $19, -1
    j Lado_P1
Reset:	
    lui $8, 0x1001
    addi $8, $8, 7936
    addi $19, $0, 0
Lado_P2:	
    beq $19, 48, interiorRua
    add $8, $8, $17
    sw $14, 0($8)
    addi $19, $19, 1
    j Lado_P2

########### -- Pintar o interior da Rua -- ###########
interiorRua:    
    lui $8, 0x1001
    addi $8, $8, 8448
   
    # Pinta o interior da rua
    sw $13, 0($8) # Topo do triangulo (apenas um pixel)   
 
    addi $17, $0, 48 # verificar a quantidade de linhas pintadas
    addi $18, $0, 1 # $18 = 1 -> IncrementoDir ;  $18 = 2 -> IncrementoEsq
    addi $19, $0, 0 # qtd de pixels a serem pintados por linha
Verificacao:
    addi $17, $17, -1       
    beq $17, 0, Faixas
    addi $19, $19, 2 # Aumentar a qtd de pixels em 2
    beq $18, 1, IncrementoDir
    beq $18, 2, IncrementoEsq
    IncrementoDir:
      addi $8, $8, 508 # Pular linha e pintar o primeiro pixel
      sw $13, 0($8)
      addi $16, $0, 0 # Recomeçar index
      addi $18, $0, 2 # Ir para o IncrementoEsq na volta      
    pintarLinhaDir: # Loop para pintar a linha para a direita
      beq $16, $19, Verificacao
      addi $8, $8, 4 # Pintar linha pra frente
      sw $13, 0($8)
      addi $16, $16, 1
      j pintarLinhaDir
    IncrementoEsq:
      addi $8, $8, 516 # Pular linha e pintar o primeiro pixel
      sw $13, 0($8)
      addi $16, $0, 0 # Recomeçar index
      addi $18, $0, 1 
    pintarLinhaEsq: # Loop para pintar a linha para a esquerda
      beq $16, $19, Verificacao
      addi $8, $8, -4 # Pintar linha pra trás
      sw $13, 0($8)
      addi $16, $16, 1
      j pintarLinhaEsq

########### -- Detalhes das faixas da rua -- ###########
Faixas:
    li $17, 8448 
    lui $8, 0x1001
    add $4, $8, $17
    
    sw $12, 512($4)
    sw $12, 2048($4) 
    sw $12, 2560($4) 
    sw $12, 4608($4) 
    sw $12, 5120($4) 
    sw $12, 5632($4) 
    sw $12, 7680($4) 
    sw $12, 8192($4) 
    sw $12, 8704($4) 
    sw $12, 9216($4) 
    sw $12, 11264($4) 
    sw $12, 11776($4) 
    sw $12, 12288($4) 
    sw $12, 12800($4) 
    sw $12, 13312($4) 
    sw $12, 13824($4) 
    sw $12, 23040($4) 
    sw $12, 23552($4) 
    sw $12, 24064($4) 
    
########### -- Detalhes das nuvens -- ###########
Nuvem_1:
    lui $8, 0x1001
    addi $8, $8, 1664
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 500
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 500
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 500
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
	
Nuvem_2:	
    lui $8, 0x1001
    addi $8, $8, 1920
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 500
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 500
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 500
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    addi $8, $8, 4
    sw $11, 0($8)
    	
########### -- Detalhes das Montanhas -- ###########
Montanha_1_Esq: 
    lui $8, 0x1001
    addi $8, $8, 10840
    addi $8, $8, 4 # - teste constante + endereço de memoria ($8)
    sw $24, 0($8)
    addi $8, $8, 512 # para baixo
    sw $24, 0($8)
	
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
	
    addi $8, $8, 512 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -512 # para baixo
    sw $24, 0($8)
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -512 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -508 # para baixo
    sw $24, 0($8)	
	
Montanha_1_Dir: 
    lui $8, 0x1001
    addi $8, $8, 10640
    addi $8, $8, 4 # - teste constante + endereço de memoria ($8)
    sw $24, 0($8)
    addi $8, $8, 512 # para baixo
    sw $24, 0($8)
	
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
	
    addi $8, $8, 512 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -512 # para baixo
    sw $24, 0($8)
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -512 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -508 # para baixo
    sw $24, 0($8)
	
Montanha_2_Dir: 
    addi $8, $8, -3640 
    addi $8, $8, 4 # - teste constante + endereço de memoria ($8)
    sw $24, 0($8)
    addi $8, $8, 512 # para baixo
    sw $24, 0($8)
	
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
	
    addi $8, $8, 512 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -512 # para baixo
    sw $24, 0($8)
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
    addi $8, $8, 4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -512 # para baixo
    sw $24, 0($8)
    addi $8, $8, -4 # para baixo
    sw $24, 0($8)
    addi $8, $8, -508 # para baixo
    sw $24, 0($8)
		
########### -- Carro -- ###########
Carro:
    addi $10, $0, 0
    li $15, 424		 # Posição inicial do carro inimigo - Esquerda
    li $16, -4680        # Posição inicial do carro inimigo - Meio
    li $17, 456          # Posição inicial do carro inimigo - Direita
    li $23, 0            # Contador de movimentos
    li $22, 8192         # Limite inferior da tela
    addi $19, $0, 6600   # Posição inicial do carro Npc
    addi $20, $0, 0	 # Chave para limitar o movimento do Npc
    
# loop principal do jogo
loop:
    beq $23, 1000, Fim         # quantidade de vezes que roda o jogo
    
    jal desenhaCarroInimigo_1        # desenha o primeiro carro inimigo - Direita
    jal desenhaCarroInimigo_2        # desenha o segundo carro inimigo - Meio
    jal desenhaCarroInimigo_3        # desenha o terceiro carro inimigo - Esquerda
    jal desenhaCarroNpc		     # desenha o carro NPC
    
    # Delay de 200ms (ajuste este valor conforme necessário)
    li $a0, 120             # 120 milissegundos
    li $v0, 32              # syscall para delay
    syscall
    
    jal apagaCarroInimigo_1    # apaga o carro inimigo - Direita
    jal apagaCarroInimigo_2    # apaga o carro inimigo - Meio
    jal apagaCarroInimigo_3    # apaga o carro inimigo - Esquerda
    jal apagaCarroNpc          # apaga o carro do NPC
    
    jal processaTeclado	    # processa entrada do teclado para mover o NPC
    
    addi $17, $17, 512      # move a posição do carro inimigo para baixo
    addi $16, $16, 512      # move a posição do carro inimigo para baixo
    addi $15, $15, 512      # move a posição do carro inimigo para baixo   
    bge $17, $22, ResetaVertical_1
    bge $16, $22, ResetaVertical_2
    bge $15, $22, ResetaVertical_3
    addi $23, $23, 1        # incrementa contador
    
    j loop

### -- Desenhar o Carro do Inimigo 1 (Direita)-- ###
desenhaCarroInimigo_1:
    lui $8, 0x1001
    mul $9, $17, 4
    add $4, $8, $9
    
    # linha 1
    lw $10, 0($4)        # carrega a cor atual do pixel
    bne $10, $13, skip1  # se for diferente da cor da rua, não desenha
    sw $25, 0($4)
skip1:    
    lw $10, 16($4)       # carrega a cor atual do pixel
    bne $10, $13, skip2  # se for diferente da cor da rua, não desenha
    sw $25, 16($4)
skip2:
    # linha 2
    lw $10, 512($4)      # carrega a cor atual do pixel
    bne $10, $13, skip3  # se for diferente da cor da rua, não desenha
    sw $25, 512($4)
skip3:
    # linha 3
    lw $10, 516($4)      # carrega a cor atual do pixel
    bne $10, $13, skip4  # se for diferente da cor da rua, não desenha
    sw $25, 516($4)
skip4:
    lw $10, 520($4)      # carrega a cor atual do pixel
    bne $10, $13, skip5  # se for diferente da cor da rua, não desenha
    sw $25, 520($4)
skip5:
    lw $10, 524($4)      # carrega a cor atual do pixel
    bne $10, $13, skip6  # se for diferente da cor da rua, não desenha
    sw $25, 524($4)
skip6:
    lw $10, 528($4)      # carrega a cor atual do pixel
    bne $10, $13, skip7  # se for diferente da cor da rua, não desenha
    sw $25, 528($4)
skip7:
    # linha 4
    lw $10, 1028($4)     # carrega a cor atual do pixel
    bne $10, $13, skip8  # se for diferente da cor da rua, não desenha
    sw $25, 1028($4)
skip8:
    # linha 5
    lw $10, 1032($4)     # carrega a cor atual do pixel
    bne $10, $13, skip9  # se for diferente da cor da rua, não desenha
    sw $25, 1032($4)
skip9:
    lw $10, 1036($4)     # carrega a cor atual do pixel
    bne $10, $13, skip10 # se for diferente da cor da rua, não desenha
    sw $25, 1036($4)
skip10:
    # linha 6
    lw $10, 1536($4)     # carrega a cor atual do pixel
    bne $10, $13, skip11 # se for diferente da cor da rua, não desenha
    sw $25, 1536($4)
skip11:
    lw $10, 1540($4)     # carrega a cor atual do pixel
    bne $10, $13, skip12 # se for diferente da cor da rua, não desenha
    sw $25, 1540($4)
skip12:
    lw $10, 1544($4)     # carrega a cor atual do pixel
    bne $10, $13, skip13 # se for diferente da cor da rua, não desenha
    sw $25, 1544($4)
skip13:
    lw $10, 1548($4)     # carrega a cor atual do pixel
    bne $10, $13, skip14 # se for diferente da cor da rua, não desenha
    sw $25, 1548($4)
skip14:
    lw $10, 1552($4)     # carrega a cor atual do pixel
    bne $10, $13, skip15 # se for diferente da cor da rua, não desenha
    sw $25, 1552($4)
skip15:
    # linha 7
    lw $10, 2044($4)     # carrega a cor atual do pixel
    bne $10, $13, skip16 # se for diferente da cor da rua, não desenha
    sw $25, 2044($4)
skip16:
    lw $10, 2048($4)     # carrega a cor atual do pixel
    bne $10, $13, skip17 # se for diferente da cor da rua, não desenha
    sw $25, 2048($4)
skip17:
    lw $10, 2052($4)     # carrega a cor atual do pixel
    bne $10, $13, skip18 # se for diferente da cor da rua, não desenha
    sw $25, 2052($4)
skip18:
    lw $10, 2056($4)     # carrega a cor atual do pixel
    bne $10, $13, skip19 # se for diferente da cor da rua, não desenha
    sw $25, 2056($4)
skip19:
    lw $10, 2060($4)     # carrega a cor atual do pixel
    bne $10, $13, skip20 # se for diferente da cor da rua, não desenha
    sw $25, 2060($4)
skip20:
    lw $10, 2064($4)     # carrega a cor atual do pixel
    bne $10, $13, skip21 # se for diferente da cor da rua, não desenha
    sw $25, 2064($4)
skip21:
    lw $10, 2068($4)     # carrega a cor atual do pixel
    bne $10, $13, skip22 # se for diferente da cor da rua, não desenha
    sw $25, 2068($4)
skip22:
    # linha 7 (segunda ocorrência)
    lw $10, 2552($4)     # carrega a cor atual do pixel
    bne $10, $13, skip23 # se for diferente da cor da rua, não desenha
    sw $25, 2552($4)
skip23:
    lw $10, 2560($4)     # carrega a cor atual do pixel
    bne $10, $13, skip24 # se for diferente da cor da rua, não desenha
    sw $25, 2560($4)
skip24:
    lw $10, 2564($4)     # carrega a cor atual do pixel
    bne $10, $13, skip25 # se for diferente da cor da rua, não desenha
    sw $25, 2564($4)
skip25:
    lw $10, 2568($4)     # carrega a cor atual do pixel
    bne $10, $13, skip26 # se for diferente da cor da rua, não desenha
    sw $25, 2568($4)
skip26:
    lw $10, 2572($4)     # carrega a cor atual do pixel
    bne $10, $13, skip27 # se for diferente da cor da rua, não desenha
    sw $25, 2572($4)
skip27:
    lw $10, 2576($4)     # carrega a cor atual do pixel
    bne $10, $13, skip28 # se for diferente da cor da rua, não desenha
    sw $25, 2576($4)
skip28:
    lw $10, 2584($4)     # carrega a cor atual do pixel
    bne $10, $13, skip29 # se for diferente da cor da rua, não desenha
    sw $25, 2584($4)
skip29:
    # linha 8
    lw $10, 3072($4)     # carrega a cor atual do pixel
    bne $10, $13, skip30 # se for diferente da cor da rua, não desenha
    sw $25, 3072($4)
skip30:
    lw $10, 3076($4)     # carrega a cor atual do pixel
    bne $10, $13, skip31 # se for diferente da cor da rua, não desenha
    sw $25, 3076($4)
skip31:
    lw $10, 3080($4)     # carrega a cor atual do pixel
    bne $10, $13, skip32 # se for diferente da cor da rua, não desenha
    sw $25, 3080($4)
skip32:
    lw $10, 3084($4)     # carrega a cor atual do pixel
    bne $10, $13, skip33 # se for diferente da cor da rua, não desenha
    sw $25, 3084($4)
skip33:
    lw $10, 3088($4)     # carrega a cor atual do pixel
    bne $10, $13, skip34 # se for diferente da cor da rua, não desenha
    sw $25, 3088($4)
skip34:
    # linha 9
    lw $10, 3580($4)     # carrega a cor atual do pixel
    bne $10, $13, skip35 # se for diferente da cor da rua, não desenha
    sw $25, 3580($4)
skip35:
    lw $10, 3584($4)     # carrega a cor atual do pixel
    bne $10, $13, skip36 # se for diferente da cor da rua, não desenha
    sw $25, 3584($4)
skip36:
    lw $10, 3588($4)     # carrega a cor atual do pixel
    bne $10, $13, skip37 # se for diferente da cor da rua, não desenha
    sw $25, 3588($4)
skip37:
    lw $10, 3592($4)     # carrega a cor atual do pixel
    bne $10, $13, skip38 # se for diferente da cor da rua, não desenha
    sw $25, 3592($4)
skip38:
    lw $10, 3596($4)     # carrega a cor atual do pixel
    bne $10, $13, skip39 # se for diferente da cor da rua, não desenha
    sw $25, 3596($4)
skip39:
    lw $10, 3600($4)     # carrega a cor atual do pixel
    bne $10, $13, skip40 # se for diferente da cor da rua, não desenha
    sw $25, 3600($4)
skip40:
    lw $10, 3604($4)     # carrega a cor atual do pixel
    bne $10, $13, skip41 # se for diferente da cor da rua, não desenha
    sw $25, 3604($4)
skip41:
    # linha 10
    lw $10, 4088($4)     # carrega a cor atual do pixel
    bne $10, $13, skip42 # se for diferente da cor da rua, não desenha
    sw $25, 4088($4)
skip42:
    lw $10, 4100($4)     # carrega a cor atual do pixel
    bne $10, $13, skip43 # se for diferente da cor da rua, não desenha
    sw $25, 4100($4)
skip43:
    lw $10, 4104($4)     # carrega a cor atual do pixel
    bne $10, $13, skip44 # se for diferente da cor da rua, não desenha
    sw $25, 4104($4)
skip44:
    lw $10, 4108($4)     # carrega a cor atual do pixel
    bne $10, $13, skip45 # se for diferente da cor da rua, não desenha
    sw $25, 4108($4)
skip45:
    lw $10, 4120($4)     # carrega a cor atual do pixel
    bne $10, $13, skip46 # se for diferente da cor da rua, não desenha
    sw $25, 4120($4)
skip46:
    jr $31

### -- Desenhar o Carro do Inimigo 2 (Meio) -- ###
desenhaCarroInimigo_2:
    lui $8, 0x1001
    mul $9, $16, 4
    add $4, $8, $9
    
    # linha 1
    lw $10, 0($4)         # carrega a cor atual do pixel
    bne $10, $13, skip47  # só pinta se for preto
    sw $25, 0($4)         # pinta de vermelho
skip47:    
    lw $10, 16($4)        
    bne $10, $13, skip48
    sw $25, 16($4)
skip48:
    # linha 2
    lw $10, 512($4)      
    bne $10, $13, skip49  
    sw $25, 512($4)
skip49:
    # linha 3
    lw $10, 516($4)      
    bne $10, $13, skip50  
    sw $25, 516($4)
skip50:
    lw $10, 520($4)      
    bne $10, $13, skip51  
    sw $25, 520($4)
skip51:
    lw $10, 524($4)      
    bne $10, $13, skip52  
    sw $25, 524($4)
skip52:
    lw $10, 528($4)      
    bne $10, $13, skip53  
    sw $25, 528($4)
skip53:
    # linha 4
    lw $10, 1028($4)     
    bne $10, $13, skip54  
    sw $25, 1028($4)
skip54:
    # linha 5
    lw $10, 1032($4)     
    bne $10, $13, skip55  
    sw $25, 1032($4)
skip55:
    lw $10, 1036($4)     
    bne $10, $13, skip56  
    sw $25, 1036($4)
skip56:
    # linha 6
    lw $10, 1536($4)     
    bne $10, $13, skip57  
    sw $25, 1536($4)
skip57:
    lw $10, 1540($4)     
    bne $10, $13, skip58  
    sw $25, 1540($4)
skip58:
    lw $10, 1544($4)     
    bne $10, $13, skip59  
    sw $25, 1544($4)
skip59:
    lw $10, 1548($4)     
    bne $10, $13, skip60  
    sw $25, 1548($4)
skip60:
    lw $10, 1552($4)     
    bne $10, $13, skip61  
    sw $25, 1552($4)
skip61:
    # linha 7
    lw $10, 2044($4)     
    bne $10, $13, skip62  
    sw $25, 2044($4)
skip62:
    lw $10, 2048($4)     
    bne $10, $13, skip63  
    sw $25, 2048($4)
skip63:
    lw $10, 2052($4)     
    bne $10, $13, skip64  
    sw $25, 2052($4)
skip64:
    lw $10, 2056($4)     
    bne $10, $13, skip65  
    sw $25, 2056($4)
skip65:
    lw $10, 2060($4)     
    bne $10, $13, skip66  
    sw $25, 2060($4)
skip66:
    lw $10, 2064($4)     
    bne $10, $13, skip67  
    sw $25, 2064($4)
skip67:
    lw $10, 2068($4)     
    bne $10, $13, skip68  
    sw $25, 2068($4)
skip68:
    # linha 7 (segunda ocorrência)
    lw $10, 2552($4)     
    bne $10, $13, skip69  
    sw $25, 2552($4)
skip69:
    lw $10, 2560($4)     
    bne $10, $13, skip70  
    sw $25, 2560($4)
skip70:
    lw $10, 2564($4)     
    bne $10, $13, skip71  
    sw $25, 2564($4)
skip71:
    lw $10, 2568($4)     
    bne $10, $13, skip72  
    sw $25, 2568($4)
skip72:
    lw $10, 2572($4)     
    bne $10, $13, skip73  
    sw $25, 2572($4)
skip73:
    lw $10, 2576($4)     
    bne $10, $13, skip74  
    sw $25, 2576($4)
skip74:
    lw $10, 2584($4)     
    bne $10, $13, skip75  
    sw $25, 2584($4)
skip75:
    # linha 8
    lw $10, 3072($4)     
    bne $10, $13, skip76  
    sw $25, 3072($4)
skip76:
    lw $10, 3076($4)     
    bne $10, $13, skip77  
    sw $25, 3076($4)
skip77:
    lw $10, 3080($4)     
    bne $10, $13, skip78  
    sw $25, 3080($4)
skip78:
    lw $10, 3084($4)     
    bne $10, $13, skip79  
    sw $25, 3084($4)
skip79:
    lw $10, 3088($4)     
    bne $10, $13, skip80  
    sw $25, 3088($4)
skip80:
    # linha 9
    lw $10, 3580($4)     
    bne $10, $13, skip81  
    sw $25, 3580($4)
skip81:
    lw $10, 3584($4)     
    bne $10, $13, skip82  
    sw $25, 3584($4)
skip82:
    lw $10, 3588($4)     
    bne $10, $13, skip83  
    sw $25, 3588($4)
skip83:
    lw $10, 3592($4)     
    bne $10, $13, skip84  
    sw $25, 3592($4)
skip84:
    lw $10, 3596($4)     
    bne $10, $13, skip85  
    sw $25, 3596($4)
skip85:
    lw $10, 3600($4)     
    bne $10, $13, skip86  
    sw $25, 3600($4)
skip86:
    lw $10, 3604($4)     
    bne $10, $13, skip87  
    sw $25, 3604($4)
skip87:
    # linha 10
    lw $10, 4088($4)     
    bne $10, $13, skip88  
    sw $25, 4088($4)
skip88:
    lw $10, 4100($4)     
    bne $10, $13, skip89  
    sw $25, 4100($4)
skip89:
    lw $10, 4104($4)     
    bne $10, $13, skip90  
    sw $25, 4104($4)
skip90:
    lw $10, 4108($4)     
    bne $10, $13, skip91  
    sw $25, 4108($4)
skip91:
    lw $10, 4120($4)     
    bne $10, $13, skip92  
    sw $25, 4120($4)
skip92:
    jr $31  	

### -- Desenhar o Carro do Inimigo 3 (Esquerda) -- ###
desenhaCarroInimigo_3:
    lui $8, 0x1001
    mul $9, $15, 4
    add $4, $8, $9

    # linha 1
    lw $10, 0($4)         # carrega a cor atual do pixel
    bne $10, $13, skip93  # só pinta se for preto
    sw $25, 0($4)         # pinta de vermelho
skip93:    
    lw $10, 16($4)        
    bne $10, $13, skip94
    sw $25, 16($4)
skip94:
    # linha 2
    lw $10, 512($4)      
    bne $10, $13, skip95  
    sw $25, 512($4)
skip95:
    # linha 3
    lw $10, 516($4)      
    bne $10, $13, skip96  
    sw $25, 516($4)
skip96:
    lw $10, 520($4)      
    bne $10, $13, skip97  
    sw $25, 520($4)
skip97:
    lw $10, 524($4)      
    bne $10, $13, skip98  
    sw $25, 524($4)
skip98:
    lw $10, 528($4)      
    bne $10, $13, skip99  
    sw $25, 528($4)
skip99:
    # linha 4
    lw $10, 1028($4)     
    bne $10, $13, skip100  
    sw $25, 1028($4)
skip100:
    # linha 5
    lw $10, 1032($4)     
    bne $10, $13, skip101  
    sw $25, 1032($4)
skip101:
    lw $10, 1036($4)     
    bne $10, $13, skip102  
    sw $25, 1036($4)
skip102:
    # linha 6
    lw $10, 1536($4)     
    bne $10, $13, skip103  
    sw $25, 1536($4)
skip103:
    lw $10, 1540($4)     
    bne $10, $13, skip104  
    sw $25, 1540($4)
skip104:
    lw $10, 1544($4)     
    bne $10, $13, skip105  
    sw $25, 1544($4)
skip105:
    lw $10, 1548($4)     
    bne $10, $13, skip106  
    sw $25, 1548($4)
skip106:
    lw $10, 1552($4)     
    bne $10, $13, skip107  
    sw $25, 1552($4)
skip107:
    # linha 7
    lw $10, 2044($4)     
    bne $10, $13, skip108  
    sw $25, 2044($4)
skip108:
    lw $10, 2048($4)     
    bne $10, $13, skip109  
    sw $25, 2048($4)
skip109:
    lw $10, 2052($4)     
    bne $10, $13, skip110  
    sw $25, 2052($4)
skip110:
    lw $10, 2056($4)     
    bne $10, $13, skip111  
    sw $25, 2056($4)
skip111:
    lw $10, 2060($4)     
    bne $10, $13, skip112  
    sw $25, 2060($4)
skip112:
    lw $10, 2064($4)     
    bne $10, $13, skip113  
    sw $25, 2064($4)
skip113:
    lw $10, 2068($4)     
    bne $10, $13, skip114  
    sw $25, 2068($4)
skip114:
    # linha 7 (segunda ocorrência)
    lw $10, 2552($4)     
    bne $10, $13, skip115  
    sw $25, 2552($4)
skip115:
    lw $10, 2560($4)     
    bne $10, $13, skip116  
    sw $25, 2560($4)
skip116:
    lw $10, 2564($4)     
    bne $10, $13, skip117  
    sw $25, 2564($4)
skip117:
    lw $10, 2568($4)     
    bne $10, $13, skip118  
    sw $25, 2568($4)
skip118:
    lw $10, 2572($4)     
    bne $10, $13, skip119  
    sw $25, 2572($4)
skip119:
    lw $10, 2576($4)     
    bne $10, $13, skip120  
    sw $25, 2576($4)
skip120:
    lw $10, 2584($4)     
    bne $10, $13, skip121  
    sw $25, 2584($4)
skip121:
    # linha 8
    lw $10, 3072($4)     
    bne $10, $13, skip122  
    sw $25, 3072($4)
skip122:
    lw $10, 3076($4)     
    bne $10, $13, skip123  
    sw $25, 3076($4)
skip123:
    lw $10, 3080($4)     
    bne $10, $13, skip124  
    sw $25, 3080($4)
skip124:
    lw $10, 3084($4)     
    bne $10, $13, skip125  
    sw $25, 3084($4)
skip125:
    lw $10, 3088($4)     
    bne $10, $13, skip126  
    sw $25, 3088($4)
skip126:
    # linha 9
    lw $10, 3580($4)     
    bne $10, $13, skip127  
    sw $25, 3580($4)
skip127:
    lw $10, 3584($4)     
    bne $10, $13, skip128  
    sw $25, 3584($4)
skip128:
    lw $10, 3588($4)     
    bne $10, $13, skip129  
    sw $25, 3588($4)
skip129:
    lw $10, 3592($4)     
    bne $10, $13, skip130  
    sw $25, 3592($4)
skip130:
    lw $10, 3596($4)     
    bne $10, $13, skip131  
    sw $25, 3596($4)
skip131:
    lw $10, 3600($4)     
    bne $10, $13, skip132  
    sw $25, 3600($4)
skip132:
    lw $10, 3604($4)     
    bne $10, $13, skip133  
    sw $25, 3604($4)
skip133:
    # linha 10
    lw $10, 4088($4)     
    bne $10, $13, skip134  
    sw $25, 4088($4)
skip134:
    lw $10, 4100($4)     
    bne $10, $13, skip135  
    sw $25, 4100($4)
skip135:
    lw $10, 4104($4)     
    bne $10, $13, skip136  
    sw $25, 4104($4)
skip136:
    lw $10, 4108($4)     
    bne $10, $13, skip137  
    sw $25, 4108($4)
skip137:
    lw $10, 4120($4)     
    bne $10, $13, skip138  
    sw $25, 4120($4)
skip138:
    jr $31

### -- Desenhar o Carro do NPC -- ###
desenhaCarroNpc:
    lui $8, 0x1001
    mul $9, $19, 4
    add $4, $8, $9
    
    # linha 1
    lw $10, 0($4)      # carrega a cor atual do pixel
    beq $10, $25, mensagemDerrota  # se a cor do pixel == cor do inimigo -> Fim de jogo
    beq $10, $14, LimiteEsq  # Se a cor do pixel == cor da borda -> atualiza $20
    sw $11, 0($4)      # Ponta
    
VoltaAqui_1:    
    lw $10, 16($4)             # carrega a cor atual do pixel
    beq $10, $25, LimparNPC_1  # se for a cor == cor do inimigo -> Fim de jogo
    beq $10, $14, LimiteDir  # Se a cor do pixel == cor da borda -> atualiza $20
    sw $11, 16($4)             # Ponta
    # linha 2
VoltaAqui_2:    
    sw $11, 512($4)
    # linha 3
    sw $11, 516($4)
    sw $11, 520($4)
    sw $11, 524($4)
    sw $11, 528($4)
    # linha 4
    sw $11, 1028($4)
    # linha 5
    sw $11, 1032($4)
    sw $11, 1036($4)    
    # linha 6
    sw $11, 1536($4)
    sw $11, 1540($4)
    sw $11, 1544($4)
    sw $11, 1548($4)
    sw $11, 1552($4)
    # linha 7
    sw $11, 2044($4)
    sw $11, 2048($4)
    sw $11, 2052($4)
    sw $11, 2056($4)
    sw $11, 2060($4)
    sw $11, 2064($4)
    sw $11, 2068($4)
    # linha 7
    lw $10, 2552($4)           # carrega a cor atual do pixel
    beq $10, $25, LimparNPC_2  # se for a cor == cor do inimigo -> Fim de jogo
    sw $11, 2552($4)           # Ponta
    sw $11, 2560($4)
    sw $11, 2564($4)
    sw $11, 2568($4)
    sw $11, 2572($4)
    sw $11, 2576($4)
    
    lw $10, 2584($4)           # carrega a cor atual do pixel
    beq $10, $25, LimparNPC_3  # se for a cor == cor do inimigo -> Fim de jogo
    sw $11, 2584($4)           # Ponta
    # linha 8
    sw $11, 3072($4)
    sw $11, 3076($4)
    sw $11, 3080($4)
    sw $11, 3084($4)
    sw $11, 3088($4)
    # linha 9
    sw $11, 3580($4)
    sw $11, 3584($4)
    sw $11, 3588($4)
    sw $11, 3592($4)
    sw $11, 3596($4)
    sw $11, 3600($4)
    sw $11, 3604($4)
    # linha 10
    sw $11, 4088($4) 
    sw $11, 4100($4)
    sw $11, 4104($4)
    sw $11, 4108($4)
    sw $11, 4120($4) 
    jr $31

### -- Apagar o Carro do inimigo 1 (Direita) -- ###
apagaCarroInimigo_1:
    lui $8, 0x1001
    mul $9, $17, 4
    add $4, $8, $9
    
    # linha 1
    lw $10, 0($4)         # carrega a cor atual do pixel
    bne $10, $25, skip139  # se for diferente da cor do carro, não apaga
    sw $13, 0($4)
skip139:
    lw $10, 16($4)        # carrega a cor atual do pixel
    bne $10, $25, skip140  # se for diferente da cor do carro, não apaga
    sw $13, 16($4)
skip140:
    # linha 2
    lw $10, 512($4)       # carrega a cor atual do pixel
    bne $10, $25, skip141  # se for diferente da cor do carro, não apaga
    sw $13, 512($4)
skip141:
    # linha 3
    lw $10, 516($4)       # carrega a cor atual do pixel
    bne $10, $25, skip142  # se for diferente da cor do carro, não apaga
    sw $13, 516($4)
skip142:
    lw $10, 520($4)       # carrega a cor atual do pixel
    bne $10, $25, skip143  # se for diferente da cor do carro, não apaga
    sw $13, 520($4)
skip143:
    lw $10, 524($4)       # carrega a cor atual do pixel
    bne $10, $25, skip144  # se for diferente da cor do carro, não apaga
    sw $13, 524($4)
skip144:
    lw $10, 528($4)       # carrega a cor atual do pixel
    bne $10, $25, skip145  # se for diferente da cor do carro, não apaga
    sw $13, 528($4)
skip145:
    # linha 4
    lw $10, 1028($4)      # carrega a cor atual do pixel
    bne $10, $25, skip146  # se for diferente da cor do carro, não apaga
    sw $13, 1028($4)
skip146:
    # linha 5
    lw $10, 1032($4)      # carrega a cor atual do pixel
    bne $10, $25, skip147  # se for diferente da cor do carro, não apaga
    sw $13, 1032($4)
skip147:
    lw $10, 1036($4)      # carrega a cor atual do pixel
    bne $10, $25, skip148  # se for diferente da cor do carro, não apaga
    sw $13, 1036($4)
skip148:
    # linha 6
    lw $10, 1536($4)      # carrega a cor atual do pixel
    bne $10, $25, skip149  # se for diferente da cor do carro, não apaga
    sw $13, 1536($4)
skip149:
    lw $10, 1540($4)      # carrega a cor atual do pixel
    bne $10, $25, skip150  # se for diferente da cor do carro, não apaga
    sw $13, 1540($4)
skip150:
    lw $10, 1544($4)      # carrega a cor atual do pixel
    bne $10, $25, skip151  # se for diferente da cor do carro, não apaga
    sw $13, 1544($4)
skip151:
    lw $10, 1548($4)      # carrega a cor atual do pixel
    bne $10, $25, skip152  # se for diferente da cor do carro, não apaga
    sw $13, 1548($4)
skip152:
    lw $10, 1552($4)      # carrega a cor atual do pixel
    bne $10, $25, skip153  # se for diferente da cor do carro, não apaga
    sw $13, 1552($4)
skip153:
    # linha 7
    lw $10, 2044($4)      # carrega a cor atual do pixel
    bne $10, $25, skip154  # se for diferente da cor do carro, não apaga
    sw $13, 2044($4)
skip154:
    lw $10, 2048($4)      # carrega a cor atual do pixel
    bne $10, $25, skip155  # se for diferente da cor do carro, não apaga
    sw $13, 2048($4)
skip155:
    lw $10, 2052($4)      # carrega a cor atual do pixel
    bne $10, $25, skip156  # se for diferente da cor do carro, não apaga
    sw $13, 2052($4)
skip156:
    lw $10, 2056($4)      # carrega a cor atual do pixel
    bne $10, $25, skip157  # se for diferente da cor do carro, não apaga
    sw $13, 2056($4)
skip157:
    lw $10, 2060($4)      # carrega a cor atual do pixel
    bne $10, $25, skip158  # se for diferente da cor do carro, não apaga
    sw $13, 2060($4)
skip158:
    lw $10, 2064($4)      # carrega a cor atual do pixel
    bne $10, $25, skip159  # se for diferente da cor do carro, não apaga
    sw $13, 2064($4)
skip159:
    lw $10, 2068($4)      # carrega a cor atual do pixel
    bne $10, $25, skip160  # se for diferente da cor do carro, não apaga
    sw $13, 2068($4)
skip160:
    # linha 7 (segunda ocorrência)
    lw $10, 2552($4)      # carrega a cor atual do pixel
    bne $10, $25, skip161  # se for diferente da cor do carro, não apaga
    sw $13, 2552($4)
skip161:
    lw $10, 2560($4)      # carrega a cor atual do pixel
    bne $10, $25, skip162  # se for diferente da cor do carro, não apaga
    sw $13, 2560($4)
skip162:
    lw $10, 2564($4)      # carrega a cor atual do pixel
    bne $10, $25, skip163  # se for diferente da cor do carro, não apaga
    sw $13, 2564($4)
skip163:
    lw $10, 2568($4)      # carrega a cor atual do pixel
    bne $10, $25, skip164  # se for diferente da cor do carro, não apaga
    sw $13, 2568($4)
skip164:
    lw $10, 2572($4)      # carrega a cor atual do pixel
    bne $10, $25, skip165  # se for diferente da cor do carro, não apaga
    sw $13, 2572($4)
skip165:
    lw $10, 2576($4)      # carrega a cor atual do pixel
    bne $10, $25, skip166  # se for diferente da cor do carro, não apaga
    sw $13, 2576($4)
skip166:
    lw $10, 2584($4)      # carrega a cor atual do pixel
    bne $10, $25, skip167  # se for diferente da cor do carro, não apaga
    sw $13, 2584($4)
skip167:
    # linha 8
    lw $10, 3072($4)      # carrega a cor atual do pixel
    bne $10, $25, skip168  # se for diferente da cor do carro, não apaga
    sw $13, 3072($4)
skip168:
    lw $10, 3076($4)      # carrega a cor atual do pixel
    bne $10, $25, skip169  # se for diferente da cor do carro, não apaga
    sw $13, 3076($4)
skip169:
    lw $10, 3080($4)      # carrega a cor atual do pixel
    bne $10, $25, skip170  # se for diferente da cor do carro, não apaga
    sw $13, 3080($4)
skip170:
    lw $10, 3084($4)      # carrega a cor atual do pixel
    bne $10, $25, skip171  # se for diferente da cor do carro, não apaga
    sw $13, 3084($4)
skip171:
    lw $10, 3088($4)      # carrega a cor atual do pixel
    bne $10, $25, skip172  # se for diferente da cor do carro, não apaga
    sw $13, 3088($4)
skip172:
    # linha 9
    lw $10, 3580($4)      # carrega a cor atual do pixel
    bne $10, $25, skip173  # se for diferente da cor do carro, não apaga
    sw $13, 3580($4)
skip173:
    lw $10, 3584($4)      # carrega a cor atual do pixel
    bne $10, $25, skip174  # se for diferente da cor do carro, não apaga
    sw $13, 3584($4)
skip174:
    lw $10, 3588($4)      # carrega a cor atual do pixel
    bne $10, $25, skip175  # se for diferente da cor do carro, não apaga
    sw $13, 3588($4)
skip175:
    lw $10, 3592($4)      # carrega a cor atual do pixel
    bne $10, $25, skip176  # se for diferente da cor do carro, não apaga
    sw $13, 3592($4)
skip176:
    lw $10, 3596($4)      # carrega a cor atual do pixel
    bne $10, $25, skip177  # se for diferente da cor do carro, não apaga
    sw $13, 3596($4)
skip177:
    lw $10, 3600($4)      # carrega a cor atual do pixel
    bne $10, $25, skip178  # se for diferente da cor do carro, não apaga
    sw $13, 3600($4)
skip178:
    lw $10, 3604($4)      # carrega a cor atual do pixel
    bne $10, $25, skip179  # se for diferente da cor do carro, não apaga
    sw $13, 3604($4)
skip179:
    # linha 10
    lw $10, 4088($4)      # carrega a cor atual do pixel
    bne $10, $25, skip180  # se for diferente da cor do carro, não apaga
    sw $13, 4088($4)
skip180:
    lw $10, 4100($4)      # carrega a cor atual do pixel
    bne $10, $25, skip181  # se for diferente da cor do carro, não apaga
    sw $13, 4100($4)
skip181:
    lw $10, 4104($4)      # carrega a cor atual do pixel
    bne $10, $25, skip182  # se for diferente da cor do carro, não apaga
    sw $13, 4104($4)
skip182:
    lw $10, 4108($4)      # carrega a cor atual do pixel
    bne $10, $25, skip183  # se for diferente da cor do carro, não apaga
    sw $13, 4108($4)
skip183:
    lw $10, 4120($4)      # carrega a cor atual do pixel
    bne $10, $25, skip184  # se for diferente da cor do carro, não apaga
    sw $13, 4120($4)
skip184:
    jr $31

ResetaVertical_1:
    li $17, -3640             # volta para base do fundo da tela
    j loop

### -- Apagar o Carro do inimigo 2 (Meio) -- ###
apagaCarroInimigo_2:
    lui $8, 0x1001
    mul $9, $16, 4
    add $4, $8, $9
    
    # linha 1
    lw $10, 0($4)         # carrega a cor atual do pixel
    bne $10, $25, skip185  # se for diferente da cor do carro, não apaga
    sw $13, 0($4)
skip185:
    lw $10, 16($4)        # carrega a cor atual do pixel
    bne $10, $25, skip186  # se for diferente da cor do carro, não apaga
    sw $13, 16($4)
skip186:
    # linha 2
    lw $10, 512($4)       # carrega a cor atual do pixel
    bne $10, $25, skip187  # se for diferente da cor do carro, não apaga
    sw $13, 512($4)
skip187:
    # linha 3
    lw $10, 516($4)       # carrega a cor atual do pixel
    bne $10, $25, skip188  # se for diferente da cor do carro, não apaga
    sw $13, 516($4)
skip188:
    lw $10, 520($4)       # carrega a cor atual do pixel
    bne $10, $25, skip189  # se for diferente da cor do carro, não apaga
    sw $13, 520($4)
skip189:
    lw $10, 524($4)       # carrega a cor atual do pixel
    bne $10, $25, skip190  # se for diferente da cor do carro, não apaga
    sw $13, 524($4)
skip190:
    lw $10, 528($4)       # carrega a cor atual do pixel
    bne $10, $25, skip191  # se for diferente da cor do carro, não apaga
    sw $13, 528($4)
skip191:
    # linha 4
    lw $10, 1028($4)      # carrega a cor atual do pixel
    bne $10, $25, skip192  # se for diferente da cor do carro, não apaga
    sw $13, 1028($4)
skip192:
    # linha 5
    lw $10, 1032($4)      # carrega a cor atual do pixel
    bne $10, $25, skip193  # se for diferente da cor do carro, não apaga
    sw $13, 1032($4)
skip193:
    lw $10, 1036($4)      # carrega a cor atual do pixel
    bne $10, $25, skip194  # se for diferente da cor do carro, não apaga
    sw $13, 1036($4)
skip194:
    # linha 6
    lw $10, 1536($4)      # carrega a cor atual do pixel
    bne $10, $25, skip195  # se for diferente da cor do carro, não apaga
    sw $13, 1536($4)
skip195:
    lw $10, 1540($4)      # carrega a cor atual do pixel
    bne $10, $25, skip196  # se for diferente da cor do carro, não apaga
    sw $13, 1540($4)
skip196:
    lw $10, 1544($4)      # carrega a cor atual do pixel
    bne $10, $25, skip197  # se for diferente da cor do carro, não apaga
    sw $13, 1544($4)
skip197:
    lw $10, 1548($4)      # carrega a cor atual do pixel
    bne $10, $25, skip198  # se for diferente da cor do carro, não apaga
    sw $13, 1548($4)
skip198:
    lw $10, 1552($4)      # carrega a cor atual do pixel
    bne $10, $25, skip199  # se for diferente da cor do carro, não apaga
    sw $13, 1552($4)
skip199:
    # linha 7
    lw $10, 2044($4)      # carrega a cor atual do pixel
    bne $10, $25, skip200  # se for diferente da cor do carro, não apaga
    sw $13, 2044($4)
skip200:
    lw $10, 2048($4)      # carrega a cor atual do pixel
    bne $10, $25, skip201  # se for diferente da cor do carro, não apaga
    sw $13, 2048($4)
skip201:
    lw $10, 2052($4)      # carrega a cor atual do pixel
    bne $10, $25, skip202  # se for diferente da cor do carro, não apaga
    sw $13, 2052($4)
skip202:
    lw $10, 2056($4)      # carrega a cor atual do pixel
    bne $10, $25, skip203  # se for diferente da cor do carro, não apaga
    sw $13, 2056($4)
skip203:
    lw $10, 2060($4)      # carrega a cor atual do pixel
    bne $10, $25, skip204  # se for diferente da cor do carro, não apaga
    sw $13, 2060($4)
skip204:
    lw $10, 2064($4)      # carrega a cor atual do pixel
    bne $10, $25, skip205  # se for diferente da cor do carro, não apaga
    sw $13, 2064($4)
skip205:
    lw $10, 2068($4)      # carrega a cor atual do pixel
    bne $10, $25, skip206  # se for diferente da cor do carro, não apaga
    sw $13, 2068($4)
skip206:
    # linha 7 (segunda ocorrência)
    lw $10, 2552($4)      # carrega a cor atual do pixel
    bne $10, $25, skip207  # se for diferente da cor do carro, não apaga
    sw $13, 2552($4)
skip207:
    lw $10, 2560($4)      # carrega a cor atual do pixel
    bne $10, $25, skip208  # se for diferente da cor do carro, não apaga
    sw $13, 2560($4)
skip208:
    lw $10, 2564($4)      # carrega a cor atual do pixel
    bne $10, $25, skip209  # se for diferente da cor do carro, não apaga
    sw $13, 2564($4)
skip209:
    lw $10, 2568($4)      # carrega a cor atual do pixel
    bne $10, $25, skip210  # se for diferente da cor do carro, não apaga
    sw $13, 2568($4)
skip210:
    lw $10, 2572($4)      # carrega a cor atual do pixel
    bne $10, $25, skip211  # se for diferente da cor do carro, não apaga
    sw $13, 2572($4)
skip211:
    lw $10, 2576($4)      # carrega a cor atual do pixel
    bne $10, $25, skip212  # se for diferente da cor do carro, não apaga
    sw $13, 2576($4)
skip212:
    lw $10, 2584($4)      # carrega a cor atual do pixel
    bne $10, $25, skip213  # se for diferente da cor do carro, não apaga
    sw $13, 2584($4)
skip213:
    # linha 8
    lw $10, 3072($4)      # carrega a cor atual do pixel
    bne $10, $25, skip214  # se for diferente da cor do carro, não apaga
    sw $13, 3072($4)
skip214:
    lw $10, 3076($4)      # carrega a cor atual do pixel
    bne $10, $25, skip215  # se for diferente da cor do carro, não apaga
    sw $13, 3076($4)
skip215:
    lw $10, 3080($4)      # carrega a cor atual do pixel
    bne $10, $25, skip216  # se for diferente da cor do carro, não apaga
    sw $13, 3080($4)
skip216:
    lw $10, 3084($4)      # carrega a cor atual do pixel
    bne $10, $25, skip217  # se for diferente da cor do carro, não apaga
    sw $13, 3084($4)
skip217:
    lw $10, 3088($4)      # carrega a cor atual do pixel
    bne $10, $25, skip218  # se for diferente da cor do carro, não apaga
    sw $13, 3088($4)
skip218:
    # linha 9
    lw $10, 3580($4)      # carrega a cor atual do pixel
    bne $10, $25, skip219  # se for diferente da cor do carro, não apaga
    sw $13, 3580($4)
skip219:
    lw $10, 3584($4)      # carrega a cor atual do pixel
    bne $10, $25, skip220  # se for diferente da cor do carro, não apaga
    sw $13, 3584($4)
skip220:
    lw $10, 3588($4)      # carrega a cor atual do pixel
    bne $10, $25, skip221  # se for diferente da cor do carro, não apaga
    sw $13, 3588($4)
skip221:
    lw $10, 3592($4)      # carrega a cor atual do pixel
    bne $10, $25, skip222  # se for diferente da cor do carro, não apaga
    sw $13, 3592($4)
skip222:
    lw $10, 3596($4)      # carrega a cor atual do pixel
    bne $10, $25, skip223  # se for diferente da cor do carro, não apaga
    sw $13, 3596($4)
skip223:
    lw $10, 3600($4)      # carrega a cor atual do pixel
    bne $10, $25, skip224  # se for diferente da cor do carro, não apaga
    sw $13, 3600($4)
skip224:
    lw $10, 3604($4)      # carrega a cor atual do pixel
    bne $10, $25, skip225  # se for diferente da cor do carro, não apaga
    sw $13, 3604($4)
skip225:
    # linha 10
    lw $10, 4088($4)      # carrega a cor atual do pixel
    bne $10, $25, skip226  # se for diferente da cor do carro, não apaga
    sw $13, 4088($4)
skip226:
    lw $10, 4100($4)      # carrega a cor atual do pixel
    bne $10, $25, skip227  # se for diferente da cor do carro, não apaga
    sw $13, 4100($4)
skip227:
    lw $10, 4104($4)      # carrega a cor atual do pixel
    bne $10, $25, skip228  # se for diferente da cor do carro, não apaga
    sw $13, 4104($4)
skip228:
    lw $10, 4108($4)      # carrega a cor atual do pixel
    bne $10, $25, skip229  # se for diferente da cor do carro, não apaga
    sw $13, 4108($4)
skip229:
    lw $10, 4120($4)      # carrega a cor atual do pixel
    bne $10, $25, skip230  # se for diferente da cor do carro, não apaga
    sw $13, 4120($4)
skip230:
    jr $31    

ResetaVertical_2:
    li $16, -8264             # volta para base do fundo da tela
    j loop

### -- Apagar o Carro do inimigo 3 (Esquerda) -- ###
apagaCarroInimigo_3:
    lui $8, 0x1001
    mul $9, $15, 4
    add $4, $8, $9

    # linha 1
    lw $10, 0($4)         # carrega a cor atual do pixel
    bne $10, $25, skip231  # se for diferente da cor do carro, não apaga
    sw $13, 0($4)
skip231:
    lw $10, 16($4)        # carrega a cor atual do pixel
    bne $10, $25, skip232  # se for diferente da cor do carro, não apaga
    sw $13, 16($4)
skip232:
    # linha 2
    lw $10, 512($4)       # carrega a cor atual do pixel
    bne $10, $25, skip233  # se for diferente da cor do carro, não apaga
    sw $13, 512($4)
skip233:
    # linha 3
    lw $10, 516($4)       # carrega a cor atual do pixel
    bne $10, $25, skip234  # se for diferente da cor do carro, não apaga
    sw $13, 516($4)
skip234:
    lw $10, 520($4)       # carrega a cor atual do pixel
    bne $10, $25, skip235  # se for diferente da cor do carro, não apaga
    sw $13, 520($4)
skip235:
    lw $10, 524($4)       # carrega a cor atual do pixel
    bne $10, $25, skip236  # se for diferente da cor do carro, não apaga
    sw $13, 524($4)
skip236:
    lw $10, 528($4)       # carrega a cor atual do pixel
    bne $10, $25, skip237  # se for diferente da cor do carro, não apaga
    sw $13, 528($4)
skip237:
    # linha 4
    lw $10, 1028($4)      # carrega a cor atual do pixel
    bne $10, $25, skip238  # se for diferente da cor do carro, não apaga
    sw $13, 1028($4)
skip238:
    # linha 5
    lw $10, 1032($4)      # carrega a cor atual do pixel
    bne $10, $25, skip239  # se for diferente da cor do carro, não apaga
    sw $13, 1032($4)
skip239:
    lw $10, 1036($4)      # carrega a cor atual do pixel
    bne $10, $25, skip240  # se for diferente da cor do carro, não apaga
    sw $13, 1036($4)
skip240:
    # linha 6
    lw $10, 1536($4)      # carrega a cor atual do pixel
    bne $10, $25, skip241  # se for diferente da cor do carro, não apaga
    sw $13, 1536($4)
skip241:
    lw $10, 1540($4)      # carrega a cor atual do pixel
    bne $10, $25, skip242  # se for diferente da cor do carro, não apaga
    sw $13, 1540($4)
skip242:
    lw $10, 1544($4)      # carrega a cor atual do pixel
    bne $10, $25, skip243  # se for diferente da cor do carro, não apaga
    sw $13, 1544($4)
skip243:
    lw $10, 1548($4)      # carrega a cor atual do pixel
    bne $10, $25, skip244  # se for diferente da cor do carro, não apaga
    sw $13, 1548($4)
skip244:
    lw $10, 1552($4)      # carrega a cor atual do pixel
    bne $10, $25, skip245  # se for diferente da cor do carro, não apaga
    sw $13, 1552($4)
skip245:
    # linha 7
    lw $10, 2044($4)      # carrega a cor atual do pixel
    bne $10, $25, skip246  # se for diferente da cor do carro, não apaga
    sw $13, 2044($4)
skip246:
    lw $10, 2048($4)      # carrega a cor atual do pixel
    bne $10, $25, skip247  # se for diferente da cor do carro, não apaga
    sw $13, 2048($4)
skip247:
    lw $10, 2052($4)      # carrega a cor atual do pixel
    bne $10, $25, skip248  # se for diferente da cor do carro, não apaga
    sw $13, 2052($4)
skip248:
    lw $10, 2056($4)      # carrega a cor atual do pixel
    bne $10, $25, skip249  # se for diferente da cor do carro, não apaga
    sw $13, 2056($4)
skip249:
    lw $10, 2060($4)      # carrega a cor atual do pixel
    bne $10, $25, skip250  # se for diferente da cor do carro, não apaga
    sw $13, 2060($4)
skip250:
    lw $10, 2064($4)      # carrega a cor atual do pixel
    bne $10, $25, skip251  # se for diferente da cor do carro, não apaga
    sw $13, 2064($4)
skip251:
    lw $10, 2068($4)      # carrega a cor atual do pixel
    bne $10, $25, skip252  # se for diferente da cor do carro, não apaga
    sw $13, 2068($4)
skip252:
    # linha 7 (segunda ocorrência)
    lw $10, 2552($4)      # carrega a cor atual do pixel
    bne $10, $25, skip253  # se for diferente da cor do carro, não apaga
    sw $13, 2552($4)
skip253:
    lw $10, 2560($4)      # carrega a cor atual do pixel
    bne $10, $25, skip254  # se for diferente da cor do carro, não apaga
    sw $13, 2560($4)
skip254:
    lw $10, 2564($4)      # carrega a cor atual do pixel
    bne $10, $25, skip255  # se for diferente da cor do carro, não apaga
    sw $13, 2564($4)
skip255:
    lw $10, 2568($4)      # carrega a cor atual do pixel
    bne $10, $25, skip256  # se for diferente da cor do carro, não apaga
    sw $13, 2568($4)
skip256:
    lw $10, 2572($4)      # carrega a cor atual do pixel
    bne $10, $25, skip257  # se for diferente da cor do carro, não apaga
    sw $13, 2572($4)
skip257:
    lw $10, 2576($4)      # carrega a cor atual do pixel
    bne $10, $25, skip258  # se for diferente da cor do carro, não apaga
    sw $13, 2576($4)
skip258:
    lw $10, 2584($4)      # carrega a cor atual do pixel
    bne $10, $25, skip259  # se for diferente da cor do carro, não apaga
    sw $13, 2584($4)
skip259:
    # linha 8
    lw $10, 3072($4)      # carrega a cor atual do pixel
    bne $10, $25, skip260  # se for diferente da cor do carro, não apaga
    sw $13, 3072($4)
skip260:
    lw $10, 3076($4)      # carrega a cor atual do pixel
    bne $10, $25, skip261  # se for diferente da cor do carro, não apaga
    sw $13, 3076($4)
skip261:
    lw $10, 3080($4)      # carrega a cor atual do pixel
    bne $10, $25, skip262  # se for diferente da cor do carro, não apaga
    sw $13, 3080($4)
skip262:
    lw $10, 3084($4)      # carrega a cor atual do pixel
    bne $10, $25, skip263  # se for diferente da cor do carro, não apaga
    sw $13, 3084($4)
skip263:
    lw $10, 3088($4)      # carrega a cor atual do pixel
    bne $10, $25, skip264  # se for diferente da cor do carro, não apaga
    sw $13, 3088($4)
skip264:
    # linha 9
    lw $10, 3580($4)      # carrega a cor atual do pixel
    bne $10, $25, skip265  # se for diferente da cor do carro, não apaga
    sw $13, 3580($4)
skip265:
    lw $10, 3584($4)      # carrega a cor atual do pixel
    bne $10, $25, skip266  # se for diferente da cor do carro, não apaga
    sw $13, 3584($4)
skip266:
    lw $10, 3588($4)      # carrega a cor atual do pixel
    bne $10, $25, skip267  # se for diferente da cor do carro, não apaga
    sw $13, 3588($4)
skip267:
    lw $10, 3592($4)      # carrega a cor atual do pixel
    bne $10, $25, skip268  # se for diferente da cor do carro, não apaga
    sw $13, 3592($4)
skip268:
    lw $10, 3596($4)      # carrega a cor atual do pixel
    bne $10, $25, skip269  # se for diferente da cor do carro, não apaga
    sw $13, 3596($4)
skip269:
    lw $10, 3600($4)      # carrega a cor atual do pixel
    bne $10, $25, skip270  # se for diferente da cor do carro, não apaga
    sw $13, 3600($4)
skip270:
    lw $10, 3604($4)      # carrega a cor atual do pixel
    bne $10, $25, skip271  # se for diferente da cor do carro, não apaga
    sw $13, 3604($4)
skip271:
    # linha 10
    lw $10, 4088($4)      # carrega a cor atual do pixel
    bne $10, $25, skip272  # se for diferente da cor do carro, não apaga
    sw $13, 4088($4)
skip272:
    lw $10, 4100($4)      # carrega a cor atual do pixel
    bne $10, $25, skip273  # se for diferente da cor do carro, não apaga
    sw $13, 4100($4)
skip273:
    lw $10, 4104($4)      # carrega a cor atual do pixel
    bne $10, $25, skip274  # se for diferente da cor do carro, não apaga
    sw $13, 4104($4)
skip274:
    lw $10, 4108($4)      # carrega a cor atual do pixel
    bne $10, $25, skip275  # se for diferente da cor do carro, não apaga
    sw $13, 4108($4)
skip275:
    lw $10, 4120($4)      # carrega a cor atual do pixel
    bne $10, $25, skip276  # se for diferente da cor do carro, não apaga
    sw $13, 4120($4)
skip276:
    jr $31    
            
ResetaVertical_3:
    li $15, -11864             # volta para base do fundo da tela
    j loop
### -- Apagar o Carro do NPC -- ###
apagaCarroNpc:
    lui $8, 0x1001
    mul $9, $19, 4
    add $4, $8, $9
    
    # linha 1
    lw $10, 0($4)
    beq $10, $14, Pula_1    
    sw $13, 0($4)

Pula_1:
    lw $10, 16($4)
    beq $10, $14, Pula_2   
    sw $13, 16($4)
    # linha 2
Pula_2:    
    sw $13, 512($4)
    # linha 3
    sw $13, 516($4)
    sw $13, 520($4)
    sw $13, 524($4)
    sw $13, 528($4)
    # linha 4
    sw $13, 1028($4)
    # linha 5
    sw $13, 1032($4)
    sw $13, 1036($4)    
    # linha 6
    sw $13, 1536($4)
    sw $13, 1540($4)
    sw $13, 1544($4)
    sw $13, 1548($4)
    sw $13, 1552($4)
    # linha 7
    sw $13, 2044($4)
    sw $13, 2048($4)
    sw $13, 2052($4)
    sw $13, 2056($4)
    sw $13, 2060($4)
    sw $13, 2064($4)
    sw $13, 2068($4)
    # linha 7
    sw $13, 2552($4)
    sw $13, 2560($4)
    sw $13, 2564($4)
    sw $13, 2568($4)
    sw $13, 2572($4)
    sw $13, 2576($4)
    sw $13, 2584($4)
    # linha 8
    sw $13, 3072($4)
    sw $13, 3076($4)
    sw $13, 3080($4)
    sw $13, 3084($4)
    sw $13, 3088($4)
    # linha 9
    sw $13, 3580($4)
    sw $13, 3584($4)
    sw $13, 3588($4)
    sw $13, 3592($4)
    sw $13, 3596($4)
    sw $13, 3600($4)
    sw $13, 3604($4)
    # linha 10
    sw $13, 4088($4)
    sw $13, 4100($4)
    sw $13, 4104($4)
    sw $13, 4108($4)
    sw $13, 4120($4)
    jr $31
    
processaTeclado:
    lui $18, 0xffff         # MMIO base
    lw $8, 0($18)           # status
    beqz $8, semTecla
    lw $9, 4($18)           # código da tecla

    beq $20, 1, moveDir    # $20 = 1 -> atingiu o limite da rua -> vá p/ direita
    beq $20, 2, moveEsq    # $20 = 1 -> atingiu o limite da rua -> vá p/ direita
    li $10, 'a'
    beq $9, $10, moveEsq
    li $10, 'd'
    beq $9, $10, moveDir

semTecla:
    jr $31

moveEsq:
    addi $20, $0 , 0
    addi $19, $19, -4       # move 1 pixel para esquerda (sem verificação de limite)
    jr $31

moveDir:
    addi $20, $0 , 0
    addi $19, $19, 4        # move 1 pixel para direita (sem verificação de limite)
    jr $31
    
### -- Limpar o NPC quando perde o jogo -- ###
LimparNPC_1:
    lui $8, 0x1001
    mul $9, $19, 4
    add $4, $8, $9
    
    # linha 1
    sw $13, 0($4)
    j mensagemDerrota
    
LimparNPC_2:
    lui $8, 0x1001
    mul $9, $19, 4
    add $4, $8, $9
    
    # linha 1
    sw $13, 0($4)
    sw $13, 16($4)
    # linha 2
    sw $13, 512($4)
    # linha 3
    sw $13, 516($4)
    sw $13, 520($4)
    sw $13, 524($4)
    sw $13, 528($4)
    # linha 4
    sw $13, 1028($4)
    # linha 5
    sw $13, 1032($4)
    sw $13, 1036($4)    
    # linha 6
    sw $13, 1536($4)
    sw $13, 1540($4)
    sw $13, 1544($4)
    sw $13, 1548($4)
    sw $13, 1552($4)
    # linha 7
    sw $13, 2044($4)
    sw $13, 2048($4)
    sw $13, 2052($4)
    sw $13, 2056($4)
    sw $13, 2060($4)
    sw $13, 2064($4)
    sw $13, 2068($4)
    j mensagemDerrota

LimparNPC_3:
    lui $8, 0x1001
    mul $9, $19, 4
    add $4, $8, $9
    
    # linha 1
    sw $13, 0($4)
    sw $13, 16($4)
    # linha 2
    sw $13, 512($4)
    # linha 3
    sw $13, 516($4)
    sw $13, 520($4)
    sw $13, 524($4)
    sw $13, 528($4)
    # linha 4
    sw $13, 1028($4)
    # linha 5
    sw $13, 1032($4)
    sw $13, 1036($4)    
    # linha 6
    sw $13, 1536($4)
    sw $13, 1540($4)
    sw $13, 1544($4)
    sw $13, 1548($4)
    sw $13, 1552($4)
    # linha 7
    sw $13, 2044($4)
    sw $13, 2048($4)
    sw $13, 2052($4)
    sw $13, 2056($4)
    sw $13, 2060($4)
    sw $13, 2064($4)
    sw $13, 2068($4)
    # linha 7
    sw $13, 2552($4)
    sw $13, 2560($4)
    sw $13, 2564($4)
    sw $13, 2568($4)
    sw $13, 2572($4)
    sw $13, 2576($4)
    j mensagemDerrota
    
### -- Atualizar $20 -- ###
LimiteEsq:
    addi $20, $0, 1    # Atualiza $20
    j VoltaAqui_1      # Volta para continuar a execução
   
LimiteDir:
    addi $20, $0, 2    # Atualiza $20
    j VoltaAqui_2      # Volta para continuar a execução

### -- Desenhar mensagem de derrota -- ###        
mensagemDerrota:
lui $8, 0x1001
addi $8, $8, 7808
addi $16, $0, 0
youLose_1:
    beq $16, 64, youLose_2
    sw $25, 0($8)
    addi $8, $8, 4
    addi $16, $16, 1
    j youLose_1
youLose_2:
    beq $16, 24, youLose_3
    sw $25, 0($8)
    addi $8, $8, 512
    addi $16, $16, -1
    j youLose_2
youLose_3:
    beq $16, 88, youLose_4
    sw $25, 0($8)
    addi $8, $8, -4
    addi $16, $16, 1
    j youLose_3
youLose_4:
    beq $16, 48, interiorMensagem
    sw $25, 0($8)
    addi $8, $8, -512
    addi $16, $16, -1
    j youLose_4
    
interiorMensagem:
lui $8, 0x1001
addi $8, $8, 7812
addi $16, $0, 0
addi $17, $0, 40
addi $18, $0, 0

verificacao:
    addi $17, $17, -1
    beq $17, $0, Letras
    beq $18, 0, verificacaoDir
    beq $18, 1, verificacaoEsq
    verificacaoDir:
        addi $8, $8, 512
        addi $18, $0, 1  
    pintarInteriorDir:
        beq $16, 63, verificacao
        sw $13, 0($8)
        addi $8, $8, 4
        addi $16, $16, 1
        addi $18, $0, 1
        j pintarInteriorDir
    verificacaoEsq:
        addi $8, $8, 512
        addi $18, $0, 0
    pintarInteriorEsq:
        beq $16, -1, verificacao
        sw $13, 0($8)
        addi $8, $8, -4
        addi $16, $16, -1
        addi $18, $0, 0
        j pintarInteriorEsq
        
Letras:
    li $17, 12496 
    lui $8, 0x1001
    add $4, $8, $17
    # Letra 'T'
    sw $11, 0($4)
    sw $11, 4($4)
    sw $11, 8($4)
    sw $11, 12($4)
    sw $11, 16($4)
    sw $11, 20($4)
    sw $11, 24($4)
    sw $11, 524($4)
    sw $11, 1036($4)
    sw $11, 1548($4)
    sw $11, 2060($4)
    sw $11, 2572($4)
    sw $11, 3084($4)
    sw $11, 3596($4)
    # Letra 'H'
    sw $11, 36($4) 
    sw $11, 548($4)
    sw $11, 1060($4)
    sw $11, 1572($4)
    sw $11, 2084($4)
    sw $11, 2596($4)
    sw $11, 3108($4)
    sw $11, 3620($4)
    sw $11, 2088($4)
    sw $11, 2092($4)
    sw $11, 2096($4)
    sw $11, 2100($4)
    sw $11, 2612($4)
    sw $11, 3124($4)
    sw $11, 3636($4)
    sw $11, 1588($4)
    sw $11, 1076($4)
    sw $11, 564($4)
    sw $11, 52($4)
    # Letra 'E'
    sw $11, 68($4)
    sw $11, 72($4)
    sw $11, 76($4)
    sw $11, 80($4)
    sw $11, 84($4)
    sw $11, 580($4)
    sw $11, 1092($4)
    sw $11, 1604($4)
    sw $11, 1608($4)
    sw $11, 1612($4)
    sw $11, 1616($4)
    sw $11, 2116($4)
    sw $11, 2628($4)
    sw $11, 3140($4)
    sw $11, 3652($4)
    sw $11, 3656($4)
    sw $11, 3660($4)
    sw $11, 3664($4)
    sw $11, 3668($4)
    # Letra 'E'
    sw $25, 6144($4)
    sw $25, 6148($4)
    sw $25, 6152($4)
    sw $25, 6156($4)
    sw $25, 6160($4)
    sw $25, 6656($4)
    sw $25, 7168($4)
    sw $25, 7680($4)
    sw $25, 7684($4)
    sw $25, 7688($4)
    sw $25, 7692($4)
    sw $25, 8192($4)
    sw $25, 8704($4)
    sw $25, 9216($4)
    sw $25, 9728($4)
    sw $25, 9732($4)
    sw $25, 9736($4)
    sw $25, 9740($4)
    sw $25, 9744($4)
    # Letra 'N'
    sw $25, 6176($4)
    sw $25, 6692($4)
    sw $25, 7208($4)
    sw $25, 7724($4)
    sw $25, 8240($4)
    sw $25, 8756($4)
    sw $25, 9272($4)
    sw $25, 9788($4)
    sw $25, 6688($4)
    sw $25, 7200($4)
    sw $25, 7712($4)
    sw $25, 8224($4)
    sw $25, 8736($4)
    sw $25, 9248($4)
    sw $25, 9760($4)
    sw $25, 9276($4)
    sw $25, 8764($4)
    sw $25, 8252($4)
    sw $25, 7740($4)
    sw $25, 7228($4)
    sw $25, 6716($4)
    sw $25, 6204($4)
    # Letra 'D'
    sw $25, 6220($4)
    sw $25, 6224($4)
    sw $25, 6228($4)
    sw $25, 6232($4)
    sw $25, 6748($4)
    sw $25, 6732($4)
    sw $25, 7244($4)
    sw $25, 7756($4)
    sw $25, 8268($4)
    sw $25, 8780($4)
    sw $25, 9292($4)
    sw $25, 9804($4)
    sw $25, 9808($4)
    sw $25, 9812($4)
    sw $25, 9816($4)
    sw $25, 9308($4)
    sw $25, 8800($4)
    sw $25, 8288($4)
    sw $25, 7776($4)
    sw $25, 7264($4)    
    
########### -- Fim -- ###########
Fim:	addi $2, $0, 10
	syscall
