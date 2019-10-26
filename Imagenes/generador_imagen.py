def read_file(filename):
    #lectura del archivo

    open('imagen.hex', 'w').close()
    f = open(filename, "r")
    values = f.readlines()
    f.close()
    for x in values:
        tipo = x[7]+x[8]

        if(tipo == "00"):
            f1 = open("imagen.hex", "a+")
            f1.write(x)
            f1.close()

read_file("test.txt")