#!/bin/bash

latexmk -pdf -auxdir=file -outdir=file laboratoire
shopt -s extglob
mv file/*.!(pdf) file/aux
