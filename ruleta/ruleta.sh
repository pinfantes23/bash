#!/bin/bash
#
# Author: Pedro Infantes
#

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
 echo -e "\n\n${redColour}[!] Saliendo... ${endColour}\n"
 tput cnorm; exit 1
}

#ctrl c
trap ctrl_c INT

function martingala(){

  echo -e "${yellowColour}[+]${endColour}${grayColour} Dinero actual:${endColour}${yellowColour} $money € ${endColour} \n"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿Cuánto dinero tienes pensado apostar?${endColour}${redColour} ->${endColour} " && read initial_bet
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A qué deseas apostar continuamente${endColour}${redColour}(${endColour}${purpleColour}par/impar${endColour}${redColour})${endColour}${grayColour}? ->${endColour} " && read par_impar
  echo -e "${yellowColour}[+]${endColour}${grayColour} Vamos a jugar con una cantidad inicial de ${endColour} ${yellowColour}$initial_bet €${endColour}${grayColour} a${endColour} ${redColour} $par_impar ${endColour}\n"

  backup_bet=$initial_bet
  play_counter=1
  jugadas_malas="[ "
  play_money_more=$initial_bet

  tput civis
  while true; do 
    money=$(($money-$initial_bet))
   # echo -e "${yellowColour}[~]${endColour}${grayColour} Acabas de apostar${endColour}${yellowColour} $initial_bet €${endColour}${grayColour} y te quedan ${endColour} ${yellowColour}$money €${endColour}"
    random_number="$(($RANDOM % 37))"
    #echo -e "${yellowColour}[~]${endColour}${grayColour} Ha salido el número: ${endColour} ${purpleColour} $random_number${endColour}\n"

   if [ ! "$money" -lt 0 ]; then
      if [ "$par_impar" == "par" ]; then
        #Todo esto es para apostar numeros pares
         if [ "$(($random_number % 2))" -eq 0 ]; then
           if [ "$random_number" -eq 0 ]; then
              #echo -e "${redColour}\t[-]${endColour}${redColour} Ha salido 0 por lo tanto,${endColour}${redColour} pierdes.${endColour}\n" 
              initial_bet=$(($initial_bet*2))
              jugadas_malas+="$random_number "
             # echo -e "${redColour}\t[-]${endColour}${grayColour} Ahora mismo te queda${endColour}${yellowColour} ${money} €${endColour}\n "
           else
              #echo -e "${yellowColour}\t[+]${endColour}${grayColour} El número que ha salido es ${endColour}${blueColour} par${endColour}${grayColour},${endColour}${greenColour}¡ganas!${endColour}${grayColour}.${endColour}" 
              reward=$((initial_bet*2))
              #echo -e "${yellowColour}\t[+]${endColour}${grayColour} Ganas un total de ${endColour}${yellowColour}$reward € ${endColour}"
              money=$(($money+$reward))

              if [ money > play_money_more ]; then
                play_money_more=$money
              fi
              # echo -e "${yellowColour}\t[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money € ${endColour}\n"
              initial_bet=$backup_bet
              jugadas_malas="[ "
           fi
         else
          # echo -e "${redColour}\t[-]${endColour}${grayColour} El número que ha salido es${endColour}${blueColour} impar${endColour}${grayColour},${endColour}${redColour} pierdes.${endColour}"
           initial_bet=$(($initial_bet*2))
           jugadas_malas+="$random_number "
          # echo -e "${redColour}\t[-]${endColour}${grayColour} Ahora mismo te queda${endColour}${yellowColour} ${money} €${endColour}\n "
         fi
      else
        #Todo esto es para apostar números impares
        if [ "$(($random_number % 2))" -eq 1 ]; then
          reward=$((initial_bet*2))
          money=$(($money+$reward))

          if [ money > play_money_more ]; then
            play_money_more=$money
          fi

          initial_bet=$backup_bet
          jugadas_malas="[ "
         else     
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "     
        fi
      fi
    else
      #Nos quedamos sin dinero
      echo -e "\n${redColour}[!] Te has quedado sin pasta ${endColour}\n"
      echo -e "${yellowColour}[~]${endColour}${grayColour} Han habido un total de ${endColour} ${redColour}$(($play_counter-1))${endColour}${grayColour} jugadas${endColour}"
      echo -e "${redColour}[-]${endColour}${grayColour} A continuación se van a representar las malas jugadas consecutivas que han salido:${endColour} \n"
      echo -e "${blueColour} $jugadas_malas]${endColour}\n"

      echo -e "${redColour}[~]${endColour}${purpleColour}La vez que más dinero tuve fue: ${endColour}${yellowColour}$play_money_more €${endColour}"


      tput cnorm; exit 0
   fi
    let play_counter+=1
  done

  tput cnorm #Recuperamos el cursor

}

