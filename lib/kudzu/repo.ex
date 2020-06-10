defmodule Kudzu.Repo do
  use Ecto.Repo,
    otp_app: :kudzu,
    adapter: Ecto.Adapters.Postgres
end
