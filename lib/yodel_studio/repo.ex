defmodule YodelStudio.Repo do
  use Ecto.Repo,
    otp_app: :yodel_studio,
    adapter: Ecto.Adapters.Postgres
end
