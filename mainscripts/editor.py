import os
import shutil
import subprocess
import sys
import threading
from time import sleep
from tkinter import filedialog as fd

import pynput

global parenth
global synbuild
global syntype
global e_lines_w_syn
inEditor = True
key = ""
cursor_blink = 0

RED = "\033[0;31m"
NC = "\033[0m"
P = "\033[0;35m"

if not os.path.dirname(sys.argv[0]) == "":
    os.chdir(os.path.dirname(sys.argv[0]))
cwd = os.getcwd().replace("\\", "/")


def increment():
    global cursor_blink
    cursor_blink = 1
    while inEditor:
        cursor_blink = 0
        sleep(0.5)
        cursor_blink = 1
        sleep(0.5)
        if key == "save":
            exit()
    exit()


def error(text):
    print(RED + "Error: " + text + NC)


b = ""

print("")
print("Select your project folder.")
print("")
fold = ""
try:
    if not sys.argv[1] is None:
        fold = sys.argv[1].replace("\\", "/")
except IndexError:
    sleep(2)
    fold = fd.askdirectory(title="Choose a project.", initialdir="../projects")
    fold = fold.replace("\\", "/")
if not os.path.isfile(fold + "/.maindir"):
    error(
        "Not a ScratchScript project ("
        + fold
        + "), or .maindir file was deleted."
    )
    exit()
os.chdir(fold + "/Stage")
editor_lines = []
print("Loading " + fold + "...")
print("")
f = open("project.ss1", "r")
flen = len(f.readlines())
f.close()
f = open("project.ss1", "r")
proglen = 55
q = 0
for line in f.readlines():
    q += 1
    per = q / flen
    print(
        "\033[A["
        + round(proglen * per) * "#"
        + (proglen - round(proglen * per)) * " "
        + "] "
        + str(round(per * 100))
        + "%"
    )
    line = line.strip("\n")
    editor_lines += [line + " "]
f.close()
print("")
print("Loading settings...")
print("")
f = open(cwd + "/var/editor_settings", "r")
tabsize = 2
shigh = True
pflen = flen
flen = len(f.readlines())
f.close()
f = open(cwd + "/var/editor_settings", "r")
proglen = 55
q = 0
for line in f.readlines():
    q += 1
    per = q / flen
    print(
        "\033[A["
        + round(proglen * per) * "#"
        + (proglen - round(proglen * per)) * " "
        + "] "
        + str(round(per * 100))
        + "%"
    )
    if "tabsize" in line:
        tabsize = int(line.replace("tabsize: ", ""))
    elif "syntax_highlighting" in line:
        shigh = line.replace("syntax_highlighting: ", "")
    elif "show_cwd" in line:
        es = line.replace("show_cwd: ", "")
        if es == "True":
            show_cwd = True
        elif es == "False":
            show_cwd = False
        else:
            show_cwd = True
