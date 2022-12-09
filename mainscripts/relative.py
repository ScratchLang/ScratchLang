import sys
from io import StringIO

import pyautogui
import win32gui


def position(offsetx=0, offsety=0, x=-1, y=-1):
    try:
        windowName = win32gui.GetWindowText(win32gui.GetForegroundWindow())
        windows = pyautogui.getAllWindows()  # type: ignore
        allWindowsList = []
        buffer = StringIO()
        sys.stdout = buffer
        for window in windows:
            print(window)
            allWindowsList += buffer.getvalue().split("\n")
        sys.stdout = sys.__stdout__
        line = ""
        for window in allWindowsList:
            if windowName in window:
                line = window
                break
        i = line.find('left="') + 5
        windowX = ""
        while True:
            i += 1
            if line[i] == '"':
                break
            windowX += line[i]
        windowX = int(windowX) + 8
        i = line.find('top="') + 4
        windowY = ""
        while True:
            i += 1
            if line[i] == '"':
                break
            windowY += line[i]
        windowY = int(windowY) + 2 + offsety
        i = line.find('width="') + 6
        width = ""
        while True:
            i += 1
            if line[i] == '"':
                break
            width += line[i]
        width = int(width) - 15 - offsetx
        i = line.find('height="') + 7
        height = ""
        while True:
            i += 1
            if line[i] == '"':
                break
            height += line[i]
        height = int(height) - 41
        relativeMX = (pyautogui.position()[0] if x == -1 else x) - windowX
        relativeMY = (pyautogui.position()[1] if y == -1 else y) - windowY
        inWindow = True
        if relativeMX < 0:
            relativeMX = 0
            inWindow = False
        if relativeMX > width:
            relativeMX = width
            inWindow = False
        if relativeMY < 0:
            relativeMY = 0
            inWindow = False
        if relativeMY > height:
            relativeMY = height
            inWindow = False
        return (relativeMX, relativeMY, inWindow, height, width)
    except:
        pass
