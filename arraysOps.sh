#!/bin/bash

echo "We are working with arrays"

# let's also download the file from a url using wget
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/M3/L2/arrays_table.csv


# give the file a name and specify the path
csv_file="./arrays_table.csv"

# let's parse table columns into three arrays
column_0=($(cut -d "," -f 1 $csv_file))
column_1=($(cut -d "," -f 2 $csv_file))
column_2=($(cut -d "," -f 3 $csv_file))


echo "${column_0[@]}"
echo "${column_1[@]}"
echo "${column_2[@]}"

# create a new column
column_3=("column_3")


# determine the number of lines in each column
nlines=$(cat $csv_file | wc -l)

for ((i=1; i<$nlines; i++)); do
    # populate the new column
    column_3[$i]=$((column_2[$i] - column_1[$i]))
done

echo "${column_3[@]}"

# now we write the column_3 to a new file
# we have only given the header for the new file
echo "${column_3[0]}" > column_3.csv

for ((i=1; i<$nlines; i++)); do
    echo "${column_3[$i]}" >> column_3.csv
done

# now we are combining all of them
paste -d "," "./arrays_table.csv" column_3.csv > report.csv

