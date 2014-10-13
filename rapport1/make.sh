#!/bin/bash

latexmk -pdf -auxdir=file -outdir=file rapport1
shopt -s extglob
mv file/*.!(pdf) file/aux
