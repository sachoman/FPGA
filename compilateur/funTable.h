#ifndef FUNTABLE
#define FUNTABLE


typedef struct{
    char nom[128];
    int ligne;
}cellFun;

typedef struct funliste{
    cellFun cell;
    struct funliste * suivant;
} funliste;

typedef  struct {
    funliste * liste;
}funtable;


void createFunTS(void);
/*Push un élément dans la table des symboles*/

void pushFun(char * , int );

/*Récupère l'offset d'un élément par rapport au stack pointer dans la pile*/

int getfun(char* );

int getFunListe(funliste** , char*);

#endif