.global _start
_start:


@ ====================================================================== @
@ Esto es para inicializar memoria (lo hace el .mif se supone)
	mov r0, #25         @ Número de iteraciones del bucle
    mov r1, #1          @ Valor inicial que se escribirá en la memoria
	mov r2, #0x100		@ Dirección de memoria

init_loop:
    str r1, [r2], #4    @ Almacena el valor en la memoria y avanza la dirección en 4 bytes
	add r1, r1, #10		@ Aumentar el 10 el valor que se va a guardar
    sub r0, r0, #1		@ Actualización del contador del bucle
	cmp r0, #0			@ Si el contador llegó a cero 
    bne init_loop		@ Salta al inicio del bucle si r0 no es cero
@ ====================================================================== @


@ Ya aquí empieza lo del algoritmo
    @ Inicialización de variables o registros
	mov r0, #0	    @ r0 = 0
    mov r1, #0      @ r1 = posición
	mov r2, #0      @ r2 = contador
	mov r3, #0x180  @ r3 = dirección de memoria de video
	mov r4, #0 	    @ r4 = offset para acceder a memoria de video
	mov r5, #0x100  @ r5 = dirección de memoria de pixeles

main_loop:
    cmp r1, #25  	@ Comparar si ya se llegó al número máximo de iteraciones 
    beq end   		@ Saltar a end si son iguales
	add r1, r1, #1	@ Aumentar la posición
	
	@ if posicion <= 5
	cmp r1, #5		@ Comparar la posición con 5
	ble if_1		@ Si la posición es menor o igual que 5 salta a if_1, sino sigue
	
	@ elif posicion > 20
	cmp r1, #20		@ Comparar la posición con 20
	bgt if_2		@ Si la posición es mayor a 20 salta a if_2, sino sigue
	
	@ else:
	@ if contador == 0
	cmp r2, #0		@ Comparar el contador con 0
	beq if_3		@ Si el contador es igual a 0 salta a if_3, sino sigue
	
	@ if contador == 4
	cmp r2, #4		@ Comparar el contador con 4
	beq if_4		@ Si el contador es igual a 4 salta a if_4, sino sigue
	
	@ else:
	@ Todo el procesamiento:
	mov r6, #0x200		@ r6 = 0x200
	@ Aquí habría que ir guardando a partir de 0x200 (en 0x200, 0x204, 0x208, 0x20c, ...)
	@ los valores de alrededor (es como ir haciendo el append)
	
	@append:
		@ldr r7, [(alguna dirección de un número alrededor)]		@ Cargar lo que esté alrededor en r7
		@str r7, [r6]
		@add r6, r6, #4
		@cmp r6, #0x220						@ En 0x220 estaría el final de la lista creo
		@blt append
	
	@ ...
	
	@ Al branchear a bubble_sort ya la lista está en memoria entonces se puede procesar
	b bubble_sort
	return:
		@ Aquí el valor de la mediana ya quedaría en r7
		str r7, [r3, r4]	@ Guardar en la dirección de memoria r3+r4, el valor que tenga r7
	
	
	add r2, r2, #1    @ Aumentar contador en 1
	end_if:		      @ Aquí retornan los ifs para seguir con la siguiente iteración
	add r4, r4, #4    @ Aumentar contador de dirección a memoria
	b main_loop		  @ Saltar de fijo a main_loop para repetir el ciclo
	
	
if_1:
	@ Esto es como hacer esto: memoria_de_imagen[posicion] = datos_en_memoria[posicion]
	ldr r6, [r5, r4]	@ Cargar en r6 lo que esté en la dirección de memoria r5+r4
	str r6, [r3, r4]	@ Guardar en la dirección de memoria r3+r4, el valor que tenga r6
	@ ...  
    b end_if			@ Volver al loop principal
	
if_2:
	ldr r6, [r5, r4]	@ Cargar en r6 lo que esté en la dirección de memoria r5+r4
	str r6, [r3, r4]	@ Guardar en la dirección de memoria r3+r4, el valor que tenga r6
	@ ...  
    b end_if			@ Volver al loop principal
	
if_3:
	ldr r6, [r5, r4]	@ Cargar en r6 lo que esté en la dirección de memoria r5+r4
	str r6, [r3, r4]	@ Guardar en la dirección de memoria r3+r4, el valor que tenga r6
	@ ...  
	add r2, r2, #1  	@ Aumentar contador en 1
    b end_if			@ Volver al loop principal

if_4:
	ldr r6, [r5, r4]	@ Cargar en r6 lo que esté en la dirección de memoria r5+r4
	str r6, [r3, r4]	@ Guardar en la dirección de memoria r3+r4, el valor que tenga r6
	@ ...  
	mov r2, #0      	@ Resetear el contador a 0
    b end_if			@ Volver al loop principal
	

mediana:
	mov r6, #0x200			   @ Dirección de memoria
    mov r7, #9                 @ Número de elementos en el arreglo
    cmp r7, #0                 @ Comprueba si hay elementos en el arreglo
    ble endBubbleSort          @ Si no hay elementos, salta al final

    mov r9, #0                 @ Inicializa el índice externo (i)
outerLoop:
    mov r10, #0                
	mov r8, #0				   @ Inicializa el índice interno (j)
innerLoop:
    ldr r12, [r6, r10]   	   @ Carga el elemento actual del arreglo
	add r10, r10, #4
    ldr r11, [r6, r10]         @ Carga el siguiente elemento del arreglo

    cmp r12, r11               @ Compara los elementos
    ble noSwap                 @ Salta si r0 <= r1

    str r12, [r6, r10]         @ Intercambia los elementos
	sub r10, r10, #4
    str r11, [r6, r10]
noSwap:
    add r8, r8, #1             @ Incrementa el índice interno (j)
    cmp r8, r7                 @ Comprueba si se han recorrido todos los elementos
    blt innerLoop              @ Si no, vuelve al bucle interno
    add r9, r9, #1             @ Incrementa el índice externo (i)
    cmp r9, r7                 @ Comprueba si se han recorrido todos los elementos
    blt outerLoop              @ Si no, vuelve al bucle externo

endBubbleSort:
	mov r6, #0x210		   @ En 0x210 queda el valor de la mediana
    ldr r7, [r6]           @ Carga el valor en la posición central (mediana)
	b return

end:
	


