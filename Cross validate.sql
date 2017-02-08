  --看個別的差集 地方有中央沒有
 select count(abc105) 
 from abc1temp
 where abc105  in(
 select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
 )
  select count(distinct abc105) 
 from abc1temp
 where abc105  in(
 select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
 )
  select count(abc105) 
 from abc1temp
 where abc105 not in(
 select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
 )
  select count(distinct abc105)
  from abc1temp
  where abc105 not in(
  select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
  select count(distinct abc105) --挑出來了 只在地方不在中央也不是99個案的abc105
 from abc1temp
 where abc105 not in (
       select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
       ) and left(abc105,2) = '99'



 --交叉比對
 select abc105, abc103, abc104, ABC134 into #t1 
 from abc1temp 
 where abc105 not in (
       select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
       ) 
 select ID, NAME, BIRTHDAY, cityid into #t2
 from CENSUSCenter
 where id not in(
       select ID from censuscenter a join abc1temp b on a.ID = b.ABC105
       )
 
 select count(abc105)
 from #t1 a join #t2 b on a.abc103 = b.NAME and a.abc104 = b.BIRTHDAY and a.ABC134 = b.cityid 
 
 drop table #t1, #t2
 
 --abc1temp篩掉99
 select count(*) from abc1temp where LEFT(abc105,2) = '99'
 select count(distinct abc105) from abc1temp where left(abc105,2) <> '99'
 select count(abc105) from censuscenter a join abc1temp b on a.ID = b.ABC105 where left(abc105,2) <> '99'
 select count(distinct abc105) from censuscenter a join abc1temp b on a.ID = b.ABC105 where left(abc105,2) <> '99'
 select count(sid)
 from baa1temp a join ABC1Temp b on a.SID = b.abc105
 where abc105 not in(
       select abc105 from censuscenter a join abc1temp b on a.ID = b.ABC105 where left(abc105,2) <> '99'
       )
