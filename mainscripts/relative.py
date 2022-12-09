import pyautogui
import win32gui


def position(offsetx=0, offsety=0, x=-1, y=-1):
    """
    Get the position of the mouse cursor relative to the foreground window.

    Returns (relative x, relative y, inWindow, height, width).

    Relative x and y is the position of the mouse cursor relative to the window.
    inWindow is the boolean indicating the mouse cursor is inside the window.
    height is the height of the window.
    width is the width of the window.

    The offsetx and offsety arguments are a integer value shortening the x and y borders that you want the mouse cursor to relative to. Or you could see it as changing (0, 0) to where you want it to be.

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
    return (relativeMX, relativeMY, inWindow, height, width)
