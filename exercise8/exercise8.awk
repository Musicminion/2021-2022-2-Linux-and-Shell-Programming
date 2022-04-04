#!/usr/bin/awk -f
BEGIN {
	FS = ",";
}
{
	sum = 0;	sumScore = 0;
	for (i = 1; i <= NF; ++i){
		table[NR,i] = $i;
		
		if(NR>=2 && i >= 3 && $i >=0){
			sumScore += $i;
			sum ++;
		}
	}
	
	if(NR>=2)
		print $1,"的个人平均分是：",sumScore/sum;
}
END{
	for(i=3; i<=NF; i++){
		sum = 0;	sumScore = 0;
		for(j=2; j<=NR; j++){
			if(table[j,i]>0){
				sumScore += table[j,i];
				sum ++;
			}			
		}
		print table[1,i],"比赛的均分是：",sumScore/sum;
	}
	
	
	for(i=2; i<=NR; i++){
		for(j=3; j<=NF; j++){
			if(table[i,j]>0){
				teamNum[table[i,2]]++;
				teamScoreSum[table[i,2]] += table[i,j];
			}
		}
	}
	
	for(i=2; i<=NR; i++){
		if(booktable[table[i,2]] ==0){
			print table[i,2],"队伍的均分是",teamScoreSum[table[i,2]]/teamNum[table[i,2]];
			booktable[table[i,2]] = 1;
		}
	}
	
}
