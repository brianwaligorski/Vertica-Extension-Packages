-- the following are a number of crazy things to do with the shell command

-- want some vertica-independent machine statistics?
select shell_execute(node_name, 'vmstat 1 5') over (partition by segval) from onallnodes order by id;

-- look at vertica log?
select shell_execute(node_name,'tail -5 vertica.log') over (partition by segval) from onallnodes order by id;

-- kill vertica?
--select shell_execute(node_name, 'killall -9 vertica') over (partition by segval) from onallnodes order by id;

-- vstack
-- cannot run vstack directly, as it needs vertica to read its
-- results... but vertica is paused for the vstack!

-- select shell_execute(node_name, 'vstack > /tmp/vstack; cat /tmp/vstack') over (partition by segval) from onallnodes order by id;

-- avoid running on down nodes
-- build a temp table
\set tablename upnodes
\set nodes 'all nodes'
\i ddl/create-temp-dist-table.sql

select shell_execute(node_name, 'pwd') over (partition by segval) from onupnodes order by id;

\i ddl/remove-dist-table.sql

-- run on just some nodes
\set tablename justes
\set nodes 'nodes e0,e1'
\i ddl/create-dist-table.sql

select shell_execute(node_name, 'pwd') over (partition by segval) from onjustes order by id;

\i ddl/remove-dist-table.sql

----- int_sequence

select int_sequence(1,5) over ();

select int_sequence(5,1) over ();

select int_sequence(-1,-1) over ();
