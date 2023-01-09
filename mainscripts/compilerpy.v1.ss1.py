# Making the compiler in a separate file before porting it to scratchlang.py.
import os
import random
import shutil
import string
import sys
from distutils.dir_util import copy_tree
from glob import glob
from time import sleep
from tkinter import filedialog as fd

import yaml

RED = "\033[31m"
NC = "\033[0m"
if not os.path.dirname(sys.argv[0]) == "":  # Set cwd to the directory of the compiler
    os.chdir(os.path.dirname(sys.argv[0]))
cwd = os.getcwd().replace("\\", "/")


def error(text):  # Error function
    print(RED + "Error: " + text + NC)


def generateRandomID(length):
    letters = string.ascii_letters + "1234567890`-=[];./~!@#$%^&*()_+{}|:<>?"
    result_str = "".join(random.choice(letters) for i in range(length))
    return result_str


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
            error("Not a ScratchScript project (" + fold + "), or .maindir file was deleted.")
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
realdirs.remove("Stage")
inDir = os.getcwd().replace("\\", "/")
os.chdir("Stage")
assetFolder = os.getcwd().replace("\\", "/") + "/assets"
json = '{"targets":[{"isStage":true,"name":"Stage","variables":{'  # Start of the json
f = open("project.ss1", "r")
fileLines = []
for i in f.readlines():
    fileLines += [i.rstrip("\n")]
i = -1
ssVer = ""
varIDDict = {}
listIDDict = {}
broadcastIDDict = {}
while True:
    i += 1
    try:
        if fileLines[i].startswith("ss"):
            ssVer = fileLines[i]
            break
    except IndexError:
        error("Project has no 'ss' line telling the compiler which ScratchScript version the file is.")
        exit()
while True:
    i += 1
    try:
        if fileLines[i] == "\\prep":
            ssVer = fileLines[i]
            break
    except IndexError:
        error("Project has no '\\prep' line.")
        exit()
variableID = ""
for j in range(i + 1, len(fileLines), 1):
    if fileLines[j] == "\\nscript":
        break
    if fileLines[j].startswith("var: "):
        line = fileLines[j].lstrip("var: ")
        varData = line.split("=")
        variableID = generateRandomID(20)
        varData[1] = varData[1].replace('"', "")
        if varData[1].isnumeric():
            json += f'"{variableID}":["{varData[0]}",{varData[1]}],'
        else:
            json += f'"{variableID}":["{varData[0]}","{varData[1]}"],'
        varIDDict[varData[0]] = variableID
json = json.rstrip(",") + '},"lists":{'
for j in range(i + 1, len(fileLines), 1):
    if fileLines[j] == "\\nscript":
        break
    if fileLines[j].startswith("list: "):
        line = fileLines[j].lstrip("list: ")
        varData = line.split("=")
        variableID = generateRandomID(20)
        json += f'"{variableID}":["{varData[0]}",['
        listData = []
        xd = -1
        while True:
            item = ""
            while True:
                xd += 1
                if xd > len(varData[1]) - 1:
                    break
                if varData[1][xd] == '"':
                    break
            while True:
                xd += 1
                if xd > len(varData[1]) - 1:
                    break
                if varData[1][xd] == '"':
                    break
                item += varData[1][xd]
            if xd > len(varData[1]) - 1:
                break
            listData += [item]
        if len(listData) == 2 and listData[0] + listData[1] == "":
            json += "]],"
        else:
            for x in listData:
                json += '"' + x + '", '
            json = json.rstrip(", ") + "]],"
        listIDDict[varData[0]] = variableID
json = json.rstrip(",") + '},"broadcasts":{'
for j in range(i + 1, len(fileLines), 1):
    if fileLines[j] == "\\nscript":
        break
    if fileLines[j].startswith("broadcast: "):
        line = fileLines[j].lstrip("broadcast: ")
        varData = [line]
        variableID = generateRandomID(20)
        json += f'"{variableID}":"{varData[0]}",'
        broadcastIDDict[varData[0]] = variableID
json = json.rstrip(",") + '},"blocks":{},"comments":{},"currentCostume":0,"costumes":['
with open(inDir + "/assets_key.yaml", "r") as loadYaml:
    assetsKey = yaml.safe_load(loadYaml)
cosId = 0
n = -1
while True:
    n += 1
    if n > len(assetsKey["Stage"]) - 1:
        break
    asset = assetsKey["Stage"][n]
    fname, fextension = os.path.splitext(asset)
    fextension = fextension[1:]
    if fextension == "svg" or fextension == "png" or fextension == "jpg":
        cosId += 1
        n += 1
        rotCX = str(assetsKey["Stage"][n])
        n += 1
        rotCY = str(assetsKey["Stage"][n])
        json += (
            '{"name":"'
            + str(cosId)
            + '","dataFormat":"'
            + fextension
            + '","assetId":"'
            + fname
            + '","md5ext":"'
            + asset
            + '","rotationCenterX":'
            + rotCX
            + ',"rotationCenterY":'
            + rotCY
            + "},"
        )
json = json.rstrip(",{") + '],"sounds":['
cosId = 0
for asset in assetsKey["Stage"]:
    try:
        fname, fextension = os.path.splitext(asset)
        fextension = fextension[1:]
        if fextension == "wav" or fextension == "mp3":
            cosId += 1
            json += (
                '{"name":"'
                + str(cosId)
                + '","assetId":"'
                + fname
                + '","dataFormat":"'
                + fextension
                + '","format":"","rate":48000,"sampleCount":99999999,"md5ext":"'
                + asset
                + '"},'
            )
    except TypeError:
        pass
json = (
    json.rstrip(",")
    + '],"volume":100,"layerOrder":0,"tempo":60,"videoTransparency":50,"videoState":"on","textToSpeechLanguage":null}],"monitors":[],"extensions":[],"meta":{"semver":"3.0.0","vm":"0.2.0","agent":""}}'
)
print(json)
os.chdir(cwd + "/../exports")
os.mkdir("a")
os.chdir("a")
with open("project.json", "x") as f:
    f.write(json)
    f.close()
copy_tree(assetFolder, os.getcwd())
os.chdir("..")
shutil.make_archive("project", "zip", "a")
os.rename("project.zip", "project.sb3")
# shutil.rmtree("a")
