-- 1 , How to create a user on localhost.
/*
create user [username]@<localhost>|<IP address>|<any host('%')>]
identified by ["password"]
*/

create user sundaymi@localhost identified by "apassword";


-- 2 , How to create a user for an IP address other than localhost.
/*
create user [username]@<localhost>|<IP address>|<any host('%')>]
identified by ["password"]
*/  

create user sundaymi@15.15.15.15 identified by "apassword";


-- 3 , How to grant permission to a user to select only from localhost
/*
grant [<permission1, permission2, ... , npermission>|all]
on [database].[<table_name>|<all_tables(*)>]
to [user name]@[<localhost>|<IP address>|<any host('%')>] 
identified by ["password"];
*/

grant select on posts.* to sundaymi@localhost identified by "apassword";
flush privileges; 


-- 4 , How to grant a user permission to create, insert, update, delete and 
-- create temporary tables from localhost.

/*
grant [<permission1, permission2, ... , npermission>|all]
on [database].[<table_name>|<all_tables(*)>]
to [user name]@[<localhost>|<IP address>|<any host('%')>] 
identified by ["password"];
*/

grant select, create, insert, update, delete, create temporary tables 
on posts.* to sundaymi@localhost identified by 'apassword';
flush privileges;


-- 5 , How to grant a user permission to create, insert, update, delete and 
-- create temporary tables from any host.
/* 
grant [<permission1, permission2, ... , npermission>|all]
on [database].[<table_name>|<all_tables(*)>]
to [user name]@[<localhost>|<IP address>|<any host('%')>] 
identified by ["password"];
*/

grant select, create, insert, update, delete, create temporary tables on posts.* 
to sundaymi@'%' identified by 'apassword';
flush privileges;


-- 6 , How to grant a user permission to select only from any host but to a specific table of a database.
/*
grant [<permission1, permission2, ... , npermission>|all]
on [database].[<table_name>|<all_tables(*)>]
to [user name]@[<localhost>|<IP address>|<any host('%')>] 
identified by ["password"];
*/

grant select on posts.url_master to sundaymi@'%' identified by 'apassword';
flush privileges;


-- 7 , How to grant all privileges to a user from all machines.

/*
grant [<permission1, permission2, ... , npermission>|all]
on [database].[<table_name>|<all_tables(*)>]
to [user name]@[<localhost>|<IP address>|<any host('%')>] 
identified by ["password"];
*/

grant all on posts.* to sundaymi@'%' identified by 'apassword';
flush privileges;


-- 8 , How to revoke all privileges from a user.

/*
revoke [<permission1,permission2, ... , nper>|<all privilieges>]
on [database].[<table_name>|<all_tables(*)>]
from [user name]@[<localhost>|<IP address>|<any host('%')>];
*/

revoke all privileges on posts.* from sundaymi@'%';
flush privileges;


-- 9 , How to revoke specific privilege from a user.
/*
revoke [<permission1,permission2, ... , nper>|<all privilieges>]
on [database].[<table_name>|<all_tables(*)>]
from [user name]@[<localhost>|<IP address>|<any host('%')>];
*/

revoke select on posts.* from sundaymi@'%';
flush privileges;

-- 10 , How to check permissions granted to a specific user.

show grants for sundaymi;

-- 11 , How to check the list of system privileges that the MySQL server supports.

show privileges;

-- 12, How to Grant permission to a user so that (s)he can execute not more than a specific 
-- number of queries in an hour.

create user sarah@localhost identified by 'mypassword';
grant select on posts.* to sarah@localhost 
identified by 'mypassword' with MAX_QUERIES_PER_HOUR 50;
flush privileges;


-- 13 , How to Grant permission to a user so that (s)he can execute not more than 
-- a specific number of queries in an hour.

set password for sarah@localhost = password('mypassword123');


-- 14 , How to delete user. 
drop user sarah@'localhost';


-- 15 , How to rename a user.
rename user sarah@localhost to sundaymi@localhost;


-- 16 , How to create a user and granting no privileges
grant usage on posts.* to boris@localhost identified by 'mypassword';


