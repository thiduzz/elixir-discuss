defmodule Discuss.Release do
  @app :discuss

  def migrate do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"

    #IO.inspect(:ecto_repos)
    #IO.inspect(@app)
    #IO.inspect(System.fetch_env!("SECRET_KEY_BASE"))
    #IO.inspect(System.fetch_env!("APP_PORT"))
    #IO.inspect(System.fetch_env!("APP_HOSTNAME"))
    #IO.inspect(System.fetch_env!("DB_USER"))
    #IO.inspect(System.fetch_env!("DB_PASSWORD"))
    #IO.inspect(System.fetch_env!("DB_HOST"))
    #IO.inspect(System.fetch_env!("DB_DATABASE"))
    #IO.inspect(System.fetch_env!("DB_POOLSIZE"))
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
    #IO.inspect(Application.fetch_env!(@app, :ecto_repos))
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
    #IO.puts "+++++++++++++++++"
  end
end