f.close()
flen = pflen
print("")
print("Building syntax highlighting...")
print("")
q = 0
# Stuff used for syntax highlighting.
colors = {
    "c": "\033[0m",
    "p": "\033[48;5;10m",
    "n": "\033[48;5;10m",
    "0": "\033[37m",
    "1": "\033[35m",
    "2": "\033[38;5;202m",
    "3": "\033[38;5;160m",
    "4": "\033[38;5;220m",
    "5": "\033[38;5;200m",
    "6": "\033[38;5;172m",
    "7": "\033[96m",
    "8": "\033[38;5;34m",
}
bgs = {
    "c": "",
    "p": "\033[1;90m",
    "n": "\033[1;90m",
    "0": "",
    "1": "",
    "2": "",
    "3": "",
    "4": "",
    "5": "",
    "6": "",
    "7": "",
    "8": "",
}
pthesis = {
    "0": "",
    "1": "\033[31m",
    "2": "\033[38;5;202m",
    "3": "\033[33m",
    "4": "\033[32m",
    "5": "\033[34m",
    "6": "\033[38;5;135m",
    "7": "\033[35m",
    "8": "\033[38;5;206m",
}
looks = [
    "switch backdrop to (",
    "next backdrop",
    "change [c",
    "change [f",
    "change [w",
    "change [pix",
    "change [m",
    "change [b",
    "change [g",
    "clear graphic effects",
    "(backdrop [",
    "set [c",
    "set [f",
    "set [w",
    "set [pix",
    "set [m",
    "set [b",
    "set [g",
]
looksFindType = [
    "le",
    "eq",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "eq",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
]
datavar = [
    "var:",
    "] to (",
    "] by (",
    "show variable [",
    "hide variable [",
]
datavarFindType = [
    "le",
    "in",
    "in",
    "le",
    "le",
]
datalist = [
    "list:",
    ") to [",
    ") by [",
    "delete all of [",
    "delete (",
    "insert (",
    "replace item (",
    "(item (",
    "(item # of (",
    "(length of [",
    "] contains (",
    "show list [",
    "hide list [",
]
datalistFindType = [
    "le",
    "in",
    "in",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "in",
    "le",
    "le",
]
events = [
    "broadcast [",
    "broadcast:",
    "when I receive [",
    "when [",
    "when flag clicked",
    "when backdrop switches to [",
]
eventsFindType = ["le", "le", "le", "le", "eq", "le"]
sounds = [
    "play sound (",
    "start sound (",
    "change [pit",
    "change [pan",
    "set [pit",
    "set [pan",
    "stop all sounds",
    "(volume)",
    "clear sound effects",
    "change volume by (",
    "set volume to (",
]
soundsFindType = [
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "eq",
    "eq",
    "eq",
    "le",
    "le",
]
control = [
    "wait (",
    "wait until <",
    "repeat (",
    "repeat until <",
    "forever {",
    "if <",
    "} else {",
    "while <",
    "create a clone of (",
]
controlFindType = [
    "le",
    "le",
    "le",
    "le",
    "le",
    "le",
    "eq",
    "le",
    "le",
]
sensing = [
    "ask (",
    "(answer)",
    "<key (",
    "<mouse down?>",
    "(mouse x)",
    "(mouse y)",
    "(loudness)",
    "(timer)",
    "reset timer",
    "([",
    "(current [",
    "(days since 2000)",
    "(username)",
]
sensingFindType = [
    "le",
    "eq",
    "le",
    "eq",
    "eq",
    "eq",
    "eq",
    "eq",
    "eq",
    "le",
    "le",
    "eq",
    "eq",
]
operators = [
    ") + (",
    ") - (",
    ") / (",
    ") * (",
    ") > (",
    ") < (",
    "(pick random (",
    ") = (",
    "> and <",
    "> or <",
    "<not <",
    "(join (",
    "(letter (",
    "(length of (",
    ") contains (",
    ") mod (",
    "(round (",
]
operatorsFindType = [
    "in",
    "in",
    "in",
    "in",
    "in",
    "in",
    "le",
    "in",
    "in",
    "in",
    "le",
    "le",
    "le",
    "le",
    "in",
    "in",
    "le",
]
pth = ["(", "[", "{", "<"]
pthends = [")", "]", "}", ">"]
excludes = ["46;1", "38;5;8", "0", "37", "35", "7", "1"]
bracks = 0
shabang = [
    "//!looks",
    "//!var",
    "//!list",
    "//!events",
    "//!sound",
    "//!control",
    "//!sensing",
    "//!operators",
]


def determine_type(lin):
    global syntype
    syntype = "0"
    sbi = 0
    q = -1
    for i in operators:
        q += 1
        if operatorsFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "8"
        elif operatorsFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "8"
        elif operatorsFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "8"
    q = -1
    for i in looks:
        q += 1
        if looksFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "1"
        elif looksFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "1"
        elif looksFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "1"
    q = -1
    for i in datavar:
        q += 1
        if datavarFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "2"
        elif datavarFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "2"
        elif datavarFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "2"
    q = -1
    for i in datalist:
        q += 1
        if datalistFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "3"
        elif datalistFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "3"
        elif datalistFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "3"
    q = -1
    for i in events:
        q += 1
        if eventsFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "4"
        elif eventsFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "4"
        elif eventsFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "4"
    q = -1
    for i in sounds:
        q += 1
        if soundsFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "5"
        elif soundsFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "5"
        elif soundsFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "5"
    q = -1
    for i in sensing:
        q += 1
        if sensingFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "7"
        elif sensingFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "7"
        elif sensingFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "7"
    q = -1
    for i in control:
        q += 1
        if controlFindType[q] == "le":
            if i == lin.lstrip(" ")[: len(i)]:
                syntype = "6"
        elif controlFindType[q] == "eq":
            if i == lin.lstrip(" ").rstrip(" "):
                syntype = "6"
        elif controlFindType[q] == "in":
            if i in lin.lstrip(" "):
                syntype = "6"
    for i in shabang:
        sbi += 1
        if i in lin.lstrip(" "):
            syntype = str(sbi)
    if "\\n" in lin.lstrip(" "):
        syntype = "n"
    if "\\p" in lin.lstrip(" "):
        syntype = "p"


