/*
tables: invoices, users
invoices: one row per invoice sent 
    invoice_token: unique id
    user_token: unique id
    sent_at: datetime
    amount
users: one row per user
    user_token
    created_at
    business_category
*/
/*Q7: What is the distribution of invoices sent per user? ie.e. How many users sent 0,1,2,3,... invoices*/
with  a as(
    SELECT user_token, count(distinct invoice_token) num_invoices
    FROM users u
    LEFT JOIN invoices i 
    on u.user_token = i.user_token
    group by user_token
),
recursive n(num_invoices) as(
    select 0
    union all
    select num_invoices + 1 from n
    where num_invoices <= (select max(num_invoices) from a)
)
select n.num_invoices, ifnull(count(distinct a.user_token),0) as num_users 
from n
left join a on 
    a.num_invoices = n.num_invoices
group by n.num_invoices
order by 1

/*Q8: What is the cumulative distribution of invoices sent per user? i.e. How many users sent at least 0,1,2,3,... invoices.*/

with  a as(
    SELECT user_token, count(distinct invoice_token) num_invoices
    FROM users u
    LEFT JOIN invoices i 
    on u.user_token = i.user_token
    group by user_token
),
recursive n(num_invoices) as(
    select 0
    union all
    select num_invoices + 1 from n
    where num_invoices <= (select max(num_invoices) from a)
)
select num_invoices, 
        ifnull((select count(distinct user_token) from a where a.num_invoices >= n.num_invoices),0) as accumul_num_invoices 
from n
order by n.num_invoices
