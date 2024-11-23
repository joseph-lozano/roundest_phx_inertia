defmodule Roundest.Repo do
  use Ecto.Repo,
    otp_app: :roundest,
    adapter: Ecto.Adapters.Postgres
end
