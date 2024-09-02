#!/bin/bash

#Colours
greenColour="\e[0;32m"
yerbaMateGreenColour="\e[38;5;107m" # Verde yerba mate
mediumGreenColour="\e[38;5;28m"     # Verde intermedio
lightMediumGreenColour="\e[38;5;34m" # Verde claro (más claro que el intermedio)
darkGreenColour="\e[38;5;22m"       # Verde oscuro
endColour="\e[0m"
redColour="\e[0;31m"
blueColour="\e[0;34m"
yellowColour="\e[0;33m"
purpleColour="\e[0;35m"
turquoiseColour="\e[0;36m"
grayColour="\e[0;37m"
orangeColour="\e[38;5;214m"        # Naranja
lightCyanColour="\e[38;5;159m"     # Cian claro

function ctrl_c(){
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm && exit 1
}

# Ctrl + c
trap ctrl_c INT

# Functions

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}"
  echo -e "\t${purpleColour}m)${endColour}${grayColour} Ingresar la cantidad de dinero que se desea usar${endColour}"
  echo -e "\t${purpleColour}t)${endColour}${grayColour} Tecnica a utilizar (${endColour}${yellowColour}martingala${endColour}${grayColour}/${endColour}${yellowColour}inverseLabouchere${endColour}${grayColour})${endColour}"
  echo -e "\t${purpleColour}h)${endColour}${grayColour} Mostrar panel de ayuda${endColour}\n"
}

