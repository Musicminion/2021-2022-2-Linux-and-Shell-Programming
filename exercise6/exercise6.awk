#!/usr/bin/awk -f
BEGIN {
	seqID = 0;
}
{
	c = substr($0, 0, 1);
	if(c == ">"){
		next;
	}
	else{
		seqID++;
		for(i=0; i<=length($0)-2; i++){
			#print substr($0, i, 3);
			if(seqID == 1){
				table1[substr($0, i, 3)]++;
			}
			if(seqID == 2){
				table2[substr($0, i, 3)]++;
			}
		}
	}
}
END {
	tmpsum = 0;
	for(i in table1)
		print i,table1[i];
	print "---------------------------------------------";
	for(i in table2)
		print i,table2[i];
	
	for(i in table1)
		tmpsum += (table1[i] - table2[i])^2;
	for(i in table2)
		tmpsum += (table1[i] - table2[i])^2;
	print "最终答案是：",2.71828182^(-tmpsum);
}
