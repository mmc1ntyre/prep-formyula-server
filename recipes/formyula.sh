log_file=$1

# Install Java 7
echo -e "\n=> Installing Formyula Configuration File..."

sudo mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS \`formyula-enterprise\`;GRANT ALL ON *.* TO \`formyula-db-user\`@\`localhost\` IDENTIFIED BY \`1formyula!2\`;FLUSH PRIVILEGES;"

sudo touch /etc/formyula.yml && sudo sh -c "cat > /etc/formyula.yml" << EOF
production:
  adapter: jdbcmysql
  encoding: utf8
  database: formyula-enterprise
  username: formyula-db-user
  password: 1formyula!2
EOF

