log_file=$1

# Install Java 7
echo -e "\n=> Installing Formyula Configuration File..."

sudo cat /etc/formyula.yml << EOF
production:
  adapter: jdbcmysl
  encoding: utf8
  database: your-database-name
  username: your-database-username
  password: your-database-password
EOF

