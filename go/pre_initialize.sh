#!/bin/bash
set -xu -o pipefail

CURRENT_DIR=$(cd $(dirname $0);pwd)
cd $CURRENT_DIR

rm -f image/*__ISUCONDITION__*
