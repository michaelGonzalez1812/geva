from fsm import StateMachine
import os

OPNOP = ["NOP"]
OPAND = ["AND", "ANDEQ", "ANDNE", "ANDGE", "ANDLT", "ANDGT", "ANDLE"]
OPXOR = ["XOR", "XOREQ", "XORNE", "XORGE", "XORLT", "XORGT", "XORLE"]
OPADD = ["ADD", "ADDEQ", "ADDNE", "ADDGE", "ADDLT", "ADDGT", "ADDLE"]
OPSUB = ["SUB", "SUBEQ", "SUBNE", "SUBGE", "SUBLT", "SUBGT", "SUBLE"]
OPCMP = ["CMP", "CMPEQ", "CMPNE", "CMPGE", "CMPLT", "CMPGT", "CMPLE"]
OPORR = ["ORR", "ORREQ", "ORRNE", "ORRGE", "ORRLT", "ORRGT", "ORRLE"]
OPMOV = ["MOV", "MOVEQ", "MOVNE", "MOVGE", "MOVLT", "MOVGT", "MOVLE"]
OPLSL = ["LSL", "LSLEQ", "LSLNE", "LSLGE", "LSLLT", "LSLGT", "LSLLE"]
OPLSR = ["LSR", "LSREQ", "LSRNE", "LSRGE", "LSRLT", "LSRGT", "LSRLE"]
OPMUL = ["MUL", "MULEQ", "MULNE", "MULGE", "MULLT", "MULGT", "MULLE"]
OPSIN = ["SIN", "SINEQ", "SINNE", "SINGE", "SINLT", "SINGT", "SINLE"]
OPCOS = ["COS", "COSEQ", "COSNE", "COSGE", "COSLT", "COSGT" "COSLE"]
OPLDR = ["LDR", "LDREQ", "LDRNE", "LDRGE", "LDRLT", "LDRGT", "LDRLE"]
OPSTR = ["STR", "STREQ", "STRNE", "STRGE", "STRLT", "STRGT", "STRLE"]
OPRDP = ["RDP", "RDPEQ", "RDPNE", "RDPGE", "RDPLT", "RDPGT", "RDPLE"]
OPWRP = ["WRP", "WRPEQ", "WRPNE", "WRPGE", "WRPLT", "WRPGT", "WRPLE"]
OPB   = ["B", "BEQ", "BNE", "BGE", "BLT", "BGT", "BLE"]
OPBL  = ["BL", "BLEQ", "BLNE", "BLGE", "BLLT", "BLGT", "BLLE"]


REGISTERS = ["r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "v0", "v1", "v2", "v3", "v4", 
             "v5", "v6", "v7"]


encodedLine="00000000000000000000000000000000" #this is the line that contains the resulting instruction to be written to the output file
lineCounter = 1 #counts the current line being encoded
insCounter = 0 #counts the part of the instruction being analysed
labelLines={}
writeLineFlag=True
fsmMode=1 #1: only save labels, 2:encode instructions


# def getCondEncode(op):
#     if len(op)==5:
#         cond=op[3:]
#     elif len(op)==4:
#         cond=op[2:]
#     elif len(op)==3 and op[0]=='B': 
#         cond=op[1:]
#     else:
#         cond="NA"
#     return {
#         'NA': '000',
#         'EQ': '001',
#         'NE': '010',
#         'GE': '011',
#         'LT': '100',
#         'GT': '101',
#         'LE': '110',
#     }[cond]

# def getRegisterEncode(rx):
#     return {
#         'R0': '0000',
#         'R1': '0001',
#         'R2': '0010',
#         'R3': '0011',
#         'R4': '0100',
#         'R5': '0101',
#         'R6': '0110',
#         'R7': '0111',
#         'R8': '1000',
#         'R9': '1001',
#         'R10': '1010',
#         'R11': '1011',
#         'R12': '1100',
#         'R13': '1101',
#         'R14': '1110',
#         'R15': '1111',
#     }[rx]

def editString1(stri,pos,replace):
	return stri[:pos]+replace+stri[pos+1:]
def editString2(stri,posB,posE,replace):
    return stri[:posB]+replace+stri[posE+1:]

def getImmSrc(imm,totalBits):
    resultImm = imm
    while (len(resultImm)<totalBits):
        resultImm = '0'+ resultImm
    return resultImm

def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

def startState(line):  
    print("start")
    global writeLineFlag,lineCounter
    splitLine = line.split()
    if len(splitLine)>0:
        word1= splitLine[insCounter]
    else: 
        writeLineFlag=False
        lineCounter-=1
        newState = "doneState"
        return(newState, line)
    wordLen = len(word1)
    if word1[0]==";":
        writeLineFlag=False
        lineCounter-=1
        newState = "doneState"
        return(newState, line)
    elif wordLen > 20 or (wordLen > 5 and word1[wordLen-1] !=":"):
        newState = "ErrorState"
    elif wordLen < 20  and word1[wordLen-1] ==":":
        writeLineFlag=False
        newState = "LabelState"
    elif wordLen <= 5  and word1[wordLen-1] !=":" and fsmMode==2:
        newState = "OperandState"
    elif fsmMode==1:
        newState = "doneState"
    else:
        newState = "ErrorState"
    return(newState, line)

