#include "funTable.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

funtable tfun;

void createFunTS(void){
    tfun.liste = NULL;
}

void pushFun(char * nom, int ligne){
    cellFun c;
    strcpy(c.nom, nom); 
    c.ligne = ligne;
    funliste *l = malloc(sizeof(funliste));
    l->cell = c;
    l->suivant = tfun.liste;
    tfun.liste = l;
}

/*Récupère l'adresse de la fonction*/

int getfun(char* nom){
    return getFunListe(&((&tfun)->liste), nom);
}

int getFunListe(funliste** l, char*nom){
    if (*l == NULL){
        printf("%s pa strouvéé\n",nom);
        exit(-1);
    }
    else{
        if (strcmp((*l)->cell.nom, nom) == 0){
            return (*l)->cell.ligne;
        }
        else{
            return getFunListe(&((*l)->suivant), nom);
        }
    }
}