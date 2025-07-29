-- Create a role (database user) with login and superuser permissions
CREATE ROLE pharmaflow_admin WITH LOGIN SUPERUSER PASSWORD 'CHANGEME';

-- Create the database owned by that role
CREATE DATABASE pharmaflow_db OWNER pharmaflow_admin;
