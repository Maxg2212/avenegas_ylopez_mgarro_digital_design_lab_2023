from PIL import Image
import numpy as np

MAX_SIZE = 30002


## Genera el archivo .mif para cargar los datos de la imagen en la ROM
def generate_mif_file(grey_image_array):
    image_width = len(grey_image_array[0])
    image_depth = len(grey_image_array)

    string_datos = "-- Imagen Generada\n\n"
    string_datos += "WIDTH=" + str(32) + ";\n" + "DEPTH=" + str(MAX_SIZE) + ";\n\n"
    string_datos += "ADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\n\n"

    string_datos += "CONTENT BEGIN\n"

    for i in range(image_depth):
        for j in range(image_width):
            string_datos += str(i * image_width + j) + " : "
            string_datos += format(int(grey_image_array[i][j]), '08x') + ";\n"

    if (image_depth * image_width < MAX_SIZE):
        string_datos += "[" + str(image_depth * image_width) + ".." + str(MAX_SIZE - 1) + "] : 00 ; \n"

    string_datos += "END;\n"

    with open("../ram_data2.mif", "w") as mif_file:
        mif_file.write(string_datos)


## Guarda la matriz en una imagen en escala de grises
def save_grey_image(grey_image_array, name):
    grey_image = Image.fromarray(grey_image_array)
    grey_image = grey_image.convert("L")
    grey_image.save(name + ".png")


## Convierte una imagen a una matriz de numpy en escala de grises, rango [0 (negro), 255 (blanco)]
def convert(file_name):
    image = Image.open(file_name)
    new_image = image.resize((100, 100))
    image_array = np.array(new_image)
    grey_image_array = np.empty([len(image_array), len(image_array[0])])

    for i in range(len(image_array)):
        for j in range(len(image_array[i])):
            blue = image_array[i, j, 0]
            green = image_array[i, j, 1]
            red = image_array[i, j, 2]

            grey_scale_value = blue * 0.114 + green * 0.587 + red * 0.299
            grey_image_array[i, j] = grey_scale_value

    return grey_image_array


grey_image_array = convert('C:\\Users\\maxga\\OneDrive\\Documentos\\Cursos CE\\Taller Diseño Digital S2.2023\\imagen\\minion.png')

save_grey_image(grey_image_array, "imagen2")
generate_mif_file(grey_image_array)