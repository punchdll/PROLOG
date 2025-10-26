#!/bin/bash

#Generador de arbol de README

file="README.md"
language="bash"
header="# PROGRAMACIÓN LÓGICA Y FUNCIONAL AGOSTO-DICIEMBRE 2025"
code_sign='```'
new_line="\n"

code_header="${code_sign}${language}${new_line}"
code_footer="\n${code_sign}${new_line}"  

green_text="\e[32m"
red_bg_text="\e[41m"
yellow_text="\e[33m"
reset_color="\e[0m"

if [ ! command -v tree &> /dev/null ]; then
    echo -e "${red_bg_text}ERROR:${reset_color} NOT OK. BYE."
    exit 1
else
    echo -e "Tree:${green_text} OK${reset_color}"
fi

if [ ! -f $file ]; then
    echo -e "File: ${red_bg_text}NOT OK${reset_color}"
    echo "Creando..."
    echo -e "File: ${green_text} OK${reset_color}"
else
    echo -e "File: ${green_text} OK${reset_color}" 
fi

(   
    echo "$header";
    echo -e "> "$(date) "\n";
    echo -e "$code_header";
    tree;
    echo -e "$code_footer"

    )> README.md

echo -e "Codigo generado: ${yellow_text}$(date)${green_text} OK${reset_color}" 