def add_syntax(lll, bar=True):
    global q, e_lines_w_syn, bracks
    synline = lll
    q += 1
    per = q / flen
    if bar:
        print(
            "\033[A["
            + round(proglen * per) * "#"
            + (proglen - round(proglen * per)) * " "
            + "] "
            + str(round(per * 100))
            + "%"
        )
    determine_type(lll)
    i = -1
    slc1 = ""
    parenth = bracks
    while True:
        i += 1
        try:
            char = synline[i]
        except IndexError:
            break
        slc1 += char
        if char in pth:
            if not char == "{":
                parenth += 1
                c = 0
                for z in range(parenth):
                    c += 1
                    if c == 9:
                        c = 1
                slc1 = slc1.rstrip(slc1[-1])
                slc1 += pthesis[str(c)] + char + colors[syntype]
            else:
                bracks += 1
                c = 0
                for z in range(bracks):
                    c += 1
                    if c == 9:
                        c = 1
                slc1 = slc1.rstrip(slc1[-1])
                slc1 += pthesis[str(c)] + char + colors[syntype]
        elif char in pthends:
            if not char == "}":
                if parenth > 0:
                    c = 0
                    for z in range(parenth):
                        c += 1
                        if c == 9:
                            c = 1
                    slc1 = slc1.rstrip(slc1[-1])
                    slc1 += pthesis[str(c)] + char + colors[syntype]
                    parenth -= 1
            else:
                if bracks > 0:
                    c = 0
                    for z in range(bracks):
                        c += 1
                        if c == 9:
                            c = 1
                    slc1 = slc1.rstrip(slc1[-1])
                    slc1 += pthesis[str(c)] + char + colors[syntype]
                    bracks -= 1
        if char == '"':
            slc1 = slc1.rstrip(slc1[-1])
            slc1 += '\033[38;5;34m"'
            while True:
                i += 1
                try:
                    char = synline[i]
                except IndexError:
                    break
                slc1 += char
                if char == '"':
                    slc1 += colors[syntype]
                    break
        if char == "'":
            slc1 = slc1.rstrip(slc1[-1])
            slc1 += "\033[38;5;34m'"
            while True:
                i += 1
                try:
                    char = synline[i]
                except IndexError:
                    break
                slc1 += char
                if char == "'":
                    slc1 += colors[syntype]
                    break
        if char == "/":
            i -= 1
            if synline[i] == "/":
                i += 1
                slc1 = slc1.rstrip("//")
                slc1 += "\033[38;5;8m//"
                while True:
                    i += 1
                    try:
                        char = synline[i]
                    except IndexError:
                        break
                    slc1 += char
                break
            else:
                i += 1
    synline = slc1
    synbuild = bgs[syntype] + colors[syntype] + synline + "\033[0m"
    if synbuild == "":
        synbuild = lll
    return synbuild


e_lines_w_syn = []
for line in editor_lines:
    e_lines_w_syn.append(add_syntax(line))
editor_current_line = 1
editor_char = len(editor_lines[0])
realline = 1
li = shutil.get_terminal_size().lines
co = shutil.get_terminal_size().columns
quotecomplete = False
parenthcomplete = 0
caps = False


