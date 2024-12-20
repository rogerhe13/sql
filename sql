
with daily_totals as(
  select
  Date(transaction_time) as transaction_time,
  Sum(transaction_amount) as daily_total
  from 
  transactions
  group by 
  date(transaction_time)
),

rolling_avg as(
  select 
  transaction_date,
  daily_total,
  round(AVG(daily_total) over(
   order by transaction_date
    rows between 2 preceding and current row  
  ),2) as rolling_3_day_avg
  
  from
  daily_totals
)

select
  transaction_date,
  rolling_3_day_avg
  
  from 
  rolling_avg
  where
  transaction_date = '2021-01-31'
  


