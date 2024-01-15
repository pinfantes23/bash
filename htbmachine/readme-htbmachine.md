# Herramienta de Gestíon de Máquinas Hack the box basadas en el curso de Savitar

Este script Bash proporciona una herramienta en linea de comandos para gestiononar y obtener información sobre las máquinas de Hack the Box. Permite buscar máquinas por nombre, dirección IP,dificultad, sistema operativo, habilidad y obtener enlaces de resolución en youtube.

## Autor 
    - Pedro Infantes

## Requisitos previos
    - Bash
    - Curl
    - js-beautify

# Uso 
    Bash        

    ./htb-tool.sh [opciones]

OPCIONES 
    -m NombredeMaquina
    -u Actualizar archivos de máquinas
    -i DireccionIP Buscar por DireccionIP
    -y NombredeMaquina Obtener enlace para resolución ded youtube
    -d Dificultad Buscar por la dificultad de la máquina
    -o SistemaOperativo buscar por el sistema operativo de la máquina.
    -s Habilidad buscar por habilidad (Skill)

