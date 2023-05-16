%{
#include <stdio.h>
#include <stdlib.h>
#include "tablesymboles.h"
#include "codeTable.h"
#include "funTable.h"
// tASSIGN is used in the lexical analyser but tAFFECTATION mentionned in the moodle page

%}
%define parse.error verbose
%code provides {
  int yylex (void);
  void yyerror (const char *);
  FILE * f;
}

%union { char IDENTIFIER[128];
         int NUMBER;
}

%token tIF tELSE tWHILE tPRINT tRETURN tINT tVOID
%token tADD tSUB tMUL tDIV
%token tLT tGT tNE tEQ tGE tLE
%token tASSIGN
%token tAND tOR tNOT
%token tLBRACE tRBRACE tLPAREN tRPAREN tCOMMA tSEMI
%token <NUMBER> tNB
%token <IDENTIFIER> tID

%left tOR tAND
%nonassoc tEQ tNE tLT tGT tGE tLE
%left tADD tSUB tMUL tDIV
%right tNOT
%nonassoc tID

%%

program:
    declaration_list
    ;

body:
    tLBRACE {addProf();} statement_list tRBRACE {profMoins();};

declaration_list:
    %empty
    | declaration declaration_list
    ;

declaration:
    int_declaration_statement
    | function_declaration
    ;

statement_list: %empty
    | statement statement_list 
    ;

statement:
    affectation_statement
    | print_statement
    | if_statement
    | while_statement
    | int_declaration_statement
    | function_declaration
    | return_statement
    ;

return_statement:
    tRETURN expression tSEMI {
        char tmp[1024];
        getTemp();
        putInstruction(POP, "r0");
        putInstruction(LOAD,"r1 bp");
        putInstruction(LOAD,"sp bp-2");
        putInstruction(LOAD,"bp bp-1");
        putInstruction(JUMP,"r1");
    }
    ;

function_declaration:
     tINT tID {pushFun($2, instructionqueue.nbInstructions+1); }  tLPAREN parameters_declaration tRPAREN body
    | tVOID tID {pushFun($2, instructionqueue.nbInstructions+1); } tLPAREN parameters_declaration tRPAREN body
    ;

parameters_declaration:
    tVOID
    |   parameters_i_declaration_list
    |%empty
    ;

parameters_i_declaration_list:
    parameter_declaration
    | parameter_declaration tCOMMA parameters_i_declaration_list
    ;

parameter_declaration:
    tINT tID {push($2, true, "int");}
    ;

affectation_statement:
    affectation_list tSEMI
    ;

affectation_list:
    affectation
    | affectation tCOMMA affectation_list
    ;

affectation:
    tID tASSIGN expression {getTemp(); putInstruction(POP,"r0"); char tmp[1024]; sprintf(tmp, "sp-%d r0",get($1)); putInstruction(STORE,tmp);}
    ;

declaration_affectation:
    tID tASSIGN expression {getTemp(); push($1,1,"int"); /*pop r0 push r0*/}
    ;

print_statement:
    tPRINT tLPAREN expression tRPAREN tSEMI
    ;

if_jmp : %empty { putInstruction(JUMP, "toto"); instruction * inst  = getLastInstruction(); empile(inst); };

else_jmp: %empty { depile(1); putInstruction(JUMP, "toto"); instruction * inst  = getLastInstruction(); empile(inst); }; 

if_statement:
    tIF tLPAREN condition if_jmp tRPAREN body {depile(0);}
    | tIF tLPAREN condition if_jmp tRPAREN  body else_jmp tELSE body {depile(0);}
    ;

while_loop: %empty {empile_while();}

while_jmp: %empty {putInstruction(JUMP, "toto"); instruction * inst  = getLastInstruction(); empile(inst);}

while_statement:
    tWHILE while_loop tLPAREN condition tRPAREN while_jmp body {char tmp[1024];sprintf(tmp, "%d",depile_while());putInstruction(JUMP, tmp ); depile(0);}
    ;

int_declaration_statement:
    tINT int_declaration_list tSEMI
    ;

int_declaration_list:
    int_declaration
    | int_declaration tCOMMA int_declaration_list
    ;

int_declaration:
    tID {push($1,0,"int"); putInstruction(PUSH,"0");}
    | declaration_affectation
    ;

expression:
    expression tADD expression {getTemp(); putInstruction(POP,"r0"); putInstruction(POP,"r1"); putInstruction(ADD,"r0 r0 r1"); putInstruction(PUSH, "r0");}
    | expression tSUB expression {getTemp(); putInstruction(POP,"r1");  putInstruction(POP,"r0"); putInstruction(SUB,"r0 r0 r1"); putInstruction(PUSH, "r0");}
    | expression tMUL expression {getTemp(); putInstruction(POP,"r0"); putInstruction(POP,"r1"); putInstruction(MUL,"r0 r0 r1"); putInstruction(PUSH, "r0");}
    | expression tDIV expression {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(DIV,"r0 r0 r1"); putInstruction(PUSH, "r0");}
    | tLPAREN expression tRPAREN
    | tNB {char tmp[1024];sprintf(tmp, "%d",$1); pushTemp(); putInstruction(PUSH,tmp);}
    | tID { char tmp[1024]; sprintf(tmp, "r0 sp-%d",get($1)); putInstruction(LOAD,tmp); pushTemp(); putInstruction(PUSH,"r0");}
    | function {pushTemp(); putInstruction(PUSH, "r0");}
    ;

function:
    tID {printf("avant pb\n");} tLPAREN {  putInstruction(PUSH, "sp"); pushTemp(); 
                                            putInstruction(PUSH,"bp"); pushTemp(); char tmp[1024]; 
                                            putInstruction(PUSH, "fake ret"); pushTemp(); 
                                            instruction * inst  = getLastInstruction(); empileRet(inst); 
                                            putInstruction(PUSH, "sp"); putInstruction(POP, "bp");
        } expression_list tRPAREN {
            char tmp[1024]; sprintf(tmp, "%d", getfun($1)); putInstruction(JUMP,tmp);  depileRet(); getTemp(); getTemp(); getTemp();
        }
    ;

expression_list:%empty
    |expression
    | expression tCOMMA expression_list
    ;

condition:
    expression tEQ expression
    | expression tNE expression
    | expression tLT expression
    | expression tGT expression
    | expression tGE expression
    | expression tLE expression
    | condition tAND condition
    | condition tOR condition
    | tNOT condition
    | tLPAREN condition tRPAREN
    ;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "error: %s\n", msg);
    exit(1);
}

int main(int argc, char* argv[]){
    createInstructionQueue();
    createTS();
    createFunTS();
    pileJumpVide = true;
    pileWhileVide = true;
    pileJumpRetVide = true;
    //fprintf(f,"Analysing the file : %s",argv[1]);
    //f = fopen("output.s", "w");
    yyparse();
    //fclose(f);
    exportTable();
    return 0;
}