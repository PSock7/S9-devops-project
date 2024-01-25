#!/bin/bash
while true; do
        status=$(kubectl get pod -l app=gowebapi -n developpement -o=jsonpath='{.items[0].status.phase}')
        if [ "$status" == "Running" ]; then
            echo "Le pod gowebapi est en cours d'exécution."
            break
        else
            echo "En attente que le pod gowebapi soit en cours d'exécution..."
            sleep 10
        fi
    done
    sleep 10
a=$(minikube service gowebapi --url -n developpement)
curl "$a/whoami"
