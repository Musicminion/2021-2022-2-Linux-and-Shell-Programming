#!/usr/bin/awk -f
BEGIN {	
    AA = 0;
    GG = 0;
    CC = 0;
    TT = 0;
}
{
	c = substr($0, 0, 1);
	if(c == ">"){
		print $0;
		next;
	}
		
	else{
		curAA = 0;
		curGG = 0;
		curCC = 0;
		curTT = 0;
		
		for(i=0; i<=length($0); i++)
		{
			if(substr($0, i, 1) == "A")
				curAA ++;
			if(substr($0, i, 1) == "G")
				curGG ++;
			if(substr($0, i, 1) == "C")
				curCC ++;
			if(substr($0, i, 1) == "T")
				curTT ++;
		}
		
		print "碱基的个数：",length($0);
		print "A的含量：",curAA,"A的频率：",curAA/length($0);
		print "G的含量：",curGG,"G的频率：",curGG/length($0);
		print "C的含量：",curCC,"C的频率：",curCC/length($0);
		print "T的含量：",curTT,"T的频率：",curTT/length($0);
		
		AA += curAA;
		GG += curGG;
		CC += curCC;
		TT += curTT;	
	}
}

END{
	print ">综合统计信息";
	print "所有A的含量：",AA;
	print "所有G的含量：",GG;
	print "所有C的含量：",CC;
	print "所有U的含量：",TT;
	print "所有A的比例：",AA/(AA+GG+CC+TT);
	print "所有G的比例：",GG/(AA+GG+CC+TT);
	print "所有C的比例：",CC/(AA+GG+CC+TT);
	print "所有U的比例：",TT/(AA+GG+CC+TT);
	
}
