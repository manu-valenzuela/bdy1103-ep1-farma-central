--FARMA CENTRAL--

--INSTRUCCIONES:
--Abrir SQLPlus e iniciar como:
/AS SYSDBA;

--Pegar las siguientes líneas para crear usuario farmacental:
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER farmacentral IDENTIFIED BY farmacentral
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER farmacentral QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION TO farmacentral;
GRANT "RESOURCE" TO farmacentral;
ALTER USER farmacentral DEFAULT ROLE "RESOURCE";

