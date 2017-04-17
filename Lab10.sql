-- Dio Minott
-- Lab10

create table Courses (
    num      integer not null,
    name     text    not null,
    credits  integer not null,
  primary key (num)
);


insert into Courses(num, name, credits)
values (499, 'CS/ITS Capping', 3 );

insert into Courses(num, name, credits)
values (308, 'Database Systems', 4 );

insert into Courses(num, name, credits)
values (221, 'Software Development Two', 4 );

insert into Courses(num, name, credits)
values (220, 'Software Development One', 4 );

insert into Courses(num, name, credits)
values (120, 'Introduction to Programming', 4);

select * 
from courses
order by num ASC;


--
-- Courses and their prerequisites
--
create table Prerequisites (
    courseNum integer not null references Courses(num),
    preReqNum integer not null references Courses(num),
  primary key (courseNum, preReqNum)
);

insert into Prerequisites(courseNum, preReqNum)
values (499, 308);

insert into Prerequisites(courseNum, preReqNum)
values (499, 221);

insert into Prerequisites(courseNum, preReqNum)
values (308, 120);

insert into Prerequisites(courseNum, preReqNum)
values (221, 220);

insert into Prerequisites(courseNum, preReqNum)
values (220, 120);

select *
from Prerequisites
order by courseNum DESC;


-- 1)
create or replace function PreReqsFor(int, REFCURSOR) returns REFCURSOR as
$$
declare
   course int:= $1;
   resultset REFCURSOR := $2;
begin
   open resultset for 
      select num, name
      from course
      where num in (select preReqNum
                   		from insert into Prerequisites(courseNum, preReqNum) 
                    	where courseNum = course);
return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
Fetch all from results;


-- 2)
create or replace function IsPreReqFor (int, REFCURSOR) returns REFCURSOR as
$$
declare
   course int := $1;
   resultset REFCURSOR := $2;
begin
   open resultset for 
      select num, name
      from, Courses
      where num in (select courseNum
      from Prerequisites
      where preReqNum = course);
   	return resultset;
end;
$$ 
language plpgsql;



select IsPreReqFor(220, 'results');
Fetch all from results;