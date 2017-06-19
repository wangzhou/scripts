#/bin/bash

touch ./test

echo "ping -c 20 htsat.vicp.cc" >> ./test
echo

for i in $(seq 10)
do
    	echo $i >> ./test
	ping -c 20 htsat.vicp.cc >> ./test
done

echo
echo "ping -c 20 124.250.134.62" >> ./test
for i in $(seq 10)
do
    	echo $i >> ./test
	ping -c 20 124.250.134.62 >> ./test
done

echo
echo "ping -c 20 114.119.4.48" >> ./test
for i in $(seq 10)
do
    	echo $i >> ./test
	ping -c 20 114.119.4.48 >> ./test
done