function inverseLabrouchere(){
  
  echo -e "\n"
  echo -e "${yellowColour}[+]${endColour}${grayColour} Dinero actual:${endColour}${yellowColour} $money € ${endColour} \n" 
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A qué deseas apostar continuamente${endColour}${redColour}(${endColour}${purpleColour}par/impar${endColour}${redColour})${endColour}${grayColour}? ->${endColour} " && read par_impar

  declare -a my_sequence=(1 2 3 4)

  echo -e "\n${yellowColour}[~]${endColour}${grayColour} Comenzamos con la secuencia ${endColour}${blueColour}[${my_sequence[@]}]${endColour}"

  bet=$((${my_sequence[0]} + ${my_sequence[-1]}))

  jugadas_totales=0
  bet_to_renew=$(($money+50)) #dinero que cuando se alcance se renueva la secuencia
  
  echo -e "${yellowColour}[+]${endColour}${grayColour} El tope a renovar la secuencia está establecido en ${endColour}${yellowColour}$bet_to_renew €${endColour}"


  tput civis
  while true; do

    let jugadas_totales+=1
    random_number=$(($RANDOM % 37))
    money=$(($money - $bet))
    
    if [ ! "$money" -lt 0 ]; then
      echo -e "${yellowColour}[+]${endColour}${grayColour} Invertimos${endColour}${yellowColour} $bet € ${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} Tenemos ${endColour}${yellowColour} $money € ${endColour}"
      echo -e "\n${yellowColour}[~]${endColour}${grayColour} Ha salido el número ${yellowColour}$random_number ${endColour}"

      if [ "$par_impar" == "par" ]; then
        if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
          echo -e "${yellowColour}[+] ${endColour}${grayColour}El numero es par ${endColour}${greenColour}ganas${endColour}"
          reward=$((bet*2))
          let money+=$reward
          echo -e "${yellowColour}[+] ${endColour}${grayColour}Tienes ${endColour}${yellowColour}$money €${endColour}"

          if [ $money -gt $bet_to_renew ]; then
            echo -e "${yellowColour}[+] ${endColour}${grayColour} Nuestro dinero a superado el de ${endColour}${yellowColour}$bet_to_renew € ${endColour} ${grayColour} establecidos para renovar nuestra secuencia ${endColour}"
            bet_to_renew=$((bet_to_renew + 50))
            echo -e "${yellowColour}[+]${endColour}${grayColour} El tope se ha establecido en ${endColour}${yellowColour}$bet_to_renew € ${endColour}"
            my_sequence=(1 2 3 4)
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            echo -e "${yellowColour}[~]${endColour} ${grayColour}La secuencia ha sido restablecida a: ${endColour} ${blueColour} [${my_sequence[@]}] ${endColour}" 
          else
            my_sequence+=($bet)
            my_sequence=(${my_sequence[@]})

            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es ${endColour}${blueColour}[${my_sequence[@]}]${endColour}"
            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia ${endColour}"
              my_sequence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a ${endColour}${blueColour}[${my_sequence[@]}] ${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          fi         
          elif [ "$((random_number % 2))" -eq 1 ] || [ "$random_number" -eq 0 ]; then
            if [ "$((random_number % 2))" -eq 1 ]; then
              echo -e "${redColour}[-] El número es impar, pierdes. ${endColour}"
            else
             echo -e "${redColour}[-] El número es 0, pierdes. ${endColour}"
            fi
            if [ $money -lt $((bet_to_renew-100)) ]; then
              echo -e "${yellowColour}[+]${endColour}${redColour} Hemos llegado a un mínimo crítico, se procede a reajustar el tope.${endColour}"
              bet_to_renew=$(($bet_to_renew - 50))
              echo -e "${yellowColour}[+]${endColour}${grayColour} El tope ha sido renovado a ${endColour}${yellowColour}$bet_to_renew €${endColour}"
              unset my_sequece[0]
              unset my_sequence[-1] 2>/dev/null

              my_sequence=(${my_sequence[@]})

              echo -e "${yellowColour}[+]}${endColour}${grayColour} Nuestra nueva secuencia es ${endColour}${blueColour}[${my_sequence[@]}]${endColour}"
              if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
                bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
              elif [ "${#my_sequence[@]}" -eq 1 ]; then
               bet=${my_sequence[0]}
              else 
                echo -e "${redColour}[!]${endColour}${grayColour} Hemos perdido nuestra secuencia ${endColour}"
                my_sequence=(1 2 3 4)
                echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos nuestra secuencia a ${endColour}${blueColour}[${my_sequence[@]}]${endColour}"
                bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
              fi
            else
              unset my_sequence[0]
              unset my_sequence[-1] 2>/dev/null  
              
              my_sequence=(${my_sequence[@]})
        
              echo -e "${yellowColour}[~]${endColour} ${grayColour}La secuencia ahora es:${endColour} ${blueColour} [${my_sequence[@]}] ${endColour}"
              if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
                bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
              elif [ "${#my_sequence[@]}" -eq 1 ]; then
                bet=${my_sequence[0]}
              else
                echo -e "${redColour}[!]${endColour} ${grayColour}Hemos perdido la secuencia${endColour}"
                my_sequence=(1 2 3 4)
                echo -e "${yellowColour}[+]${endColour} ${grayColour}Restablecemos la secuencia a ${endColour} ${blueColour}[${my_sequence[@]}] ${endColour}"
                bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
              fi
            fi 
          fi
        fi
    else 
      echo -e "\n${redColour}[!] Te has quedado sin pasta ${endColour}\n"
      echo -e "$yellowColour[~]${endColour}${grayColour} En total han habido ${endColour} ${blueColour}$(($jugadas_totales-1)) ${endColour} ${grayColour}jugadas totales${endColour}"
      tput cnorm; exit 1
    fi
  
  done

  tput cnorm
}

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}${purpleColour} $0${endColour}\n"
  echo -e "\t${purpleColour}-m)${endColour}${grayColour} Dinero con el que se desea jugar${endColour}"
  echo -e "\t${purpleColour}-t)${endColour}${grayColour} Técnicas${endColour}${redColour}:${endColour}${purpleColour} (martingala/inverseLabrouchere)${endColour}\n"

  exit 1

}
while getopts "m:t:h" arg; do 
  case $arg in 
    m) money=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;
  esac
done

if [ $money ] && [ $technique ]; then
  if [ "$technique" == "martingala" ]; then
    martingala
  elif [ "$technique" == "inverseLabrouchere" ]; then
   inverseLabrouchere
  else
   echo -e "\n${redColour}[!] La técnica introducida no existe ${endColour}"
   helpPanel
  fi
else
  helpPanel
fi
