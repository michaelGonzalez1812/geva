from PIL import Image

def remake(num):
    while(len(num) < 4):
        num = '0'+num
    return num

def getAllData(data,n):
    x = 0
    all_data = list()
    while(x < n):
        print(data[x])
        all_data.append(str(hex(data[x])[2:]))
        x += 1
    return all_data

im = Image.open("b.bmp", "r")
pix_val = getAllData(list(im.getdata()),len(list(im.getdata())))
n = len(pix_val)

def getRgb(rgb_values):
    return remake(str(hex(rgb_values[0])[2:]))+remake(str(hex(rgb_values[1])[2:]))+remake(str(hex(rgb_values[2])[2:]))


#lectura del archivo
open('imagen.hex', 'w').close()
direccion = 0
cont = 0
data = ""
sub_cont = 0
f1 = open("imagen.hex", "a+")
while(cont < 65536):
    data = pix_val[cont]
    print(data)
    direccionHex = remake(hex(direccion)[2:])
    f1.write(":01"+direccionHex+"00"+data+"\n")
    direccion += 1
    sub_cont = 0
    data = ""
    cont += 1
f1.write(":00000001FF")
f1.close()
