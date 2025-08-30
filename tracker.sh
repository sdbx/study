#!/bin/bash

dirname="pro-git"
path="$1.*/"
if [ -z $1 ]
then
   path="*/"
else
   if [ $1 = "help" ]; then
      echo "usage: ./tracker [chapter-number]"
      echo "       ./tracker help"
      echo "note: if no chapter-number specified, it prints all."
      echo "example:"
      echo "  ./tracker     # prints all sections under all chapters."
      echo "  ./tracker 3   # prints only sections under the chapter 3."
      echo "  ./tracker help   # prints this help manual."
      exit 0
   fi
fi

# Colors
dirc="\033[36m"
goodc="\033[38;5;49;1m"
badc="\033[91m"
progc="\033[33m"
init="\033[0m"   # color reset

### MAIN PART ###
echo "###########"
echo "# TRACKER #"
echo "###########"
echo

all_count=0
raro_count=0
cor_count=0
cd $dirname
dirs=$(ls -d $path)  # Lists only directories
for dir in $dirs; do
   all_count=$(($all_count+1))
   raro_flag="${badc}WIP${init}"
   cor_flag="${badc}WIP${init}"

   if [ -e $dir/raro.md ]  # Is there a file?
   then
      raro_count=$(($raro_count+1))
      raro_flag="${goodc}DONE!${init}"
   fi
   
   if [ -e $dir/cor.md ]
   then
      cor_count=$(($cor_count+1))
      cor_flag="${goodc}DONE!${init}"
   fi

   _dir=$(echo $dir | sed 's/.$//')  # Deletes the last character
   printf "$dirc$_dir$init\n  RARO $raro_flag\tCOR $cor_flag"
   echo
done

# fixme: use function to remove redundancy
echo
printf "${progc}PROGRESS${init}"
echo
raro_perct=$(($raro_count*100/$all_count))
cor_perct=$(($cor_count*100/$all_count))
raro_nsharp=$(($raro_perct/10))
cor_nsharp=$(($cor_perct/10))
raro_ndot=$((10-$raro_nsharp))
cor_ndot=$((10-$cor_nsharp))
raro_resstr=""
cor_resstr=""
count=0
while [ $count -lt $raro_nsharp ]; do
   raro_resstr="${raro_resstr}#"
   count=$(($count+1))
done
count=0
while [ $count -lt $raro_ndot ]; do
   raro_resstr="${raro_resstr}."
   count=$(($count+1))
done
count=0
while [ $count -lt $cor_nsharp ]; do
   cor_resstr="${cor_resstr}#"
   count=$(($count+1))
done
count=0
while [ $count -lt $cor_ndot ]; do
   cor_resstr="${cor_resstr}."
   count=$(($count+1))
done
printf "RARO %3i%% [$raro_resstr]" $raro_perct
echo
printf "COR  %3i%% [$cor_resstr]" $cor_perct
echo