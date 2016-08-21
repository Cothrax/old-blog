#!/bin/bash
name="test"	                    	#文件名

for ((;1;))		                    #死循环
do
    ./${name}_gen		            #数据生成器
    ./${name}_che	            	#暴力程序
    ./${name}		                #程序
    diff ${name}.out ${name}.ans    #比较
    if [ $? -ne "0" ]; then         #如果diff的输出$?和"0"不等
        echo "fail"
        exit		            	#退出
    else
        echo "pass"
    fi
done
