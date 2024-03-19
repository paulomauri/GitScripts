
-- parameters to be defined on databse on mount state;
-- startup mount;


-- altera o banco para o modo archivelog
alter database archivelog;

-- força o banco para realizar o log de toda alteração realizada
alter database force logging;

-- habilita o flashback no banco
alter database flashback on;

-- specifies the upper limit (in minutes) on how far back in time the database may be flashed back
alter system set db_flashback_retention_target=1440;


--enables you to specify the number of seconds the database takes to perform crash recovery of a single instance.
alter system set fast_start_mttr_target=1800;

---abrir o banco
alter database open;

--- Para garantir a retenção de dados das transações finalizadas, é necessário alterar o tablespace executando o comando.
alter tablespace undotabs1 retention guarantee;

