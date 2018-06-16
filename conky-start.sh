#!/bin/bash

#Carregador do Conky
sleep 15s
killall conky
cd "/opt/conky"
conky -c "/opt/conky/conky-grey.conf" &
