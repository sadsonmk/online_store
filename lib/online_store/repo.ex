defmodule OnlineStore.Repo do
  use Ecto.Repo,
    otp_app: :online_store,
    adapter: Ecto.Adapters.Postgres
end
