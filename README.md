# Ruleta

[Este script es meramente demostrativo y no busca hace apología a las apuestas]

Existen varias estrategias y técnicas que supuestamente se encargan de ‘_vencer_‘ a la ruleta de los casinos, alguna de ellas son las siguientes:

- Martingala
- D’Alembert
- Secuencia de Fibonacci
- Paroli
- Óscar Grind
- Guetting
- Labouchere
- Inverse Labouchere

En este caso se ponen a prueba la "Martingala" y el "Inverse Labouchere". Se busca analizar de manera matemática mediante una simulación de juego de ruleta como diferentes técnicas funcionan y demostrar que la casa siempre termina ganando

## Opciones:
```
[+] Uso:
	m) Ingresar la cantidad de dinero que se desea usar
	t) Tecnica a utilizar (martingala/inverseLabouchere)
	h) Mostrar panel de ayuda
```
## Uso:

Haciendo la llamada al archivo se indica el dinero "-m" y la técnica "-t" para poder jugar, luego se elige entre si apostar únicamente a par o impar; y en caso de la martingala se seleciona la cantidad para la apuesta inicial

Operación Martingala:
```
./ruleta.sh -m 1000 -t martingala
```
Operación Labouchere:
```
./ruleta.sh -m 1000 -t inverseLabouchere
```

## Tecnologías usadas

- Bash

