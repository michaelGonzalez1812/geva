from PIL import Image

def remake(num):
    while(len(num) < 4):
        num = '0'+num
    return num

def getAllData(data,n):
    x = 0
    all_data = list()
    while(x < n):
        tmp = data[x]
        promedio = (tmp[0]+tmp[1]+tmp[2])//3
        all_data.append(remake(str(hex(promedio)[2:])))
        x += 1
    return all_data

im = Image.open("ee.bmp", "r")
pix_val = getAllData(list(im.getdata()),len(list(im.getdata())))
n = len(pix_val)
print(n)

def getRgb(rgb_values):
    return remake(str(hex(rgb_values[0])[2:]))+remake(str(hex(rgb_values[1])[2:]))+remake(str(hex(rgb_values[2])[2:]))


#lectura del archivo
open('imagen.hex', 'w').close()
direccion = 0
cont = 0
data = ""
sub_cont = 0
f1 = open("imagen.hex", "a+")
while(cont < 2047):
    while(sub_cont <= 16):
        tmp = pix_val[cont]
        data += tmp
        sub_cont += 1
    direccionHex = remake(hex(direccion)[2:])
    f1.write(":20"+direccionHex+"00"+data+"\n")
    direccion += 32
    sub_cont = 0
    data = ""
    cont += 1
f1.write(":0A008000FFFFFFFFFFFFFFFFFFFF80")
f1.close()
