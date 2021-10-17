	RANK() 
	• DENSE_RANK() 并列且不占并列
		SELECT Studentname, 
		       Subject, 
		       Marks, 
		       DENSE_RANK() OVER(PARTITION BY Subject ORDER BY Marks DESC) Rank
		FROM ExamResult
		ORDER BY Studentname, 
		         Rank;
	• NTILE() 分级
		SELECT *, 
		       NTILE(2) OVER(PARTITION  BY subject ORDER BY Marks DESC) Rank
		FROM ExamResult
ORDER BY subject, rank;