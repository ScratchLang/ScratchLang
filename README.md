# ![logo](https://user-images.githubusercontent.com/78574005/191553528-5a2a13a1-ac75-4fd5-a9e8-b01c01c4a2d2.png)

###### Logo by [MagicCrayon9342](https://scratch.mit.edu/users/MagicCrayon9342/)
[link to discussion forum](https://scratch.mit.edu/discuss/topic/629954/)

This is for people who want to use Scratch like other programming languages.

# Latest big updates
Added all backdrop "looks" blocks!

# The Plan
This is mainly made in Shell Script, but if you know languages like C and Python, then you can make some stuff in that so people have many options to choose from.

We need to get the compiler working first, then we can add all the blocks. A ScratchLang file (.ss) is locaded in the resources folder. Just create a project, go into the sprite folder, then replace the text from the .ss in the sprite folder with the text from the .ss in the resources folder.

The compiler should read the testcode.ss, write the project.json, and pack it and every asset into a .sb3, that can be played and edited in Scratch

Each sprite (including Stage) has a asset folder. The costumes and sound will go there. It also has a .ss file, which is where the code is.

A project.json is also included in the resources folder to help understand and reverse engineer how it's made.

I'm programming the decompiler. First I'm gonna program it to decompile all the global and stage-exclusive blocks, then sprite-exclusive blocks.

## Contributing to the decompiler
If you want to help with the decompiler but you don't understand any of the code, just ask and I'll link a discussion explaining it. If there is no discussion, I'll create one.

## Notice
Im wondering if there's a more efficient way to decompile the .json. Just 12 blocks added 2827 lines, and if I did the math correctly ((3466-379)/10*141), adding every block will add about 44,000 lines of code (including the eight already added) :(

# How to use
Clone the repo with
```
git clone https://github.com/0K9090/ScratchLang.git
cd ScratchLang/mainscripts
```

Start the project with
```
chmod 755 start.sh
./start.sh
```
If you create a scratchlang command, start the project wtih
```
scratchlang
```

To code, edit the .ss(es) in you favorite glorified text editor like VSC or Atom.

To add assets, put them in the "assets" folder for the chosen sprite (or stage)

You don't need ScratchLang to program ScratchScript (.ss) files, you can use a text editor. You just need ScratchLang to compile your project so it can run in Scratch.

# Dependencies
## Windows
You need `zenity`.
https://github.com/ncruces/zenity/wiki/Zenity-for-WSL%2C-Cygwin%2C-MSYS2 Download here, or you can run ./start.sh and input 5 to install zenity.
## Linux
You need the command `zenity` to run the .sh.
```
sudo apt-get install -y zenity
```

Please write down any dependencies I missed.

# Jobs
This is what people will do.

### 0K9090
Program the decompiler
### wendiner
I don't know what they're doing

# ScratchLang Language
## ScratchLang blocks
\nscript - (Tells the compiler that it's a new script. Or maybe we could get rid of this and just detect for hat blocks.) <br />
**\prep - (Everything below this [until \nscript] is used for compiling the .json)** <br />

## Vanilla Scratch Blocks
### Added blocks
Write every block in the order they are defined.

var=string - (Define [or set] a variable) <br />
**list=item1,item2,item3,etc - (No spaces, and for an empty list, just add a comma after the equal sign.)** <br />
{broadcast}=broadcastexample - (Define a broadcast. The brackets tell the program that it is not defining a variable or a list.) <br />
**broadcast (message) - (Use a broadcast.)** <br />
move (num) steps (Move an amount of steps.) <br />
**wait (num) seconds - (Wait for an amount of seconds.)** <br />
switch backdrop to () - (Changes backdrop.) <br />
**switch backdrop to () and wait -  (Changes backdrop and waits.)** <br />
next backdrop - (Changes backdrop by 1.)
**change (EFFECT #has to be in caps) effect by (num) - (Change an effect by an amount.)** <br />
set (EFFECT) effect to (num) - (Sets an effect to an amount.) <br />
**clear graphic effects - (Clears all effects applied to the stage or sprite.)** <br />
(backdrop (number/name)) - (Reports the number or name of the backdrop.)

### Blocks to Add

turn cw () deg <br />
turn ccw () deg <br />
go to () <br />
go to x () y () <br />
glide () secs to () <br />
glide () secs to x () y () <br />
point in direction () <br />
point towards () <br />
change x by ()
set x to () <br />
change y by () <br />
set y to () <br />
if on edge, bounce <br />
set rotation style () <br />
(x position) <br />
(y position) <br />
(direction) <br />

say () for () seconds <br />
say () <br />
think () for () seconds <br />
think () <br />
switch costume to () <br />
next costume <br />
change size by () <br />
set size to () <br />
show <br />
hide <br />
go to () layer <br />
go () () layers <br />
(costume ()) <br />
(size) <br />

play sound () until done <br />
start sound () <br />
stop all sounds <br />
change () effect by () <br />
set () effect to () <br />
clear sound effects <br />
change volume by () <br />
set volume to () <br />
(volume) <br />

when flag clicked <br />
when () key pressed <br />
when this sprite clicked <br />
when backdrop switches to () <br />
when () > () <br />
when i receive () <br />
broadcast () and wait <br />

repeat () { <br />

} <br />

forever { <br />

} <br />

if <> then { <br />

} <br />

if <> then { <br />

} <br />
else { <br />

} <br />

wait until <> <br />
repeat until <> { <br />

} <br />

while <> { <br />

} <br />

for each () in () { <br />

} <br />

stop () <br />
when i start as a clone <br />
create clone of () <br />
delete this clone <br />

<touching ()> <br />
<touching color (#hex)> <br />
<color (#hex) is touching (#hex)> <br />
(distance to ()) <br />
ask () and wait <br />
(answer) <br />
<key () pressed?> <br />
<mouse down?> <br />
(mouse x) <br />
(mouse y) <br />
set drag mode () <br />
(loudness) <br />
(timer) <br />
reset timer <br />
(() of ()) <br />
(current ()) <br />
(days since 2000) <br />
(username) <br />

(() + ()) <br />
(() - ()) <br />
(() * ()) <br />
(() / ()) <br />
(pick random () to ()) <br />
<() > ()> <br />
<() < ()> <br />
<() = ()> <br />
<<> and <>> <br />
<<> or <>> <br />
<not <>> <br />
(join ()()) <br />
(letter () of ()) <br />
(length of ()) <br />
<() contains ()?> <br />
(() mod ()) <br />
(round ()) <br />
(op () of ()) #abs of block <br />

(my variable) <br />
change () by () <br />
show variable () <br />
hide variable () <br />
(my list) <br />
add () to () <br />
delete () of () <br />
delete all of () <br />
insert () at () of () <br />
replace item () of () with () <br />
(item () of ()) <br />
(item # of () in ()) <br />
(length of ())
<li () contains ()?> #list contains block
show list () <br />
hide list () <br />

def example { <br />

} <br />

def example -sr { <br /> #run without screen refresh

} <br />
example <br />

pen|erase all <br />
pen|stamp <br />
pen|pen down <br />
pen|pen up <br />
pen|set pen color to (#hex) <br />
pen|change pen () by () <br />
pen|set pen () to () <br />
pen|change pen size by () <br />
pen|set pen size to () <br />

## Future: supporting custom Scratch mods?
Probably not.

# Troubleshooting
## Variable or List taking a very long time to decompile?
The variable or list is probably long.
## Decompiler just stops or is outputting random junk
The decompiler is not complete yet, which means stuff like that will happen.

# Bugs
Loads broadcasts even if there are none (Try decompiling decompilerteset.sb3 which is in the resources folder)

![image_2022-09-20_190744081](https://user-images.githubusercontent.com/78574005/191398176-fe011d14-62e9-45ed-ad43-80db3ef49152.png)
