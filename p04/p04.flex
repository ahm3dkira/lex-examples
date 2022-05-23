

%{
#include<stdio.h>
%}

even_digit (0|2|4|6|8)
odd_digit (1|3|5|7|9)
all_digit [0-9]
WHITESPACE  [ \t]+

%%
{all_digit}*{even_digit}        {fprintf(yyout,"<%s , Accepted>\n", yytext);}
{all_digit}*{odd_digit}         {fprintf(yyout,"<%s , odd Number>\n", yytext);}
{WHITESPACE}                    {/* skip whitespace */}
.                               {fprintf(yyout,"<%s , Not a Number>\n", yytext);}
%%

int yywrap(){
    return 1;
}

int main() {
    extern FILE *yyin, *yyout;
    yyin = fopen("input.txt" , "r");
    yyout = fopen("output.txt" , "w");
    yylex();
    return 0;
}