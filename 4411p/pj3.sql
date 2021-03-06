connect to c4411;
insert into path1(origin, arrival)
	with t_p1(origin, depart, arrival) as
		(select R.subject, R.subject, R.object
		from sub_owns R
		UNION ALL
		select P.origin, C.subject, C.object
		from sub_owns C, t_p1 P
		where  C.subject = P.arrival and C.object <> P.origin )
select origin, arrival from t_p1;

insert into path2(origin, arrival)
	with t_p2(origin, depart, arrival) as 
		(select R.subject, R.subject, R.object
		from sub_isIn R
		UNION ALL
		select P.origin, C.subject, C.object
		from sub_isIn C, t_p2 P
		where  C.subject = P.arrival and C.object <> P.origin 
		)
select origin, arrival from t_p2;


UPDATE trans_cl 
SET count_distinct = (select count(*) from (select distinct origin, arrival from path2) X)
WHERE closure_predicate = 'isInterestedIn';

UPDATE trans_cl 
SET count_distinct = (select count(*) from (select distinct origin, arrival from path1) X)
WHERE closure_predicate = 'owns';

select * from trans_cl;
terminate;