def on_press(what):
    global realline, editor_current_line, editor_char, cursor_blink, key, caps
    global quotecomplete, parenthcomplete, inEditor, state
    if len(str(what)) < 5:
        key = str(what)[1:-1]
    else:
        key = str(what).replace("'", "")
    if key == "Key.f1":
        inEditor = False
        state = "tree"
    if key == "Key.up" and editor_current_line > 1:
        editor_current_line -= 1
        if editor_current_line == realline and realline > 1:
            realline -= 1
        cursor_blink = 1
        if editor_char > len(editor_lines[editor_current_line - 1]):
            editor_char = len(editor_lines[editor_current_line - 1])
    if key == "Key.down" and editor_current_line < len(editor_lines):
        editor_current_line += 1
        if (
            editor_current_line == realline + li - 3
            and not editor_current_line == len(editor_lines)
        ):
            realline += 1
        cursor_blink = 1
        if editor_char > len(editor_lines[editor_current_line - 1]):
            editor_char = len(editor_lines[editor_current_line - 1])
    if key == "Key.left":
        if editor_char > 1:
            editor_char -= 1
        elif editor_current_line > 1:
            editor_char = len(editor_lines[editor_current_line - 2])
            editor_current_line -= 1
            if editor_current_line == realline and realline > 1:
                realline -= 1
            if editor_char > len(editor_lines[editor_current_line - 1]):
                editor_char = len(editor_lines[editor_current_line - 1])
        if quotecomplete:
            quotecomplete = False
        cursor_blink = 1
    if key == "Key.right":
        if editor_char < len(editor_lines[editor_current_line - 1]):
            editor_char += 1
        elif editor_current_line < len(editor_lines):
            editor_char = 1
            editor_current_line += 1
            if (
                editor_current_line == realline + li - 3
                and not editor_current_line == len(editor_lines)
            ):
                realline += 1
            if editor_char > len(editor_lines[editor_current_line - 1]):
                editor_char = len(editor_lines[editor_current_line - 1])
        if quotecomplete:
            quotecomplete = False
        cursor_blink = 1
    if key == "Key.backspace":
        if editor_char == 1:
            if not editor_current_line == 1:
                editor_char = len(editor_lines[editor_current_line - 2])
                transfer = (
                    editor_lines[editor_current_line - 2].rstrip(" ")
                    + editor_lines[editor_current_line - 1]
                )
                editor_lines[editor_current_line - 2] = transfer
                e_lines_w_syn[editor_current_line - 2] = add_syntax(
                    transfer, False
                )
                del editor_lines[editor_current_line - 1]
                del e_lines_w_syn[editor_current_line - 1]
                editor_current_line -= 1
                if realline > 1:
                    if editor_current_line == realline and realline > 1:
                        realline -= 1
        else:
            backspace_split = (
                editor_lines[editor_current_line - 1][: editor_char - 2]
                + editor_lines[editor_current_line - 1][editor_char - 1 :]
            )
            editor_lines[editor_current_line - 1] = backspace_split
            e_lines_w_syn[editor_current_line - 1] = add_syntax(
                backspace_split, False
            )
            if editor_char > 1:
                editor_char -= 1
            editor_char = (
                len(editor_lines[editor_current_line - 1])
                if editor_char > len(editor_lines[editor_current_line - 1])
                else editor_char
            )
        cursor_blink = 1
    if key == "Key.delete":
        if not editor_char + 1 == len(editor_lines[editor_current_line - 1]):
            backspace_split = (
                editor_lines[editor_current_line - 1][:editor_char]
                + editor_lines[editor_current_line - 1][editor_char + 1 :]
            )
            editor_lines[editor_current_line - 1] = backspace_split
            e_lines_w_syn[editor_current_line - 1] = add_syntax(
                backspace_split, False
            )
        cursor_blink = 1
    if key == "Key.enter":
        leadings = len(editor_lines[editor_current_line - 1]) - len(
            editor_lines[editor_current_line - 1].lstrip(" ")
        )
        if editor_char == len(editor_lines[editor_current_line - 1]):
            if len(editor_lines[editor_current_line - 1]) == len(
                editor_lines[editor_current_line - 1].lstrip(" ")
            ):
                leadings -= 1
            editor_lines.insert(
                editor_current_line,
                (
                    leadings
                    + (
                        2
                        if leadings == -1
                        else 1
                        - (
                            1
                            if str.strip(editor_lines[editor_current_line - 1])
                            == ""
                            else 0
                        )
                    )
                )
                * " ",
            )
            e_lines_w_syn.insert(
                editor_current_line,
                (
                    leadings
                    + (
                        2
                        if leadings == -1
                        else 1
                        - (
                            1
                            if str.strip(editor_lines[editor_current_line - 1])
                            == ""
                            else 0
                        )
                    )
                )
                * " ",
            )
            editor_char = len(editor_lines[editor_current_line])
        else:
            if (
                editor_lines[editor_current_line - 1][editor_char - 1] == "}"
                and editor_lines[editor_current_line - 1][editor_char - 2]
                == "{"
            ):
                leadings = len(editor_lines[editor_current_line - 1]) - len(
                    editor_lines[editor_current_line - 1].lstrip(" ")
                )
                ins = (
                    leadings * " "
                    + editor_lines[editor_current_line - 1][editor_char - 1 :]
                )
                editor_lines[editor_current_line - 1] = (
                    editor_lines[editor_current_line - 1].rstrip(ins) + " "
                )
                e_lines_w_syn[editor_current_line - 1] = add_syntax(
                    editor_lines[editor_current_line - 1],
                    False,
                )
                editor_lines.insert(
                    editor_current_line, (leadings + tabsize + 1) * " "
                )
                e_lines_w_syn.insert(
                    editor_current_line, (leadings + tabsize + 1) * " "
                )
                editor_lines.insert(editor_current_line + 1, ins)
                e_lines_w_syn.insert(
                    editor_current_line + 1, add_syntax(ins, False)
                )
                editor_char = leadings + tabsize + 1
            else:
                ins = editor_lines[editor_current_line - 1][editor_char - 1 :]
                editor_lines[editor_current_line - 1] = (
                    editor_lines[editor_current_line - 1].rstrip(ins) + " "
                )
                e_lines_w_syn[editor_current_line - 1] = add_syntax(
                    editor_lines[editor_current_line - 1],
                    False,
                )
                editor_lines.insert(
                    editor_current_line,
                    (leadings + (2 if leadings == -1 else 0)) * " " + ins,
                )
                e_lines_w_syn.insert(
                    editor_current_line,
                    add_syntax(
                        (leadings + (2 if leadings == -1 else 0)) * " " + ins,
                        False,
                    ),
                )
                editor_char = leadings + 1
        editor_current_line += 1
        if editor_current_line == realline + li - 3:
            realline += 1
        cursor_blink = 1
    if key == "Key.caps_lock":
        if caps:
            caps = False
        else:
            caps = True
    if key == "Key.space":
        key = " "
    if key == "\\\\":
        key = "\\"
    if key == "\\x13":
        key = "save"
        exit()
    if key == "Key.tab":
        key = tabsize * " "
        newline = (
            editor_lines[editor_current_line - 1][: editor_char - 1]
            + (key if not caps else key.upper())
            + editor_lines[editor_current_line - 1][editor_char - 1 :]
        )
        editor_lines[editor_current_line - 1] = newline
        e_lines_w_syn[editor_current_line - 1] = add_syntax(newline, False)
        editor_char += tabsize
    if len(str(key)) == 1:
        if key == '"' or key == "'":
            if not quotecomplete:
                newline = (
                    editor_lines[editor_current_line - 1][: editor_char - 1]
                    + (key if not caps else key.upper())
                    + editor_lines[editor_current_line - 1][editor_char - 1 :]
                )
                editor_lines[editor_current_line - 1] = newline
                e_lines_w_syn[editor_current_line - 1] = add_syntax(
                    newline, False
                )
                editor_char += 1
                cursor_blink = 1
                quotecomplete = True
                newline = (
                    editor_lines[editor_current_line - 1][: editor_char - 1]
                    + (key if not caps else key.upper())
                    + editor_lines[editor_current_line - 1][editor_char - 1 :]
                )
                editor_lines[editor_current_line - 1] = newline
                e_lines_w_syn[editor_current_line - 1] = add_syntax(
                    newline, False
                )
            else:
                editor_char += 1
                cursor_blink = 1
                quotecomplete = False
        elif key in pth:
            parenthcomplete += 1
            pkey = key
            newline = (
                editor_lines[editor_current_line - 1][: editor_char - 1]
                + key
                + editor_lines[editor_current_line - 1][editor_char - 1 :]
            )
            editor_lines[editor_current_line - 1] = newline
            e_lines_w_syn[editor_current_line - 1] = add_syntax(newline, False)
            editor_char += 1
            cursor_blink = 1
            if key == "(":
                key = ")"
            if key == "[":
                key = "]"
            if key == "{":
                key = "}"
                parenthcomplete -= 1
            if key == "<":
                key = ">"
            newline = (
                editor_lines[editor_current_line - 1][: editor_char - 1]
                + key
                + editor_lines[editor_current_line - 1][editor_char - 1 :]
            )
            key = pkey
            editor_lines[editor_current_line - 1] = newline
            e_lines_w_syn[editor_current_line - 1] = add_syntax(newline, False)
        elif key in pthends:
            if parenthcomplete > 0:
                parenthcomplete -= 1
                editor_char += 1
                cursor_blink = 1
            else:
                newline = (
                    editor_lines[editor_current_line - 1][: editor_char - 1]
                    + key
                    + editor_lines[editor_current_line - 1][editor_char - 1 :]
                )
                editor_lines[editor_current_line - 1] = newline
                e_lines_w_syn[editor_current_line - 1] = add_syntax(
                    newline, False
                )
                editor_char += 1
                cursor_blink = 1
        else:
            if caps:
                newline = (
                    editor_lines[editor_current_line - 1][: editor_char - 1]
                    + (key.upper() if key.lower() == key else key.lower())
                    + editor_lines[editor_current_line - 1][editor_char - 1 :]
                )
            else:
                newline = (
                    editor_lines[editor_current_line - 1][: editor_char - 1]
                    + key
                    + editor_lines[editor_current_line - 1][editor_char - 1 :]
                )
            editor_lines[editor_current_line - 1] = newline
            e_lines_w_syn[editor_current_line - 1] = add_syntax(newline, False)
            editor_char += 1
            cursor_blink = 1
    if editor_char < 1:
        editor_char = 1
    if editor_char > len(editor_lines[editor_current_line - 1]):
        editor_char = len(editor_lines[editor_current_line - 1])


