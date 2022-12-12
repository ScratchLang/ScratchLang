import math
import shutil
import threading

import pyautogui
import pynput
import win32gui

pmousex = -1
pmousey = -1


def position(offsetx=0, offsety=0, x=-1, y=-1):
    """
    Get the position of the mouse cursor relative to the foreground window.

    Returns (relative x, relative y, inWindow, height, width).

    Relative x and y is the position of the mouse cursor relative to the window.
    inWindow is the boolean indicating the mouse cursor is inside the window.
    height is the height of the window.
    width is the width of the window.

    The offsetx and offsety arguments are an integer value shortening the x and y borders that you want the mouse
    cursor to relative to. Or you could see it as changing (0, 0) to where you want it to be.

    The x and y arguments are there just in case you already have the coordinates of the mouse cursor.

    (0, 0) is the top left corner of the window.
    """
    rect = win32gui.GetWindowRect(win32gui.GetForegroundWindow())
    windowX = rect[0] + 8
    windowY = rect[1] + 2 + offsety
    width = rect[2] - 15 - offsetx
    height = rect[3] - 41
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
    return relativeMX, relativeMY, inWindow, height, width


def termposition(offsetx=0, offsety=0, x=-1, y=-1):
    """
    Get the position of the mouse cursor relative to the foreground window.

    Returns (relative x, relative y, inWindow, height, width).

    Relative x and y is the position of the mouse cursor relative to the window.
    inWindow is the boolean indicating the mouse cursor is inside the window.
    height is the height of the window.
    width is the width of the window.

    The offsetx and offsety arguments are an integer value shortening the x and y borders that you want the mouse
    cursor to relative to. Or you could see it as changing (0, 0) to where you want it to be.

    The x and y arguments are there just in case you already have the coordinates of the mouse cursor.

    (0, 0) is the top left corner of the window.

    The difference between the 'position' function and the 'termposition' function is that the 'termposition' function returns the line and column relative to the terminal, instead of the x and y relative to the window.
    """
    rect = win32gui.GetWindowRect(win32gui.GetForegroundWindow())
    windowX = rect[0] + 8
    windowY = rect[1] + 2 + offsety
    width = rect[2] - 15 - offsetx
    height = rect[3] - 41
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
    return (
        math.floor(relativeMX / round(width / shutil.get_terminal_size().columns)),
        math.floor(relativeMY / round(height / shutil.get_terminal_size().lines)),
        inWindow,
        height,
        width,
    )


def calibrate():
    global pmousex, pmousey
    """
    Calibrate the relative position of the mouse cursor.
    """

    def onClick(x, y, button, pressed):
        global pmousex, pmousey
        mousex, mousey, insideWindow, h, w = position(20, 30, x, y)
        pmousex = math.floor(mousex / round(w / shutil.get_terminal_size().columns))
        pmousey = math.floor(mousey / round(h / shutil.get_terminal_size().lines))

    def clicking():
        with pynput.mouse.Listener(on_click=onClick) as listener:
            listener.join()
            listener.stop()
            exit()

    mouse = threading.Thread(target=clicking, daemon=True)
    mouse.start()

    print(
        "# click on the hashtag." + "\n" * (shutil.get_terminal_size().lines - 1),
        end="",
    )
    while True:
        if not pmousex == -1 or not pmousey == -1:
            break
    print(pmousex, pmousey)
    offsetx = 0 - pmousex
    offsety = 0 - pmousey
    f = open("var/editor_settings.yaml", "r")
    settingsFile = []
    for line in f.readlines():
        line = line.strip("\n")
        if "offsetX: " in line:
            pass
        elif "offsetY: " in line:
            pass
        else:
            settingsFile += [line]
    settingsFile += ["offsetX: " + str(offsetx)]
    settingsFile += ["offsetY: " + str(offsety)]
    f.close()
    with open("var/editor_settings.yaml", "w") as file:
        for line in settingsFile:
            file.write("%s\n" % line)
    print("Done.")
    exit()
