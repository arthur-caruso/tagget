#! /usr/bin/env bash

source get_filetype.sh

echo "Adding newly added files into TagGet scheme...";
files=(./data/*);
stagedFiles=();
mapfile -t stagedFiles < staged;

for i in "${files[@]}"
do
	alreadyStaged="false";
	case "${stagedFiles[@]}" in *$i*)
		alreadyStaged="true" &&
		echo "$i already staged!" ;; esac
	if [ $alreadyStaged == "false" ]; then
		echo "$i not staged!";
		echo "Renaming and staging...";
		exists="true";
		while $exists == "true"; do
			# 16 ^ (26 + 26 + 10) possible filenames
			n=`shuf -er -n16  {A..Z} {a..z} {0..9} | paste -sd ""`;
			get_filetype $i;
			n="./data/$n$ext";
			exists="false";
			case "${files[@]}" in *$n*)
				exists="true" &&
				echo "$n already exists!" &&
				echo "Renaming again..." ;; esac
		done
		echo $n >> staged;
		mv "$i" "$n";
		echo "$i -> $n";
    fi
done
echo "Done.";
exit
