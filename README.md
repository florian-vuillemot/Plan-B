# Plan-B
School project {{ EPITECH }}

## Subject summary

We have to set up a GitLab, Jenkins and SMTP server on 3 differents VMs and configures there for developers team. Moreover we have to follow infrastructure with metrics (cpu/ram/disk/latency/..) and launch alert in case of problem.

Technical documentation is provide in Azure and Salt Readme (in English). The rest of this README will be in French and not technic.

# Retour d’expérience Plan-B #Azure #Epitech

## Sujet:

Mettre en place 3 machines virtuelles:

  - Une machine avec un GitLab pour le versionning de code
  - Une machine avec un Jenkins pour faire tourner les tests et mettre en place une CI
  - Une machine avec un serveur SMTP pour l’envoie d’email

Le tout doit être relié pour travailler ensemble.

De plus il faut offrir une solution de reprise d’activité après sinistre ainsi que mettre en place un sytème d’alerting et de monitoring.

**Temps:** 3 semaines sur la période Noël et nouvel an

De plus ce n’est pas 3 semaines en temps complet. Durant le projet j’ai passé seulement 1 jour à l’école. Le reste du temps je suis en entreprise (ma formation est en alternance). J’ai donc uniquement le soir et le week-end pour travailler dessus.

## Retour d’expérience:

Le sujet est posé, passons maintenant au contenu.

### Mes objectifs:

  - Mieux prendre en main la technologie d’Azure. J’ai déjà travailler dans un environement de production avec la solution d’Amazon. Cela fait 2-3 mois que je travaille dans l’équipe Cloud d’Axa France. Seulement je n’ai pas trop eu l’occasion jusque là de réellement toucher l’infra… J’étais plus sur des sujets transverses ou extrèmement précis et totalement différent du sujet. C’est donc une super occasion pour moi d’en apprendre plus avec l’outil !
  - L’automatisation. Je souhaite pouvoir re deployer l'infra en quelques clicks.
  - Avoir le plus haut niveau d’abstraction possible. Plus je peux déléguer les services à la plateforme mieux c’est !
  - Allez le plus vite possible. C’est la période noël-nouvel an. J’ai l’occasion de rentrez revoir ma famille dans le sud de la France. Je compte bien profiter d’eux, même si je n’ai pas pu poser de jour de congé.
  - Apprendre des trucs cool et aller le plus loin possible dans le sujet. Le sujet étant très large et non restrictif j’en profite !

### L’automatisation sur Azure:

La plateforme offre de nombreuse API. Vous pouvez casiment tout faire grâce à elles. De plus lorsque vous effectuez une opération sur le portail d’Azure, on vous propose de télécharger le template dès que c’est possible. Grâce au template vous pouvez reproduire votre action manuelle de façon automatique dans de nombreux cas.


### “Quand on dit ‘trop facile’ à 9h puis que l’on y est encore à 22h”:

J’ai commencé par regarder ce que fourni la plateforme Azure pour mon projet. Et la bonne nouvelle ! Il existe déjà des templates tout fait pour créer un GitLab et un Jenkins.

Je crée donc les machines, je teste et récupère les templates. Puis les modifie en ajoutant des options comme des ouvertures de flux…

#### Première erreur :

  - D’abord on ne modifie jamais 2 choses en même temps ! Pour ceux qui ne savent pas pourquoi c’est mal je vous renvoie vers ce que je considère comme la bible de l’innovateur le “Lean Startup”.

  - A cela s’ajoute une mauvaise connaissance du produit. Je n’ai pas pris assez de temps pour découvrir le produit de façon “aléatoire”.

##### Explication:

Lorsque j’ai commencé, j’ai d’abord fait une liste de mes besoins. Ensuite j’ai regardé les solutions offertes par la plateforme. Puis en avant Guingamp je monte mes machines et réponds à mes besoins.

Mais à aucun moment je me le suis approprié. Je suis resté concentré sur “comment répondre à mes problèmes” et ce sans regarder de façon plus large ce que peut faire la plateforme pour moi. Et pourtant je suis extrément curieux... Mais pour aller vite je me suis (trop) bridé. Trouver le juste milieu productivité/décourverte n'est pas simple.

Si on revient sur les templates. Je les ai modifié à la main → grosse erreur ! En regardant en détail les services qu’Azure me fournit, j’aurai pu voir que je peux modifier une machine et ensuite re extraire les templates qui sont automatiquement mis à jour par la plateforme.

