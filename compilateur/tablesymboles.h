#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#ifndef TABLESYMBOLES
# define TABLESYMBOLES

#define INT_SIZE 1;

typedef struct{
    char nom[128];
    bool init; //0 non init, 1 init
    char type[8];
    int prof;
}cell;

typedef struct liste{
    cell cell;
    struct liste * suivant;
} liste;

typedef  struct {
    int profondeurCourante;
    liste * liste;
}tablesymboles;

//cell pop(tablesymboles);
void createTS(void);
void push( char *, bool, char *);
void pushparam( char *, bool, char *);
void profMoins();
int get( char*);
int getListe(liste**, char*, int);
void addProf();
int sizeTS(char *);
void printTs();
int getProf();
void pushTemp();
void getTemp();

#endif
