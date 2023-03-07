#! /usr/bin/env bash

source get_filetype.sh

echo "Initiating TagGet scheme on ./data directory...";
files=(./data/*);
rm staged;
touch staged;

for i in "${files[@]}"
do
	exists="true";
	while $exists == "true"; do
		# 16 ^ (26 + 26 + 10) possible filenames
		hash=`shuf -er -n16  {A..Z} {a..z} {0..9} | paste -sd ""`;
		get_filetype $i;
		file="./data/$hash$ext";
		exists="false";
		case "${files[@]}" in *$file*)
			exists="true" &&
			echo "$file already exists!" &&
			echo "Renaming again..." ;; esac
	done
	echo $n >> staged;
	mv "$i" "$file";
	echo "$i -> $file";
done
echo "Done.";
exit
