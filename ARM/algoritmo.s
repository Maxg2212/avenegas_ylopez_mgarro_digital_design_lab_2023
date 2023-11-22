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
	mov r6, #0x69		@ r6 = 69
	str r6, [r3, r4]	@ Guardar en la dirección de memoria r3+r4, el valor que tenga r6
	@ ...
	
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


end:
	


