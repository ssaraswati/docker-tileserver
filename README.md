# Kubemaps
creates a render service backed by an external postgres database loaded with osm data
helm chart provided to install in a kubernetes cluster

### Build
docker build -t renderer:latest renderer

### Install
helm upgrade --install kubemaps helm

### Load Data
open a port forwarding connection with 
```
kubectl port-forward `kubectl get pod -l app=postgres -o name` 5432:5432
```
load data with osm2pgsql in a seperate terminal
```
osm2pgsql -d osm -H localhost -P 5432 --username <username> -W --create --slim --flat-nodes flat-nodes.bin <location>.osm.pbf
```
e.g.
```
osm2pgsql -d osm -H localhost -P 5432 --username mapsAdmin -W --create --slim --flat-nodes flat-nodes.bin australia-latest.osm.pbf
```