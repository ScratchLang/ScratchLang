# Making the compiler in a separate file before porting it to scratchlang.py.
import os
import sys
from glob import glob
from time import sleep
from tkinter import filedialog as fd

RED = "\033[31m"
NC = "\033[0m"
if (
    not os.path.dirname(sys.argv[0]) == ""
):  # Set cwd to the directory of the compiler
    os.chdir(os.path.dirname(sys.argv[0]))
cwd = os.getcwd().replace("\\", "/")


def error(text):  # Error function
    print(RED + "Error: " + text + NC)


print("")
print(RED + "Compiler Python Version 1.0" + NC)
print("")
print("Remember, the Python Compiler doesn't work yet.")
print("")
print("Select your project folder.")
print("")
sleep(2)
fold = ""
try:
    if not sys.argv[1] is None:
        fold = sys.argv[1].replace("\\", "/")
except IndexError:
    sleep(2)
    fold = fd.askdirectory(title="Choose a project.", initialdir="../projects")
    if not fold == "":
        os.chdir(fold)
        if not os.path.isfile(".maindir"):
            error(
                "Not a ScratchScript project ("
                + fold
                + "), or .maindir file was deleted."
            )
            exit()
    else:
        error("Empty path.")
        exit()
os.chdir(fold)
fff = glob("./*/", recursive=True)
realdirs = []
for i in fff:
    if not i == "Stage":
        realdirs += [i.lstrip(".\\\\").rstrip("\\\\")]
os.chdir("Stage")
json = '{"targets":[{"isStage":true,"name":"Stage","variables":'  # Start of the json
