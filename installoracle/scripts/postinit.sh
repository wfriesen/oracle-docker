#!/bin/bash
su - oracle -c "\$ORACLE_HOME/bin/sqlplus / as sysdba @/scripts/openpdb.sql"
