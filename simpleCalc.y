%token_type {int}

%left PLUS MINUS.
%left MULT DIVIDE.

%include {
	#include <iostream>
	#include <stdio.h>
	#include <assert.h>

	using namespace std;

	extern int line;
}

%syntax_error{
	cout << "Syntax error! en linea " << line << endl;
	exit(0);
}

program ::= in.
program ::= in state.

in ::= .
in ::= in state NEWLINE.



state ::= expr(A). {cout << A << endl;}



expr(A) ::= expr(B) PLUS expr(C). {A = B + C;}
expr(A) ::= expr(B) MINUS expr(C). {A = B - C;}
expr(A) ::= expr(B) MULT expr(C). {A = B * C;}
expr(A) ::= expr(B) DIVIDE expr(C). {A = B / C;}
expr(A) ::= INTEGER(B). {A = B;}