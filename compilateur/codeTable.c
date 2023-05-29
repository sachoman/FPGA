#include "codeTable.h"
#include "funTable.h"

void exportTable(void) {
    FILE * f;
    f = fopen("output.s", "w");
    instruction * instructionCourante;
    instruction * instToFree;
    instructionCourante = instructionqueue.firstInstruction;
    fprintf(f, "JUMP ");
    char str[1024];
    sprintf(str,"%d",getfun("main"));
    fputs(str,f);
    fprintf(f,"\n");
    instToFree = instructionCourante;
    instructionCourante = instructionCourante->next;
    free(instToFree);
    while(instructionCourante != NULL) {
        enum opcode op = instructionCourante->opcode;
        if (op == ADD) {
            fprintf(f,"ADD ");
        }
        if (op == MUL) {
            fprintf(f,"MUL ");
        }
        if (op == DIV) {
            fprintf(f,"DIV ");
        }
        if (op == SUB) {
            fprintf(f,"SUB ");
        }
        if (op == PUSHR) {
            fprintf(f,"PUSHR ");
        }
        if (op == PUSHSP) {
            fprintf(f,"PUSHSP ");
        }
        if (op == PUSHV) {
            fprintf(f,"PUSHV ");
        }
        if (op == POP) {
            fprintf(f,"POP ");
        }
        if (op == STORE) {
            fprintf(f,"STORE ");
        }
        if (op == LOADSP) {
            fprintf(f,"LOADSP ");
        }
        if (op == LOADBP) {
            fprintf(f,"LOADBP ");
        }
        if (op == JUMP) {
            fprintf(f,"JUMP ");
        }
        if (op == JUMPCOND) {
            fprintf(f,"JUMPCOND ");
        }
            if (op == JUMPNOTCOND) {
            fprintf(f,"JUMPNOTCOND ");
        }
                if (op == EQ) {
            fprintf(f,"EQ ");
        }
                if (op == NE) {
            fprintf(f,"NE ");
        }
                if (op == LT) {
            fprintf(f,"LT ");
        }
                if (op == GT) {
            fprintf(f,"GT ");
        }
                if (op == GE) {
            fprintf(f,"GE ");
        }
                if (op == LE) {
            fprintf(f,"LE ");
        }
                if (op == AND) {
            fprintf(f,"AND ");
        }
                if (op == OR) {
            fprintf(f,"OR ");
        }
                if (op == NOT) {
            fprintf(f,"NOT ");
        }
        printf("opcode : %d",op);
        fputs(instructionCourante->nom,f);
        fprintf(f,"\n");
        instToFree = instructionCourante;
        instructionCourante = instructionCourante->next;
        free(instToFree);
    }
    fclose(f);
}

void createInstructionQueue(void) {
    instructionqueue.nbInstructions = 0;
    instructionqueue.lastInstruction = NULL;
    instructionqueue.firstInstruction = NULL;
}

void putInstruction(enum opcode opcode, char * nom) {
    instruction * inst = malloc(sizeof(instruction));
    inst->next = NULL;
    strcpy(inst->nom,nom);
    inst->opcode = opcode;
    if (instructionqueue.firstInstruction == NULL) {
        instructionqueue.firstInstruction = inst;
    } else {
        instructionqueue.lastInstruction->next = inst;
    }
    instructionqueue.lastInstruction = inst;
    instructionqueue.nbInstructions++;
}

void modifyInstruction(instruction * inst, char * nom) {
    strcpy(inst->nom , nom);
}

void empile(instruction * inst){
    if (pileJumpVide){
        pilejump.jumpInstruction = inst;
        pilejump.next = NULL;
        pileJumpVide = false;
    }
    else{
        pileJump * next = malloc(sizeof(pileJump));
        *next = pilejump;
        pilejump.jumpInstruction = inst;
        pilejump.next = next;
    }
}

int getNbInstructions(void){
    return instructionqueue.nbInstructions;
}

void depile(int offset){
    if (pileJumpVide){
        printf("erreur pile vide \n");
        exit(-1);
    }
    instruction * inst = pilejump.jumpInstruction;
    pileJump * next = pilejump.next;
    if (next == NULL){
        pileJumpVide = true;
    }
    else{
        pilejump.jumpInstruction = pilejump.next->jumpInstruction;
        pilejump.next = next->next;
        free(next);
    }
    char tmp[128];
    sprintf(tmp,"%d", getNbInstructions()+1+offset);
    strcpy(inst->nom, tmp);
}

void empileRet(instruction * inst){
    if (pileJumpRetVide){
        pilejumpret.jumpretInstruction = inst;
        pilejumpret.next = NULL;
        pileJumpRetVide = false;
    }
    else{
        pileJumpRet * next = malloc(sizeof(pileJumpRet));
        *next = pilejumpret;
        pilejumpret.jumpretInstruction = inst;
        pilejumpret.next = next;
    }
}

void depileRet(){
    if (pileJumpRetVide){
        printf("erreur pile vide \n");
        exit(-1);
    }
    instruction * inst = pilejumpret.jumpretInstruction;
    pileJumpRet * next = pilejumpret.next;
    if (next == NULL){
        pileJumpRetVide = true;
    }
    else{
        pilejumpret.jumpretInstruction = pilejumpret.next->jumpretInstruction;
        pilejumpret.next = next->next;
        free(next);
    }
    char tmp[128];
    sprintf(tmp,"%d", getNbInstructions()+1);
    strcpy(inst->nom, tmp);
}

instruction * getLastInstruction(void){
    return instructionqueue.lastInstruction;
}

void empile_while(){
    if (pileWhileVide){
        pilewhile.inst = getNbInstructions();
        pilewhile.next = NULL;
        pileWhileVide = false;
    }
    else{
        pileWhile * next = malloc(sizeof(pileWhile));
        *next = pilewhile;
         pilewhile.inst = getNbInstructions()+1;
        pilewhile.next = next;
    }
}

int depile_while(void){
    if (pileWhileVide){
        printf("erreur pile while vide \n");
        exit(-1);
    }
    int inst = pilewhile.inst;
    pileWhile * next = pilewhile.next;
    if (next == NULL){
        pileWhileVide = true;
    }
    else{
        pilewhile.inst = pilewhile.next->inst;
        pilewhile.next = next->next;
        free(next);
    }
    return inst;
}