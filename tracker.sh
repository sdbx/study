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

# Auto-detect users from existing .md files
USERS=($(find "$dirname" -name "*.md" -not -name "README.md" | xargs -n1 basename | sed 's/\.md$//' | sort -u))

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
declare -A user_counts
declare -A user_flags

# Initialize user counts
for user in "${USERS[@]}"; do
   user_counts[$user]=0
done

cd $dirname
dirs=$(ls -d $path)  # Lists only directories
for dir in $dirs; do
   all_count=$(($all_count+1))
   
   # Check each user's file and set flags
   for user in "${USERS[@]}"; do
      user_flags[$user]="${badc}WIP${init}"
      if [ -e $dir/$user.md ]; then
         user_counts[$user]=$((${user_counts[$user]}+1))
         user_flags[$user]="${goodc}DONE!${init}"
      fi
   done

   _dir=$(echo $dir | sed 's/.$//')  # Deletes the last character
   printf "$dirc$_dir$init\n"
   for user in "${USERS[@]}"; do
      user_upper=$(echo $user | tr '[:lower:]' '[:upper:]')
      printf "  $user_upper ${user_flags[$user]}\t"
   done
   echo
done

echo
printf "${progc}PROGRESS${init}"
echo

# Function to generate progress bar
generate_progress_bar() {
   local percentage=$1
   local nsharp=$(($percentage/10))
   local ndot=$((10-$nsharp))
   local resstr=""
   local count=0

   while [ $count -lt $nsharp ]; do
      resstr="${resstr}#"
      count=$(($count+1))
   done
   count=0
   while [ $count -lt $ndot ]; do
      resstr="${resstr}."
      count=$(($count+1))
   done
   echo "$resstr"
}

# Display progress for each user
for user in "${USERS[@]}"; do
   user_perct=$((${user_counts[$user]}*100/$all_count))
   user_upper=$(echo $user | tr '[:lower:]' '[:upper:]')
   progress_bar=$(generate_progress_bar $user_perct)
   printf "%-4s %3i%% [%s]" "$user_upper" $user_perct "$progress_bar"
   echo
done