echo -e "Count\tIp\t\tRegion\tCountry\tISP"

cat /var/log/auth.log  | grep -ohE "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort | uniq -c| 
while read name ; 
do
	
	ip=$(echo $name | cut -f2 -d " ")
	count=$(echo $name | cut -f1 -d " ")
	

	if [ "$ip" != "0.0.0.0" ] && [ "$ip" != "127.0.0.1" ] && [ "$ip" != "localhost" ] && [[ "$ip" != 192.168* ]] ; then
	info=$(curl -s ipinfo.io/$ip)

	

	data=$(echo $info | tr "{}" " " | sed -e 's/\"[a-zA-Z]\{1,\}\"://g' | tr "\"" " "  |awk '{$1=$1}1')

	region=$(echo $data | cut -f4 -d "," | awk '{$1=$1}1')
	country=$(echo $data | cut -f5 -d "," | awk '{$1=$1}1')
	isp=$(echo $data | cut -f8 -d "," | awk '{$1=$1}1')

	echo -e $count"\t"$ip"\t"$region"\t"$country"\t"$isp
	fi
done