def OperandState(line):
    print("OperandState")
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    newState = ""
    if op in OPNOP:
        newState= "doneState"
    elif op in OPAND:
        newState= "andState"
    elif op in OPXOR:
        newState= "xorState"
    elif op in OPADD:
        newState= "addState"
    elif op in OPSUB:
        newState= "subState"
    elif op in OPCMP:
        newState= "cmpState"
    elif op in OPORR:
        newState= "orrState"
    elif op in OPMOV:
        newState= "movState"
    elif op in OPLSL:
        newState= "lslState"
    elif op in OPLSR:
        newState= "lsrState"
    elif op in OPMUL:
        newState= "mulState"
    elif op in OPSIN:
        newState= "sinState"
    elif op in OPCOS:
        newState= "cosState"
    elif op in OPLDR:
        newState= "ldrState"
    elif op in OPSTR:
        newState= "strState"
    elif op in OPRDP:
        newState= "rdpState"
    elif op in OPWRP:
        newState= "wrpState"
    elif op in OPB:
        newState= "bState"
    elif op in OPBL:
        newState= "blState"
    else:
        newState= "ErrorState"
    return(newState, line)
    
def LabelState(line):
    print("LabelState")
    if fsmMode==1:
        global labelLines,lineCounter
        splitLine = line.split()
        label= splitLine[insCounter].upper()
        label=label[:len(label)-1]
        labelLines[label] = lineCounter
    lineCounter-=1
    newState= "doneState"
    return (newState,line)


def andState(line):
    print("andState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00001")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)

    
    

def xorState(line):
    print("xorState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00010")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)

def subState(line):
    print("subState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00011")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)  

def addState(line):
    print("addState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00100")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)    

def cmpState(line):                  
    print("cmpState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00101")
    encodedLine = editString2(encodedLine,3,4,"00")
    rn = splitLine[insCounter].upper()
    if rn[len(rn)-1]==",":
        rn=rn[:len(rn)-1]
    if rn in REGISTERS:
        newState="regSrc1State"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)  

