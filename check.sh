#! /usr/bin/env bash

echo "Checking for missing files inside TagGet scheme...";
files=(./data/*);
stagedFiles=();
mapfile -t stagedFiles < staged;

for i in "${stagedFiles[@]}"
do
	exists="false";
	case "${files[@]}" in *$i*)
		exists="true" ;; esac
	if [ $exists == "false" ]; then
		echo "$i is staged but does not exist!";
		echo "Unstaging...";
		stagedFiles=("${stagedFiles[@]/$i}")
	fi
done
printf "%s\n" ${stagedFiles[@]} > staged
echo "Done.";
exit
