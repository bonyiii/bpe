#!/bin/bash
set -e

gosu dev yarn
gosu dev npm start
#set -- gosu dev "$@"