Ceci m’aurait fait gagner un grand temps. Je n’aurai pas eu besoin de reconstruire toute l’infrastructure à chaque modification de template. Avec à chaque fois le lot d’erreurs qu'une modification manuelle peut provoquer.

### “Ai-je fait le bon choix ?”:

Au fur est à mesure que le projet avance, les difficultés s’accumulent. Je sens l’usine à gaz se rapprocher. Je suis à la moitié du temps autorisé. Et je me demande de plus en plus si ma solution est la bonne et si je vais réussir à avoir une réelle solution pour la reprise d’activité après désastre. Le doute me pousse à regarder d’autres technologies comme les conteneurs et Kubernetes.

### “C’est le moment de pivoter”:

“J’ai fait un mauvais choix j’aurai du faire du Kubernetes, je change de direction”. Ok pas de problème Florian en avant. Euh… Si en fait il y a un problème! Docker tu connais un peu, Kubernetes pas du tout et sur Azure il y a un truc qui s’appel AKS. Bon du coups je sors ma machette et pars à l’aventure. Je lis, regarde des vidéos, fais des tutos… Le temps passe, c’est la nouvelle année et je me rends compte qu’il me reste 3-4 jours pour faire les containers et mettre en place cette architecture…

### “360 > 180”:

Je refais alors un pivot. Dans les faits je fais un rollback. J’ai oublié une règle importante: **No overkill**. J’ai 3 semaines, le sujet spécifie que c’est une solution pour les dévelopeurs de l’entreprise et que c’est une start-up. A priori la haute disponibilité que peut offrir une solution tel que Kubernetes n’est pas obligatoire. Ne pas confondre la reprise sur activité après sinistre et la haute disponibilité.

De plus je fais un rapide calcul de coût entre ce que GitLab préconise comme cluster pour Kubernetes + Jenkins + le serveur SMTP + les préconisations d’Azure. Je me retrouve avec 3 machines de 4VCPU et 16 GB de ram. Cela fait environ 450$ par mois. Alors que dans ma solution “d’origine” me permet d'avoir des machines de beaucoup plus faible puissance et m’en sortir pour moins de 200$ par mois. De plus, grâces à l’auto scale je peux réduire le tarif. J’ai donc de réels arguments à offrir pour ma décision. Au vue du contexte, je pense sincèrement que la solution IAAS est meilleure que la solution conteneurs. Mais cela reste un sujet à débattre bien sûr.

Ces chiffres sont à prendre avec du recul. Je n’ai pas pu faire une réelle estimation car je manque de mesure (ma solution ne fut jamais utilisée en production).

Le dernier argument: J’ai déjà un bout d’infra qui tourne avec ma solution de base. Alors qu’il me reste tout à faire avec Kubernetes. Les tutos c’est bien mais ce n’est pas la vrai vie.

### “Quand faut y aller”:

Je ne sais pas si vous avez déjà connu le “syndrome de la page blanche” ? C’est ce que j’ai ressenti chaque soir devant mon PC. Je ne savais pas que faire, par ou commencer. C’est bête j’ai perdu les derniers jours de ma dernière semaine ainsi. Pendant la journée je me disais “C’est bon ce soir je fais ça”. Puis le soir je fais rien. Perdu entre une incompréhension de ce que je dois faire et la peur de mal faire.

Cela provoque une grande perte de temps, des nuits de plus en plus courtes mais la deadline elle, est toujours la même. Quand arrive le vendredi soir dans le train je fais un peu d’introspection et me dis “Florian 2 jours de perdus car tu n’as pas su poser et borner les objectifs! Le rendu c’est dimanche il faut aller vite.”. J’ai donc pris un papier et j’ai posé de la façon la plus présice ce que je devais faire. Fini les “je devrais peut etre faire...”. Il me reste le week-end et j’ai juste réussie à mettre en place 3 Vms. Elles ne sont pas raccordé entre elles. Je n’ai pas de back up, pas de solution de reprise d’activité en cas de désastre… Pas grand chose quoi ! Puis une fois que tout est posé, un grand vide agréable apparaît. Face à chaque objectif j’ai une solution. Il suffit de faire maintenant.

Au passage je me frappe la tête contre un mur en me rappelant ce que me disait mon père ou mon ancien CTO et qui est très bien résumé en la maxime de Sénèque “il n'est pas de vent favorable pour celui qui ne sait pas où il va.”. Bref let’s go !

### “So easy ?”:

