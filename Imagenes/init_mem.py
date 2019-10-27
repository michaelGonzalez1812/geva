def remake(num):
    while(len(num) < 4):
        num = '0'+num
    return num

def init_mem():
    #lectura del archivo
    open('init.hex', 'w').close()
    direccion = 0
    f1 = open("init.hex", "a+")
    cont = 0
    while(cont < 65536):
        data = "00"
        direccionHex = remake(hex(direccion)[2:])
        f1.write(":01"+direccionHex+"00"+data+"\n")
        #print(":20"+str(direccionHex)+"00"+data)
        direccion += 1
        cont += 1
    f1.write(":00000001FF")
    f1.close()


init_mem()

    #f1 = open("init.hex", "a+")
    #cont = 0
    #while(cont <= 2047):
    #    data = "00000000000000000000000000000000000000000