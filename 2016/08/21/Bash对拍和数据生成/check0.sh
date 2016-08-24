for ((i=1;i<51;i++))
do
	cp ./transport${i}.in ./transport.in
	./transport
	diff -w ./transport.out ./transport${i}.out
	if [ $? -ne "0" ];then
		echo "fail: "${i}
	else
		echo "pass: "${i}
	fi
	rm ./transport.in
	rm ./transport.out
done
