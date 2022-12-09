# Turns out the clicking to place the cursor was a little off because of an oversight. But I'm gonna keep the option to calibrate just in case.

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
    mx = math.floor(mousex / round(w / shutil.get_terminal_size().columns))
    my = math.floor(mousey / round(h / shutil.get_terminal_size().lines))


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
    if not mx == -1 or not my == -1:
        break
print(mx, my)
offsetx = 0 - mx
offsety = 0 - my
f = open("var/editor_settings.yaml", "r")
offsetOptx = False
offsetOpty = False
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
