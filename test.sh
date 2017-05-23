#!/bin/bash
# Split script

#variabili
u_start=1
u_end=2;
u_counter=1;

#parametri
echo "----------------------------------------"
echo "Script Name: $0"
echo "New Splitted PDF Name List: $1"
echo "Complete PDF Name: $2"
echo "Total Number of Parameters : $#"
echo "----------------------------------------"

#controlli
echo "INFO: Procedure Started"
if (($# == 2 ))
then
    echo "INFO: Parameters are present"
    if [ -f "$1" ]
      then
	echo "INFO: file $1 is present"
	if [ ${1: -4} != ".txt" ]
	  then
	  echo "ERROR: wrong format, first file should be .txt"
	  exit
	fi	  
      else
	echo "ERROR: file $1 is NOT present"
	exit
    fi
    if [ -f "$2" ]
      then
	echo "INFO: file $2 is present"
	if [ ${2: -4} != ".pdf" ]
	  then
	  echo "ERROR: wrong format, second file should be .pdf"
	  exit
	fi	
      else
	echo "ERROR: file $2 is NOT present"
	exit
    fi    
    
else
    echo "ERROR: Please USE-> $0 namefile.txt namefile.pdf"
    exit
fi

#split
echo "SPLIT Started.."
echo " Generating:"
while IFS='' read -r line || [[ -n "$line" ]]; do   
  if $(pdftk $2 cat $u_start-$u_end output $line)
      then
	echo "  $u_counter) $line [OK]"
      else
	echo "  $u_counter) $line [NOK]"
    fi
    u_counter=$((u_counter+1))
    u_start=$((u_start+2))
    u_end=$((u_end+2))
done < "$1"
echo " Generation ended"
echo "SPLIT ended."

echo "INFO: Procedure Ended with $((u_counter-1)) new PDF(s)"
