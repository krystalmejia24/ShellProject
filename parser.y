%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include "shell.h"

extern char** environ;
extern char* yytext;
COMMAND *p;

 
void yyerror(const char *str)
{

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

%token <i>	LT GT AMP LPAREN RPAREN BAR FSLASH
%token <i>	SETENV UNSETENV PRINTENV CD BYE ALIAS UNALIAS
%token <sval>	WORD MATCH QUEST

%type <sval> cmd

%start commands


%%
commands:
		| commands command
		;
command:
		| builtin
		| builtin LT WORD
			{ 
				err_msg = "illegal input redirection";
				return 1;	//return error value
			}
		| piped
		| other
		| other LT WORD
			{ printf("Error: illegal input redirection\n"); }
builtin:
		SETENV WORD WORD
		{
			bicmd = SETENVIRON;	//set builtin command
			bistr = $2;
			bistr2 = $3;
		}
		|
		UNSETENV WORD
		{
			bicmd = UNSETENVIRON;	//set builtin command
			bistr = $2;
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
			bicmd = PRINTALIAS;
		}
		|
		ALIAS GT WORD
		{
			bicmd = PRINTALIAS;
			bioutf = 1;	//output redirection is true
			bistr = $3;		//filename
		}
		|
		ALIAS WORD WORD
		{
			bicmd = SETALIAS;
			bistr = $2;
			bistr2 = $3;
		}
		|
		UNALIAS WORD
		{
			bicmd = UNSETALIAS;
			bistr = $2;
		}
		|
		CD WORD
		{
			bicmd = CHANGEDIR;
			bistr = $2;
		}
		|
		CD
		{
			bicmd = CHANGEDIR;
			bistr = NULL;
		}
		|
		BYE
		{
			bicmd = GOODBYE;
		}
		;

piped:
		other BAR other
		{
			ncmds = currcmd;
		}
		|
		piped BAR other
		{
			ncmds = currcmd;
		}

other: 
		cmd
		{
			bicmd = 0;
			comtab[currcmd].comname = $1;
			comtab[currcmd].nargs = 1;
			(p = &comtab[currcmd])-> atptr = Allocate(ARGTAB);
			p->atptr->args[0] = $1;
			currcmd++;
			ncmds = currcmd;
		}
		|
		cmd arguments
		{
			bicmd = 0;
			comtab[currcmd].comname = $1;
			comtab[currcmd].nargs = currarg;
			comtab[currcmd].atptr->args[0] = $1;
			currcmd++;
			ncmds = currcmd;
		}
		;
		
cmd:	
		WORD 
		{
			$$ = $1;
		}
		;
	
arguments:
		MATCH
		{ 	
			(p = &comtab[currcmd])-> atptr = Allocate(ARGTAB);
			currarg = 1;
			p->atptr->args[currarg++] = $1;
		}
		|
		QUEST
		{ 	
			(p = &comtab[currcmd])-> atptr = Allocate(ARGTAB);
			currarg = 1;
			p->atptr->args[currarg++] = $1;
		}
		|
		WORD
		{
			(p = &comtab[currcmd])-> atptr = Allocate(ARGTAB);
			currarg = 1;
			p->atptr->args[currarg++] = $1;
		}
		|
		meta
		|
		AMP
		|
		arguments WORD
		{
			p->atptr->args[currarg++] = $2;
		}
		|
		arguments MATCH
		{
			p->atptr->args[currarg++] = $2;
		}
		|
		arguments AMP
		{
			printf("do something in background\n");
		} 
		;
		
meta:
		FSLASH
		{
			printf("/ testing... IDK WHY WE NEED TO RECOGNIZE YOU\n");
		}
		;
%%