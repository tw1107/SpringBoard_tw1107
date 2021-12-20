/*
--q3 :  List the names of students who have taken a course from department v6 (deptId), but not v7
What was the bottleneck? How did you identify it? What method you chose to resolve the bottleneck


It was doing two full table scan, then a join.
We want to reduce table scan as much as possible.

I reduced the full table scan to only 1 time on 3 tbales and removed the subquery as well

*/

SELECT name 
FROM springboardopt.Student s
left join Transcript t on t.studId = s.id
where  crsCode = 'MGT382'
;


/*
--q4 : List the names of students who have taken a course taught by professor v5 (name).
What was the bottleneck? How did you identify it? What method you chose to resolve the bottleneck

We should always reduce full table scan. 

*/



/*
--q5 :  List the names of students who have taken a course from department v6 (deptId), but not v7

What was the bottleneck?
How did you identify it?
What method you chose to resolve the bottleneck



It was doing two full table scan, then a subquery, then 3 full table scan which is not ideal. 
We want to reduce table scan as much as possible.

I reduced the full table scan to only 1 time on 3 tbales and removed the subquery as well

*/

select distinct name
from student s
left join Transcript t on s.id = t.studId
left join Course c on c.crsCode = t.crsCode
where deptId = @v6
and deptId != @v7 
;


