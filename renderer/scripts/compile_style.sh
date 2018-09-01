#!/usr/bin/env bash

# Compiling carto css style and generates OSM xml
# that can be passed to mapnik.

carto /openstreetmap-carto/project.mml > /map_data/stylesheet_.xml

DS='<Parameter name=\"dbname\"><![CDATA['$PG_DBNAME']]><\/Parameter>\
    <Parameter name=\"host\"><![CDATA['$PG_HOST']]><\/Parameter>\
    <Parameter name=\"port\"><![CDATA['$PG_PORT']]><\/Parameter>\
    <Parameter name=\"user\"><![CDATA['$PG_USER']]><\/Parameter>\
    <Parameter name=\"password\"><![CDATA['$PG_PASSWORD']]><\/Parameter>'
sed "s/<Parameter name=\"dbname\">.*<\/Parameter>/${DS}/" /map_data/stylesheet_.xml > /map_data/stylesheet.xml
rm /map_data/stylesheet_.xml