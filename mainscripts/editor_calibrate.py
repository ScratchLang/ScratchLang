import relative
import pynput
import threading
import shutil
import math

mx = -1
my = -1


def onClick(x, y, button, pressed):
    global mx, my
    mousex, mousey, insideWindow, h, w = relative.position(20, 30, x, y)
    mousex = math.floor(mousex / round(w / shutil.get_terminal_size().columns))
    mousey = math.floor(mousey / round(h / shutil.get_terminal_size().lines))


def clicking():
    with pynput.mouse.Listener(on_click=onClick) as listener:
        listener.join()


mouse = threading.Thread(target=clicking)
mouse.start()


print(
    "# click on the hashtag." + "\n" * (shutil.get_terminal_size().lines - 1),
    end="",
)
while True:
    if not mx == -1 or not my == -1:
        break
