defmodule LearntList.Repo do
  use Ecto.Repo,
    otp_app: :learnt_list,
    adapter: Ecto.Adapters.Postgres
end