Nous sommes samedi matin. Il est temps de faire:

  - Back-up: Vm > Back-up > Programmation des back-up tous les X heures → DONE
  - Restauration d’une VM. VM > Back-up > Restauration → DONE
  - Ajouter des metrics: VM > metric > ajout CPU et network -> DONE
  - Ajouter des alerts:
    1. Ajouter des Agents sur les machines → DONE
    2. Activer la remontée des agents: VM > diagnostic settings > activer → DONE
    3. Ajouter les metrics au tableau Azure de bord → DONE
    4. Ajouter des alertes sur les metrics: Monitor > Alert > créer → DONE
  - DR: VM > disaster recovery > … un peu de config… → DONE
  - Test de failover: VM > disaster recovery > test de failober → DONE
  - DNS:
    1. IP static pour les Vms et les reseaux de back-up -> DONE
    2. DNS Zone > configuration > nommage & addressage des IP pour www|dr|prod -> DONE
  - Test de failover “pour de vrai”:
    1. Allez sur la VM > l’éteindre → DONE
    2. Aller sur le site vérifier l’indisponibilité → DONE
    3. Recevoir une alerte pour un CPU à Zero → DONE
    4. Retourner sur la VM > disaster recovery > activer le failover -> DONE
    5. Attendre que la nouvelle machine soit mise en oeuvre dans l’autre région -> DONE
    6. Changer la configuration du DNS → DONE
    7. Accèder au site, il est fonctionnelle ("ouff") → DONE

### “Le temps c’est des bières”:

Nous sommes samedi soir. J’ai pu faire tous cela en un jour. Le rendu c’est demain je ne vais pas m’attarder sur de l’automatisation. Pourquoi ? D’abord car il y a la doc dans les README du repos GitHub. Qu’il s’agit de 3 machines dont le runtime est non critique pour l’entreprise. Seul les données sont critiques.

Sans oublié qu’il me reste les confs entre GitLab, Jenkins et le serveur mail à faire. Puis j’ai 25 ans un samedi soir et j’ai pas vu ma copine de la semaine. Le code attendra !


### “L’overkill n’est pas Lean”:

Voici des problèmes des techs (femmes & hommes) que plusieurs CTO m’ont déjà remonté: “Je peux faire mieux”, “Le code n’est pas parfait”, “On peut optimiser”, “Ca peut être plus générique”… Oui Oui et Oui on peut TOUJOURS faire mieux. Mais toujours vouloir faire mieux c’est aussi perdre du temps et parfois c’est pas franchement utile. Je pourrais ne pas dormir de la nuit, faire des scripts et reproduire cette infra en scripts pour la re générer la prochaine fois instantanément comme j’avais prévu au début. Alors oui il y a plein de scripts qui sont nécessaires comme l’installation des Vms, les configs networks… Mais mettre en place la solution de DR en scripts ce n’est pas actuellement trivial. Bon évidement j’ai regardé comment faire... Le temps que j’ai pris pour comprendre comment l’implémenter est supérieur au temps que j’ai pris pour le faire depuis le portail puis le documenter dans le README puis me faire un café puis… Sachant que ce n’est pas une action quotidienne sur le projet je pense pouvoir dire qu’automatiser est ici une perte de temps.

Quand on est passionné on veut toujours la perfection. Mais la perfection est une métrique difficile à analyser car intréquement liée à nos émotions. C’est la principal divergence avec le business. Le business veut des choses fonctionnelles. Il ne veut pas perdre de temps et ce parfois au détriment du futur. Les deux extrémes ne sont pas bons, il faut trouver un juste milieu.

### Une petite conclusion ?

Comme on dit en Python “Simple is better than complex”. Ca rejoint bien la mentalité lean. Avoir quelque chose de fonctionnel c’est mieux que d’avoir du parfait. Attention à ne pas tomber dans la dérive de l’Infra As Code en souhaitant tout automatiser. Les outils fournis par les cloud providers font une bonne partie du travail, il ne faut pas les négliger sous peine de perdre du temps. Il faut adapter la solution à son problème.

### On en reste là ?

Maintenant que le projet est terminé je vais débrifer avec les gens du boulot. Des personnes qui maitrisent Azure (il y a des consultants Microsoft dans le lot). Je vais leur exposer le sujet, les problèmes rencontrés et je vais leur dire “et toi comment aurais tu fait ?”. Je pense qu’il est plus formateur d’apprendre de ses erreurs pour ne pas les reproduire, que de se laisser guider et de manquer ses apprentissages. De plus, à présent que c’est réalisé – et que ça fonctionne – je peux challenger ma solution. L’échange pourra donc être bi-directionnel de "sachant" vers "apprenant" et pas juste de "sachant" à" novice".
