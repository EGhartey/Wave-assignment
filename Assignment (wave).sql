Question 1
select count (u_id)
from users;
Question 2
select count (send_amount_currency)
from transfers
where send_amount_currency = 'CFA';
Question 3
select count (distinct u_id)
from transfers
where send_amount_currency ='CFA';
Question 4
select count (atx_id)
from agent_transactions
where extract (year from when_created) = 2018
group by extract (month from when_created);
Question 5
select sum(case when amount > 0 THEN amount else 0 END) as withdrawal,  
sum(case when amount < 0 then amount else 0 END) as deposit, 
case when ((sum(case when amount > 0 THEN amount else 0 END)) > ((sum(case when amount < 0 then amount else 0 END))) * -1) then 'withdrawer' 
else 'depositer' END as agent_status, 
count(*)from agent_transactions WHERE when_created  between (now()  - '1 WEEK'::INTERVAL) and now()
Question 6
 SELECT City, Volume INTO atx_volume_city_summary 
 FROM (Select agents.city AS City, count(agent_transactions.atx_id) 
 AS Volume FROM agents INNER JOIN agent_transactions ON agents.agent_id = agent_transactions.agent_id 
 where (agent_transactions.when_created) between (now() - '1 WEEK'::INTERVAL) and now() 
 GROUP BY agents.city) as atx_volume_summary;
 Question 7
 SELECT City, Volume, Country INTO atx_volume_city_summary_with_Country 
 FROM (Select agents.city AS City, agents.country AS Country, count(agent_transactions.atx_id) 
 AS Volume FROM agents INNER JOIN agent_transactions ON agents.agent_id = agent_transactions.agent_id 
 where (agent_transactions.when_created) between (NOW() - '1 WEEK'::INTERVAL) AND NOW() 
 GROUP BY agents.country,agents.city) as atx_volume_summary_with_Country;
 Question 8
 SELECT transfers.kind AS Kind, wallets.ledger_location AS Country, sum(transfers.send_amount_scalar) 
 AS Volume FROM transfers 
 INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id 
 where (transfers.when_created) between (NOW() - '1 WEEK'::INTERVAL) AND NOW() 
 GROUP BY wallets.ledger_location, transfers.kind;
 Question 9
 SELECT count(transfers.source_wallet_id) 
 AS Unique_Senders, count(transfer_id) 
 AS Transaction_count, transfers.kind 
 AS Transfer_Kind, wallets.ledger_location 
 AS Country, sum(transfers.send_amount_scalar) 
 AS Volume FROM transfers 
 INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id where (transfers.when_created > (NOW() - INTERVAL '1 week')) 
 GROUP BY wallets.ledger_location, transfers.kind;
 Question 10
  SELECT source_wallet_id, send_amount_scalar FROM transfers 
  WHERE send_amount_currency = 'CFA' 
  AND (send_amount_scalar>10000000) 
  AND (transfers.when_created) between (NOW() - '1 MONTH'::INTERVAL) and now();



