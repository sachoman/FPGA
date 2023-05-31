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
    {putInstruction(JUMP, "toto");}declaration_list
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
        putInstruction(LOADBP,"r1 bp");
        putInstruction(LOADRET,"sp bp-2");
        putInstruction(LOADBP,"bp bp-1");
        putInstruction(JUMPR,"r1");
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
    tINT tID {pushparam($2, true, "int");}
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

if_jmp : %empty { getTemp(); putInstruction(POP,"r0"); putInstruction(JUMPNOTCOND, "toto"); instruction * inst  = getLastInstruction(); empile(inst);};

else_jmp: %empty { depile(1); putInstruction(JUMP, "toto"); instruction * inst  = getLastInstruction(); empile(inst); }; 

if_statement:
    tIF tLPAREN condition if_jmp tRPAREN body {depile(0);}
    | tIF tLPAREN condition if_jmp tRPAREN  body else_jmp tELSE body {depile(0);}
    ;

while_loop: %empty {empile_while();}

while_jmp: %empty {getTemp(); putInstruction(POP,"r0"); putInstruction(JUMPNOTCOND, "toto"); instruction * inst  = getLastInstruction(); empile(inst);}

while_statement:
    tWHILE while_loop tLPAREN condition tRPAREN while_jmp {
        putInstruction(PUSHSP, "sp"); pushTemp(); 
        putInstruction(PUSHR,"bp"); pushTemp();
        putInstruction(PUSHSP, "sp"); putInstruction(POP, "bp");
    } 
    body {
        getTemp();getTemp();
        putInstruction(LOADRET,"sp bp-1");
        putInstruction(LOADBP,"bp bp");
        char tmp[1024];
        sprintf(tmp, "%d",depile_while()+1);
        putInstruction(JUMP, tmp ); 
        depile(0);
        }
    ;

int_declaration_statement:
    tINT int_declaration_list tSEMI
    ;

int_declaration_list:
    int_declaration
    | int_declaration tCOMMA int_declaration_list
    ;

int_declaration:
    tID {push($1,0,"int"); putInstruction(PUSHV,"0");}
    | declaration_affectation
    ;

expression:
    expression tADD expression {getTemp(); putInstruction(POP,"r0"); putInstruction(POP,"r1"); putInstruction(ADD,"r0 r0 r1"); putInstruction(PUSHR, "r0");}
    | expression tSUB expression {getTemp(); putInstruction(POP,"r1");  putInstruction(POP,"r0"); putInstruction(SUB,"r0 r0 r1"); putInstruction(PUSHR, "r0");}
    | expression tMUL expression {getTemp(); putInstruction(POP,"r0"); putInstruction(POP,"r1"); putInstruction(MUL,"r0 r0 r1"); putInstruction(PUSHR, "r0");}
    | expression tDIV expression {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(DIV,"r0 r0 r1"); putInstruction(PUSHR, "r0");}
    | tLPAREN expression tRPAREN
    | tNB {char tmp[1024];sprintf(tmp, "%d",$1); pushTemp(); putInstruction(PUSHV,tmp);}
    | tID { char tmp[1024]; sprintf(tmp, "r0 sp-%d",get($1)); putInstruction(LOADSP,tmp); pushTemp(); putInstruction(PUSHR,"r0");}
    | function {pushTemp(); putInstruction(PUSHR, "r0");}
    ;

function:
    tID tLPAREN {  putInstruction(PUSHSP, "sp"); pushTemp(); 
                                            putInstruction(PUSHR,"bp"); pushTemp(); char tmp[1024]; 
                                            putInstruction(PUSHV, "fake ret"); pushTemp(); 
                                            instruction * inst  = getLastInstruction(); empileRet(inst); 
                                            putInstruction(PUSHSP, "sp"); putInstruction(POP, "bp");                                  
        } expression_list tRPAREN {
            char tmp[1024]; sprintf(tmp, "%d", getfun($1)); putInstruction(JUMP,tmp);  depileRet(); getTemp(); getTemp(); getTemp(); getTemp();
        }
    ;

expression_list:%empty
    |expression
    | expression tCOMMA expression_list
    ;

condition:
    expression
    |expression tEQ expression {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(EQ,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | expression tNE expression  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(NE,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | expression tLT expression  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(LT,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | expression tGT expression  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(GT,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | expression tGE expression  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(GE,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | expression tLE expression  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(LE,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | condition tAND condition  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(AND,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | condition tOR condition  {getTemp(); putInstruction(POP,"r1"); putInstruction(POP,"r0"); putInstruction(OR,"r0 r0 r1");  putInstruction(PUSHR, "r0");}
    | tNOT condition  {getTemp(); putInstruction(POP,"r0"); putInstruction(NOT,"r0 r0");  putInstruction(PUSHR, "r0");}
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