#!/bin/bash

latexmk -pdf -auxdir=file -outdir=file flow_sheet 
shopt -s extglob
mv file/*.!(pdf) file/aux
