#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "tablesymboles.h"

tablesymboles t;

void createTS(void){
    t.profondeurCourante = 0;
    t.liste = NULL;
}

void addProf(){
    (&t)->profondeurCourante = (&t)->profondeurCourante +1;
}

/*Push un élément dans la table des symboles*/

void push(char * nom, bool init, char * type){
    int prof = t.profondeurCourante;
    cell c;
    c.init = init;
    strcpy(c.nom, nom); 
    strcpy(c.type, type);
    c.prof = prof;
    liste *l = malloc(sizeof(liste));
    l->cell = c;
    l->suivant = t.liste;
    t.liste = l;
}
void pushparam(char * nom, bool init, char * type){
    int prof = t.profondeurCourante+1;
    cell c;
    c.init = init;
    strcpy(c.nom, nom); 
    strcpy(c.type, type);
    c.prof = prof;
    liste *l = malloc(sizeof(liste));
    l->cell = c;
    l->suivant = t.liste;
    t.liste = l;
}



/*Retire 1 à la profondeur de la atble des symboles et supprime les entrées hors scope*/
void profMoinsListe(liste ** l, int prof) {
    if (*l != NULL){
        if ((*l)->cell.prof == prof){
            liste * suivant = (*l)->suivant;
            free(*l);
            (*l) = suivant;
            profMoinsListe(l, prof);
        }
        else{
            profMoinsListe(&((*l)->suivant), prof);
        }
    }
}
void profMoins(){
    int prof = (&t)->profondeurCourante;
    (&t)->profondeurCourante--;
    profMoinsListe(&(t.liste), prof);
}

/*Récupère l'offset d'un élément par rapport au stack pointer dans la pile*/

int get(char* nom){
    return getListe(&((&t)->liste), nom, 0);
}

int getListe(liste** l, char*nom, int offset){
    if (*l == NULL){
        printf("Erreur de compilation : variable \"%s\" non déclarée avant affectation \n", nom);
        exit(-1);
    }
    else{
        if (strcmp((*l)->cell.nom, nom) == 0){
            return offset;
        }
        else{
            return getListe(&((*l)->suivant), nom, offset+sizeTS((*l)->cell.type));
        }
    }
}

/*Définit la taille des données dans la pile*/

int sizeTS(char * type){
    if (strcmp(type,"int")){
        return INT_SIZE;
    }
    else{
        return 1;
    }
}

/*affiche la ts*/


void printTsListe(liste ** l) {
    if (*l != NULL){
        printf("nom : %s - init : %d - type : %s - prof : %d\n", (*l)->cell.nom, (*l)->cell.init, (*l)->cell.type, (*l)->cell.prof);
        printTsListe(&((*l)->suivant));
    }
}

void printTs(){
    printf("-- Print de la TS --  \n");
    printTsListe(&((&t)->liste));
}

int getProf(){
    return t.profondeurCourante;
}

void pushTemp(){
    push("cou cou", 0, "int");
}

void getTemp(){
    liste ** l = &(t.liste);
    liste * suivant = (*l)->suivant;
    free(*l);
    (*l) = suivant;
}
