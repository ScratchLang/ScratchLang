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
                writetofile(dcd + "/project.ss1", "(backdrop [" + word + "])")
                print(RED + "Added block: " + NC + "\"(backdrop [" + word + "])\"")
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
                writetofile(dcd + "/project.ss1", "(volume)")
                print(RED + "Added block: " + NC + "\"(volume)\"")
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
                writetofile("Stage/project.ss1", "m{broadcast}=" + varname)
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
        break
    elif input3.lower() == "n":
        print("Install zenity for MSYS2, or this won't work.")
        break
    else:
        error(input3 + " is not an input.")