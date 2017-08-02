## I Too Found Paul Revere
I am coming from [this Reddit post](http://www.reddit.com/r/sociology/comments/1g38fk/finding_paul_revere_in_a_historical_example_a/) and from [here](http://kieranhealy.org/blog/archives/2013/06/09/using-metadata-to-find-paul-revere/)… This post exists solely because I too wanted to find Paul Revere.  I am not even going to use ‘big data’.  Mainly because this data is not big, I do not have a graph database and because I think it would be fun to see what plain old SQL and [Tableau](http://www.tableausoftware.com/) can show us.  For truly insightful posts, just visit [Kieran Healy](http://kieranhealy.org/blog/), the author of the original post instead.

Kieran makes a very compelling argument on what is possible for surveillance programs the general population may (or not) understand.  His post is really fascinating.  Follow along and you can learn to monitor your citizens as well. 

Heck, I bet you could build your own surveillance network with freely available online services.  Imagine what you could cook up with [Google Alerts](http://www.google.com/alerts), [Amazon S3](http://aws.amazon.com/s3/), [IFTTT](https://ifttt.com/) and a bit of time!

Anyways, just follow me for some simple analysis and see how we can too find Paul Revere.  All the resources for this post are [here](https://github.com/Mayin/paulrevere).  The Tableau Visuals are [here](http://public.tableausoftware.com/views/PaulRevere/Summary?:embed=y&:display_count=no).

1. First up, I grabbed a copy of the data he used which he has graciously supplied in [GitHub](https://github.com/).  All the resources from his blog post are [here](https://github.com/kjhealy/revere).

2. Looking at the data, we can easily imagine how to import this into a relational system.  We only need to add a header to the person column and we will be up and going in no time.  This file contains organization data for 254 persons and 7 organizations.

![image1.png](https://raw.githubusercontent.com/mariotalavera/paulrevere/master/docs/image1.png)

Without doing any work, we have a table with persons and a bit stating whether they belong to any of the seven organizations defined.

3. Create our database and tables: person, org and orgperson:

``` SQL
CREATE TABLE `person` ( 
  `idperson` int(11) NOT NULL AUTO_INCREMENT, 
  `name` varchar(45) NOT NULL, 
  PRIMARY KEY (`idperson`) 
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8;
```

```SQL
CREATE TABLE `org` ( 
  `idorg` int(11) NOT NULL AUTO_INCREMENT, 
  `name` varchar(45) NOT NULL, 
  PRIMARY KEY (`idorg`) 
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
```

```sql
CREATE TABLE `orgperson` ( 
  `idperson` int(11) NOT NULL, 
  `idorg` int(11) NOT NULL, 
  PRIMARY KEY (`idperson`,`idorg`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

4. Populate our database

Using the CVS file that Kieran provided, we create an insert into script to bulk insert data into table.

5. Having this table in our database, we populate the person table (script) as follows:

``` sql
insert into person(name) select person from matrix;
```

6. Populating the Organization Table is about as simple (script).

```
insert into org(name) values(‘stAndrewsLodge’); 
insert into org(name) values(‘LoyalNine’); 
insert into org(name) values(‘NorthCaucus’); 
insert into org(name) values(‘LongRoomClub’); 
insert into org(name) values(‘TeaParty’); 
insert into org(name) values(‘BostonCommittee’); 
insert into org(name) values(‘LondonEnemies’);
```

7. Lastly of our population scripts, we populate our association table, orgperson.  High tech indeed.  The script for this is here.  The general idea is to insert all person-org memberships along these lines:

```
— pop orgperson, stAndrewsLodge 
insert into orgperson(idperson, idorg) 
select  a.idperson, c.idorg 
from    person a inner join matrix b on a.name = b.person 
        inner join org c on c.name = ‘stAndrewsLodge’ 
where   b.stAndrewsLodge = 1;
```

8 . Finding persons of interest, as Kieran pointed out, boils down to the persons of most influence on their peers.  In SQL lingo, we just want to rank our users by number of connections.  This is a much simpler problem like that of Facebook or LinkedIn because every person we have, we connect thru a defined group.

First, lets create a view so that we can reuse this set (script).

```
create or replace view personconns as 
select  a.name, count(distinct e.name) numconns 
from    person a 
        — Lets join person to orgs he belongs to 
        inner join orgperson b on a.idperson = b.idperson 
        inner join org c on b.idorg = c.idorg 
        — Lets join this org to other persons 
        inner join orgperson d on c.idorg = d.idorg 
        inner join person e on d.idperson = e.idperson 
where   a.idperson <> d.idperson 
group by a.name 
order by 2 desc;
```

Lastly, we write a script with the simplest of queries to rank these persons by the number of connections each has.

```
select (select count(distinct numconns) from personconns where numconns >= m.numconns) rank, m.name, numconns 
from personconns m;
```

Here’s our top suspects.  First lets look at the raw data.

![image2.png](https://raw.githubusercontent.com/mariotalavera/paulrevere/master/docs/image2.png)

All of this just to say that I too found Paul Revere! Yay!  Sorry Paul, you’re a hero to us.  Lets go ahead and visualize this.  It is very clear who our field operatives should lean into right?  All this without invading anyone’s privacy!

![image3.png](https://raw.githubusercontent.com/mariotalavera/paulrevere/master/docs/image3.png)

9. Interestingly, we can build an additional script on this and determine which organizations should be deemed suspect by the influence its members have on the population as follows.  Lets create a view to keep things neat.

```
create or replace view orgconns as 
select  z.name, count(distinct e.name) numconns 
from    org z 
        — Lets get all the users for this org 
        inner join orgperson x on z.idorg = x.idorg 
        inner join person a on x.idperson = a.idperson 
        — Lets join person to orgs he belongs to 
        inner join orgperson b on a.idperson = b.idperson 
        inner join org c on b.idorg = c.idorg 
        — Lets join this org to other persons 
        inner join orgperson d on c.idorg = d.idorg 
        inner join person e on d.idperson = e.idperson 
where   1=1 
and     a.idperson <> d.idperson 
group by z.name 
order by 2 desc;
```

Just as before, we can rank the set of our findings for our field agents with this script!

```
select (select count(distinct numconns) from orgconns where numconns >= m.numconns) rank, m.name, numconns 
from orgconns m;
```

The results of this do not prove as interesting as the person connections but the at least help us narrow down the work.  Remember, we only have 254 persons and 7 organizations.

![image4.png](https://raw.githubusercontent.com/mariotalavera/paulrevere/master/docs/image4.png)

Not a clear result here, for the most part, all organizations seem to be similarly influential.  Our visual further exposes this.

![image5.png](https://raw.githubusercontent.com/mariotalavera/paulrevere/master/docs/image5.png)

Just for kicks, I decided to create a few views to derive the original matrix of data from our SQL. This one provides us with the user/organizations matrix we started with.  This would prove useful in further analysis.

```
create or replace view membershipmatrix as

select    concat_ws(‘ ‘, SUBSTRING_INDEX(a.name, ‘.’,-1),  SUBSTRING_INDEX(a.name, ‘.’,1)) Person, 
          SUBSTRING_INDEX(a.name, ‘.’,-1) FName, 
          SUBSTRING_INDEX(a.name, ‘.’,1) LName, 
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
order by  SUBSTRING_INDEX(a.name, ‘.’,1),  SUBSTRING_INDEX(a.name, ‘.’,-1);
```

For example, this will enable us to follow on Kieran’s post finding organizations persons have in common as shown.

```
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
where    a.person <> b.person 
order by  a.lname, a.fname, b.lname, b.fname
```

With only seven organizations, writing a sql query to do the equivalent organization matrix is no trouble at all.  It is a bit lengthy for post thou, you can always pick up script here.

Instead, have a look at the set it returns. At a glance, we see how many persons any two organizations have in common.

![image6.png](https://raw.githubusercontent.com/mariotalavera/paulrevere/master/docs/image6.png)

It was good to follow thru something fun like this.  Thanks for reading.

