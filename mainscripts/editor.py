import os
import re
import shutil
import subprocess
import sys
import threading
import time
from tkinter import filedialog as fd


# https://www.tutorialspoint.com/How-can-I-remove-the-ANSI-escape-sequences-from-a-string-in-python
# ---
def escape_ansi(yee):
    ansi_escape = re.compile(r"(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]")
    return ansi_escape.sub("", yee)


# ---


global parenth
global synbuild
global syntype
global e_lines_w_syn

RED = "\033[0;31m"
NC = "\033[0m"
P = "\033[0;35m"

cwd = os.getcwd().replace("\\", "/")


def increment():
    global cursor_blink
    cursor_blink = 1
    while True:
        cursor_blink = 0
        time.sleep(0.5)
        cursor_blink = 1
        time.sleep(0.5)


def error(text):
    print(RED + "Error: " + text + NC)


b = ""


def getinput():
    return (
        subprocess.check_output("bash -c '" + cwd + "/getarrows.sh 2'", shell=False)
        .decode("utf-8")
        .strip()
    )


print("")
print("Select your project folder.")
print("")
fold = ""
try:
    if not sys.argv[1] is None:
        fold = sys.argv[1].replace("\\", "/")
except IndexError:
    time.sleep(2)
    fold = fd.askdirectory(title="Choose a project.", initialdir="../projects")
    fold = fold.replace("\\", "/")
if not os.path.isfile(fold + "/.maindir"):
    error("Not a ScratchScript project, or .maindir file was deleted.")
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
    q = q + 1
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
    editor_lines += [line]
f.close()
print("")
print("Building syntax highlighting...")
print("")
q = 0
colors = {
    "c": "\033[0m",
    "n": "\033[37m\033[7m\033[1m",
    "0": "\033[37m",
    "1": "\033[35m",
}
bgs = {"c": "", "n": "\033[40;1m", "0": "", "1": ""}
pthesis = {"0": "", "1": "\033[38;5;94m", "2": "\033[34m", "3": "\033[38;5;196m"}
looks = [
    "switch backdrop",
    "next backdrop",
    "change [color",
    "change [fish",
    "change [whirl",
    "change [pixel",
    "change [mosa",
    "change [bright",
    "change [ghost",
    "clear g",
    "(backdrop",
]
pth = ["(", "[", "{"]
pthends = [")", "]", "}"]
excludes = ["46;1", "38;5;8", "0", "37", "35", "7", "1"]


def determine_type(lin):
    global syntype
    syntype = "0"
    for i in looks:
        if i in lin:
            syntype = "1"
    if lin == "\\nscript":
        syntype = "n"


def add_syntax(lll):
    global q, e_lines_w_syn
    synline = lll
    q = q + 1
    per = q / flen
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
    parenth = 0
    while True:
        i = i + 1
        try:
            char = synline[i]
        except IndexError:
            break
        slc1 += char
        if char in pth:
            parenth = parenth + 1
            c = 0
            for z in range(parenth):
                c = c + 1
                if c == 4:
                    c = 1
            slc1 = slc1.rstrip(slc1[-1])
            slc1 += pthesis[str(c)] + char + colors[syntype]
        elif char in pthends:
            c = 0
            for z in range(parenth):
                c = c + 1
                if c == 4:
                    c = 1
            slc1 = slc1.rstrip(slc1[-1])
            slc1 += pthesis[str(c)] + char + colors[syntype]
            parenth = parenth - 1
        if char == '"':
            slc1 = slc1.rstrip(slc1[-1])
            slc1 += '\033[38;5;34m"'
            while True:
                i = i + 1
                try:
                    char = synline[i]
                except IndexError:
                    break
                slc1 += char
                if char == '"':
                    slc1 += colors[syntype]
                    break
    synline = slc1
    synbuild = bgs[syntype] + colors[syntype] + synline + "\033[0m"
    if synbuild == "":
        synbuild = lll
    return synbuild