def resetkey(release):
    global key
    key = ""


def inputloop():
    with pynput.keyboard.Listener(
        on_press=on_press, on_release=resetkey
    ) as listener:
        listener.join()


def editor_print(lin):
    global bracks
    glc = len(str(len(editor_lines)))
    if show_cwd:
        cwdstr = (
            "\033[46m\033[35;1mCurrent Working Directory: "
            + os.getcwd().replace("\\", "/")
            + "/project.ss1"
        )
        if (
            len("Current Working Directory: ")
            + len(os.getcwd().replace("\\", "/") + "/project.ss1")
            > co
        ):
            cwdstr = (
                cwdstr.rstrip(
                    cwdstr[
                        co
                        - (
                            len("Current Working Directory: ")
                            + len(
                                os.getcwd().replace("\\", "/") + "/project.ss1"
                            )
                        )
                        - 4 :
                    ]
                )
                + "..."
            )
    else:
        cwdstr = "\033[46m\033[35;1m                           "
    editor_buffer = cwdstr + (co - (len(cwdstr) - 12)) * " " + "\033[0m\n"
    q = realline - 1
    for i in range(lin - 2):
        q += 1
        try:
            filler = (
                co
                - (len(editor_lines[q - 1]) + len(str(len(editor_lines))) + 5)
            ) * " "
            eb_line = (
                "\033[38;5;8m"
                + (glc - len(str(q))) * " "
                + ("\033[93m" if editor_current_line == q else "")
                + str(q)
                + "     "
                + "\033[0m"
                + e_lines_w_syn[q - 1]
                + filler
                + "\n"
            )
            if editor_current_line == q and cursor_blink == 1:
                ebb = editor_lines[q - 1]
                determine_type(ebb)
                find = colors[syntype]
                parenth = 0
                bracks = 0
                j = -1
                for k in range(len(ebb)):
                    quote = False
                    comment = False
                    j += 1
                    if editor_char == j + 1:
                        find += "\033[46;1m"
                    try:
                        if ebb[j] == '"':
                            find += '\033[38;5;34m"'
                            quote = True
                        elif ebb[j] == "'":
                            find += "\033[38;5;34m'"
                            quote = True
                        elif ebb[j] == "/":
                            j -= 1
                            if ebb[j] == "/":
                                j += 1
                                if editor_char == j:
                                    find += "\033[46;1m\033[38;5;8m/\033[0m\033[38;5;8m/"
                                elif editor_char == j + 1:
                                    find += "\033[0m\033[38;5;8m/\033[46;1m/\033[0m"
                                else:
                                    find += "\033[38;5;8m//"
                                comment = True
                            else:
                                j += 1
                        else:
                            find += ebb[j]
                    except IndexError:
                        break
                    char = ebb[j]
                    if editor_char == j + 1:
                        find += "\033[0m" + colors[syntype]
                    if char in pth:
                        if not char == "{":
                            parenth += 1
                            c = 0
                            for z in range(parenth):
                                c += 1
                                if c == 9:
                                    c = 1
                            find = find.rstrip(find[-1])
                            find += (
                                pthesis[str(c)]
                                + (char if not editor_char == j + 1 else "")
                                + colors[syntype]
                            )
                        else:
                            bracks += 1
                            c = 0
                            for z in range(bracks):
                                c += 1
                                if c == 9:
                                    c = 1
                            find = find.rstrip(find[-1])
                            find += (
                                pthesis[str(c)]
                                + (char if not editor_char == j + 1 else "")
                                + colors[syntype]
                            )
                    elif char in pthends:
                        if not char == "}":
                            if parenth > 0:
                                c = 0
                                for z in range(parenth):
                                    c += 1
                                    if c == 9:
                                        c = 1
                                find = find.rstrip(find[-1])
                                find += (
                                    pthesis[str(c)]
                                    + (
                                        char
                                        if not editor_char == j + 1
                                        else ""
                                    )
                                    + colors[syntype]
                                )
                                parenth -= 1
                        else:
                            if bracks > 0:
                                c = 0
                                for z in range(bracks):
                                    c += 1
                                    if c == 9:
                                        c = 1
                                find = find.rstrip(find[-1])
                                find += (
                                    pthesis[str(c)]
                                    + (
                                        char
                                        if not editor_char == j + 1
                                        else ""
                                    )
                                    + colors[syntype]
                                )
                                bracks -= 1
                    if char == '"':
                        if quote:
                            find += "\033[38;5;34m"
                            while True:
                                j += 1
                                try:
                                    char = ebb[j]
                                except IndexError:
                                    break
                                if editor_char == j + 1:
                                    find += "\033[46;1m"
                                char = ebb[j]
                                find += char
                                if editor_char == j + 1:
                                    find += "\033[0m" + "\033[38;5;34m"
                                if char == '"':
                                    find += colors[syntype]
                                    break
                        else:
                            find = find.rstrip(find[-1])
                            find += '\033[38;5;34m"'
                            while True:
                                j += 1
                                try:
                                    char = ebb[j]
                                except IndexError:
                                    break
                                find += char
                                if char == '"':
                                    find += colors[syntype]
                                    break
                    if char == "'":
                        if quote:
                            find += "\033[38;5;34m"
                            while True:
                                j += 1
                                try:
                                    char = ebb[j]
                                except IndexError:
                                    break
                                if editor_char == j + 1:
                                    find += "\033[46;1m"
                                char = ebb[j]
                                find += char
                                if editor_char == j + 1:
                                    find += "\033[0m" + "\033[38;5;34m"
                                if char == "'":
                                    find += colors[syntype]
                                    break
                        else:
                            find = find.rstrip(find[-1])
                            find += "\033[38;5;34m'"
                            while True:
                                j += 1
                                try:
                                    char = ebb[j]
                                except IndexError:
                                    break
                                find += char
                                if char == "'":
                                    find += colors[syntype]
                                    break
                    if char == "/":
                        j -= 1
                        if ebb[j] == "/":
                            j += 1
                            if comment:
                                find += "\033[38;5;8m"
                                while True:
                                    j += 1
                                    try:
                                        char = ebb[j]
                                    except IndexError:
                                        break
                                    if editor_char == j + 1:
                                        find += "\033[46;1m"
                                    char = ebb[j]
                                    find += char
                                    if editor_char == j + 1:
                                        find += "\033[0m" + "\033[38;5;8m"
                            else:
                                find = find.rstrip("//")
                                if editor_char == j:
                                    find += "\033[46;1m\033[38;5;8m/\033[0m\033[38;5;8m/"
                                elif editor_char == j + 1:
                                    find += "\033[38;5;8m/\033[46;1m/\033[0m"
                                else:
                                    find += "\033[38;5;8m//"
                                while True:
                                    j += 1
                                    try:
                                        char = ebb[j]
                                    except IndexError:
                                        break
                                    find += char
                                break
                        else:
                            j += 1
                            if not ebb[j + 1] == "/":
                                if editor_char == j + 1:
                                    find += "\033[46;1m/\033[0m"
                                else:
                                    find += char
                eb_line = (
                    "\033[38;5;8m"
                    + (glc - len(str(editor_current_line))) * " "
                    + "\033[93m"
                    + str(editor_current_line)
                    + "     "
                    + "\033[0m"
                    + find
                    + "\033[0m"
                    + filler
                    + "\033[0m\n"
                )
        except IndexError:
            eb_line = "\033[38;5;8m~\033[0m     " + (co - 6) * " " + "\n"
        editor_buffer += eb_line
    print("\033[H\033[3J", end="")
    print(editor_buffer + "\033[A")


