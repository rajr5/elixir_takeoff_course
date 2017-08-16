defmodule Mix.Tasks.LoadFlares do
    use Mix.Task
    use Timex

    def run(_args) do
        Mix.Task.run "app.start"

        flares = [
            %{classification: "X", scale: 99.0, date: Timex.to_date({1859, 8, 29})},
            %{classification: "M", scale: 5.8, date: Timex.to_date({2015, 1, 12})},
            %{classification: "M", scale: 1.2, date: Timex.to_date({2015, 2, 9})},
            %{classification: "C", scale: 3.2, date: Timex.to_date({2015, 4, 18})},
            %{classification: "M", scale: 83.6, date: Timex.to_date({2015, 6, 23})},
            %{classification: "C", scale: 2.5, date: Timex.to_date({2015, 7, 4})},
            %{classification: "X", scale: 72.0, date: Timex.to_date({2012, 7, 23})},
            %{classification: "X", scale: 45.0, date: Timex.to_date({2003, 11, 4})}
        ]

        for flare <- flares, do: struct(Physics.SolarFlare, flare) |> Physics.Repo.insert!
    end
end