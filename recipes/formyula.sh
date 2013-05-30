#!/bin/bash
log_file=$1

# Install Java 7
echo -e "\n=> Installing Formyula Configuration File..."

# Install DB & Formyula Configuration
echo "Enter default database name [formyula-default]:"
read DB_NAME

echo "Enter default database user [formyula-db-user]"
read DB_USER

echo "Enter default database user password [1formyula!2]"
read DB_PASSWD

echo "Enter default FORMYULA_DATA_TOKEN [3formyula!4]"
read WS_TOKEN

echo "\n*****************************"
echo "\n** AMAZON S3 Configuration **"
echo "\n*****************************"
echo "\n"
echo "Please Note: The information you are entering must match the information you provide the Formyula team."
echo "\n"
echo "Enter your Amazon S3 : ACCESS KEY [blank]"
read ACCESS_KEY

echo "Enter your Amazon S3 : SECRET KEY [blank]"
read SECRET_KEY

echo "Enter your Amazon S3 : BUCKET [blank]"
read BUCKET

if [$DB_NAME -eq ""];
then
	DB_NAME="formyula-default"
fi

if [$DB_USER -eq ""];
then
	DB_USER="formyula-db-user"
fi

if [$DB_PASSWD -eq ""];
then
	DB_PASSWD="1formyula!2"
fi

if [$WS_TOKEN -eq ""];
then
	WS_TOKEN="3formyula!4"
fi

echo "Enter Maria-DB User password ..."
sudo mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;GRANT ALL ON *.* TO \`$DB_USER\`@\`localhost\` IDENTIFIED BY \"$DB_PASSWD\";
USE $DB_NAME;
CREATE TABLE \`app_surveys\` (\`id\` int(11) unsigned NOT NULL AUTO_INCREMENT,\`name\` varchar(100) DEFAULT NULL,\`guid\` varchar(255) DEFAULT NULL,\`keywords\` varchar(255) DEFAULT NULL, \`version\` varchar(5) DEFAULT NULL,\`json_data\` mediumtext,\`account_id\` int(11) DEFAULT NULL,\`user_id\` int(11) DEFAULT NULL,\`survey_completed_at\` datetime DEFAULT NULL,\`created_at\` datetime DEFAULT NULL,PRIMARY KEY (\`id\`),UNIQUE KEY \`unq_guid_version\` (\`guid\`,\`version\`),KEY \`idx_name\` (\`name\`),KEY \`idx_keywords\` (\`keywords\`),KEY \`guid\` (\`guid\`),KEY \`version\` (\`version\`)) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;
CREATE TABLE \`locations\` (\`id\` int(11) NOT NULL AUTO_INCREMENT,\`name\` varchar(255) DEFAULT NULL,\`address_1\` varchar(255) DEFAULT NULL,\`address_2\` varchar(255) DEFAULT NULL,\`city\` varchar(255) DEFAULT NULL,\`state\` varchar(255) DEFAULT NULL,\`zip\` varchar(255) DEFAULT NULL,\`country\` varchar(255) DEFAULT NULL,\`deleted_at\` datetime DEFAULT NULL,PRIMARY KEY (\`id\`),KEY \`index_locations_on_address_1_and_city_and_state_and_zip\` (\`address_1\`,\`city\`,\`state\`,\`zip\`)) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
"

sudo touch /etc/formyula.yml && sudo sh -c "cat > /etc/formyula.yml" << EOF
production:
  adapter: jdbcmysql
  encoding: utf8
  database: $DB_NAME
  username: $DB_USER
  password: $DB_PASSWD
  data_token: $WS_TOKEN
  s3_access_key: $ACCESS_KEY
  s3_secret_key: $SECRET_KEY
  s3_bucket: $BUCKET
EOF

