--U22222222222111111111111
select zz.Name, aaa.bodate, count(aaa.TOABC1SID) ct into #b21
from 
(
select aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid, COUNT(*) ctt 
from BCK1Collect aa join ABC1Collect as dd on dd.ABC105=aa.TOABC1SID 
                    left outer join BAI1Collect cc on aa.TOGBAI1Hspid = cc.HOSPID 
                    left outer join BAI2Collect ee on cc.TOBAI2OID = ee.OID
group by aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid

) as aaa join abc1collect bbb on aaa.toabc1sid = bbb.abc105
         left outer join bai2collect zz on bbb.abc134 = zz.id
group by zz.Name, aaa.bodate
select sum(ct) from #b21
drop table #b21
--U222222222222222222222222
select zz.Name, aaa.bodate, count(aaa.TOABC1SID) ct into #b22
from 
(
select aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid, COUNT(*) ctt 
from BCK1Collect aa left outer join ABC1Collect as dd on dd.ABC105=aa.TOABC1SID 
                    left outer join BAI1Collect cc on aa.TOGBAI1Hspid = cc.HOSPID 
                    left outer join BAI2Collect ee on cc.TOBAI2OID = ee.OID
                    left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                    left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
     where ff.ResultType in (1,2)
group by aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid
) as aaa left outer join abc1collect bbb on aaa.toabc1sid = bbb.abc105
         left outer join bai2collect zz on bbb.abc134 = zz.id
group by zz.Name, aaa.bodate
select sum(ct) from #b22
drop table #b22

------這可以代表上面兩個

--算出resulttype不同的有多少
select aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid, COUNT(*) from
(
  select aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid, ff.ResultType
  from BCK1Collect aa join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
) as aa
group by aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid
having COUNT(*) >1
--

  select ff.DataClassID, ff.ResultType
  , COUNT(*)
  from BCK1Collect aa left outer join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
  --where ff.ResultType in (0,1,2)
  group by ff.DataClassID, ff.ResultType
  order by 1

  select COUNT(*) from BCK1Collect aa join ABC1Collect cc on aa.toabc1sid = cc.abc105
  where TOABC1SID ='99%'

--
  select distinct aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid into #distpgb0
  from BCK1Collect aa left outer join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
  where ff.ResultType = 0
  
  select distinct aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid into #distpgb1
  from BCK1Collect aa left outer join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
  where ff.ResultType = 1
  
  select distinct aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid into #distpgb1
  from BCK1Collect aa left outer join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
  where ff.ResultType = 2
  
  select distinct aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid into #distpgb3
  from BCK1Collect aa left outer join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
  where ff.ResultType = 3

select distinct aa.TOABC1SID, aa.BODATE, aa.TOGBAI1Hspid  
from #distpgb3 aa join #distpgb2 bb on aa.TOABC1SID = bb.TOABC1SID and aa.BODATE = bb.BODATE and aa.TOGBAI1Hspid = bb.TOGBAI1Hspid

select * from BCK1Collect aa left outer join ABC1Collect cc on aa.toabc1sid = cc.abc105
                      left outer join Bck1Result as bb on bb.HealthCenterID=aa.HealthCenterID and bb.OID=aa.OID
                      left outer join ResultCode as ff on ff.ResultCode = bb.ResultCode 
where toabc1sid = 'C220231480' and BODATE ='2009-10-08 00:00:00.000' and TOGBAI1Hspid = '3511011969'



select * from ResultCode
