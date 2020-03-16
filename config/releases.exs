import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
app_port = System.fetch_env!("APP_PORT")
app_hostname = System.fetch_env!("APP_HOSTNAME")
db_user = System.fetch_env!("DB_USER")
db_password = System.fetch_env!("DB_PASSWORD")
db_host = System.fetch_env!("DB_HOST")
db_database = System.fetch_env!("DB_DATABASE")
db_poolsize = System.fetch_env!("DB_POOLSIZE")

config :discuss, DiscussWeb.Endpoint,
  http: [:inet6, port: String.to_integer(app_port)],
  secret_key_base: secret_key_base

config :discuss,
  app_port: app_port

config :discuss,
  app_hostname: app_hostname

# Configure your database
config :discuss, DiscussWeb.Repo,
  username: db_user,
  password: db_password,
  database: db_database,
  hostname: db_host,
  pool_size: 10,
  port: 5432,
  show_sensitive_data_on_connection_error: true
