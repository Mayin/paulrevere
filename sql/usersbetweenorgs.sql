select    'StAndrewsLodge' org,
          null StAndrewsLodge, 
          sum(case when a.StAndrewsLodge = 1 and a.LoyalNine = 1 then 1 else 0 end) LoyalNine, 
          sum(case when a.StAndrewsLodge = 1 and a.NorthCaucus = 1 then 1 else 0 end) NorthCaucus, 
          sum(case when a.StAndrewsLodge = 1 and a.LongRoomClub = 1 then 1 else 0 end) LongRoomClub, 
          sum(case when a.StAndrewsLodge = 1 and a.TeaParty = 1 then 1 else 0 end) TeaParty, 
          sum(case when a.StAndrewsLodge = 1 and a.BostonCommittee = 1 then 1 else 0 end) BostonCommittee, 
          sum(case when a.StAndrewsLodge = 1 and a.LondonEnemies = 1 then 1 else 0 end) LondonEnemies
from      membershipmatrix a
union
select    'LoyalNine',
          sum(case when a.LoyalNine = 1 and a.StAndrewsLodge = 1 then 1 else 0 end) StAndrewsLodge, 
          null LoyalNine, 
          sum(case when a.LoyalNine = 1 and a.NorthCaucus = 1 then 1 else 0 end) NorthCaucus, 
          sum(case when a.LoyalNine = 1 and a.LongRoomClub = 1 then 1 else 0 end) LongRoomClub, 
          sum(case when a.LoyalNine = 1 and a.TeaParty = 1 then 1 else 0 end) TeaParty, 
          sum(case when a.LoyalNine = 1 and a.BostonCommittee = 1 then 1 else 0 end) BostonCommittee, 
          sum(case when a.LoyalNine = 1 and a.LondonEnemies = 1 then 1 else 0 end) LondonEnemies
from      membershipmatrix a
union
select    'NorthCaucus',
          sum(case when a.NorthCaucus = 1 and a.StAndrewsLodge = 1 then 1 else 0 end) StAndrewsLodge, 
          sum(case when a.NorthCaucus = 1 and a.LoyalNine = 1 then 1 else 0 end) LoyalNine, 
          null NorthCaucus, 
          sum(case when a.NorthCaucus = 1 and a.LongRoomClub = 1 then 1 else 0 end) LongRoomClub, 
          sum(case when a.NorthCaucus = 1 and a.TeaParty = 1 then 1 else 0 end) TeaParty, 
          sum(case when a.NorthCaucus = 1 and a.BostonCommittee = 1 then 1 else 0 end) BostonCommittee, 
          sum(case when a.NorthCaucus = 1 and a.LondonEnemies = 1 then 1 else 0 end) LondonEnemies
from      membershipmatrix a
union
select    'LongRoomClub',
          sum(case when a.LongRoomClub = 1 and a.StAndrewsLodge = 1 then 1 else 0 end) StAndrewsLodge, 
          sum(case when a.LongRoomClub = 1 and a.LoyalNine = 1 then 1 else 0 end) LoyalNine, 
          sum(case when a.LongRoomClub = 1 and a.NorthCaucus = 1 then 1 else 0 end) NorthCaucus, 
          null LongRoomClub, 
          sum(case when a.LongRoomClub = 1 and a.TeaParty = 1 then 1 else 0 end) TeaParty, 
          sum(case when a.LongRoomClub = 1 and a.BostonCommittee = 1 then 1 else 0 end) BostonCommittee, 
          sum(case when a.LongRoomClub = 1 and a.LondonEnemies = 1 then 1 else 0 end) LondonEnemies
from      membershipmatrix a
union
select    'TeaParty',
          sum(case when a.TeaParty = 1 and a.StAndrewsLodge = 1 then 1 else 0 end) StAndrewsLodge, 
          sum(case when a.TeaParty = 1 and a.LoyalNine = 1 then 1 else 0 end) LoyalNine, 
          sum(case when a.TeaParty = 1 and a.NorthCaucus = 1 then 1 else 0 end) NorthCaucus, 
          sum(case when a.TeaParty = 1 and a.LongRoomClub = 1 then 1 else 0 end) LongRoomClub, 
          null TeaParty, 
          sum(case when a.TeaParty = 1 and a.BostonCommittee = 1 then 1 else 0 end) BostonCommittee, 
          sum(case when a.TeaParty = 1 and a.LondonEnemies = 1 then 1 else 0 end) LondonEnemies
from      membershipmatrix a
union
select    'BostonCommittee',
          sum(case when a.BostonCommittee = 1 and a.StAndrewsLodge = 1 then 1 else 0 end) StAndrewsLodge, 
          sum(case when a.BostonCommittee = 1 and a.LoyalNine = 1 then 1 else 0 end) LoyalNine, 
          sum(case when a.BostonCommittee = 1 and a.NorthCaucus = 1 then 1 else 0 end) NorthCaucus, 
          sum(case when a.BostonCommittee = 1 and a.LongRoomClub = 1 then 1 else 0 end) LongRoomClub, 
          sum(case when a.BostonCommittee = 1 and a.TeaParty = 1 then 1 else 0 end) TeaParty, 
          null BostonCommittee, 
          sum(case when a.BostonCommittee = 1 and a.LondonEnemies = 1 then 1 else 0 end) LondonEnemies
from      membershipmatrix a
union
select    'LondonEnemies',
          sum(case when a.LondonEnemies = 1 and a.StAndrewsLodge = 1 then 1 else 0 end) StAndrewsLodge, 
          sum(case when a.LondonEnemies = 1 and a.LoyalNine = 1 then 1 else 0 end) LoyalNine, 
          sum(case when a.LondonEnemies = 1 and a.NorthCaucus = 1 then 1 else 0 end) NorthCaucus, 
          sum(case when a.LondonEnemies = 1 and a.LongRoomClub = 1 then 1 else 0 end) LongRoomClub, 
          sum(case when a.LondonEnemies = 1 and a.TeaParty = 1 then 1 else 0 end) TeaParty, 
          sum(case when a.LondonEnemies = 1 and a.BostonCommittee = 1 then 1 else 0 end) BostonCommittee, 
          null LondonEnemies
from      membershipmatrix a;