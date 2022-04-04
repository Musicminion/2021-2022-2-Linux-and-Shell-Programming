#!/usr/bin/awk -f
BEGIN {
	num = 0;
}
{
     table[$4]++;
     if($3 == "CA"){
     	num++;
     	xx[num] = $7;
     	yy[num] = $8;
     	zz[num] = $9;
     	acid[num] = $2;
     }
}
END{
    for(i in table)
		print i,table[i];
	
	for(x = 1; x<=num; x++){
		for(y = x+1; y<=num; y++){
			print acid[x],"和",acid[y],"位置的氨基酸的距离是：",sqrt((xx[x]-xx[y])*(xx[x]-xx[y]) + (yy[x]-yy[y])*(yy[x]-yy[y]) + (zz[x]-zz[y])*(zz[x]-zz[y]))
		}
	}
}
