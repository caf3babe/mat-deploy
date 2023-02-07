
These repo holds all helm charts used for deploying the car-rental application. Additionally a run_helm.sh script is provided which updates alle helm dependencies and installs helm charts to the currently selected cluster by the kubectl cli. 

1. Deployment success rate
    - Ausführen von 10 Deployments und Erfolgsrate festhalten
2. Rollback success rate
    - Bei nicht-erfolgreichen Deployments, festhalten von erfolgreichen Rollbacks
3. Time to deploy
    - Start und Ende des Deployments messen
    - Mit 4 in Verbindung stellen -> Ressourcenverbrauch vs Time to deploy
4. Application performance
    - CPU, Memory, Disk Usage during Deployments
    - Mit 3 in Verbindung stellen -> Ressourcenverbrauch vs Time to deploy
5. User satisfaction
    - Während den Testphasen messen, wie oft ein HTTP response > 400 retourniert wurde
6. Error rate
    - Messen von aufgetretenen Exceptions (Java) in den Logs