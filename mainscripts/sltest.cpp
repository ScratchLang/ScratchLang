/* I learn programming languages with a mix of recreating things I've already made in a different language, and searching up how to do things and just memorizing the function. (I learned most of my Python with this method. That other bit was from trying to convert a Python script to Shell Script.) I am making ScratchLang in C++ to try and learn it with this method. However, completing ScratchLang C++ won't be my #1 priority. */
#include <unistd.h>
#include <stdlib.h>
#include <iostream>
#include <string>

bool inEditor = true;
std::string key = "";
int cursor_blink = 0;
std::string RED = "\033[0;31m";
std::string NC = "\033[0m";
std::string P = "\033[0;35m";

int increment()
{
    cursor_blink = 1;
    while (inEditor)
    {
        cursor_blink = 0;
        sleep(0.5);
        cursor_blink = 1;
        sleep(0.5);
        if (key == "save")
        {
            exit(0);
        }
    }
    exit(0);
}

void eeee(std::string text)
{
    std::cout << RED << "Error: " << text << NC << std::endl;
}

int main()
{
    std::string b = "";
    std::cout << "\nSelect your project folder.\n";
    sleep(2);
    std::string fold = "";
    return 0;
}