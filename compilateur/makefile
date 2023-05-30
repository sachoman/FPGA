c_parser :
	bison -t -v -d lex.y
	flex lex.l
	gcc -g -o lex lex.tab.c lex.yy.c tablesymboles.c codeTable.c funTable.c

c_test : c_parser
	./lex < test.c
	javac *.java
	java interpreteur
	java hexatranslator

ts :
	gcc -Wall tablesymboles.c -o tablesymboles

test: 
	gcc -Wall tablesymboles.c codeTable.c test.c -o test
	./test

projet : c_test
	$(RM) *.class
	$(RM) lex.yy.c
	$(RM) lex.tab.c
	$(RM) lex.tab.h
	$(RM) lex
	$(RM) lex.output
	$(RM) tablesymboles
	$(RM) test

clean: 
	$(RM) *.class
	$(RM) output.s 
	$(RM) output
	$(RM) lex.yy.c
	$(RM) lex.tab.c
	$(RM) lex.tab.h
	$(RM) lex
	$(RM) lex.output
	$(RM) tablesymboles
	$(RM) test