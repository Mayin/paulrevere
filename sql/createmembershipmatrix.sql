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
