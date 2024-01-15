
#Comprobar de forma aritmética 
172.14.15.16/17
-----------------------------------------------------------------------------------------------------------------
> echo "obase=2;172" | bc
> echo "obase=2;14" | bc
> echo "obase=2;15" | bc
> echo "obase=2;16" | bc

10101100.00001110.00001111.00010000 (172.14.15.16/17) #ip en binario al poner el comando te dara x numeros tendras que rellenar en 0 hasta completar 8 bits por la izquierda

#Si es /17 sabemos que los primeros 17 bits corresponde a la parte de -red y los otros 15 corresponde a la parte de hots
#Tendremos que poner 17 1 y el resto a 0
11111111.11111111.10000000.00000000

> echo "ibase=2;11111111" | bc  ---> 255
> echo "ibase=2;11111111" | bc  ---> 255
> echo "ibase=2;10000000" | bc  ---> 128
> echo "ibase=2;00000000" | bc  ---> 0

#Máscara de -red  
255.255.128.0 / 17

-----------------------------------------------------------------------------------------------------------------

10101100.00001110.00001111.00010000 (172.14.15.16/17) #ip en binario
11111111.11111111.10000000.00000000 # mascara de -red en binario

-----------------------------------------------------------------------------------------------------------------
#Network ID 
#Hacemos una comparatoria entre la ip y mascara de -red donde si hay dos 1 se pone uno y si tiene un 0 se pone 0
10101100.00001110.00000000.00000000 

> echo "ibase=2;10101100" | bc  ---> 0
> echo "ibase=2;00001110" | bc  ---> 0
> echo "ibase=2;00000000" | bc  ---> 0
> echo "ibase=2;00000000" | bc  ---> 0

--> Esto equivale a 172.14.0.0 -->NetworkID

-----------------------------------------------------------------------------------------------------------------

> echo $((32-17))  --> 15 corresponde a la parte de hots

#Cogemos la ip en binario y contamos 15 bits desde la derecha hacia la izquierda, es decir desde el final hacia el principio <---- 

10101100.00001110.00001111.00010000 (172.14.15.16/17) 
10101100.00001110.00001111.00010000 (172.14.15.16/17) #ip en binario
#A partir de 15 bits contados desde la izquierda hacia la derecha se pondría todo a 1. y ese seria -->Broadcast Address
10101100.00001110.01111111.11111111

#Pasamos de binario a decimal y lo tendriamos 

> echo "ibase=2;10101100" | bc  ---> 0
> echo "ibase=2;00001110" | bc  ---> 0
> echo "ibase=2;01111111" | bc  ---> 0
> echo "ibase=2;11111111" | bc  ---> 0

# -->BroadcastAddres
172.14.127.255

-----------------------------------------------------------------------------------------------------------------


