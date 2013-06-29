create or replace view orgconns as 
select  z.name, count(distinct e.name) numconns
from    org z
        -- Lets get all the users for this org
        inner join orgperson x on z.idorg = x.idorg
        inner join person a on x.idperson = a.idperson 
        -- Lets join person to orgs he belongs to
        inner join orgperson b on a.idperson = b.idperson
        inner join org c on b.idorg = c.idorg
        -- Lets join this org to other persons
        inner join orgperson d on c.idorg = d.idorg
        inner join person e on d.idperson = e.idperson
where   1=1
and     a.idperson <> d.idperson
group by z.name
order by 2 desc;