#!/bin/bash

function saveInk()
{
inkscape --file=$1 --export-area-page --export-width=$3 --export-png=$2
}

mypath=$(dirname $(readlink -f $0))
#declare -a res=(22 48 128)
declare -a res=(48)
INPUT=names.csv
OLDIFS=$IFS
IFS=,

echo "Select theme"
echo "1) black"
echo "2) white"
echo "3) solid black"
echo "4) solid white"
read selection
case $selection in
1)
source_path="./../dist/icons/black/svg/" ;;
2)
source_path="./../dist/icons/white/svg/" ;;
3)
source_path="./../dist/icons/solid-black/svg/" ;;
4)
source_path="./../dist/icons/solid-white/svg/" ;;
*)
echo "selection is not valid!" ;
exit 99 ;;
esac

for the_res in "${res[@]}"
do
	mkdir $the_res
	[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
	while read oname nname
	do
		echo "== $oname.svg =="
		saveInk "$source_path$oname.svg" "$mypath/$the_res/$nname" $the_res
	done < $INPUT
done
IFS=$OLDIFS
#COMMENT1
