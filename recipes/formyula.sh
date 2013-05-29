log_file=$1

# Install Java 7
echo -e "\n=> Installing Formyula Configuration File..."

# Install DB & Formyula Configuration
echo -e "\n=> Enter ROOT user database password..."

echo "Enter default database name [formyula-default]:"
read database_name

echo "Enter default database user [formyula-db-user]"
read database_user

echo "Enter default database user password [1formyula!2]"
read database_password

if [$database_name = ""];
then
	$database_name := "formyula-default"
fi

if [$database_user = ""];
then
	$database_user := "formyula-db-user"
fi

if [$database_password = ""];
then
	$database_password := "1formyula!2"
fi


sudo mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS \`$database_name\`;
GRANT ALL ON *.* TO \`$database_user\`@\`localhost\` IDENTIFIED BY \"$databse_password\"
USE \`$database_name\`;
CREATE TABLE \`app_surveys\` (
  \`id\` int(11) unsigned NOT NULL AUTO_INCREMENT,
  \`name\` varchar(100) DEFAULT NULL,
  \`guid\` varchar(255) DEFAULT NULL,
  \`keywords\` varchar(255) DEFAULT NULL,
  \`version\` varchar(5) DEFAULT NULL,
  \`json_data\` mediumtext,
  \`account_id\` int(11) DEFAULT NULL,
  \`user_id\` int(11) DEFAULT NULL,
  \`survey_completed_at\` datetime DEFAULT NULL,
  \`created_at\` datetime DEFAULT NULL,
  PRIMARY KEY (\`id\`),
  UNIQUE KEY \`unq_guid_version\` (\`guid\`,\`version\`),
  KEY \`idx_name\` (\`name\`),
  KEY \`idx_keywords\` (\`keywords\`),
  KEY \`guid\` (\`guid\`),
  KEY \`version\` (\`version\`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;
CREATE TABLE \`locations\` (
  \`id\` int(11) NOT NULL AUTO_INCREMENT,
  \`name\` varchar(255) DEFAULT NULL,
  \`address_1\` varchar(255) DEFAULT NULL,
  \`address_2\` varchar(255) DEFAULT NULL,
  \`city\` varchar(255) DEFAULT NULL,
  \`state\` varchar(255) DEFAULT NULL,
  \`zip\` varchar(255) DEFAULT NULL,
  \`country\` varchar(255) DEFAULT NULL,
  \`deleted_at\` datetime DEFAULT NULL,
  PRIMARY KEY (\`id\`),
  KEY \`index_locations_on_address_1_and_city_and_state_and_zip\` (\`address_1\`,\`city\`,\`state\`,\`zip\`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
"

sudo touch /etc/formyula.yml && sudo sh -c "cat > /etc/formyula.yml" << EOF
production:
  adapter: jdbcmysql
  encoding: utf8
  database: $database_name
  username: $database_user
  password: $database_password
EOF 

