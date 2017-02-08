 select round(cast(replace(replace(B.abc104,' ',''),'.','') as numeric)/10000,0,1)
       ,COUNT(distinct A.sid)
 from bab2temp as a join ABC1Temp as b on A.sid = b.abc105
 where isnumeric(B.abc104) = 1
 and round(cast(replace(replace(B.abc104,' ',''),'.','') as numeric)/10000,0,1) between -100 and -4 
 group by round(cast(replace(replace(B.abc104,' ',''),'.','') as numeric)/10000,0,1) 
 order by 1
 
 select COUNT(distinct A.sid)
 from bab2temp as a join ABC1Temp as b on A.sid = b.abc105
 where isnumeric(B.abc104) = 1