function martingala(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual: ${endColour}${yellowColour}$money$ ${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿Cuanto dinero queries apostar? ->${endColour} " && read initial_bet
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A que deseas apostar continuamente (par/impar)? ->${endColour} " && read par_impar

#  echo -e "\n${turquoiseColour}[+]${endColour}${grayColour} Vamos a jugar con una cantidad inicial de ${grayColour}${yellowColour}$initial_bet$ ${endColour}a ${yellowColour}$par_impar${endColour}"

  backup_bet=$initial_bet
  play_counter=0
  par_counter=0
  impar_counter=0
  ceros_counter=0
  jugadas_malas=""

  tput civis
  while true; do

    money=$(($money - $initial_bet))
#    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar${endColour}${yellowColour} $initial_bet$ ${grayColour}y tienes ${endColour}${yellowColour}$money$ ${endColour}"
    random_number="$(($RANDOM % 37))"
#    echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el numero ${endColour}${yellowColour}$random_number${endColour}"
    apuesta=$initial_bet

    if [ "$money" -gt 0 ]; then
      if [ "$par_impar" == "par" ]; then
        # Ejecucion de apostar a par
        if [ "$(($random_number % 2))" -eq 0 ]; then
          if [ "$random_number" -eq 0 ]; then
#            echo -e "${yellowColour}[+]${endColour}${redColour} Ha salido el 0, perdiste${endColour}"
            initial_bet=$(($initial_bet*2))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste: ${endColour}${redColour}$apuesta$ ${endColour}"
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora tienes: ${endColour}${redColour}$money$ ${endColour}"
            let ceros_counter+=1
            jugadas_malas+="$random_number "
          else
#            echo -e "${yellowColour}[+]${endColour}${mediumGreenColour} El numero que ha salido es par, ¡¡ganaste!!${endColour}"
            reward=$(($initial_bet*2))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ganaste: ${endColour}${mediumGreenColour}$reward$ ${endColour}"
            money=$(($money+$reward))
#            echo -e "$yellowColour[+]${endColour}${grayColour} Tienes: ${endColour}${mediumGreenColour}$money$ ${endColour}"
            let par_counter+=1
            initial_bet=$backup_bet
            jugadas_malas=""

            money_max=0
            if [ $money -gt $money_max ]; then
              let money_max=$money
            fi
          fi
        else
#          echo -e "${yellowColour}[+]${endColour}${redColour} El numero que ha salido es impar, perdiste :(${endColour}"
          initial_bet=$(($initial_bet*2))
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste: ${endColour}${redColour}$apuesta$ ${endColour}"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora tienes: ${endColour}${redColour}$money$ ${endColour}"
          let impar_counter+=1
          jugadas_malas+="$random_number "
        fi
      elif [ "$par_impar" == "impar" ]; then
        # Ejecucion de apostar a impar
        if [ "$(($random_number % 2))" -eq 1 ]; then
          if [ "$random_number" -eq 0 ]; then
#            echo -e "${yellowColour}[+]${endColour}${redColour} Ha salido el 0, perdiste${endColour}"
            initial_bet=$(($initial_bet*2))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste: ${endColour}${redColour}$apuesta$ ${endColour}"
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora tienes: ${endColour}${redColour}$money$ ${endColour}"
            let ceros_counter+=1
            jugadas_malas+="$random_number "
          else
#            echo -e "${yellowColour}[+]${endColour}${mediumGreenColour} El numero que ha salido es impar, ¡¡ganaste!!${endColour}"
            reward=$(($initial_bet*2))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ganaste: ${endColour}${mediumGreenColour}$reward$ ${endColour}"
            money=$(($money+$reward))
#            echo -e "$yellowColour[+]${endColour}${grayColour} Tienes: ${endColour}${mediumGreenColour}$money$ ${endColour}"
            let impar_counter+=1
            initial_bet=$backup_bet
            jugadas_malas=""

            money_max=0
            if [ $money -gt $money_max ]; then
              let money_max=$money
            fi
          fi
        else
#          echo -e "${yellowColour}[+]${endColour}${redColour} El numero que ha saludo es par, perdiste :(${endColour}"
          initial_bet=$(($initial_bet*2))
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste: ${endColour}${redColour}$apuesta$ ${endColour}"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora tienes: ${endColour}${redColour}$money$ ${endColour}"
          let par_counter+=1
          jugadas_malas+="$random_number "
        fi
      else
        echo -e "\n${redColour}[!] Error, $par_impar no se reconoce como apuesta valida${endColour}"
        helpPanel
        tput cnorm; exit 1
      fi
    else
      # Se queda sin dinero
      echo -e "\n${redColour}[!] Te has quedado sin dinero suficiente para seguir jugando${endColour}\n"
      echo -e "${yellowColour}[*]${endColour}${lightCyanColour} Resumen de la partida${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Jugadas totales: ${endColour}${yellowColour}$play_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Cantidad maxima de dinero alcanzada:${endColour}${yellowColour} $money_max${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Numero pares totales:${endColour}${yellowColour} $par_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Numero impares totales:${endColour}${yellowColour} $impar_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Numero de ceros totales:${endColour}${yellowColour} $ceros_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Malas jugadas consecutivas: ${endColour}"
      echo -e "\t${blueColour}$jugadas_malas${endColour}"
      tput cnorm; exit 0
    fi

    let play_counter+=1
  done
  
  tput cnorm
}

function inverseLabouchere(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual: ${endColour}${yellowColour}$money$ ${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A que deseas apostar continuamente (par/impar)? ->${endColour} " && read par_impar

  declare -a my_sequence=(1 2 3 4)

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Comenzamos con la secuencia ${endColour}${purpleColour}[${my_sequence[@]}]${endColour}"

  bet=$((${my_sequence[0]} + ${my_sequence[-1]}))

  play_counter=0
  par_counter=0
  impar_counter=0
  ceros_counter=0
  jugadas_malas=""
  bet_to_renew=$(($money + 50)) # Dinero a alcanzar para renovar la secuencia a [1 2 3 4]
  money_max=0

#  echo -e "${yellowColour}[+]${endColour}${grayColour} El tope a renovar la secuencia esta establecido por encima de${endColour}$yellowColour $bet_to_renew$ ${endColour}"

  tput civis
  while true; do
    random_number="$(($RANDOM % 37))"
    money=$(($money - $bet))
#    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Inviertes:${endColour}${yellowColour} $bet$ ${endColour}"
#    echo -e "${yellowColour}[+]${endColour}${grayColour} Te quedan:${endColour}${yellowColour} $money$ ${endColour}"

#    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Ha salido el numero${endColour}$purpleColour $random_number${endColour}"

    if [ "$money" -gt 0 ]; then
      if [ "$par_impar" == "par" ]; then
        # Ejecucion de apostar a par
        if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
#          echo -e "${yellowColour}[+]${endColour}${mediumGreenColour} El numero que ha salido es par, ¡¡ganaste!!${endColour}"
          reward=$(($bet*2))
          let money+=$reward
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ganaste: ${endColour}${mediumGreenColour}$reward$ ${endColour}"
#          echo -e "$yellowColour[+]${endColour}${grayColour} Tienes: ${endColour}${mediumGreenColour}$money$ ${endColour}"
          if [ $money -gt $money_max ]; then
            let money_max=$money
          fi
          if [ $money -gt $bet_to_renew ]; then
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Se ha superado la meta de ${endColour}${yellowColour}$bet_to_renew$ ${endColour}${grayColour}para renovar la secuencia${endColour}"
            bet_to_renew=$(($bet_to_renew + 50))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuevo tope establecido a ${endColour}${yellowColour}$bet_to_renew$ ${endColour}"
            my_sequence=(1 2 3 4)
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia ha sido restablecida a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
          else
            my_sequence+=($bet)
            my_sequence=(${my_sequence[@]})

#            echo -e "${yellowColour}[+]${endColour}${grayColour} La nueva secuencia es${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
#              echo -e "${redColour}[!] La secuencia ha finalizado${endColour}"
              my_sequence=(1 2 3 4)
#              echo -e "${yellowColour}[+]${endColour}${grayColour} Se restablece la secuencia a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          fi
          let par_counter+=1
          jugadas_malas=""
        # Perder
        elif [ "$((random_number % 2))" -eq 1 ] || [ "$random_number" -eq 0 ]; then
          if [ "$((random_number % 2))" -eq 1 ]; then
#            echo -e "${redColour}[!] El numero que ha salido es impar, perdiste :(${endColour}"
            let impar_counter+=1
            jugadas_malas+="$random_number "
          else
#            echo -e "${redColour}[!] El numero que ha salido es 0, perdiste :(${endColour}"
            let ceros_counter+=1
            jugadas_malas+="$random_number "
          fi
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste: ${endColour}${redColour}$bet$ ${endColour}"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora tienes: ${endColour}${redColour}$money$ ${endColour}"

          if [ $money -lt $(($bet_to_renew - 100)) ]; then
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Has llegado a un minimo, se procede a reajustar el tope${endColour}"
            bet_to_renew=$(($bet_to_renew - 50))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} El tope ha sido renovado a ${endColour}${yellowColour}$bet_to_renew$ ${endColour}"

            unset my_sequence[0]
            unset my_sequence[-1] 2>/dev/null
            
            my_sequence=(${my_sequence[@]})

#            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia queda de la siguiente forma:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"

            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
#              echo -e "${redColour}[!] La secuencia ha finalizado${endColour}"
              my_sequence=(1 2 3 4)
#              echo -e "${yellowColour}[+]${endColour}${grayColour} Se restablece la secuencia a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          else
            unset my_sequence[0]
            unset my_sequence[-1] 2>/dev/null
            
            my_sequence=(${my_sequence[@]})

#            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia queda de la siguiente forma:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"

            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
#              echo -e "${redColour}[!] La secuencia ha finalizado${endColour}"
              my_sequence=(1 2 3 4)
#              echo -e "${yellowColour}[+]${endColour}${grayColour} Se restablece la secuencia a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          fi
        fi
      elif [ "$par_impar" == "impar" ]; then
        # Ejecucion de apostar a impar
        if [ "$(($random_number % 2))" -eq 1 ]; then
#          echo -e "${yellowColour}[+]${endColour}${mediumGreenColour} El numero que ha salido es impar, ¡¡ganaste!!${endColour}"
          reward=$(($bet*2))
          let money+=$reward
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ganaste: ${endColour}${mediumGreenColour}$reward$ ${endColour}"
#          echo -e "$yellowColour[+]${endColour}${grayColour} Tienes: ${endColour}${mediumGreenColour}$money$ ${endColour}"
          if [ $money -gt $money_max ]; then
            let money_max=$money
          fi
          if [ $money -gt $bet_to_renew ]; then
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Se ha superado la meta de ${endColour}${yellowColour}$bet_to_renew$ ${endColour}${grayColour}para renovar la secuencia${endColour}"
            bet_to_renew=$(($bet_to_renew + 50))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuevo tope establecido a ${endColour}${yellowColour}$bet_to_renew$ ${endColour}"
            my_sequence=(1 2 3 4)
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia ha sido restablecida a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
          else
            my_sequence+=($bet)
            my_sequence=(${my_sequence[@]})

#            echo -e "${yellowColour}[+]${endColour}${grayColour} La nueva secuencia es${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
#              echo -e "${redColour}[!] La secuencia ha finalizado${endColour}"
              my_sequence=(1 2 3 4)
#              echo -e "${yellowColour}[+]${endColour}${grayColour} Se restablece la secuencia a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          fi
          let impar_counter+=1
          jugadas_malas=""
        # Perder
        elif [ "$((random_number % 2))" -eq 0 ]; then
          if [ "$random_number" -eq 0 ]; then
#            echo -e "${redColour}[!] El numero que ha salido es 0, perdiste :(${endColour}"
            let ceros_counter+=1
            jugadas_malas+="$random_number "
          else
#            echo -e "${redColour}[!] El numero que ha salido es par, perdiste :(${endColour}"
            let par_counter+=1
            jugadas_malas+="$random_number "
          fi
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Perdiste: ${endColour}${redColour}$bet$ ${endColour}"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ahora tienes: ${endColour}${redColour}$money$ ${endColour}"

          if [ $money -lt $(($bet_to_renew - 100)) ]; then
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Has llegado a un minimo, se procede a reajustar el tope${endColour}"
            bet_to_renew=$(($bet_to_renew - 50))
#            echo -e "${yellowColour}[+]${endColour}${grayColour} El tope ha sido renovado a ${endColour}${yellowColour}$bet_to_renew$ ${endColour}"

            unset my_sequence[0]
            unset my_sequence[-1] 2>/dev/null
            
            my_sequence=(${my_sequence[@]})

#            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia queda de la siguiente forma:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"

            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
#              echo -e "${redColour}[!] La secuencia ha finalizado${endColour}"
              my_sequence=(1 2 3 4)
#              echo -e "${yellowColour}[+]${endColour}${grayColour} Se restablece la secuencia a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          else
            unset my_sequence[0]
            unset my_sequence[-1] 2>/dev/null
            
            my_sequence=(${my_sequence[@]})

#            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia queda de la siguiente forma:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"

            if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            elif [ "${#my_sequence[@]}" -eq 1 ]; then
              bet=${my_sequence[0]}
            else
#              echo -e "${redColour}[!] La secuencia ha finalizado${endColour}"
              my_sequence=(1 2 3 4)
#              echo -e "${yellowColour}[+]${endColour}${grayColour} Se restablece la secuencia a:${endColour}${purpleColour} [${my_sequence[@]}]${endColour}"
              bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
            fi
          fi
        fi

      else
        echo -e "\n${redColour}[!] Error, $par_impar no se reconoce como apuesta valida${endColour}"
        helpPanel
        tput cnorm; exit 1
      fi
    else
      # Se queda sin dinero
      echo -e "\n${redColour}[!] Te has quedado sin dinero suficiente para seguir jugando${endColour}\n"
      echo -e "${yellowColour}[*]${endColour}${lightCyanColour} Resumen de la partida${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Jugadas totales: ${endColour}${yellowColour}$play_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Cantidad maxima de dinero alcanzada:${endColour}${yellowColour} $money_max${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Numero pares totales:${endColour}${yellowColour} $par_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Numero impares totales:${endColour}${yellowColour} $impar_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Numero de ceros totales:${endColour}${yellowColour} $ceros_counter${endColour}"
      echo -e "\t${yellowColour}[-]${endColour}${grayColour} Malas jugadas consecutivas: ${endColour}"
      echo -e "\t${blueColour}$jugadas_malas${endColour}"
      tput cnorm; exit 0
    fi

    let play_counter+=1
#    sleep 2
  done
  tput cnorm

}

while getopts "m:t:h" arg; do
  case $arg in
    m) money="$OPTARG"; let parameter_counter+=1;;
    t) technique="$OPTARG"; parameter_counter+=2;;
    h) helpPanel;;
  esac
done

if [ $money ] && [ $technique ]; then
  if [ "$technique" == "martingala" ]; then
    martingala
  elif [ "$technique" == "inverseLabouchere" ]; then
    inverseLabouchere
  else
    echo -e "\n${redColour}[!] La técnica indicada no es correcta${endColour}"
    helpPanel
  fi
else
  helpPanel
fi
