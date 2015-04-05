%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include "shell.h"

extern char** environ;
extern char* yytext;
 
void yyerror(const char *str)
{
    fprintf(stderr,"error: %s\n",str);
    yyparse();
}
 
int yywrap()
{
    return 1;
} 

%}

%union {
	int i;
	char* sval;
}

%token <i>	LT GT AMP LPAREN RPAREN BAR DOT QUOTE
%token <i>	SETENV UNSETENV PRINTENV CD BYE ALIAS UNALIAS PWD
%token <sval>	WORD

%%
commands:
		| commands command
		;
command:
		| builtin
		| builtin LT WORD
			{ printf("Error: illegal input redirection\n"); }
builtin:
		SETENV WORD WORD
		{
			setenv($2, $3, 1);
		}
		|
		UNSETENV WORD
		{
			unsetenv($2);
		}
		|
		PRINTENV
		{
			bicmd = PRINTENVIRON;	//set builtin command
			bioutf = 0;		//output redirection is false
		}
		|
		PRINTENV GT WORD
		{
			bicmd = PRINTENVIRON;
			bioutf = 1;		//output redirection is true
			bistr = $3;
		}
		|
		ALIAS
		{
			printAliases();
		}
		|
		ALIAS WORD WORD
		{
			insertAlias($2, $3);
		}
		|
		UNALIAS WORD
		{
			removeAlias($2);
		}
		|
		CD WORD
		{
			char* dir = $2;
			chdir(dir);
		}
		|
		CD
		{
			char* home = getenv("HOME");
			chdir(home);
		}
		|
		PWD
			{ 
				char * buf;
    			char * cwd;
    			buf = (char *)malloc(sizeof(char) * 1024);

    			if((cwd = getcwd(buf, 1024)) != NULL)
            		printf("pwd : %s\n", cwd);
    			else
           			perror("getcwd() error : ");
			}
		|
		BYE
		{
			bicmd = GOODBYE;
		}
		;
%%