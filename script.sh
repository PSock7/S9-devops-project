#!/bin/bash
a=$(minikube service gowebapi --url -n developpement)
curl "$a/whoami"
