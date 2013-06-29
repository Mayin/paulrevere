create or replace view membershipmatrix as
select    concat_ws(' ', SUBSTRING_INDEX(a.name, '.',-1),  SUBSTRING_INDEX(a.name, '.',1)) Person, 
          SUBSTRING_INDEX(a.name, '.',-1) FName,
          SUBSTRING_INDEX(a.name, '.',1) LName,
          sum(case when b.idorg = 1 then 1 else 0 end) StAndrewsLodge ,
          sum(case when b.idorg = 2 then 1 else 0 end) LoyalNine,
          sum(case when b.idorg = 3 then 1 else 0 end) NorthCaucus,
          sum(case when b.idorg = 4 then 1 else 0 end) LongRoomClub,
          sum(case when b.idorg = 5 then 1 else 0 end) TeaParty,
          sum(case when b.idorg = 6 then 1 else 0 end) BostonCommittee,
          sum(case when b.idorg = 7 then 1 else 0 end) LondonEnemies
from      person a left join orgperson b on a.idperson = b.idperson
          left join org c on c.idorg = b.idorg
group by a.name
order by  SUBSTRING_INDEX(a.name, '.',1),  SUBSTRING_INDEX(a.name, '.',-1);

3.0 Group in common between users. Link to script.
select    a.Person PersonA,
          b.Person PersonB,
          case when a.StAndrewsLodge + b.StAndrewsLodge = 2 then 1 else 0 end +
          case when a.LoyalNine + b.LoyalNine = 2 then 1 else 0 end +
          case when a.NorthCaucus + b.NorthCaucus = 2 then 1 else 0 end +
          case when a.LongRoomClub + b.LongRoomClub = 2 then 1 else 0 end +
          case when a.TeaParty + b.TeaParty = 2 then 1 else 0 end +
          case when a.BostonCommittee + b.BostonCommittee = 2 then 1 else 0 end +
          case when a.LondonEnemies + b.LondonEnemies = 2 then 1 else 0 end Connections
from      membershipmatrix a cross join membershipmatrix b
where     1=1
and       a.person <> b.person
order by  a.lname, a.fname, b.lname, b.fname;