def assembleur_vers_binaire(chemin_fichier_assembleur, chemin_fichier_binaire):
    with open(chemin_fichier_assembleur, 'r') as fichier_assembleur:
        lignes_assembleur = fichier_assembleur.readlines()
        
    instructions_binaires = []
    
    for ligne in lignes_assembleur:
        instruction_binaire = assembler_ligne(ligne)
        instructions_binaires.append(instruction_binaire)
        
    with open(chemin_fichier_binaire, 'wb') as fichier_binaire:
        for instruction_binaire in instructions_binaires:
            fichier_binaire.write(instruction_binaire)
            
    print("Conversion terminée avec succès.")


def assembler_ligne(ligne_assembleur):
    # Ajoute le code nécessaire pour convertir une ligne assembleur en binaire
    # Utilisez les opérations appropriées pour décoder les instructions
    
    instructions = ligne_assembleur.split()

    instruction_binaire = b''  # Utilisation de bytes pour stocker les données binaires
    
    # Ajoutez votre logique de conversion ici
    
    return instruction_binaire


# Exemple d'utilisation
fichier_assembleur = 'output.s'
fichier_binaire = 'binaire'
assembleur_vers_binaire(fichier_assembleur, fichier_binaire)

print()
print("  toto sf s   sdg".split())
