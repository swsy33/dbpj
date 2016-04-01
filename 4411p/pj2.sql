connect to c4411;
with sub_owns(subject, object)
	as(
		select T.subject, T.object
		from graph T
		where T.predicate = 'owns'
	),
	sub_isIn(subject, object)
	as(
		select T.subject, T.object
		from graph T
		where T.predicate = 'isInterestedIn'
	),
	path1(origin, depart, arrival)
	as(
		select R.subject, R.subject, R.object
		from sub_owns R
		UNION ALL
		select P.origin, C.subject, C.object
		from sub_isIn C, path1 P
		where  C.subject = P.arrival and C.object <> P.origin 
	),
	path2(origin, depart, arrival)
	as(
		select R.subject, R.subject, R.object
		from sub_isIn R
		UNION ALL
		select P.origin, C.subject, C.object
		from sub_isIn C, path2 P
		where  C.subject = P.arrival and C.object <> P.origin 
	)
	
	
select count(*) from graph where predicate = 'isInterestedIn';
terminate;




insert into path1(select R.subject, R.subject, R.object
		from sub_owns R
		UNION ALL
		select P.origin, C.subject, C.object
		from sub_owns C, path1 P
		where  C.subject = P.arrival and C.object <> P.origin );
