import Config

config :playground, Playground.Repo,
  adapter: Ecto.Adapters.Postgres,
  url:
    "postgres://bxhirenqdvhqtu:528c613ddc05e69807b09fdc33197fbf6b9b8012595cd24de64517aa666bdb77@ec2-52-213-173-172.eu-west-1.compute.amazonaws.com:5432/diufhptto6ilr",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "4246db4c4c9b88ca3b05",
  client_secret: "d9d70250f50a072081c6a6ea0ea99ec3617d127d"