e_lines_w_syn = [""]
for line in editor_lines:
    e_lines_w_syn.append(add_syntax(line))
editor_current_line = 1
editor_char = len(editor_lines[0])
realline = 1
li = shutil.get_terminal_size().lines
co = shutil.get_terminal_size().columns


def editor_print(lin):
    cwdstr = (
            "\033[46m\033[35;1mCurrent Working Directory: "
            + os.getcwd().replace("\\", "/")
            + "/project.ss1"
    )
    editor_buffer = cwdstr + (co - (len(cwdstr) - 12)) * " " + "\033[0m\n"
    q = realline - 1
    for i in range(lin - 2):
        q = q + 1
        eb_line = (
                "\033[38;5;8m"
                + str(q)
                + (5 - len(str(q))) * " "
                + " \033[0m"
                + e_lines_w_syn[q]
                + "\n"
        )
        if editor_current_line == q and cursor_blink == 1:
            ebb = editor_lines[q - 1]
            determine_type(ebb)
            find = colors[syntype]
            parenth = 0
            j = -1
            for k in range(len(ebb)):
                j = j + 1
                if editor_char == j + 1:
                    find += "\\033[46;1m"
                try:
                    find += ebb[j]
                except IndexError:
                    break
                char = ebb[j]
                if editor_char == j + 1:
                    find += "\\033[0m" + colors[syntype]
                if char in pth:
                    parenth = parenth + 1
                    c = 0
                    for z in range(parenth):
                        c = c + 1
                        if c == 4:
                            c = 1
                    find = find.rstrip(find[-1])
                    find += (
                            pthesis[str(c)]
                            + (char if not editor_char == j + 1 else "")
                            + colors[syntype]
                    )
                elif char in pthends:
                    c = 0
                    for z in range(parenth):
                        c = c + 1
                        if c == 4:
                            c = 1
                    find = find.rstrip(find[-1])
                    find += (
                            pthesis[str(c)]
                            + (char if not editor_char == j + 1 else "")
                            + colors[syntype]
                    )
                    parenth = parenth - 1
                if char == '"':
                    find = find.rstrip(find[-1])
                    print(find)
                    find += (
                        "\033[38;5;34m" + '"'
                        if not find.endswith('"')
                        else ""
                    )
                    while True:
                        j = j + 1
                        try:
                            char = ebb[j]
                        except IndexError:
                            break
                        find += char
                        if char == '"':
                            find += colors[syntype]
                            break
            eb_line = (
                    "\033[38;5;8m"
                    + str(editor_current_line)
                    + (5 - len(str(editor_current_line))) * " "
                    + " \033[0m"
                    + find
                    + "\033[0m\n"
            )
        editor_buffer += eb_line
    subprocess.run("bash -c clear", shell=False)
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

# ---

subprocess.run("bash -c clear", shell=False)
while True:
    li = shutil.get_terminal_size().lines
    co = shutil.get_terminal_size().columns
    editor_print(li)
    key = getinput()
    if key == "up" and editor_current_line > 1:
        editor_current_line = editor_current_line - 1
        if editor_current_line == realline - 1:
            realline = realline - 1
        cursor_blink = 1
        if editor_char > len(editor_lines[editor_current_line - 1]):
            editor_char = len(editor_lines[editor_current_line - 1])
    if key == "do" and editor_current_line < len(editor_lines):
        editor_current_line = editor_current_line + 1
        if editor_current_line == realline + li - 2:
            realline = realline + 1
        cursor_blink = 1
        if editor_char > len(editor_lines[editor_current_line - 1]):
            editor_char = len(editor_lines[editor_current_line - 1])
    if key == "le":
        if editor_char > 1:
            editor_char = editor_char - 1
        cursor_blink = 1
    if key == "ri":
        if editor_char < len(editor_lines[editor_current_line - 1]):
            editor_char = editor_char + 1
        cursor_blink = 1
