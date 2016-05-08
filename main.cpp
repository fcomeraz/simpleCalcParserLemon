#include <iostream>
#include <stdio.h>
#include "simpleCalcLexer.h"
#include "Symbols.h"

using namespace std;

extern int value;


void* ParseAlloc(void * (*allocProc)(size_t));
void* Parse(void*, int, int);
void* ParseFree(void*, void(*freeProc)(void*));

int main(){
	void* pParser = ParseAlloc(malloc);

	int n = yylex();
	while(n){
		switch (n){
			case INTEGER:
				Parse(pParser, n, value);
				break;
			default:
				Parse(pParser, n, 0);
		}
		
		if(n == NEWLINE){
			do{
				n = yylex();
			}while(n == NEWLINE);
		}else{
			n = yylex();
		}
	}
	Parse(pParser, 0, 0);
	ParseFree(pParser, free);

	return 0;
}