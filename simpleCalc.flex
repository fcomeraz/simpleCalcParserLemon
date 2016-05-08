%option noyywrap

%{
	#include <iostream>
	#include <stdio.h>
	#include "Symbols.h"

	using namespace std;

	int line = 1;
	string texto;
	int value;
%}


number (0|[1-9][0-9]*)
white_space [ \t\r\0]
new_line \n


%%

{number} { value = atoi(yytext); return INTEGER;}
"+" { return PLUS;}
"-" { return MINUS;}
"*" { return MULT;}
"/" { return DIVIDE;}
{white_space}
{new_line} {line++; return NEWLINE;}
. {printf("\nCaracter '%s' no valido en linea %d\n", yytext, line); exit(0);}
<<EOF>> {return 0;}

%%


