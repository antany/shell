# split the files based on specific column of the file

srcfile="file.txt"
# in the below line change 2p means take the header from 2nd row, incase want to read header from 1st row, use 1p
head=`sed -n 2p $srcfile`

# Change the delimit and column location in the below cut statement, in the below example 23 is column location and "|" is delimitor

cat $srcfile  | cut -f23 -d "|" |sort| uniq | 

while read name ;
do
	
	#it can be anything, in my example it uses the value as file 
	filename=$(echo $name | sed -e s/"[$ -]"//g)	
	
	echo $filename

	echo $head > $filename.txt

	cat $srcfile | grep -E "$name" >> $filename.txt
	
done
