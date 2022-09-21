#There should be no empty lines.
sl
\nscript #This tells the compiler if it's a new script line.
when flag clicked;
say ("testing"); #Quotations tells it it's not a variable.
broadcast ("btest");
\nscript
when i receive ("btest");
var = sup dude;
say (var);
