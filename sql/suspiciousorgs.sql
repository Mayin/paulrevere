select (select count(distinct numconns) from orgconns where numconns >= m.numconns) rank, m.name, numconns
from orgconns m;