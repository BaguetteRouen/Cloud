# Cloud
# TP Minecraft
L'infrastructure a été construite en utilisant Terraform pour décrire les ressources AWS nécessaires, telles que les instances EC2, les subnets, les groupes de sécurité, les load balancers,.
Nous avons mis en place le code Terraform pour créer les instances EC2 te les subnets ainsi que les groupes de sécurité. Nous n’avons mis en place le load balancer sur notre projet. 


Terraform a été utilisé pour automatiser la création et la mise à jour de ces ressources, ce qui permet de construire rapidement les environnements de jeu pour les équipes au fur et à mesure de leur inscription à l'événement.
 
Ansible a été utilisé pour configurer les instances EC2 et installer les logiciels nécessaires pour exécuter le jeu Minecraft. 


AWS CloudWatch a été utilisé pour surveiller les instances EC2 et les ressources de l'infrastructure, et pour envoyer des alertes par courrier électronique dès que le CPU et la RAM dépassent 70% d'utilisation. Les données du serveur ont été sauvegardées toutes les heures et externalisées dans un bucket S3 pour assurer la durabilité des données. 

GitHub a été utilisé pour versionner le code Terraform et Ansible. Cela permet de conserver l'historique des modifications et de faciliter la collaboration entre les membres de l'équipe. Voici l’accès à notre GitHub qui contient le code de notre projet Minecraft : https://github.com/BaguetteRouen/Cloud 

Un tableau KANBAN a été utilisé pour suivre les tâches du projet sur la plateforme Trello , ce qui permet de visualiser l'avancement du projet et de planifier les tâches à venir. Il est accessible depuis ce lien : https://trello.com/b/F5hkPsUt/suivi-projet 
