import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)
from asyncore import write
import sys, os, time, subprocess, msvcrt
from pathlib import Path

def error(text):
    print(RED + "Error: " + text + NC)
def createdir(dir):
    os.mkdir(dir)
def getinput():
    return msvcrt.getch().decode("utf-8")
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
def extdata():
    b = "0"
    word = ""
    while True:
        ip()
        b = getchar("-\"")
        if b == "1":
            break
        word += char
    return word
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
    global dcd
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
            sb3file = subprocess.check_output("zenity -cygpath -file-selection -file-filter *.sb3", shell=False).decode("utf-8")
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
                subprocess.run("rm -rf " + name, shell=False)
            else:
                exit(0)
                
            print("")
        print("Decompiling project...\n")
        time.sleep(1)
        createdir(name)
        os.chdir(name)
        with open(".maindir", 'w') as f: f.write("Please don't remove this file.")
        print("Extracting .sb3...\n")
        print(sb3file)
        subprocess.run("unzip " + sb3file, shell=False)
        createdir("Stage")
        os.chdir("Stage")
        createdir("assets")
        os.chdir("..")
        file = open("project.json", 'r')
        jsonfile = file.read()
        file.close()
        global i
        i = 55
        def getchar(a1, a2=""):    
            global b
            global char
            b = ""     
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
        def ip(num=1):
            global i
            i = i + num
        def im(num=1):
            global i
            i = i - num
        def nq(num=1):
            for k in range(num):
                global b
                b = "0"
                while True:
                    ip()
                    b = getchar("-\"")
                    if b == "1":
                        break
        def start(a1=""):
            global nxt
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"")
            if not b == "1":
                if "h" + a1 == "h":
                    nxt = "fin"
            else:
                b = "0"
                varname = ""
                while True:
                    ip()
                    b = getchar("-\"")
                    if b == "1":
                        break
                    varname += char
                if "h" + a1 == "h":
                    nxt = varname
                    dte("next: " + nxt + ", " + varname)               
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"")
            if not b == "1":
                if a1 == "":
                    writetofile(dcd + "/project.ss1", "\\nscript")
                    print("")     
            else:
                b = "0"
                pname = ""
                while True:
                    ip()
                    b = getchar("-\"")
                    if b == "1":
                        break

                    pname += char
            dte(nxt) 
        def start2(a1=""):
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"")
            if not b == "1":
                if "h" + a1 == "h":
                    con = "fin"
            else:
                b = "0"
                varname = ""
                while True:
                    ip()
                    b = getchar("-\"")
                    if b == "1":
                        break
                    varname += char
                if "h" + a1 == "h":
                    con = varname
            nq(2)
            ip(2)
            b = "0"
            b = getchar("-\"")
            if not b == "1":
                if "h" + a1 == "h":
                    writetofile(dcd + "project.ss1", "\\nscript")
                    print("")     
            else:
                b = "0"
                pname = ""
                while True:
                    ip()
                    b = getchar("-\"")
                    if b == "1":
                        break

                    pname += char
            dte(con)
        def addblock(a1):
            global i
            global nxt
            global con
            try:
                con
            except NameError:
                con = ""
            cnext = ""
            start()
            if a1 == "looks_switchbackdropto":
                nq(5)
                word = extdata()
                i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                nq(18)
                word = extdata()
                writetofile(dcd + "/project.ss1", "switch backdrop to (\"" + word + "\")")
                print(RED + "Added block: " + NC + "\"switch backdrop to (\"" + word + "\")\"")
            elif a1 == "looks_switchbackdroptoandwait":
                nq(5)
                word = extdata()
                i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                nq(18)
                word = extdata()
                writetofile(dcd + "/project.ss1", "switch backdrop to (\"" + word + "\") and wait")
                print(RED + "Added block: " + NC + "\"switch backdrop to (\"" + word + "\") and wait\"")
            elif a1 == "looks_nextbackdrop":
                writetofile(dcd + "/project.ss1", "next backdrop")
                print(RED + "Added block: " + NC + "\"next backdrop\"")
            elif a1 == "looks_changeeffectby":
                nq(5)
                word = extdata()
                if not word == "fields":
                    amt = word
                    nq(2)
                else:
                    amt = ""
                nq(3)
                word = extdata()
                word = word.lower()
                writetofile(dcd + "/project.ss1", "change [" + word + "] effect by (\"" + amt + "\") # looks")
                print(RED + "Added block: " + NC + "\"change [" + word + "] effect by (\"" + amt + "\")\"")
            elif a1 == "looks_seteffectto":
                nq(5)
                word = extdata()
                if not word == "fields":
                    amt = word
                    nq(2)
                else:
                    amt = ""
                nq(3)
                word = extdata()
                word = word.lower()
                writetofile(dcd + "/project.ss1", "set [" + word + "] effect to (\"" + amt + "\") # looks")
                print(RED + "Added block: " + NC + "\"set [" + word + "] effect to (\"" + amt + "\")\"")
            elif a1 == "looks_cleargraphiceffects":
                writetofile(dcd + "/project.ss1", "clear graphic effects")
                print(RED + "Added block: " + NC + "\"clear graphic effects\"")
            elif a1 == "looks_backdropnumbername":
                nq(7)
                word = extdata()
                con += "(backdrop [" + word + "])"
            elif a1 == "sound_playuntildone":
                nq(5)
                word = extdata()
                i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                nq(18)
                word = extdata()
                writetofile(dcd + "/project.ss1", "play sound (\"" + word + "\") until done")
                print(RED + "Added block: " + NC + "\"play sound (\"" + word + "\") until done\"")
            elif a1 == "sound_play":
                nq(5)
                word = extdata()
                i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                nq(18)
                word = extdata()
                writetofile(dcd + "/project.ss1", "start sound (\"" + word + "\")")
                print(RED + "Added block: " + NC + "\"start sound (\"" + word + "\")\"")
            elif a1 == "sound_stopallsounds":
                writetofile(dcd + "/project.ss1", "stop all sounds")
                print(RED + "Added block: " + NC + "\"stop all sounds\"")
            elif a1 == "sound_changeeffectby":
                nq(5)
                word = extdata()
                if not word == "fields":
                    amt = word
                    nq(2)
                else:
                    amt = ""
                nq(3)
                word = extdata()
                word = word.lower()
                writetofile(dcd + "/project.ss1", "change [" + word + "] effect by (\"" + amt + "\") # sound")
                print(RED + "Added block: " + NC + "\"change [" + word + "] effect by (\"" + amt + "\")\"")
            elif a1 == "sound_seteffectto":
                nq(5)
                word = extdata()
                if not word == "fields":
                    amt = word
                    nq(2)
                else:
                    amt = ""
                nq(3)
                word = extdata()
                word = word.lower()
                writetofile(dcd + "/project.ss1", "set [" + word + "] effect to (\"" + amt + "\") # sound")
                print(RED + "Added block: " + NC + "\"set [" + word + "] effect to (\"" + amt + "\")\"")
            elif a1 == "sound_cleareffects":
                writetofile(dcd + "/project.ss1", "clear sound effects")
                print(RED + "Added block: " + NC + "\"clear sound effects\"")
            elif a1 == "sound_changevolumeby":
                nq(5)
                word = extdata()
                if word == "fields":
                    word = ""
                writetofile(dcd + "/project.ss1", "change volume by (\"" + word + "\")")
                print(RED + "Added block: " + NC + "\"change volume by (\"" + word + "\")\"")
            elif a1 == "sound_setvolumeto":
                nq(5)
                word = extdata()
                if word == "fields":
                    word = ""
                writetofile(dcd + "/project.ss1", "set volume to (\"" + word + "\") %")
                print(RED + "Added block: " + NC + "\"set volume to (\"" + word + "\") %\"")
            elif a1 == "sound_volume":
                con += "(volume)"
            elif a1 == "event_whenflagclicked":
                writetofile(dcd + "/project.ss1", "when flag clicked")
                print(RED + "Added block: " + NC + "\"when flag clicked\"")
            elif a1 == "event_whenkeypressed":
                nq(7)
                word = extdata()
                writetofile(dcd + "/project.ss1", "when [" + word + "] key pressed")
                print(RED + "Added block: " + NC + "\"when [" + word + "] key pressed\"")
            elif a1 == "event_whenstageclicked":
                writetofile(dcd + "/project.ss1", "when flag clicked")
                print(RED + "Added block: " + NC + "\"when flag clicked\"")
            elif a1 == "event_whenbackdropswitchesto":
                nq(7)
                word = extdata()
                writetofile(dcd + "/project.ss1", "when backdrop switches to [" + word + "]")
                print(RED + "Added block: " + NC + "\"when backdrop switches to [" + word + "]\"")
            elif a1 == "event_whengreaterthan":
                nq(5)
                word = extdata()
                if word == "fields":
                    word = ""
                else:
                    nq(2)
                amt = word
                nq(3)
                word = extdata()
                word = word.lower()
                writetofile(dcd + "/project.ss1", "when [" + word + "] > (\"" + amt + "\")")
                print(RED + "Added block: " + NC + "\"when [" + word + "] > (\"" + amt + "\")\"")
            elif a1 == "event_whenbroadcastreceived":
                nq(7)
                word = extdata()
                writetofile(dcd + "/project.ss1", "when I receive [" + word + "]")
                print(RED + "Added block: " + NC + "\"when I receive [" + word + "]\"")
            elif a1 == "event_broadcast":
                nq(5)
                word = extdata()
                writetofile(dcd + "/project.ss1", "broadcast [" + word + "]")
                print(RED + "Added block: " + NC + "\"broadcast [" + word + "]\"")
            elif a1 == "event_broadcastandwait":
                nq(5)
                word = extdata()
                writetofile(dcd + "/project.ss1", "broadcast [" + word + "] and wait")
                print(RED + "Added block: " + NC + "\"broadcast [" + word + "] and wait\"")
            elif a1 == "control_wait":
                nq(5)
                word = extdata()
                if word == "fields":
                    word = ""
                writetofile(dcd + "/project.ss1", "wait (\"" + word + "\") seconds")
                print(RED + "Added block: " + NC + "\"wait (\"" + word + "\") seconds\"")
            elif a1 == "control_repeat":
                cnext = nxt
                nq(5)
                word = extdata()
                if word == "SUBSTACK":
                    word = ""
                    writetofile(dcd + "/project.ss1", "repeat (" + word + ") {")
                    print(RED + "Starting repeat |" + NC + " repeat (" + word + ") {")
                else:
                    nq()
                    writetofile(dcd + "/project.ss1", "repeat (" + word + ") {")
                    print(RED + "Starting repeat |" + NC + " repeat (" + word + ") {")
                    word = extdata()
                if not word == "SUBSTACK":
                    writetofile(dcd + "/project.ss1", "}")
                    print("")
                    print(RED + "Ended repeat |" + NC + " }")
                else:
                    nq()
                    word = extdata()
                    if not word == "fields":
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        writetofile(dcd + "/project.ss1", "}")
                        print(RED + "Ended repeat |" + NC + " }")
                    else:
                        writetofile(dcd + "/project.ss1", "}")
                        print(RED + "Ended repeat |" + NC + " }")
                    nxt = cnext
            elif a1 == "control_forever":
                cnext = nxt
                nq(3)
                word = extdata()
                if word == "SUBSTACK":
                    nq()
                    word = extdata()
                    if word == "fields":
                        word = ""
                else:
                    word = ""
                writetofile(dcd + "/project.ss1", "forever {")
                print(RED + "Starting forever |" + NC + " forever {")
                if not word == "":
                    i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                    nq(4)
                    word = extdata()
                    addblock(word)
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended forever |" + NC + " }")
                else:
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended forever |" + NC + " }")
                nxt = cnext
            elif a1 == "control_if":
                con = ""
                cnext = nxt
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "CONDITION" or word == "fields":
                        break
                if word == "CONDITION":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        writetofile(dcd + "/project.ss1", "if " + con + " {")
                        print(RED + "Starting if |" + NC + " if " + con + " {")
                    else:
                        writetofile(dcd + "/project.ss1", "if <> {")
                        print(RED + "Starting if |" + NC + " if <> {")
                else:
                    writetofile(dcd + "/project.ss1", "if <> {")
                    print(RED + "Starting if |" + NC + " if <> {")
                i = j
                while True:
                    word = extdata()
                    if word == "SUBSTACK" or word == "fields":
                        break
                if word == "SUBSTACK":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended if |" + NC + " }")
                else:
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended if |" + NC + " }")
                nxt = cnext
            elif a1 == "control_if_else":
                con = ""
                cnext = nxt
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "CONDITION" or word == "fields":
                        break
                if word == "CONDITION":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        writetofile(dcd + "/project.ss1", "if " + con + " {")
                        print(RED + "Starting if/else |" + NC + " if " + con + " {")
                    else:
                        writetofile(dcd + "/project.ss1", "if <> {")
                        print(RED + "Starting if\else |" + NC + " if <> {")
                else:
                    writetofile(dcd + "/project.ss1", "if <> {")
                    print(RED + "Starting if/else |" + NC + " if <> {")
                i = j
                while True:
                    word = extdata()
                    if word == "SUBSTACK" or word == "fields":
                        break
                if word == "SUBSTACK":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                    writetofile(dcd + "/project.ss1", "} else {")
                    print(RED + "else |" + NC + " } else {")
                else:
                    writetofile(dcd + "/project.ss1", "} else {")
                    print(RED + "else |" + NC + " } else {")
                i = j
                while True:
                    word = extdata()
                    if word == "SUBSTACK2" or word == "fields":
                        break
                if word == "SUBSTACK2":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended if/else |" + NC + " }")
                else:
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended if/else |" + NC + " }")
                nxt = cnext
            elif a1 == "control_wait_until":
                con = ""
                cnext = nxt
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "CONDITION" or word == "fields":
                        break
                if word == "CONDITION":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        writetofile(dcd + "/project.ss1", "wait until " + con)
                        print(RED + "Added block: " + NC + "\"wait until " + con + "\"")
                    else:
                        writetofile(dcd + "/project.ss1", "wait until <>")
                        print(RED + "Added block: " + NC + "\"wait until <>")
                else:
                    writetofile(dcd + "/project.ss1", "if <> {")
                    print(RED + "Starting if |" + NC + " if <> {")
                i = j
            elif a1 == "control_repeat_until":
                con = ""
                cnext = nxt
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "CONDITION" or word == "fields":
                        break
                if word == "CONDITION":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        writetofile(dcd + "/project.ss1", "repeat until " + con + " {")
                        print(RED + "Starting repeat until |" + NC + " repeat until " + con + " {")
                    else:
                        writetofile(dcd + "/project.ss1", "repeat until <> {")
                        print(RED + "Starting repeat until |" + NC + " repeat until <> {")
                else:
                    writetofile(dcd + "/project.ss1", "repeat until <> {")
                    print(RED + "Starting repeat until |" + NC + " repeat until <> {")
                i = j
                while True:
                    word = extdata()
                    if word == "SUBSTACK" or word == "fields":
                        break
                if word == "SUBSTACK":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended repeat until |" + NC + " }")
                else:
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended repeat until |" + NC + " }")
                nxt = cnext
            elif a1 == "control_while":
                con = ""
                cnext = nxt
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "CONDITION" or word == "fields":
                        break
                if word == "CONDITION":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        writetofile(dcd + "/project.ss1", "while " + con + " {")
                        print(RED + "Starting while |" + NC + " while " + con + " {")
                    else:
                        writetofile(dcd + "/project.ss1", "while <> {")
                        print(RED + "while |" + NC + " while <> {")
                else:
                    writetofile(dcd + "/project.ss1", "while <> {")
                    print(RED + "Starting while |" + NC + " while <> {")
                i = j
                while True:
                    word = extdata()
                    if word == "SUBSTACK" or word == "fields":
                        break
                if word == "SUBSTACK":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended while |" + NC + " }")
                else:
                    writetofile(dcd + "/project.ss1", "}")
                    print(RED + "Ended while |" + NC + " }")
                nxt = cnext
            elif a1 == "control_create_clone_of":
                nq(5)
                word = extdata()
                i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                nq(18)
                word = extdata()
                writetofile(dcd + "/project.ss1", "create a clone of (\"" + word + "\")")
                print(RED + "Added block: " + NC + "\"create a clone of (\"" + word + "\")\"")
            elif a1 == "sensing_askandwait":
                nq(5)
                word = extdata()
                writetofile(dcd + "/project.ss1", "ask (\"" + word + "\") and wait")
                print(RED + "Added block: " + NC + "\"ask (\"" + word + "\") and wait\"")
            elif a1 == "sensing_answer":
                con += "(anwser)"
            elif a1 == "sensing_keypressed":
                nq(5)
                word = extdata()
                i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                nq(18)
                word = extdata()
                con += "<key (\"" + word + "\") pressed?>"
            elif a1 == "sensing_mousedown":
                con += "<mouse down?>"
            elif a1 == "sensing_mousex":
                con += "(mouse x)"
            elif a1 == "sensing_mousey":
                con += "(mouse y)"
            elif a1 == "sensing_loudness":
                con += "(loudness)"
            elif a1 == "sensing_timer":
                con += "(timer)"
            elif a1 == "sensing_resettimer":
                writetofile(dcd + "/project.ss1", "reset timer")
                print(RED + "Added block: " + NC + "\"reset timer\"")
            elif a1 == "sensing_of":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "PROPERTY" or word == "shadow":
                        break
                if word == "PROPERTY":
                    nq()
                    word = extdata()
                    sofprop = word
                else:
                    sofprop = ""
                i = j
                while True:
                    word = extdata()
                    if word == "OBJECT" or word == "shadow":
                        break
                if word == "OBJECT":
                    nq()
                    word = extdata()
                    i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                    nq(18)
                    word = extdata()
                    if word == "_stage_":
                        word = "Stage"
                else:
                    word = ""
                con += "([" + sofprop + "] of (\"" + word + "\")"
            elif a1 == "sensing_current":
                nq(7)
                word = extdata()
                word = word.lower()
                con += "(current [" + word + "])"
            elif a1 == "sensing_dayssince2000":
                con += "(days since 2000)"
            elif a1 == "sensing_username":
                con += "(username)"
            elif a1 == "operator_add":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "NUM1" or word == "fields":
                        break
                if word == "NUM1":
                    nq()
                    op1 = extdata()
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "NUM2" or word == "fields":
                        break
                if word == "NUM2":
                    nq()
                    op2 = extdata()
                else:
                    op2 = ""
                con += "((\"" + op1 + "\") + (\"" + op2 + "\"))"
            elif a1 == "operator_subtract":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "NUM1" or word == "fields":
                        break
                if word == "NUM1":
                    nq()
                    op1 = extdata()
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "NUM2" or word == "fields":
                        break
                if word == "NUM2":
                    nq()
                    op2 = extdata()
                else:
                    op2 = ""
                con += "((\"" + op1 + "\") - (\"" + op2 + "\"))"
            elif a1 == "operator_multiply":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "NUM1" or word == "fields":
                        break
                if word == "NUM1":
                    nq()
                    op1 = extdata()
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "NUM2" or word == "fields":
                        break
                if word == "NUM2":
                    nq()
                    op2 = extdata()
                else:
                    op2 = ""
                con += "((\"" + op1 + "\") * (\"" + op2 + "\"))"
            elif a1 == "operator_divide":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "NUM1" or word == "fields":
                        break
                if word == "NUM1":
                    nq()
                    op1 = extdata()
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "NUM2" or word == "fields":
                        break
                if word == "NUM2":
                    nq()
                    op2 = extdata()
                else:
                    op2 = ""
                con += "((\"" + op1 + "\") / (\"" + op2 + "\"))"
            elif a1 == "operator_random":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "FROM" or word == "fields":
                        break
                if word == "FROM":
                    nq()
                    op1 = extdata()
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "TO" or word == "fields":
                        break
                if word == "TO":
                    nq()
                    op2 = extdata()
                else:
                    op2 = ""
                con += "(pick random (\"" + op1 + "\") to (\"" + op2 + "\"))"
            elif a1 == "operator_equals":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "OPERAND1" or word == "fields":
                        break
                if word == "OPERAND1":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-,")
                        if b == "1":
                            break
                    ip()
                    b = "0"
                    b = getchar("-\"")
                    if b == "1":
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        con += "<"
                        addblock(word)
                        con += " = "
                    else:
                        b = "0"
                        while True:
                            ip()
                            b = getchar("-]")
                            if b == "1":
                                break
                        im()
                        b = 0
                        b = getchar("-\"")
                        if b == "1":
                            i = k
                            nq()
                            op1 = extdata()
                        else:
                            op1 = ""
                        con += "<(\"" + op1 + "\") = (\""
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "OPERAND2" or word == "fields":
                        break
                if word == "OPERAND2":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-,")
                        if b == "1":
                            break
                    ip()
                    b = "0"
                    b = getchar("-\"")
                    if b == "1":
                        word = extdata()
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        con += ">"
                    else:
                        b = "0"
                        while True:
                            ip()
                            b = getchar("-]")
                            if b == "1":
                                break
                        im()
                        b = 0
                        b = getchar("-\"")
                        if b == "1":
                            i = k
                            nq()
                            op2 = extdata()
                        else:
                            op2 = ""
                        con += op2 + "\")>"
                else:
                    op2 = ""
                    con += op2 + "\")>"
            elif a1 == "operator_gt":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "OPERAND1" or word == "fields":
                        break
                if word == "OPERAND1":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        op1 = extdata()
                    else:
                        op1 = ""
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "OPERAND2" or word == "fields":
                        break
                if word == "OPERAND2":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        op2 = extdata()
                    else:
                        op2 = ""
                else:
                    op2 = ""
                con += "<(\"" + op1 + "\") > (\"" + op2 + "\")>"
            elif a1 == "operator_lt":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "OPERAND1" or word == "fields":
                        break
                if word == "OPERAND1":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        op1 = extdata()
                    else:
                        op1 = ""
                else:
                    op1 = ""
                i = j
                while True:
                    word = extdata()
                    if word == "OPERAND2" or word == "fields":
                        break
                if word == "OPERAND2":
                    k = i
                    b = "0"
                    while True:
                        ip()
                        b = getchar("-]")
                        if b == "1":
                            break
                    im()
                    b = 0
                    b = getchar("-\"")
                    if b == "1":
                        i = k
                        nq()
                        op2 = extdata()
                    else:
                        op2 = ""
                else:
                    op2 = ""
                con += "<(\"" + op1 + "\") < (\"" + op2 + "\")>"
            elif a1 == "operator_and":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "OPERAND1" or word == "fields":
                        break
                if word == "OPERAND1":
                    nq()
                    word = extdata()
                    if not word == "fields" and not word == "OPERAND2":
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        con += "<"
                        nq(4)
                        word = extdata()
                        addblock(word)
                        con += " and "
                    else:
                        con += "<<> and "
                else:
                    con += "<<> and "
                i = j
                while True:
                    word = extdata()
                    if word == "OPERAND2" or word == "fields":
                        break
                if word == "OPERAND2":
                    nq()
                    word = extdata()
                    if not word == "fields" and not word == "OPERAND1":
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        con += ">"
                    else:
                        con += "<>>"
                else:
                    con += "<>>"
            elif a1 == "operator_or":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "OPERAND1" or word == "fields":
                        break
                if word == "OPERAND1":
                    nq()
                    word = extdata()
                    if not word == "fields" and not word == "OPERAND2":
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        con += "<"
                        nq(4)
                        word = extdata()
                        addblock(word)
                        con += " or "
                    else:
                        con += "<<> or "
                else:
                    con += "<<> or "
                i = j
                while True:
                    word = extdata()
                    if word == "OPERAND2" or word == "fields":
                        break
                if word == "OPERAND2":
                    nq()
                    word = extdata()
                    if not word == "fields" and not word == "OPERAND1":
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        nq(4)
                        word = extdata()
                        addblock(word)
                        con += ">"
                    else:
                        con += "<>>"
                else:
                    con += "<>>"
            elif a1 == "operator_not":
                nq(2)
                j = i
                while True:
                    word = extdata()
                    if word == "OPERAND" or word == "fields":
                        break
                if word == "OPERAND":
                    nq()
                    word = extdata()
                    if not word == "fields":
                        i = jsonfile.find("\"" + word + "\":{\"opcode\":")
                        con += "<not "
                        nq(4)
                        word = extdata()
                        addblock(word)
                        con += ">"
                    else:
                        con += "<not <>>"
                else:
                        con += "<not <>>"
            else:
                print(RED + "Unknown block: \"" + a1 + "\" Skipping." + NC)
                writetofile(dcd + "/project.ss1", "DECOMPERR: Unknown block:  \"" + a1 + "\"")
            if not nxt == "fin":
                i = jsonfile.find("\"" + nxt + "\":{\"opcode\":")
                nq(4)
                word = extdata()
                addblock(word)
        print("Defining variables...\n")
        while True:
            nq()
            ip()
            nq()
            b = 0
            novars = "0"
            while True:
                ip()
                b = getchar("-[")
                if b == "1":
                    break
                b = getchar("-}")
                if b == "1":
                    novars = "1"
                    break
            if novars == "0":
                ip()
                b = "0"
                varname = ""
                while True:
                    ip()
                    b = getchar("-\"", "++")
                    varname += char
                    if b == "1":
                        break
                ip(2)
                b = "0"
                varvalue = ""
                while True:
                    ip()
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
                b = getchar("-}")
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
            b = getchar("-}")
            if b == "1":
                novars = "1"
                im(2)
            else:
                im(2)
                nq()
                ip()
                nq()
                b = "0"
                novars = "0"
                while True:
                    ip()
                    b = getchar("-[")
                    if b == "1":
                        break
                    b = getchar("-}")
                    if b == "1":
                        novars = "1"
                        break
            if novars == "0":
                ip()
                b = "0"
                listname = ""
                while True:
                    ip()
                    b = getchar("-\"", "++")
                    listname += char
                    if b == "1":
                        break
                ip(4)
                b = "0"
                b = getchar("-]")
                if not b == "1":
                    if char == "\"":
                        b = 0
                        while True:
                            b = 0
                            varname = ""
                            while True:
                                ip()
                                b = getchar("-\"")
                                if b == "1":
                                    break
                                varname += char
                            ip()
                            b = 0
                            b = getchar("-]")
                            if not b == "1":
                                writetofile("st", varname + ",")
                                ip()
                            else:
                                writetofile("st", varname)
                                break
                    else:
                        im()
                        b = "0"
                        while True:
                            b = "0"
                            varname = ""
                            while True:
                                ip()
                                b = getchar("-,")
                                if b == "1":
                                    break
                                b = getchar("-]")
                                if b == "1":
                                    break
                                varname += char
                            b = "0"
                            b = getchar("-]")
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
            b = getchar("-}")
            if b == "1":
                break
        print("Loading broadcasts...")
        print("")
        while True:
            b = "0"
            word = ""
            while True:
                ip()
                b = getchar("-\"")
                if b == "1":
                    break
                word += char
            if word == "broadcasts":
                break
        b = "0"
        novars = "0"
        ip(3)
        b = "0"
        b = getchar("-}")
        if b == "1":
            novars = "1"
            im(2)
        else:
            im(2)
            while True:
                ip()
                b = getchar("-\"")
                if b == "1":
                    break
                b = getchar("-}")
                if b == "1":
                    novars = "1"
                    break
            nq()
        if novars == "0":
            while True:
                ip()
                nq()
                b = "0"
                varname = ""
                while True:
                    ip()
                    b = getchar("-\"")
                    if b == "1":
                        break
                    varname += char
                writetofile("Stage/project.ss1", "{broadcast}=" + varname)
                print(RED + "Loaded broadcast: " + NC + "\"" + varname + "\"")
                print("")
                ip()
                b = "0"
                b = getchar("-}")
                if b == "1":
                    break
                ip(2)
                nq()
        global rep
        rep = 0
        print("Making blocks...")
        print("")
        dcd = "Stage"
        k = -1
        done = "0"
        while True:
            i = k
            while True:
                word = extdata()
                if word == "parent":
                    k = i
                    ip(2)
                    b = "0"
                    b = getchar("-\"")
                    if not b == "1":
                        break
                if word == "comments":
                    done = "1"
                    break
            if done == "0":
                b = "0"
                while True:
                    im()
                    b = getchar("-{")
                    if b == "1":
                        break
                ip()
                nq(2)
                word = extdata()
                addblock(word)
            if done == "1":
                break
        print("\nFormatting code to make it easier to read (Please wait)...")
        f = open(dcd + "/project.ss1", "r")
        spaces = ""
        i = 0
        for line in f.readlines():
            line = line.strip("\n")
            if "}" in line and "{" in line:
                i = i - 1
                spaces = i*"  "
                i = i + 1
            elif "{" in line:
                spaces = i*"  "
                i = i + 1
            elif "}" in line:
                i = i - 1
                spaces = i*"  "
            else:
                spaces = i*"  "
            writetofile(dcd + "/a.txt", spaces + line)
        f.close()
        os.remove(dcd + "/project.ss1")
        os.rename(dcd + "/a.txt", dcd + "/project.ss1")
        os.chdir("..")
        dir = os.getcwd()
        print("")
        print(RED + "Your project can be found in " + dir + "/" + name + "." + NC)
        break
    elif input3.lower() == "n":
        print("Install zenity for MSYS2, or this won't work.")
        break
    else:
        error(input3 + " is not an input.")