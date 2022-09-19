# ScratchScript
This is for people who want to use Scratch like other programming languages.

# The Plan

We need to get the compiler working first, then we can add all the blocks. A ScratchScript file (.ss) is locaded in the resources folder. Just create a project, go into the sprite folder, then replace the text from the .ss in the sprite folder with the text from the .ss in the resources folder.

The compiler should read the testcode.ss, write the project.json, and pack it and every asset into a .sb3, that can be played and edited in Scratch

Each sprite (including Stage) has a asset folder. The costumes and sound will go there. It also has a .ss file, which is where the code is.

A project.json is also included in the resources folder to help understand and reverse engineer how it's made.

Maybe add a decompiler

# How to use
Clone the repo with
```
git clone https://github.com/0K9090/ScratchScript
cd ScratchScript/mainscripts
```

Start the project with
```
chmod 755 start.sh
./start.sh
```
# Dependencies
## Windows
You need `zenity` if you plan on using the .sh and `gcc` if you want to use the exe.
## Linux
`zenity`

Please write down any dependencies I missed.

# ScratchScript Language
## ScratchScript blocks
\nscript (Tells the compiler that it's a new script. Or maybe we could get rid of this and just detect for hat blocks.)

## Vanilla Scratch Blocks
Write every block in the order they appear in the editor

## Future: supporting custom Scratch mods?
Probably not.

![SharedScreenshot](https://user-images.githubusercontent.com/78574005/191061757-c42d69b8-8fe2-4720-a51b-58a4927b8b2f.jpg)
