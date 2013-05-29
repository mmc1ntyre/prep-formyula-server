#!/bin/bash

echo "Enter database name [formyula-default]:"
read database_name

echo "Enter default database user [formyula-db-user]"
read database_user

echo "Enter default database user password [1formyula!2]"
read database_password

if [$database_name = ""];
then
	echo "formyula-default"
else
	echo $database_name
fi

echo "done"