# https://stackoverflow.com/questions/7168508/background-function-in-python
# ---


class CursorBlink(threading.Thread):
    def __init__(self, increment):
        threading.Thread.__init__(self)
        self.runnable = increment
        self.daemon = True

    def run(self):
        self.runnable()


csblink = CursorBlink(increment)
csblink.start()


class InputLoop(threading.Thread):
    def __init__(self, inputloop):
        threading.Thread.__init__(self)
        self.runnable = inputloop
        self.daemon = True

    def run(self):
        self.runnable()


iloop = CursorBlink(inputloop)
iloop.start()


# ---
def editor():
    global li, co, inEditor, cursor_blink, key
    subprocess.run("bash -c clear", shell=False)
    editor_print(li)
    while inEditor:
        li = shutil.get_terminal_size().lines
        co = shutil.get_terminal_size().columns
        editor_print(li)
        ccurblk = cursor_blink
        while True:
            if not ccurblk == cursor_blink:
                break
            if not key == "":
                if key == "save":
                    projectdir = (
                        os.getcwd().replace("\\", "/") + "/project.ss1"
                    )
                    print("Saving to " + projectdir + "...")
                    with open(projectdir, "w") as fp:
                        for item in editor_lines:
                            fp.write("%s\n" % item.rstrip(" "))
                    inEditor = False
                    print("Done. Press ctrl+c to exit.")
                    exit()
                break


