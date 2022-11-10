/* I learn programming languages with a mix of recreating things I've already made in a different languague, and searching up how to do things and just memorizing the function. (I learned most of my Python with this method. That other bit was from trying to convert a Python script to Shell Script.) I am making ScratchLang in C++ to try and learn it with this method. However, completing ScratchLang C++ won't be my #1 priority. */

#include <iostream>
#include <filesystem>
#include <libloaderapi.h>
using namespace std;

int main()
{
    string red = "\033[0;31m";
    string nc = "\033[0m";
    string p = "\033[0;35m";
    string test = "abc";
    TCHAR out[MAX_PATH];
    GetModuleFileName(NULL, out, MAX_PATH);
    basic_string<TCHAR> str = out;
    int i = str.size();
    while (1 == 1)
    {
        i--;
        wchar_t cchar = str.at(i);
        cout << cchar;
        if ((cchar == "/") || (cchar == "\\"))
        {
            break;
        }
    }
    cout << i;
    return 0;
}