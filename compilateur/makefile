JFLAGS = -g
JC = javac

.SUFFIXES: .java .class

.java.class:
        $(JC) $(JFLAGS) $*.java

CLASSES = \
        interpreteur.java \
        hexatranslator.java \

classes: $(CLASSES:.java=.class)

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

java_build: classes

clean: 
	rm *.class
	rm output.s 
	rm output
	rm lex.yy.c
	rm lex.tab.c
	rm lex.tab.h