## [总结各类表格格式化问题](https://leetcode-cn.com/problems/students-report-by-geography/solution/zong-jie-ge-lei-biao-ge-ge-shi-hua-wen-t-tl4e/)

## Row to Column - string
```sql
SELECT 
 max(if(continent = 'America', name, null)) as America,
 max(if(continent = 'Asia', name, null)) as Asia,
 max(if(continent = 'Europe', name, null)) as Europe
FROM (
	select *, 
			row_number() over (partition by continent order by name) as rnk 
	from Student
) t
group by rnk
```