from fsm import StateMachine
import os
import sys
# Codigo fuente Compilador para ISA GEVA
# Autores:                       
#   Michael Gonzalez Rivera     
#   Erick Cordero Rojas         
#   Victor Montero Barboza      
#   Jorge Aguero Zamora         


#Global variables declartion
#this is the line that contains the resulting instruction 
# to be written to the output file
encodedLine="0000000000000000" 

#counts the current line being encoded
lineCounter = 1 

#counts the part of the instruction being analysed
insCounter = 0 

#indicates if the current line being read from SyntaxEfile should 
# be writen or not. e.g. a comment or blank line is not written
writeLineFlag=True 

#buffer of instructions to be repeated
repeatBuffer = "" 

#active after "@repetir" is found. 
# While ON, read lines are saved on 
# the buffer and written once "@finrepetir" is encountered
repeatFlag = False

# active after "@finrepetir" is found. 
# While ON, lines on the buffer are repeated until 
# "repetitions" is reached
writeRepeat = False

# indicates the amount of times the code in repeatBuffer should be 
# repeated
repetitions=0         

# The following arrays are used to identify the correct sintaxys of the 
# mnemonics as well as to identify the format of the operation.
OP_A_FORMAT = ["ANDVE", "ANDVV", "ORVE", "ORVV", 
               "XORE", "XORV", "CDV","CIV", "RD", 
               "RI", "SV", "SVE", "RV", "RVE", "STP"]

OP_B_FORMAT = ["CV", "CE", "GV", "GE", "TB"]

OP_C_FORMAT = ["CDE", "CIE", "SI"]

OP_D_FORMAT = ["CI"]


# Array to identify register name
REGISTERS = ["R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7", 
             "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7"]

# Identify type of operation
# Can take values: "a", "b", "c", "d"
opType = ""

COMMENT_CHAR = '/'

##############################################################
# Generate the register number encryption
# Parameters:
#   rx: String value. Indicates the specific register
# Output:
#   String value of lenght 3 with register encodification
###############################################################
def getRegisterEncode(rx):
    return {
        'R0': '000',
        'V0': '000',
        'R1': '001',
        'V1': '001',
        'R2': '010',
        'V2': '010',
        'R3': '011',
        'V3': '011',
        'R4': '100',
        'V4': '100',
        'R5': '101',
        'V5': '101',
        'R6': '110',
        'V6': '110',
        'R7': '111',
        'V7': '111',
    }[rx]



#######################################OP_A_FORMAT#######################
# The next 2 functions are auxiliars to edit a string in the 
# middle of it.
# Parameters:
#   stri: String value to be editedsplitLine
#   pos: where to wite the char
#   posB,posE: range to insert strisplitLine (B:begin, E:end)
#   replace: String value to be inssplitLineted. 1 char for editString1. 
#            Multiple chars for editString2
#
# Output:
#   Modified string
###############################################################
def editString1(stri,pos,replace):
	return stri[:pos]+replace+stri[pos+1:]
def editString2(stri,posB,posE,replace):
    return stri[:posB]+replace+stri[posE+1:]


##############################################################
# Get an immidiate codification to binary
# Parameters:
#   n: Number(base10) to be encoded
#   bits: desired amount of bits to represen the number(zeroes
#   on front)r0
#
# Output:
#   Binary number
###############################################################
def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)





##############################################################
# Function to be executed by Initial State. Takes one line and
# and splits it to start analyzing. Forw"SVE"ards to next states.
# Parameters:
#   line: string read from file.
# REGISTERS
# Output:insCounter+=1
#   NA
###############################################################
def startState(line):  
    print("start")
    global writeLineFlag,lineCounter,repeatFlag,writeRepeat, repetitions
    splitLine = line.split()
    if len(splitLine)>0:
        word1= splitLine[insCounter]
    else: 
        writeLineFlag=False
        lineCounter-=1
        newState = "doneState"
        return(newState, line)
    wordLen = len(word1)
    # check if its a comment
    if word1[0]== COMMENT_CHAR:
        writeLineFlag=False
        lineCounter-=1
        newState = "doneState"
        return(newState, line)
        
    # check if is a directive to repeat
    elif word1 == "@repetir":
        print("repetir")
        if len(splitLine)<2:
            newState = "ErrorState"
            return(newState, "Missing directive argument")
        else:
            try:
                temp = int(splitLine[1])
            except:
                newState = "ErrorState"
                return(newState, "Directive argument should be number")
            repeatFlag = True
            repetitions = temp
            newState = "doneState"
            writeLineFlag=False
            return(newState, line)
    # check if is a directive to end repeat
    elif word1=="@finrepetir":
        print("FINrepetir")
        if len(splitLine)>1:
            newState = "ErrorState"
            return(newState, "Incorrect Directive")
        else:
            repeatFlag = False
            writeRepeat = True
            writeLineFlag=False
            newState = "doneState"
            return(newState, line)
    # check if word could be operator
    elif wordLen <= 5:
        newState = "OperandState"
        return(newState, line)
    else:
        newState = "ErrorState"
        return(newState, "InstinsCounterruction expected operator")

