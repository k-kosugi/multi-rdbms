-- This is simple VDB that connects to a single PostgreSQL database and exposes it
-- as a Virtual Database.

-- create database
CREATE DATABASE customer OPTIONS (ANNOTATION 'Customer VDB');
USE DATABASE customer;

-- create translators and connections to source
CREATE FOREIGN DATA WRAPPER postgresql;
CREATE SERVER postgresql TYPE 'NONE' FOREIGN DATA WRAPPER postgresql OPTIONS ("jndi-name" 'postgresql');
CREATE FOREIGN DATA WRAPPER mysql;
CREATE SERVER mysql TYPE 'NONE' FOREIGN DATA WRAPPER mysql OPTIONS ("jndi-name" 'mysql');

-- create schema, then import the metadata from the PostgreSQL database
CREATE SCHEMA postgresql_schema SERVER postgresql;
CREATE SCHEMA mysql_schema SERVER mysql;
CREATE VIRTUAL SCHEMA portfolio;

SET SCHEMA postgresql_schema;
IMPORT FOREIGN SCHEMA public FROM SERVER postgresql INTO postgresql_schema OPTIONS("importer.useFullSchemaName" 'false');

SET SCHEMA mysql_schema;
IMPORT FOREIGN SCHEMA address FROM SERVER mysql INTO mysql_schema OPTIONS("importer.useFullSchemaName" 'false');

SET SCHEMA portfolio;

CREATE VIEW CustomerZip(id bigint PRIMARY KEY, name string, ssn string, zip string) AS
   SELECT c.ID as id, c.NAME as name, c.SSN as ssn, a.ZIP as zip
   FROM postgresql_schema.customer c LEFT OUTER JOIN mysql_schema.ADDRESS a
   ON c.ID = a.CUSTOMER_ID;