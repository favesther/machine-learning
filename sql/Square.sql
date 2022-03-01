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

with a as(SELECT user_token, count(distinct invoice_token) num_invoices
FROM users u
LEFT JOIN invoices i 
on u.user_token = i.user_token
group by user_token)
SELECT b.num_invoices, ifnull(count(distinct user_token),0) as num_users
FROM (
    select 0 as num_invoices
    union all
    select (@x:=@x+1) as num_invoices from user_token, (select @x:=0) nums
) b 
LEFT JOIN a
on b.num_invoices = a.num_invoices
where num_invoices < (select max(num_invoices) from a)
order by b.num_invoices
/*Q8: What is the cumulative distribution of invoices sent per user? i.e. How many users sent at least 0,1,2,3,... invoices.*/
