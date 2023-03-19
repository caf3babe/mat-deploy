# Master Thesis Project Deployment

These repo holds all helm charts used for deploying the car-rental application. Additionally a run_helm.sh script is provided which updates alle helm dependencies and installs helm charts to the currently selected cluster by the kubectl cli. 

## Deployment of flagger and other services
```bash
# install everything for flagger
./deploy-services flagger
```

## Deploy services for spinnaker
```bash
# install everything for flagger
./deploy-services spinnaker
```