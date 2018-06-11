#!/bin/bash

exe=$(dmenu_run -fn 'Zekton-9' -nb '#222D32' -nf '#2E9AFE' -sb '#2E9AFE' -sf '#222D32') && eval "exec $exe"
