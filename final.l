%{
#include "final.tab.h"
#include <stdio.h>

int line_number = 1;  
%}

%%

[ \t]+          ;  

if              return T_IF;
else            return T_ELSE;
for             return T_FOR;
do              return T_DO;
while           return T_WHILE;
continue        return T_CONTINUE;
break           return T_BREAK;
return          return T_RETURN;
switch          return T_SWITCH;
case            return T_CASE;
int             return T_INT;

[a-zA-Z_][a-zA-Z0-9_]* return T_ID;

"=="            return T_EQ;
"="             return '=';
">"             return '>';
"<"             return '<';
";"             return ';';
","             return ',';
"("             return '(';
")"             return ')';
"{"             return '{';
"}"             return '}';
"["             return '[';
"]"             return ']';

[0-9]+          return T_NUM;

[\n]            { line_number++; return T_NL; }  

.               return yytext[0];  

%% 

int yywrap() {
    return 1; 
}
