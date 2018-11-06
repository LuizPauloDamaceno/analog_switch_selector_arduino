opcao="NONE"
meas1="UTC_EXP"
meas2="EXP_EXP"
lockvar1=0
lockvar2=0
final=0
media1=0
media2=0
while true
do
echo "Insira o modo de operacao (UTC_EXP ou EXP_EXP) no arquivo modo.txt"
echo "--------------------------------"

echo -e '\033[05;31mAPÓS A AQUISIÇÃO DAS MEDIDAS, MATE O SCRIPT (CTRL+C), INSIRA none NO ARQUIVO modo.txt E INICIE NOVAMENTE DIGITANDO ./serial_ack.sh NO TERMINAL\033[00;37m'
echo "--------------------------------"
opcao=$(cat modo.txt)
hora=$(date +%H%M)
horadarun=$(date +%H:%M:%S)
if [ "$opcao" == "$meas1" ] && [ "$hora" -ne "1155" ] && [ "$hora" -ne "1205" ] && [ $lockvar1 -eq 0 ] && [ $lockvar2 -eq 0 ]; then
	echo "Modo de medição UTC - Experimento"
	echo "--------------------------------"
	./python_UTC_EXP.py
	sleep 1
	r1=$(./autoclock.sh)
	echo "Medida atual" $r1
	echo  $r1 >> utc_exp_measure/counter_output.txt
fi

if [ "$opcao" == "$meas2" ] && [ "$hora" -ne "1155" ] && [ "$hora" -ne "1205" ] && [ $lockvar1 -eq 0 ] && [ $lockvar2 -eq 0 ]; then
	echo "Modo de medição Experimento - Experimento"
	echo "--------------------------------"
	./python_EXP_EXP.py
	sleep 1
	r2=$(./autoclock.sh)
	echo "Medida atual" $r2
	echo  $r2 >> exp_exp_measure/counter_output.txt
fi

if [ "$hora" -eq "1155" ] && [ $lockvar1 -lt 2 ]; then
	./python_BIPM.py
	sleep 1
	diferenca1=$(./autoclock.sh)
	sleep 1
	diferenca2=$(./autoclock.sh)
	sleep 1
	diferenca3=$(./autoclock.sh)
	sleep 1
	diferenca4=$(./autoclock.sh)
	sleep 1
	diferenca5=$(./autoclock.sh)
	A=$diferenca1
	B=$diferenca2
	C=$diferenca3
	D=$diferenca4
	E=$diferenca5
	media1=$(bc <<< "scale=12;($A+$B+$C+$D+$E)/5")
	let lockvar1=lockvar1+1
	
fi

if [ "$hora" -eq "1205" ] && [ $lockvar2 -lt 2 ]; then
	./python_BIPM.py
	sleep 1
	diferenca1=$(./autoclock.sh)
	sleep 1
	diferenca2=$(./autoclock.sh)
	sleep 1
	diferenca3=$(./autoclock.sh)
	sleep 1
	diferenca4=$(./autoclock.sh)
	sleep 1
	diferenca5=$(./autoclock.sh)
	sleep 1
	A=$diferenca1
	B=$diferenca2
	C=$diferenca3
	D=$diferenca4
	E=$diferenca5
	media2=$(bc <<< "scale=12;($A+$B+$C+$D+$E)/5")
	let lockvar2=lockvar2+1
	
fi

if [ $lockvar1 -ge 2 ] && [ "$hora" -eq "1156" ]; then
	lockvar1=0
	sleep 0.5
fi

if [ $lockvar2 -ge 2 ] && [ "$hora" -eq "1206" ]; then
	lockvar2=0
	sleep 0.5
	final=$(bc <<< "scale=12;($media1+$media2)/2")
	sleep 1
	resultado_bipm=$(echo $final*1000000000000/1 | bc)
	echo $resultado_bipm.0 > bipm_measure/bipm_counter.txt
fi
sleep 5
clear
echo "Media 5 minutos antes da virada UTC: " 0$media1
echo "Media 5 minutos depois da virada UTC: " 0$media2
echo "Symmetricom 5071 - UTC(LRTE) -DAILY- (nS): " $resultado_bipm.0
done
