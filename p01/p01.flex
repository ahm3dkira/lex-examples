%{
#include<stdio.h>
int lines = 1;
int characters = 0; 
%}

%%
\n      lines++;
[^ ]    characters++;
%%

int yywrap(){
    return 1;
}

int main() {
    extern FILE *yyin, *yyout;
    yyin = fopen("input.txt" , "r");
    yyout = fopen("output.txt" , "w");
    yylex();
    fprintf(yyout,"\nNumber OF Lines = %d", lines );
    fprintf(yyout,"\nNumber OF Characters = %d", characters );
    return 0;
}