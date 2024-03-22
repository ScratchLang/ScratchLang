/* I learn programming languages with a mix of recreating things I've already made in a different language, and searching up how to do things and just memorizing the function. (I learned most of my Python with this method. That other bit was from trying to convert a Python script to Shell Script.) I am making ScratchLang in C++ to try and learn it with this method. However, completing ScratchLang C++ won't be my #1 priority. */

/* I would continue this if I knew how to OPEN A FUCKING DIRECTORY SELECT DIALOG IN C++!!! But, I don't. So I can't continue this until I figure out how.*/
// #include <iostream>
// #include <string>
// #include <shlobj.h>
// #include <Commdlg.h>
// #include <winuser.h>
// #include <Windows.h>
// using namespace std;

// bool inEditor = true;
// string key;
// int cursor_blink = 0;
// string RED = "\033[0;31m";
// string NC = "\033[0m";
// string P = "\033[0;35m";

// int increment()
// {
//   cursor_blink = 1;
//   while (inEditor)
//   {
//     cursor_blink = 0;
//     sleep(0.5);
//     cursor_blink = 1;
//     sleep(0.5);
//     if (key == "save")
//     {
//       exit(0);
//     }
//   }
//   exit(0);
// }

// void eeee(const string text)
// {
//   cout << RED << "Error: " << text << NC << endl;
// }

// int main(int argc, char **argv)
// {
//   string b;
//   cout << "\nType in your project directory, as I can't figure out how to make directory selection dialog.\n";
//   sleep(2);
//   string folder;
//   if (argc > 1)
//   {
//     folder = "";
//   }
//   string path;
//   getline(cin, path);
//   cout << path << endl;
//   return 0;
// }