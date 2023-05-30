#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#ifndef CODETABLE
#define CODETABLE

enum opcode {
    ADD,
    MUL,
    DIV,
    JUMP,
    SUB,
    PUSHR,
    PUSHSP,
    POP,
    STORE,
    LOADSP,
    LOADBP,
    GE,
    LE,
    AND,
    OR,
    NOT,
    PUSHV,
    JUMPCOND,
    JUMPNOTCOND,
    GT,
    LT,
    EQ,
    NE,
    LOADRET,
    JUMPR
};

typedef struct pileWhile{
    int inst;
    struct pileWhile * next;
}pileWhile;

typedef struct instruction{
    enum opcode opcode;
    char nom[128];
    struct instruction * next;
} instruction;

typedef struct instructionQueue{
    int nbInstructions;
    instruction * lastInstruction;
    instruction * firstInstruction;
} instructionQueue;


typedef struct pileJump{
    instruction * jumpInstruction;
    struct pileJump * next;
} pileJump;

instructionQueue instructionqueue;

typedef struct pileJumpRet{
    instruction * jumpretInstruction;
    struct pileJumpRet * next;
} pileJumpRet;


pileJump pilejump;
bool pileJumpVide;

pileWhile pilewhile;
bool pileWhileVide;

pileJumpRet pilejumpret;
bool pileJumpRetVide;

void empileRet(instruction *);
void depileRet();


void empile_while(void);
int depile_while(void);


void depile(int);

void createInstructionQueue(void);

void empile(instruction *);

int getNbInstructions(void);

void exportTable(void);

void putInstruction(enum opcode, char *);

instruction * getLastInstruction(void);

#endif

