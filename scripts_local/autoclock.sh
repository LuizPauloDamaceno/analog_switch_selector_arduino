
#Leitura serial: várias vezes para garantir terminal
echo "MEAS? 0" > /dev/ttyS0
echo "MEAS? 0" > /dev/ttyS0
echo "MEAS? 0" > /dev/ttyS0
echo "MEAS? 0" > /dev/ttyS0
echo "MEAS? 0" > /dev/ttyS0
echo "MEAS? 0" > /dev/ttyS0
echo "MEAS? 0" > /dev/ttyS0
sleep 0.725
read serial < /dev/ttyS0
echo $serial > log.txt
potencia=$(sed 's/.*\(...\)/\1/' log.txt)
resultado=$(cut -f -1 -d 'E' log.txt)

#Algorítmo para tratamento do valor lido na serial.
A=$resultado
B=$potencia

if  [ "$B" = "E-1" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -1' | bc)
	echo 0$C
else
 if [ "$B" = "E-2" ] ; then 
	#cut vai aqui#
	C=$(echo 'scale=12; '$A' *10^ -2' | bc)
	echo 0$C
else
 if [ "$B" = "E-3" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -3' | bc)
	echo 0$C
else
 if [ "$B" = "E-4" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -4' | bc)
	echo 0$C
else
 if [ "$B" = "E-5" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -5' | bc)
	echo 0$C
else
 if [ "$B" = "E-6" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -6' | bc)
	echo 0$C
else
 if [ "$B" = "E-7" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -7' | bc)
	echo 0$C
else
 if [ "$B" = "E-8" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -8' | bc)
	echo 0$C
else
 if [ "$B" = "E-9" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -9' | bc)
	echo 0$C
else
 if [ "$B" = "E-10" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -10' | bc)
	echo 0$C
else
 if [ "$B" = "E-11" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -11' | bc)
	echo 0$C
else
 if [ "$B" = "E-12" ] ; then 
	C=$(echo 'scale=12; '$A' *10^ -12' | bc)
	echo 0$C
           fi
          fi
         fi
        fi
       fi
      fi
     fi
    fi
   fi
  fi
 fi
fi
exit 0
rm -rf log.txt
#Fim da leitura serial

