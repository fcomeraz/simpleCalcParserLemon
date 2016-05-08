TARGET = simpleCalc

.PHONY: clean test

all: lemon ${TARGET}

lemon: lemon.c
	gcc -o $@ $<

${TARGET}: ${TARGET}Parser.o ${TARGET}Lexer.o main.o
	g++ -o $@ $^

main.o: main.cpp
	g++ -c -o $@ $<

${TARGET}Parser.o: ${TARGET}Parser.cpp
	g++ -c -o $@ $<

${TARGET}Parser.cpp: ${TARGET}.y
	./lemon -s -q -Tlempar.c $<
	mv ${TARGET}.c $@
	mv ${TARGET}.h Symbols.h


${TARGET}Lexer.o: ${TARGET}Lexer.cpp
	g++ -c -o $@ $<

${TARGET}Lexer.cpp: ${TARGET}.flex
	flex -o $@ --header-file=${TARGET}Lexer.h $<

clean: 
	rm -rf lemon
	rm -rf ${TARGET}
	rm -rf *.o
	rm -rf *.out
	rm -rf ${TARGET}Lexer.cpp ${TARGET}Lexer.h
	rm -rf Symbols.h ${TARGET}Parser.cpp
	rm -rf ${TARGET}.h ${TARGET}.c

rebuild: clean all

test: all
	./${TARGET} < test
