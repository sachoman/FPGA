
c_parser :
	bison -t -v -d lex.y
	flex lex.l
	gcc -g -o lex lex.tab.c lex.yy.c tablesymboles.c codeTable.c funTable.c

c_test : c_parser
	./lex < test.c

ts :
	gcc -Wall tablesymboles.c -o tablesymboles

test: 
	gcc -Wall tablesymboles.c codeTable.c test.c -o test
	./test

test_binaire:
	python3 assembleurToBinaire.py