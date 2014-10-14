#!/bin/bash

latexmk -pdf -auxdir=file -outdir=file rapport2 
shopt -s extglob
mv file/*.!(pdf) file/aux
