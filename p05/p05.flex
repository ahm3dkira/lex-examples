%{ 
char* validateParentheses(char* s);
%}
%option nounput yylineno
%%
[ \n\t]		    ;			
[^ \n\t]* 	    {
                    char* validMsg = validateParentheses(yytext);
                    fprintf(yyout, "@line %d\n%s: %s\n\n", yylineno, yytext, validMsg);
                    free(validMsg);
                }

%%

char* validateParentheses(char* s) {
    int length = strlen(s);
    int numOfOpens = 0;
    char* msg = malloc(sizeof(char) * (39));
    for (int i = 0; i < length; i++) {
        if (s[i] == '(') numOfOpens++;
        else if (s[i] == ')') {
            if (numOfOpens > 0) numOfOpens--;
            else {
                char res[length+1];
                for (int j = 0; j < length; j++) {
                    if (j==i) res[j] = '^';
                    else res[j] = '~';
                }
                res[length] = '\0';
                msg = realloc(msg, sizeof(char) * (39+length));
                strcpy(msg, "invalid; extra closed parenthesis found.\n");
                strcat(msg, res);
                return msg;
            }
        }
    }
    if (numOfOpens > 0) strcpy(msg,"invalid; extra open parentheses found.");
    else strcpy(msg, "balanced.");
    return msg;
}

int main(int argc, char *argv[]) 
{

	FILE *ifp = fopen(argv[1],"r");
	yyin = ifp;	

	yyout = fopen("validate_parentheses.txt", "w");


	while(yylex()){yylex();}
	printf("Done.\n");

	fclose(ifp);

	return 0;
}