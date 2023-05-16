%option noyywrap
%option noinput
%option nounput

ALPHA [a-zA-Z]
DIGIT [0-9]

%{
    // Supra : sorte de DEFINE

    #include <stdio.h> // Utilisé pour ouvrir un fichier avec fopen
    #include <stdlib.h>
    #include "lex.tab.h"

    int yylex(void);
    void yyerror(const char *);

    int result;
%}


%%

"//"(.)*\n {} // Commentaires simples (comme celui-ci) --> on ne fait rien
"/*"([^*]|(\*+[^*/]))*\*+"/" {} /* Commentaires complexes (comme celui-ci) --> on ne fait rien */
"if" {return tIF;}
"else" {return tELSE;}
"while" {return tWHILE;}
"print" {return tPRINT;}
"return" {return tRETURN;}
"int" {return tINT;}
"void" {return tVOID;}
"+" {return tADD;}
"-" {return tSUB;}
"*" {return tMUL;}
"/" {return tDIV;}
"<" {return tLT;}
">" {return tGT;}
"!=" {return tNE;}
"==" {return tEQ;}
">=" {return tGE;}
"<=" {return tLE;}
"=" {return tASSIGN;} // tAFFECTATION sur Moodle
"&&" {return tAND;}
"||" {return tOR;}
"!" {return tNOT;}
"{" {return tLBRACE;}
"}" {return tRBRACE;}
"(" {return tLPAREN;}
")" {return tRPAREN;}
";" {return tSEMI;}
"," {return tCOMMA;}
0[xX][0-9a-fA-F]+  {yylval.NUMBER = (int)strtol(yytext, NULL, 16); return tNB;}
{DIGIT}* {yylval.NUMBER = atoi(yytext); return tNB;}
{ALPHA}({ALPHA}|{DIGIT})* {strcpy(yylval.IDENTIFIER,yytext); return tID;}
" " {} // Rien de particulier
"\n" {} // Rien de particulier
. {yyerror(yytext);}

%%