def orrState(line):
    print("orrState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00110")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def movState(line):
    print("movState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"00111")
    encodedLine = editString2(encodedLine,3,4,"00")
    rd = splitLine[insCounter].upper()
    if rd[len(rd)-1]==",":
        rd=rd[:len(rd)-1]
    if rd in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 


def lslState(line):
    print("lslState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"01000")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def lsrState(line):
    print("lsrState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"01001")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def mulState(line):
    print("mulState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"01010")
    encodedLine = editString2(encodedLine,3,4,"00")
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def sinState(line):
    print("sinState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"01011")
    encodedLine = editString2(encodedLine,3,4,"00")
    rd = splitLine[insCounter].upper()
    if rd[len(rd)-1]==",":
        rd=rd[:len(rd)-1]
    if rd in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def cosState(line):
    print("cosState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1

    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,10,"01100")
    encodedLine = editString2(encodedLine,3,4,"00")
    rd = splitLine[insCounter].upper()
    if rd[len(rd)-1]==",":
        rd=rd[:len(rd)-1]
    if rd in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def ldrState(line):
    print("ldrState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))
    encodedLine = editString2(encodedLine,6,7,"00")
    encodedLine = editString2(encodedLine,3,4,"01")
    encodedLine = editString1(encodedLine,5,"1")#imm = 1
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 
        
def strState(line):
    print("strState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))#cond
    encodedLine = editString2(encodedLine,6,7,"01")#cmd
    encodedLine = editString2(encodedLine,3,4,"01")#op
    encodedLine = editString1(encodedLine,5,"1")#imm = 1
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 

def rdpState(line):
    print("rdpState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))#cond
    encodedLine = editString2(encodedLine,6,7,"10")#cmd
    encodedLine = editString2(encodedLine,3,4,"01")#op
    encodedLine = editString1(encodedLine,5,"1")#imm = 1
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS and ( insCounter+1 >= len(splitLine) or splitLine[insCounter+1][0]==";") :
        encodedLine = editString2(encodedLine,11,14,getRegisterEncode(rx))#rd
        newState="doneState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 


def wrpState(line):
    print("wrpState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))#cond
    encodedLine = editString2(encodedLine,6,7,"11")#cmd
    encodedLine = editString2(encodedLine,3,4,"01")#op
    encodedLine = editString1(encodedLine,5,"1")#imm = 1
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS and ( insCounter+1 >= len(splitLine) or splitLine[insCounter+1][0]==";") :
        encodedLine = editString2(encodedLine,11,14,getRegisterEncode(rx))#rd
        newState="doneState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line) 


def bState(line):
    print("bState")
    global encodedLine, insCounter
    splitLine = line.split()
    op= splitLine[insCounter].upper()
    insCounter+=1
    
    encodedLine = editString2(encodedLine,0,2,getCondEncode(op))#cond
    encodedLine = editString1(encodedLine,5,"0")#cmd
    encodedLine = editString2(encodedLine,3,4,"10")#op
    
    if insCounter+1 < len(splitLine):
        if splitLine[insCounter+1][0]!=";":
            newState="ErrorState"
            return (newState,line)

    label = splitLine[insCounter].upper()
    if label not in labelLines:
        newState="ErrorState"
        return (newState,line)

    imm = -(lineCounter-1 - labelLines[label])
    binaryImm = bindigits(int(imm),26)
    encodedLine = editString2(encodedLine,6,31,binaryImm)
    newState="doneState"
    return (newState,line)

'''def blState(line):'''

def regDestState(line):
    print("regDestState")
    global encodedLine, insCounter
    splitLine = line.split()
    rx = splitLine[insCounter].upper()
    insCounter+=1
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    
    encodedLine = editString2(encodedLine,11,14,getRegisterEncode(rx))

    rn = splitLine[insCounter].upper()  
    if rn[len(rn)-1]==",":
        rn=rn[:len(rn)-1]
    
    if rn in REGISTERS:
        newState="regSrc1State"
        return (newState,line)
    elif rn[0]=="#":
        newState="src2State"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)

def regSrc1State(line):
    print("regSrc1State")
    global encodedLine, insCounter
    splitLine = line.split()
    src1 = splitLine[insCounter].upper() 
    insCounter+=1
    if src1[len(src1)-1]==",":
        src1=src1[:len(src1)-1]

    encodedLine = editString2(encodedLine,15,18,getRegisterEncode(src1))
    
    if insCounter>=len(splitLine) or splitLine[insCounter][0]==";": 
        newState="doneState"
        return (newState,line)
    
    src2 = splitLine[insCounter].upper()  
    if src2[len(src2)-1]==",":
        src2=src2[:len(src2)-1]
    
    if src2 in REGISTERS or src2[0]=="#":
        newState="src2State"
        return (newState,line)

    else:
        newState="ErrorState"
        return (newState,line)

def src2State(line):
    print("Src2State")
    global encodedLine , insCounter
    splitLine = line.split()
    src2 = splitLine[insCounter].upper()   
    insCounter+=1
    if src2[len(src2)-1]==",":
        src2=src2[:len(src2)-1]

    if src2 in REGISTERS:
        encodedLine = editString2(encodedLine,28,31,getRegisterEncode(src2))
        encodedLine = editString1(encodedLine,5,"0")
        if  insCounter<len(splitLine) and splitLine[insCounter][0]!=";":
            newState="ErrorState"
            return (newState,line)    
        newState="doneState"
        return (newState,line)
    elif src2[0]=="#":
        src2=src2[1:]
        binarySrc2 = bindigits(int(src2),13)
        encodedLine = editString2(encodedLine,19,31,binarySrc2)
        encodedLine = editString1(encodedLine,5,"1")
        if  insCounter<len(splitLine) and splitLine[insCounter][0]!=";":
            newState="ErrorState"
            return (newState,line) 
        newState="doneState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,line)

def main():
    global encodedLine, insCounter, lineCounter, writeLineFlag, fsmMode
    F= open("asmDraw.txt","r")
    os.remove("instructions.txt")
    F2= open("instructions.txt", "a+") 
    FLines = F.readlines()
    
    m = StateMachine()
    m.add_state("Start", startState)
    m.add_state("LabelState", LabelState)
    m.add_state("OperandState", OperandState) 
    m.add_state("andState", andState)
    m.add_state("xorState", xorState)
    m.add_state("subState", subState)
    m.add_state("addState", addState)
    m.add_state("cmpState", cmpState)
    m.add_state("orrState", orrState)
    m.add_state("movState", movState)
    m.add_state("lslState", lslState)
    m.add_state("lsrState", lslState)
    m.add_state("mulState", mulState)
    m.add_state("sinState", sinState)
    m.add_state("cosState", cosState)
    m.add_state("ldrState", ldrState)
    m.add_state("strState", strState)
    m.add_state("rdpState", rdpState)
    m.add_state("wrpState", wrpState)
    
    m.add_state("bState", bState)
    '''m.add_state("blState", blState)'''

    m.add_state("regDestState", regDestState)
    m.add_state("regSrc1State", regSrc1State)
    m.add_state("src2State", src2State)
    m.add_state("doneState", None,end_state=1)
    m.add_state("ErrorState", None, end_state=1)
    m.set_start("Start")
    print(FLines)
    
    ''' Set labels'''
    fsmMode=1
    for l in FLines: 
        m.run(l)
        insCounter = 0
        lineCounter+=1

    fsmMode=2
    lineCounter=1
    for l in FLines:
        print(lineCounter)
        if m.run(l):
            if writeLineFlag:
                F2.write(encodedLine + "\r")
            encodedLine ="00000000000000000000000000000000"
            insCounter = 0
            lineCounter+=1
            writeLineFlag=True

    print(labelLines)
    F.close() 


if __name__=="__main__":
    main()
