scripts_shell-et-playbooks

Ce repo est répertorie des scripts shell, ansible(playbooks), terraform et docker-compose pour des déploiements rapides.

## Explication du playbook du repo

Le playbook permet de déployer tous les services définis en tant que variables via leur script d'installation respectif

## Explication des Tags

Chaque bloc de tâches est associé à un tag correspondant au service qu'il installe.

Par exemple, le tag **docker** est associé aux tâches d'installation du service Docker.

Pour exécuter uniquement les tâches associées à un service spécifique, vous pouvez utiliser le paramètre --tags lors de l'exécution du playbook.

## Exemples d'Exécution

1. Pour exécuter uniquement les tâches liées à Docker :

**ansible-playbook -i inventory nom_du_playbook.yml --tags docker**

2. Pour exécuter les tâches liées à Docker et Jenkins :

**ansible-playbook -i inventory playbook.yml --tags "docker,jenkins"**

3. Pour exécuter toutes les tâches :

**ansible-playbook -i inventory playbook.yml**
