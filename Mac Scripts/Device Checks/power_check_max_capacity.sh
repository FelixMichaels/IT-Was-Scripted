capacity=$(system_profiler SPPowerDataType | awk '/Maximum Capacity/{printf "%s,", $3}' | tr "," " ")
max_capacity=$(echo "${capacity}" | tr "%" " ")


if [[ ${max_capacity} -ge 90 && ${max_capacity} -lt 100 ]] 
then
	echo "5 Star Rating ★★★★★"
	rating_a=5
fi

if [[ ${max_capacity} -ge 70 && ${max_capacity} -lt 90 ]] 
then
	echo "4 Star Rating ★★★★☆"
	rating_a=4
fi

if [[ ${max_capacity} -ge 50 && ${max_capacity} -lt 70 ]] 
then
	echo "3 Star Rating ★★★☆☆"
	rating_a=3
fi

if [[ ${max_capacity} -ge 30 && ${max_capacity} -lt 50 ]] 
then
	echo "2 Star Rating ★★☆☆☆"
	rating_a=2
fi

if [[ ${max_capacity} -ge 0 && ${max_capacity} -lt 30 ]] 
then
	echo "1 Star Rating ★☆☆☆☆"
	rating_a=1
fi