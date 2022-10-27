from asyncore import write
import tty, sys, termios, os, time, subprocess
from pathlib import Path

global b
global i
def error(text):
    print(RED + "Error: " + text + NC)
def createdir(dir):
    os.system("mkdir " + dir)
def getinput():
    fd = sys.stdin.fileno()
    attr = termios.tcgetattr(fd)
    try:
        tty.setcbreak(fd)
        key = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, attr)
    return key
def writetofile(file, towrite):
    if os.path.isfile(file):
        f = open(file, 'r')
        fcontents = f.read()
        f = open(file, 'w')
        f.write(fcontents + "\n" + towrite)
    else:
        f = open(file, 'w')
        f.write(towrite)
        f.close()
while True:
    dv2dt = "0"
    def dte(arg1):
        if dv2dt == "1":
            print(arg1)
    if os.path.isfile("var/devmode"):
        dv2dt = "1"
    RED = "\033[0;31m"
    NC = "\033[0m"
    print("")
    print(RED + "Decompiler Python Version 1.0" + NC)
    dcd = "Stage"
    if dv2dt == "1":
        print("")
        print (RED + "Todo list:" + NC)
        print("Higher Priorities go first.")
        print("-------------------------------------------------------------------")
        print(RED + "* " + NC + "Add every block/fix every bug.")
        print(RED + "* " + NC + "Remake the C-Block decompilation, because I just found out that function variables exist and they could really help me.")
        print("")
        print("Order of items may change.")
        print("-------------------------------------------------------------------")
        print("")
    print("Remember, both the compiler and decompiler don't work yet. The decompiler can extract the sb3, define variables, build lists, load broadcasts, and decompile some blocks, but it can't do anything else yet.")
    print("")
    if not os.path.isfile("var/zenity"):
        print("Do you have the command zenity? [Y/N]")
        input3 = getinput()
    else:
        input3 = "y"
    print("")
    if input3.lower() == "y":
        if not os.path.isfile("var/zenity"):
            open("var/zenity", "x")
        print("Select the .sb3 you want to decompile. " + RED + "WARNING! THE NAME OF THE FILE CANNOT HAVE ANY SPACES OR IT WILL NOT UNZIP CORRECTLY!!!" + NC)
        print("")
        time.sleep(2)
        try:
            sb3file = subprocess.check_output("zenity -cygpath -file-selection -file-filter 'Scratch SB3 *.sb3'", shell=True).decode("utf-8")
            sb3file.replace('\\', "/")
        except subprocess.CalledProcessError:
            error("Empty path.")
            exit(0)
        name = input("Name of project? " + RED + "Keep in mind that it cannot be empty or it will not be created." + NC + "\n")
        print("")
        if name == "":
            error("Project name cannot be empty.")
            exit(0)
        os.chdir("..")
        if not os.path.isdir("projects"):
            createdir("projects")
        os.chdir("projects")
        if os.path.isdir(name):
            print("Project " + name + " already exists. Replace? [Y/N]")
            anss = getinput()
            if anss.lower() == "y":
                os.system("rm -rf " + name)
            else:
                exit(0)
                
            print("")
        print("Decompiling project...\n")
        time.sleep(1)
        createdir(name)
        os.chdir(name)
        with open(".maindir", 'w') as f: f.write("Please don't remove this file.")
        print("Extracting .sb3...\n")
        os.system("unzip " + sb3file)
        createdir("Stage")
        os.chdir("Stage")
        createdir("assets")
        os.chdir("..")
        file = open("project.json", 'r')
        jsonfile = file.read()
        file.close()
        i = 55
        def getchar(a1, a2):
            global char
            global b
            if not "-" + a2 == "-++":
                char=jsonfile[i]
                if "-" + char == a1:
                    b = "1"
            elif not "-" + char == a1:
                char=jsonfile[i + 1]
                if "-" + char == a1:
                    b = "1"
                char=jsonfile[i]
            else:
                char = ""
            return b
        def ip(num):
            global i
            i = i + num
        def im(num):
            global i
            i = i - num
        def nq(num):
            for k in range(num):
                global b
                b = "0"
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
        def start(a1):
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"", "")
            if not b == "1":
                if "h" + a1 == "h":
                    next = "fin"
            else:
                b = "0"
                varname = ""
                while True:
                    ip
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    varname += char
                if "h" + a1 == "h":
                    next = varname
                    dte("next: " + next)               
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"", "")
            if not b == "1":
                if "h" + a1 == "h":
                    writetofile(dcd + "project.ss1", "\\nscript")
                    print("")     
            else:
                b = "0"
                pname = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break

                    pname += char
            dte(next) 
        def start2(a1):
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"", "")
            if not b == "1":
                if "h" + a1 == "h":
                    con = "fin"
            else:
                b = "0"
                varname = ""
                while True:
                    ip
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    varname += char
                if "h" + a1 == "h":
                    con = varname
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"", "")
            if not b == "1":
                if "h" + a1 == "h":
                    writetofile(dcd + "project.ss1", "\\nscript")
                    print("")     
            else:
                b = "0"
                pname = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break

                    pname += char
            dte(con)
        cm = 0
        wew = 0
        ci = [] 
        ca = []
        nst = []
        def addop(a1):
            dte("addop " + a1)
            if a1 == "operator_equals":
                start2()
                nq(5)
                b = "0"
                o1 = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    o1 += char
                nq(3)
                b = "0"
                o2 = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    o2 += char
                addt += "<(\"" + o1 + "\") = ( \"" + o2 + "\")>"
            elif a1 == "operator_gt":
                start2()
                nq(5)
                b = "0"
                o1 = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    o1 += char
                nq(3)
                b = "0"
                o2 = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    o2 += char
                addt += "<(\"" + o1 + "\") > ( \"" + o2 + "\")>"
            elif a1 == "operator_lt":
                start2()
                nq(5)
                b = "0"
                o1 = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    o1 += char
                nq(3)
                b = "0"
                o2 = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    o2 += char
                addt += "<(\"" + o1 + "\") < ( \"" + o2 + "\")>"
            elif a1 == "operator_and":
                start2()
                nq(3)
                b = "0"
                word = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    word += char
                if word == "OPERAND2" or word == "OPERAND1":
                    b = "0"
                    vi = i
                    while True:
                        ip(1)
                        b = getchar("-]", "")
                        if b == "1":
                            break
                    im(1)
                    b = "0"
                    b = getchar("-\"", "")
                    if b == "0":
                        addt += "<<> and "
                        nq(1)
                        b = "0"
                        word = ""
                        while True:
                            ip(1)
                            b = getchar("-\"", "")
                            if b == "1":
                                break
                            word += char
                        if word == "OPERAND1" or word == "OPERAND2":
                            b = "0"
                            vi = i
                            while True:
                                ip(1)
                                b = getchar("-]", "")
                                if b == "1":
                                    break
                            im(1)
                            b = "0"
                            b = getchar("-\"", "")
                            if b == "0":
                                addt += "<>>"
                            else:
                                i = vi
                                nq(1)
                                b = "0"
                                op1 = ""
                                while True:
                                    ip(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                    op1 += char
                                wy = i
                                i = 1
                                while True:
                                    b = "0"
                                    word = ""
                                    while True:
                                        ip(1)
                                        b = getchar("-\"", "")
                                        if b == "1":
                                            break
                                        word += char
                                    if word == "opcode":
                                        b = "0"
                                        while True:
                                            im(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                        b = "0"
                                        while True:
                                            im(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                        b = "0"
                                        while True:
                                            im(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                        b = "0"
                                        word = ""
                                        while True:
                                            ip(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                            word += char
                                        if word == op1:
                                            break
                                        ip(10)
                                nq(3)
                                b = "0"
                                word = ""
                                while True:
                                    ip(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                    word += char
                                addop(word)
                                addt += ">"
                        else:
                            addt += "<>>"
                else:
                    addt += "<<> and <>>"
            elif a1 == "operator_or":
                start2()
                nq(3)
                b = "0"
                word = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    word += char
                if word == "OPERAND2" or word == "OPERAND1":
                    b = "0"
                    vi = i
                    while True:
                        ip(1)
                        b = getchar("-]", "")
                        if b == "1":
                            break
                    im(1)
                    b = "0"
                    b = getchar("-\"", "")
                    if b == "0":
                        addt += "<<> or "
                        nq(1)
                        b = "0"
                        word = ""
                        while True:
                            ip(1)
                            b = getchar("-\"", "")
                            if b == "1":
                                break
                            word += char
                        if word == "OPERAND1" or word == "OPERAND2":
                            b = "0"
                            vi = i
                            while True:
                                ip(1)
                                b = getchar("-]", "")
                                if b == "1":
                                    break
                            im(1)
                            b = "0"
                            b = getchar("-\"", "")
                            if b == "0":
                                addt += "<>>"
                            else:
                                i = vi
                                nq(1)
                                b = "0"
                                op1 = ""
                                while True:
                                    ip(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                    op1 += char
                                wy = i
                                i = 1
                                while True:
                                    b = "0"
                                    word = ""
                                    while True:
                                        ip(1)
                                        b = getchar("-\"", "")
                                        if b == "1":
                                            break
                                        word += char
                                    if word == "opcode":
                                        b = "0"
                                        while True:
                                            im(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                        b = "0"
                                        while True:
                                            im(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                        b = "0"
                                        while True:
                                            im(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                        b = "0"
                                        word = ""
                                        while True:
                                            ip(1)
                                            b = getchar("-\"", "")
                                            if b == "1":
                                                break
                                            word += char
                                        if word == op1:
                                            break
                                        ip(10)
                                nq(3)
                                b = "0"
                                word = ""
                                while True:
                                    ip(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                    word += char
                                addop(word)
                                addt += ">"
                        else:
                            addt += "<>>"
                else:
                    addt += "<<> or <>>"
            elif a1 == "operator_not":
                start2()
                nq(3)
                b = "0"
                word = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "")
                    if b == "1":
                        break
                    word += char
                if word == "OPERAND":
                    b = "0"
                    vi = i
                    while True:
                        ip(1)
                        b = getchar("-]", "")
                        if b == "1":
                            break
                    im(1)
                    b = "0"
                    b = getchar("-\"", "")
                    if b == "0":
                        addt += "<not <>>"
                    else:
                        i = vi
                        nq(1)
                        b = "0"
                        op1 = ""
                        while True:
                            ip(1)
                            b = getchar("-\"", "")
                            if b == "1":
                                break
                            op1 += char
                        wy = i
                        addt += "<not "
                        i = 1
                        while True:
                            b = "0"
                            word = ""
                            while True:
                                ip(1)
                                b = getchar("-\"", "")
                                if b == "1":
                                    break
                                word += char
                            if word == "opcode":
                                b = "0"
                                while True:
                                    im(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                b = "0"
                                while True:
                                    im(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                b = "0"
                                while True:
                                    im(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                b = "0"
                                word = ""
                                while True:
                                    ip(1)
                                    b = getchar("-\"", "")
                                    if b == "1":
                                        break
                                    word += char
                                if word == op1:
                                    break
                                ip(10)
                        nq(3)
                        b = "0"
                        word = ""
                        while True:
                            ip(1)
                            b = getchar("-\"", "")
                            if b == "1":
                                break
                            word += char
                        addop(word)
                        i = wy
                        addt += ">"
                        nq(1)
                        b = "0"
                        word = ""
                        while True:
                            ip(1)
                            b = getchar("-\"", "")
                            if b == "1":
                                break
                            word += char
                else:
                    addt += "<not <>>"
        # Implement addblock function here
        print("Defining variables...\n")
        while True:
            nq(1)
            ip(1)
            nq(1)
            b = 0
            novars = "0"
            while True:
                ip(1)
                b = getchar("-[", "")
                if b == "1":
                    break
                b = getchar("-}", "")
                if b == "1":
                    novars = "1"
                    break
            if novars == "0":
                ip(1)
                b = "0"
                varname = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "++")
                    varname += char
                    if b == "1":
                        break
                ip(2)
                b = "0"
                varvalue = ""
                while True:
                    ip(1)
                    b = getchar("-]", "++")
                    varvalue += char
                    if b == "1":
                        break
                if not os.path.isfile("Stage/project.ss1"):
                    writetofile("Stage/project.ss1", "#There should be no empty lines.\nss1\n\\prep")
                writetofile("Stage/project.ss1", varname + "=" + varvalue)
                print(RED + "Added variable: " + NC + "\"" + varname + "\".")
                print(RED + "Value: " + NC + varvalue)
                print("")
                b = "0"
                varname = ""
                ip(2)
                isub = 2
                b = getchar("-}", "")
                if b == "1":
                    break
                im(2)
            if novars == "1":
                writetofile("Stage/project.ss1", "#There should be no empty lines.\nss1\n\\prep")
                break
        print("Building lists...")
        print("")
        ip(9)
        while True:
            ip(2)
            b = "0"
            b = getchar("-}", "")
            if b == "1":
                novars = "1"
                im(2)
            else:
                im(2)
                nq(1)
                ip(1)
                nq(1)
                b = "0"
                novars = "0"
                while True:
                    ip(1)
                    b = getchar("-[", "")
                    if b == "1":
                        break
                    b = getchar("-}", "")
                    if b == "1":
                        novars = "1"
                        break
            if novars == "0":
                ip(1)
                b = "0"
                listname = ""
                while True:
                    ip(1)
                    b = getchar("-\"", "++")
                    listname += char
                    if b == "1":
                        break
                ip(4)
                b = "0"
                b = getchar("-]", "")
                if not b == "1":
                    if char == "\"":
                        b = 0
                        while True:
                            b = 0
                            varname = ""
                            while True:
                                ip(1)
                                b = getchar("-\"", "")
                                if b == "1":
                                    break
                                varname += char
                            ip(1)
                            b = 0
                            b = getchar("-]", "")
                            if not b == "1":
                                writetofile("st", varname + ",")
                                ip(1)
                            else:
                                writetofile("st", varname)
                                break
                    else:
                        im(1)
                        b = "0"
                        while True:
                            b = "0"
                            varname = ""
                            while True:
                                ip(1)
                                b = getchar("-,", "")
                                if b == "1":
                                    break
                                b = getchar("-]", "")
                                if b == "1":
                                    break
                                varname += char
                            b = "0"
                            b = getchar("-]", "")
                            if not b == "1":
                                writetofile("st", varname + ",")
                            else:
                                writetofile("st", varname)
                                break
                    f = open("st", 'r')
                    list = ""
                    for k in f:
                        list += f.readline().replace('\n', '')
                    f.close()
                    writetofile("Stage/project.ss1", listname + "=" + list)
                    print(RED + "Added list: " + NC + "\"" + listname + "\".")
                    print(RED + "Contents: " + NC + list)
                    print("")
                else:
                    writetofile("Stage/project.ss1", listname + "=,")
                    print(RED + "Added list: " + NC + "\"" + listname + "\".")
                    print(RED + "Contents: " + NC + "Nothing.")
                    print("")
                    if novars == "1":
                        break
            if novars == "1":
                break
            ip(2)
            b = "0"
            b = getchar("-}", "")
            if b == "1":
                break
        break
    elif input3.lower() == "n":
        print("Install zenity for MSYS2, or this won't work.")
        break
    else:
        error(input3 + " is not an input.")