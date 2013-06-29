-- pop orgperson, stAndrewsLodge
insert into orgperson(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'stAndrewsLodge' 
where   1=1
and     b.stAndrewsLodge = 1;
-- pop orguser, LoyalNine
insert into orguser(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'LoyalNine' 
where   1=1
and     b.LoyalNine = 1;
-- pop orguser, NorthCaucus
insert into orguser(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'NorthCaucus' 
where   1=1
and     b.NorthCaucus = 1;
-- pop orguser, LongRoomClub
insert into orguser(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'LongRoomClub' 
where   1=1
and     b.LongRoomClub = 1;
-- pop orguser, TeaParty
insert into orguser(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'TeaParty' 
where   1=1
and     b.TeaParty = 1;
-- pop orguser, BostonCommittee
insert into orguser(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'BostonCommittee' 
where   1=1
and     b.BostonCommittee= 1;
-- pop orguser, LodonEnemies
insert into orguser(idperson, idorg)
select  a.idperson, c.idorg
from    person a inner join matrix b on a.name = b.person
        inner join org c on c.name = 'LodonEnemies' 
where   1=1
and     b.LondonEnemies = 1;