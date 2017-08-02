## I Too Found Paul Revere
I am coming from [this Reddit post](http://www.reddit.com/r/sociology/comments/1g38fk/finding_paul_revere_in_a_historical_example_a/) and from [here](http://kieranhealy.org/blog/archives/2013/06/09/using-metadata-to-find-paul-revere/)… This post exists solely because I too wanted to find Paul Revere.  I am not even going to use ‘big data’.  Mainly because this data is not big, I do not have a graph database and because I think it would be fun to see what plain old SQL and [Tableau](http://www.tableausoftware.com/) can show us.  For truly insightful posts, just visit [Kieran Healy](http://kieranhealy.org/blog/), the author of the original post instead.

Kieran makes a very compelling argument on what is possible for surveillance programs the general population may (or not) understand.  His post is really fascinating.  Follow along and you can learn to monitor your citizens as well. 

Heck, I bet you could build your own surveillance network with freely available online services.  Imagine what you could cook up with [Google Alerts](http://www.google.com/alerts), [Amazon S3](http://aws.amazon.com/s3/), [IFTTT](https://ifttt.com/) and a bit of time!

Anyways, just follow me for some simple analysis and see how we can too find Paul Revere.  All the resources for this post are [here](https://github.com/Mayin/paulrevere).  The Tableau Visuals are [here](http://public.tableausoftware.com/views/PaulRevere/Summary?:embed=y&:display_count=no).

1. First up, I grabbed a copy of the data he used which he has graciously supplied in [GitHub](https://github.com/).  All the resources from his blog post are [here](https://github.com/kjhealy/revere).

2. Looking at the data, we can easily imagine how to import this into a relational system.  We only need to add a header to the person column and we will be up and going in no time.  This file contains organization data for 254 persons and 7 organizations.

![image1.png]({{site.baseurl}}/docs/image1.png)

Without doing any work, we have a table with persons and a bit stating whether they belong to any of the seven organizations defined.

3. Create our database and tables: person, org and orgperson:


