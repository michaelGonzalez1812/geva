"Código fuente Compilador para ISA GEVA"
"Autores:                       "
"   Michael Gonzalez Rivera     "
"   Erick Cordero Rojas         "
"   Victor Montero Barboza      "
"   Jorge Aguero Zamora         "


from fsm import StateMachine
import os


#Global variables declartion
encodedLine="0000000000000000" #this is the line that contains the resulting instruction to be written to the output file
lineCounter = 1 #counts the current line being encoded
insCounter = 0 #counts the part of the instruction being analysed


##############################################################
# Generate the register number encryption
# Parameters:
#   rx: String value. Indicates the specific register
# Output:
#   String value of lenght 3 with register encodification
###############################################################
def getRegisterEncode(rx):
    return {
        'r0': '000',
        'v0': '000',
        'r1': '001',
        'v1': '001',
        'r2': '010',
        'v2': '010',
        'r3': '011',
        'v3': '011',
        'r4': '100',
        'v4': '100',
        'r5': '101',
        'v5': '101',
        'r6': '110',
        'v6': '110',
        'r7': '111',
        'v7': '111',
    }[rx]



##############################################################
# The next 2 functions are auxiliars to edit a string in the 
# middle of it.
# Parameters:
#   stri: String value to be edited
#   pos: from where to start writing
#   replace: String value to be inserted
#   posB,posE
#
# Output:
#   Modified string
###############################################################
def editString1(stri,pos,replace):
	return stri[:pos]+replace+stri[pos+1:]
def editString2(stri,posB,posE,replace):
    return stri[:posB]+replace+stri[posE+1:]







def main():
    global encodedLine, insCounter, lineCounter
    F= open("asmDraw.txt","r")
    os.remove("instructions.txt")
    F2= open("instructions.txt", "a+") 
    FLines = F.readlines()
    
    #Initializing the state machine
    m = StateMachine()
   
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

    F.close() 


if __name__=="__main__":
    main()