##############################################################
# Determines encodification for the Opetarion
# Parameters:
#   op: string with the operation
# 
# Output:
#   String with encodification"SVE"
###############################################################
def getOpEncode(op):
    return {
        "ANDVE": '00000',
        "ANDVV": '00001',
        "ORVE": '00010',
        "XORE": '00100',
        "XORV": '00101',
        "CDV": '00110',
        "CIV": '00111',
        "RD": '01000',
        "RI": '01001',
        "SV": '01010',
        "ORVV": '00011',
        "RV": '01100',
        "RVE": '01101',
        "STP": '11111',
        "CV": '01110',
        "CE": '01111',
        "GV": '10000',
        "GE": '10001',
        "TB": '10010',
        "CDE": '10011',
        "CIE": '10100',
        "SI": '10101',
        "CI": '10110',
        "SVE":"01011",
    }[op]

##############################################################
# Function to be executed by OpErrorStateerand State. Identifies the operation
# Parameters:
#   line: string read from file.
# 
# Output:
#   NA
###############################################################
def OperandState(line):
    print("OperandState")
    global opType,insCounter,encodedLine
    splitLine = line.split()
    op = splitLine[insCounter].upper()
    print(op)
    newState = ""
    # Determine operation format
    if op in OP_A_FORMAT:
        
        opType = 'a'
    elif op in OP_B_FORMAT:
        opType = 'b'
    elif op in OP_C_FORMAT:
        opType = 'c'
    elif op in OP_D_FORMAT:
        opType = 'd'
    else: #unrecognized operatio 
        newState= "ErrorState"
        return(newState, "Unrecognized operation")
    insCounter+=1
    # encoding 
    encodedLine = editString2(encodedLine,0,4,getOpEncode(op))
    # checking if is stp state
    if (op == "STP"):
        if insCounter >= len(splitLine) or splitLine[insCounter][0] != COMMENT_CHAR:
            newState="doneState"
            return (newState,line)
        else: 
            newState="ErrorState"
        return (newState,"Too many arguments")
    #changing state, allways to destination register state
    rx = splitLine[insCounter].upper()
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    if rx in REGISTERS:
        newState="regDestState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,"Expected Register")
    newState="ErrorState"
    return(newState, "Error on operadnd")

##############################################################
# Function for destination register state
# Encodes the register and decides next state based on
# opType
# Parameters:
#   line: string read from file.
# 
# Output:
#   NA
###############################################################
def regDestState(line):
    print("regDestState")
    global encodedLine, insCounter
    splitLine = line.split()
    rx = splitLine[insCounter].upper()
    insCounter+=1
    if rx[len(rx)-1]==",":
        rx=rx[:len(rx)-1]
    
    #encoding destination register
    encodedLine = editString2(encodedLine,5,7,getRegisterEncode(rx))
    
    rn = splitLine[insCounter].upper()
    if opType == 'a' or opType == 'b' or opType == 'c':
        
        if rn[len(rn)-1]==",":
            rn=rn[:len(rn)-1]
        #check if next string is valid register
        if rn in REGISTERS:
            newState="regSrc1State"
            return (newState,line)
        else:
            newState="ErrorState"
            return (newState,"Expected register")
    elif opType == 'd':
        
        if rn[0]=="#":
            newState="immSrc1State"
            return (newState,line)
        else:
            newState="ErrorState"
            return (newState,"Expected immediate")

##############################################################
# Function for register source 1 state
# Encodes the register and decides next state based on
# opType
# Parameters:
#   line: string read from file.
# 
# Output:
#   NA
###############################################################
def regSrc1State(line):
    print("regSrc1State")
    global encodedLine, insCounter
    splitLine = line.split()
    src1 = splitLine[insCounter].upper() 
    insCounter+=1
    if src1[len(src1)-1]==",":
        src1=src1[:len(src1)-1]

    encodedLine = editString2(encodedLine,8,10,getRegisterEncode(src1))

    # verify to go to next state
    
    # case opType == a
    if opType == 'a':
        
        if insCounter >= len(splitLine):
            newState="ErrorState"
            return (newState,"Expected more operands")
        #src2 must be a register for opType a
        src2 = splitLine[insCounter].upper() 
        if src2 in REGISTERS:
            newState="regSrc2State"
            return (newState,line)
        else:
            newState="ErrorState"
            return (newState,"Expected register")
    
    # case opType == b
    if opType == 'b':
        # instruction should finish or have comment at the end 
        # for opType b
        if insCounter >= len(splitLine) or splitLine[insCounter][0] == COMMENT_CHAR: 
            newState="doneState"
            return (newState,line)
        else:
            newState="ErrorState"
            return (newState,"More arguments than spected for Type \"b\" operation")

    # case opType == c
    elif opType == 'c':
        if insCounter >= len(splitLine):
            newState="ErrorState"
            return (newState,line)
        # src2 must be immediate for opType c
        src2 = splitLine[insCounter].upper() 
        if src2[0]=="#":
            newState="immSrc2State"
            return (newState,line)
        else:
            newState="ErrorState"
            return (newState,"Ecpected immediate")

    else:
        newState="ErrorState"
        return (newState,"this should have never happen")


