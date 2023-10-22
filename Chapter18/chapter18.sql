-- chapter 18

create user replicarole with replication encrypted password 'supersecret';

create database db_source;

create table t1 (id integer not null primary key, name varchar(64));

select on all tables in schema public to replicarole;

create publication all_tables_pub for all tables;

create database db_destination;

create table t1 (id integer not null primary key, name varchar(64));

create subscription sub_all_tables connection 'user=replicarole password=supersecret host=pg1 port=5432 dbname=db_source' publication all_tables_pub;

insert into t1 values(1, 'linux'), (2, 'freebsd');

select * from t1;

select * from pg_stat_replication;

select * from pg_publication;

select * from pg_subscription;

insert into t1 values (3, 'openbsd');

insert into t1 values(4, 'minix');

insert into t1 values(3, 'windows');

insert into t1 values(5, 'unix');

drop subscription sub_all_tables;

truncate t1;

create subscription sub_all_tables connection 'user=replicarole password=supersecret host=pg1 port=5432 dbname=db_source' publication all_tables_pub;

alter table t1 add description varchar(64);

delete from t1 where id = 5;

alter table t1 add description varchar(64);

drop subscription sub_all_tables;

sub_all_tables set (slot_name = none);

-- db_destination=#
sub_all_tables disable;

-- db_destination=#
sub_all_tables set (slot_name = none);

-- db_destination=#
drop subscription sub_all_tables;
