defmodule Bomber do
    use GenServer

    def start_link do
        Agent.start_link fn -> [] end
    end

    def record_flare(pid, flare) do
        Agent.get_and_update pid, fn(flares) ->
            add_flare(flare)
            new_flares = List.insert_at(flares, -1, flare)
            {new_flares, new_flares}
        end
    end

    defp add_flare(flare) do
        """
        INSERT INTO solar_flares(classification, scale, stations, inserted_at, updated_at)
        VALUES ($1, $2, 100, now(), now()) RETURNING *;
        """
        |> execute([flare.classification, flare.scale])
    end

    defp execute(sql, params) do
        {:ok, pid} = connect()

        res = Postgrex.query!(pid, sql, params)
        res
    end

    defp connect do
        Postgrex.start_link(hostname: "localhost", database: "redfour")
    end
end

Enum.map 1..5000, fn(_n) ->
    {:ok, pid} = Bomber.start_link
    Bomber.record_flare pid, %{classification: "X", scale: 33.0, stations: 10}
end

IO.inspect("DONE")