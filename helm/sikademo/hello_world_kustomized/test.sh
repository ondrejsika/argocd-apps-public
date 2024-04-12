#!/bin/sh

helm template hello-world-kustomized . > all.yml && kustomize build
