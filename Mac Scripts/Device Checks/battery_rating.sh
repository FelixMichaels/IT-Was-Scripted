###############
#Power Ratings
###############

#Battery Condition Rating

condition=$(system_profiler SPPowerDataType | awk '/Condition/{printf "%s,", $2}')

if [[ ${condition} == "Normal," ]] 
then
	echo "Battery Condition: ${condition} 5 Star Rating ★★★★★"
	rating_a=5
fi

if [[ ${condition} == "Service recommended," ]] 
then
	echo "Battery Condition: ${condition} 1 Star Rating ★☆☆☆☆"
	rating_a=5
fi

#Battery Max Capacity Rating

capacity=$(system_profiler SPPowerDataType | awk '/Maximum Capacity/{printf "%s,", $3}' | tr "," " ")
max_capacity=$(echo "${capacity}" | tr "%" " ")


if [[ ${max_capacity} -ge 90 && ${max_capacity} -lt 100 ]] 
then
	echo "Battery Capacity: ${capacity} 5 Star Rating ★★★★★"
	rating_b=5
fi

if [[ ${max_capacity} -ge 70 && ${max_capacity} -lt 90 ]] 
then
	echo "Battery Capacity: ${capacity} 4 Star Rating ★★★★☆"
	rating_b=4
fi

if [[ ${max_capacity} -ge 50 && ${max_capacity} -lt 70 ]] 
then
	echo "Battery Capacity: ${capacity} 3 Star Rating ★★★☆☆"
	rating_b=3
fi

if [[ ${max_capacity} -ge 30 && ${max_capacity} -lt 50 ]] 
then
	echo "Battery Capacity: ${capacity} 2 Star Rating ★★☆☆☆"
	rating_b=2
fi

if [[ ${max_capacity} -ge 0 && ${max_capacity} -lt 30 ]] 
then
	echo "Battery Capacity: ${capacity} 1 Star Rating ★☆☆☆☆"
	rating_b=1
fi

#Sum of all ratings
Full_Rating=$(awk -v x="${rating_a}" -v y="${rating_b}" 'BEGIN { print  ( x + y )}')

echo "Battery Rating for this Device is: ${Full_Rating} out of 10"