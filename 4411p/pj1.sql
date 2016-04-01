connect to c4411;
drop table test;
drop table closureg;
create table graph(subject varchar(100), predicate varchar(20), object varchar(100));
import from /eecs/home/cse31018/4411p/tnoc.csv of del insert into graph;
select * from graph where RRN(graph)=17986;

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
	path(origin, depart, arrival)
	as(
		select R.subject, R.subject, R.object
		from sub_owns R
		UNION ALL
		select P.origin, C.subject, C.object
		from sub_owns C, path P
		where  C.subject = P.arrival and C.object <> P.origin 
),

closureg(closure_predicate, count_distinct)
as(select 1, count(*) from path)

terminate;

