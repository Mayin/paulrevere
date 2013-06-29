select (select count(distinct numconns) from personconns where numconns >= m.numconns) rank, m.name, numconns
from personconns m;