export PATH=$PATH:.
i=0
for file in *.mp3
do
i=$((i+1))
nfile="$i."`fileren 1 "$file"`
mv "$file" "$nfile"
done

