%{
#include<stdio.h>
#include <ctype.h>
%}

%%
[A-Z]   {fprintf(yyout,"%c",tolower(yytext[0])); }    
.       {fprintf(yyout, "%s", yytext); }
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