tree_buffer = []
tree_num = 0


def listdirs(dircwd=""):
    global tree_buffer, tree_num
    if not dircwd == "":
        os.chdir(dircwd)
    file_list = os.listdir()
    for i in file_list:
        tree_buffer += (
            tree_num * "|  " + i + ("/" if os.path.isdir(i) else "") + "\n"
        )
        if os.path.isdir(i):
            tree_num += 1
            listdirs(i)
            tree_num -= 1
    if not dircwd == "":
        os.chdir("..")


def filetree():
    global tree_buffer
    subprocess.run("bash -c clear", shell=False)
    os.chdir(os.path.dirname(os.getcwd()))
    os.chdir("../..")
    if show_cwd:
        cwdstr = (
            "\033[46m\033[35;1mCurrent Working Directory: "
            + os.getcwd().replace("\\", "/")
        )
        if (
            len("Current Working Directory: ")
            + len(os.getcwd().replace("\\", "/"))
            > co
        ):
            cwdstr = (
                cwdstr.rstrip(
                    cwdstr[
                        co
                        - (
                            len("Current Working Directory: ")
                            + len(os.getcwd().replace("\\", "/"))
                        )
                        - 4 :
                    ]
                )
                + "..."
            )
    else:
        cwdstr = "\033[46m\033[35;1m                           "
    tree_buffer = cwdstr + (co - (len(cwdstr) - 12)) * " " + "\033[0m\n"
    listdirs()
    print(tree_buffer)
    exit()


state = "edit"
while True:
    if state == "edit":
        editor()
    elif state == "tree":
        filetree()
