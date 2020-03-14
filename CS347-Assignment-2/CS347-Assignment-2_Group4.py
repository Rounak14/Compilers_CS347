import sys, re

if len(sys.argv) != 3:
	print("Error in command!! Give Command as: python main.py <input_source_code> <output_file>", file=sys.stderr)
	exit()



Watch_Word = ['else','goto','return','typedef']                 
file_ptr = open(sys.argv[1]).read()                         #read arg 1 as file name
lines = file_ptr.splitlines()
Total_lines_source_code = len(lines)                        #total lines 
output_file = open(sys.argv[2],'w')                         #write in arg 2 

# Counting the number of blank lines
blanklines_source_code = 0                                  #initiation


def write_to_file(File_Name, Text_to_write):                #write text to file File_Name
    file_ptr = open(File_Name,'w');
    file_ptr.write(Text_to_write)
    file_ptr.close()


for i in lines:
    if i.strip() == "" :
        blanklines_source_code += 1

#considering last line which is blank (not counted while splitlines() function executed)
if file_ptr.endswith("\n"):
    blanklines_source_code += 1
    Total_lines_source_code += 1
lines = [ i.replace("\\n","") for i in lines ]
file_ptr = "\n".join(lines)
file_ptr = file_ptr.replace("\\\n"," ")


def clear_comment(Text_to_check):
    def comment_utility_replace(match):
        temporary = match.group(0)
        if temporary.startswith('/*'):
            return "\n"
        elif temporary.startswith('/'):
            return " "
        else:
            return temporary
    regex = re.compile(
        r'\/\/.*?$|\/\*.*?\*\/|\'(?:\\.|[^\\\'])*\'|\"(?:\\.|[^\\\"])*\"',
        re.DOTALL | re.MULTILINE
    )

    #print(z);
    z = re.findall(regex,Text_to_check)
    #print(z)
    Count = sum([ len(i.split("\n")) for i in z if i.startswith('/')])
    #print(Count)    
    regex2 = re.compile(
        r'\*\/[^\n]*\/\/.*?$|\'(?:\\.|[^\\\'])*\'|\"(?:\\.|[^\\\"])*\"',
         re.MULTILINE
    )
    z = re.findall(regex2,Text_to_check)
    #print(z)
    Cnt = sum([ len(i.split("\n")) for i in z if i.startswith('*')])
    #print(Cnt)
    return re.sub(regex, comment_utility_replace, Text_to_check), Count - Cnt

Comments_source_code = 0
file_ptr , Comments_source_code = clear_comment(file_ptr)
# clear comments and white spaces or same no. of lines to it

#write to different file
#write_to_file("intermidiate_comment.c",file_ptr)

# clear string between single or double qoutes
file_ptr = re.sub(re.compile(r'\".*?\"',re.DOTALL|re.MULTILINE),"\" \"",file_ptr)
file_ptr = re.sub(re.compile(r'\'.\'',re.DOTALL|re.MULTILINE),"\' \'",file_ptr)

# Removing the removed code from here.
lines = [i.strip() for i in file_ptr.splitlines() if len(i.strip())>0]
file_ptr = "\n".join(lines)
#write_to_file("intermidiate_comment_string.c",file_ptr)

Variable_source_code = 0
Macro_definitions_source_code = 0
Function_declarations = 0
Function_definitions = 0

#pattern  = re.compile(r'((([a-zA-Z_][a-zA-Z_0-9]*[\ \*]+?){1,}))([\*\s]*)([a-zA-Z_][a-zA-Z0-9_]*)\s*[\[;,=)]',re.MULTILINE|re.DOTALL)
regex  = re.compile(r'\b(?:(?:auto\s*|register\s*|extern\s*|unsigned\s*|double\s*|short\s*|const\s*|volatile\s*|signed\s*|void\s*|long\s*|char\s*|float\s*|_Bool\s*|int\s*|complex\s*)+)(?:\s*\*?\*?\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*[\[;,=)]')

for i in lines:
    if re.match(r'^#[\ \t]*define',i):
        Macro_definitions_source_code += 1

for i in lines:
    if (re.match(regex,i)):
        var = 0
        for j in Watch_Word:
            if j in re.match(regex,i).group().split(" "):
                var = 1
        if var == 0:
            Variable_source_code += 1
            # print(re.match(pattern,x).group())

func_regex_def = re.compile(r'(([a-zA-Z_][a-zA-Z_0-9]*[\ \*]*?){1,}\(([^!@#$+%^;{}]*?)\)(?!\s*;))[\s]*{', re.MULTILINE|re.DOTALL)

strech = [i.span() for i  in func_regex_def.finditer(file_ptr)]
strech.sort()
strech.reverse()



def Get_line_number(File, offset):                          #get in which line offset exist in File 
    length = len(File.splitlines())
    for i in range(0,length):
        if len("\n".join(File.splitlines()[0:i+1])) >= offset:
            return i
    return 0



for i in strech:
    var1 = 0
    c_start = i[0]
    start = -1
    while(1):
        if file_ptr[c_start] == '{':
            if start == -1:
                start = c_start 
            var1 += 1
        elif file_ptr[c_start] == '}':
            var1 -= 1
        c_start+=1
        if start!= -1 and var1 == 0:
            break
    file_ptr = file_ptr[0:i[1]] + '\n'*(len(file_ptr[start:c_start].split("\n"))-1) +  "}" + file_ptr[c_start:]



#regural expression for function definition
func_regex_def = re.compile(r'(([a-zA-Z_][a-zA-Z_0-9]*[\ \*]*?){1,}\(([^!@#$+%^;\{\}]*?)\)(?!\s*;))', re.MULTILINE|re.DOTALL)
temp_arr = []
for i in func_regex_def.finditer(file_ptr):
    for j in range(Get_line_number(file_ptr,i.start()),Get_line_number(file_ptr,i.end())+1):
        temp_arr.append(j)

Function_definitions = len(set(temp_arr))


#regular expression for function declaration
func_regex_dec = re.compile(r'(([a-zA-Z_][a-zA-Z_0-9]*[\ \*]*?){1,}\(([^!@#$+%^;\{\}]*?)\)\s*?;)', re.MULTILINE| re.DOTALL)
temp_arr = []
for i in func_regex_dec.finditer(file_ptr):
    for j in range(Get_line_number(file_ptr,i.start()),Get_line_number(file_ptr,i.end())+1):
        temp_arr.append(j)

Function_declarations = len(set(temp_arr))

# Generating the output
output_file.write("1) Source code statements : " + str(Total_lines_source_code) + "\n")
output_file.write("2) Blank Lines            : " + str(blanklines_source_code) + "\n")
output_file.write("3) Comments               : " + str(Comments_source_code) + "\n")
output_file.write("4) Variable Declarations  : " + str(Variable_source_code) + "\n")
output_file.write("5) Macro Definitions      : " + str(Macro_definitions_source_code) + "\n")
output_file.write("6) Function Declarations  : " + str(Function_declarations) + "\n")
output_file.write("7) Function Definitions   : " + str(Function_definitions))
output_file.close()