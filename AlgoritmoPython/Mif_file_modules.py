from PIL import Image
import numpy as np
import mif 

MAX_SIZE = 65536

def mif_file(grey_image_array):
    image_width = len(grey_image_array[0])
    image_depth = len(grey_image_array)
    mif_data = np.zeros((MAX_SIZE, 32), dtype=np.uint8)

    for i in range(image_depth):
        for j in range(image_width):
            mif_data[i * image_width + j] = int(grey_image_array[i][j])

    mif_data[image_depth * image_width:] = 0
    with open("../image_hex_data_1.mif", "w") as f:
        f.write("DEPTH = {};\n".format(MAX_SIZE))
        f.write("WIDTH = 32;\n")
        f.write("ADDRESS_RADIX = UNS;\n")
        f.write("DATA_RADIX = HEX;\n")
        f.write("CONTENT BEGIN\n")

        for i in range(MAX_SIZE):
            hex_values = ['{:02X}'.format(b) for b in mif_data[i]]
            hex_string = ''.join(hex_values)
            f.write("\t{} : {};\n".format(i, hex_string))

        f.write("END;\n")


def save_grey_image(grey_image_array, name):
    grey_image = Image.fromarray(grey_image_array)
    grey_image = grey_image.convert("L")
    grey_image.save(name + ".png")



def convert_to_grey(file_name):
    image = Image.open(file_name)
    new_image = image.resize((256, 256))
    image_array = np.array(new_image)
    grey_image_array = 0.114 * image_array[:, :, 0] + 0.587 * image_array[:, :, 1] + 0.299 * image_array[:, :, 2]

    return grey_image_array

    
grey_image_array = convert_to_grey('C:\\Users\\yarit\\OneDrive\\Imágenes\\Capturas de pantalla\\tb2.png')
save_grey_image(grey_image_array, "imagen2")
mif_file(grey_image_array)
