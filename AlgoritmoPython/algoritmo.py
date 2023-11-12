import numpy as np
from PIL import Image

datos_en_memoria_imagen = [0, 30, 20, 10, 40,
                           50, 60, 70, 120, 160,
                           100, 130, 80, 110, 140,
                           150, 90, 170, 180, 190,
                           200, 210, 220, 230, 240]  # el 150 está en (x,y)

L = len(datos_en_memoria_imagen)
tamano_fila = 5
memoria_de_imagen_filtrada = [0, 0, 0, 0, 0,
                              0, 0, 0, 0, 0,
                              0, 0, 0, 0, 0,
                              0, 0, 0, 0, 0,
                              0, 0, 0, 0, 0]


# 150 en (x,y)
# (x+1,y) = arriba de 150
# (x-1,y) = abajo de 150
# (x,y+1) = derecha de 150
# (x,y-1) = izquierda de 150
# (x+1,y+1) = extremo derecho inferior
# (x-1, y-1) = extremo izquierdo inferior
# (x+1,y-1) = extremo izquierdo superior
# (x-1, y+1) = extremo derecho superior
posicion = 0
contador = 0
i = 0
while posicion < 25:
    print("Posicion: ", posicion)
    lista_mediana = []
    if posicion < 5:
        print("Borde superior")
        memoria_de_imagen_filtrada[posicion] = datos_en_memoria_imagen[posicion]
    elif posicion >= 19:
        print("Borde inferior")
        memoria_de_imagen_filtrada[posicion] = datos_en_memoria_imagen[posicion]
    else:
        print("Este es el contador: ", contador)
        if contador == 0:
            print("Contador es 0")
            memoria_de_imagen_filtrada[posicion] = datos_en_memoria_imagen[posicion]
            contador += 1
        elif contador == 4:
            print("Contador es 4")
            memoria_de_imagen_filtrada[posicion] = datos_en_memoria_imagen[posicion]
            contador = 0
        else:
            print("Entro el else")
            # lo que esta dentro del append estoy haciedo load, cuando se mete en una lista se hace un store
            lista_mediana.append(datos_en_memoria_imagen[posicion])
            # para avanzar a la siguiente instruccion se le debe sumar 4 (es decir, 4 bytes =32 bits)
            lista_mediana.append(datos_en_memoria_imagen[posicion+1])
            lista_mediana.append(datos_en_memoria_imagen[posicion - 1])
            lista_mediana.append(datos_en_memoria_imagen[posicion-tamano_fila])
            lista_mediana.append(
                datos_en_memoria_imagen[posicion - tamano_fila-1])
            lista_mediana.append(
                datos_en_memoria_imagen[posicion - tamano_fila + 1])
            lista_mediana.append(datos_en_memoria_imagen[posicion+tamano_fila])
            lista_mediana.append(
                datos_en_memoria_imagen[posicion + tamano_fila-1])
            lista_mediana.append(
                datos_en_memoria_imagen[posicion + tamano_fila + 1])
            print("Lista original: ", lista_mediana)
            n = len(lista_mediana)
            for i in range(n):
                # Últimos elementos ya están en su lugar correcto, así que no es necesario volver a revisarlos
                for j in range(0, n - i - 1):
                    # Intercambiar si el elemento encontrado es mayor que el siguiente elemento
                    if lista_mediana[j] > lista_mediana[j + 1]:
                        lista_mediana[j], lista_mediana[j +
                                                        1] = lista_mediana[j + 1], lista_mediana[j]
            print("Lista ordenada: ", lista_mediana)
            memoria_de_imagen_filtrada[posicion] = lista_mediana[4]
            contador += 1

    print("Lista con la imagen filtrada:")
    for i in range(5):
        fila = memoria_de_imagen_filtrada[i * 5: (i + 1) * 5]
        print(fila)

    posicion += 1