##############################################################
# Function for immediate source 1 state
# Encodes the immediate and checks if is end of instruction
# Parameters:
#   line: string read from file.
# 
# Output:
#   NA
###############################################################
def immSrc1State(line):
    print("immSrc1State")
    global encodedLine, insCounter
    splitLine = line.split()
    src1 = splitLine[insCounter].upper() 
    insCounter+=1
    
    # encoding immediate
    src1=src1[1:]
    binarySrc1 = bindigits(int(src1),8)
    encodedLine = editString2(encodedLine,8,15,binarySrc1)
    # instruction should finish or have comment at the end 
    # for opType d
    if insCounter >= len(splitLine) or splitLine[insCounter][0] == COMMENT_CHAR: 
        newState="doneState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,"More arguments than spected for Type \"d\" operation")


##############################################################
# Function for register source 2 state
# Encodes the register and checks if is end of instruction
# Parameters:
#   line: string read from file.
# 
# Output:
#   NA
###############################################################
def regSrc2State(line):
    print("regSrc2State")
    global encodedLine, insCounter
    splitLine = line.split()
    src2 = splitLine[insCounter].upper() 
    insCounter+=1

    # encoding register
    encodedLine = editString2(encodedLine,8,10,getRegisterEncode(src2))

    
    # instruction should finish or have comment at the end 
    # for opType d
    if insCounter >= len(splitLine) or splitLine[insCounter][0] == COMMENT_CHAR: 
        newState="doneState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,"More arguments than spected for Type \"d\" operation")


##############################################################
# Function for immediate source 2 state
# Encodes the immediate and checks if is end of instruction
# Parameters:
#   line: string read from file.
# 
# Output:
#   NA
###############################################################
def immSrc2State(line):
    print("immSrc2State")
    global encodedLine, insCounter
    splitLine = line.split()
    src2 = splitLine[insCounter].upper() 
    insCounter+=1
    
    # encoding immediate
    src2=src2[1:]
    binarySrc1 = bindigits(int(src2),5)
    encodedLine = editString2(encodedLine,11,15,binarySrc1)

    # instruction should finish or have comment at the end 
    # for opType c
    if insCounter >= len(splitLine) or splitLine[insCounter][0] == COMMENT_CHAR: 
        newState="doneState"
        return (newState,line)
    else:
        newState="ErrorState"
        return (newState,"More arguments than spected for Type \"c\" operation")



##############################################################
# Function to print err message on error state
# Parameters:
#   string with error messaje
# 
# Output:
#   NA
###############################################################
def ErrorState(line):
    print(line)
    sys.exit()







def main():
    global encodedLine, insCounter, lineCounter, repeatFlag 
    global repeatBuffer, writeRepeat, writeLineFlag,repetitions
    F= open("asm.txt","r")
    try:
        os.remove("instructionsOut.txt")
    except:
        pass
    F2= open("instructionsOut.txt", "a+") 
    FLines = F.readlines()
    
    #Initializing the state machine
    m = StateMachine()

    m.add_state("Start", startState)
    
    m.add_state("OperandState", OperandState)
    m.add_state("regDestState", regDestState)
    m.add_state("regSrc1State", regSrc1State)
    m.add_state("immSrc1State", immSrc1State)
    m.add_state("regSrc2State", regSrc2State)
    m.add_state("immSrc2State", immSrc2State)

    m.add_state("doneState", None,end_state=1)
    m.add_state("ErrorState", ErrorState)
    m.set_start("Start")

    print(FLines)

    lineCounter=1
    for l in FLines:
        print(lineCounter)
        if m.run(l):
            if writeLineFlag:
                F2.write(encodedLine + "\r")
                if repeatFlag:
                    repeatBuffer = repeatBuffer + encodedLine + "\r"
            if writeRepeat:
                while repetitions>0:
                    F2.write(repeatBuffer)
                    repetitions-=1
                writeRepeat = False
                repeatBuffer = ""



            encodedLine ="0000000000000000"
            insCounter = 0
            lineCounter+=1
            writeLineFlag=True
    if repeatFlag:
        print("Repeate cycle not closed")
    F.close() 


if __name__=="__main__":
    main()
