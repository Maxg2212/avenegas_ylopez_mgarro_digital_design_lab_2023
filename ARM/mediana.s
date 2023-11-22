.global _start
_start:


@ ====================================================================== @
@ Para probar: inicializar memoria de 0x200 en adelante con 9 números random
@ ====================================================================== @

	mov r6, #0x200		@ Dirección de memoria
    mov r7, #9                 @ Número de elementos en el arreglo
    cmp r7, #0                 @ Comprueba si hay elementos en el arreglo
    ble endBubbleSort          @ Si no hay elementos, salta al final

    mov r5, #0                 @ Inicializa el índice externo (i)
outerLoop:
    mov r4, #0                
	mov r8, #0				   @ Inicializa el índice interno (j)
innerLoop:
    ldr r0, [r6, r4]   		   @ Carga el elemento actual del arreglo
	add r4, r4, #4
    ldr r1, [r6, r4]   		   @ Carga el siguiente elemento del arreglo

    cmp r0, r1                 @ Compara los elementos
    ble noSwap                 @ Salta si r0 <= r1

    str r0, [r6, r4]           @ Intercambia los elementos
	sub r4, r4, #4
    str r1, [r6, r4]
noSwap:
    add r8, r8, #1             @ Incrementa el índice interno (j)
    cmp r8, r7                 @ Comprueba si se han recorrido todos los elementos
    blt innerLoop              @ Si no, vuelve al bucle interno
    add r5, r5, #1             @ Incrementa el índice externo (i)
    cmp r5, r7                 @ Comprueba si se han recorrido todos los elementos
    blt outerLoop              @ Si no, vuelve al bucle externo

endBubbleSort:
	mov r6, #0x210
    ldr r2, [r6]           @ Carga el valor en la posición central (mediana)

	mov r11, #11
	


