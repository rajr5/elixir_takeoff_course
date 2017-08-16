defmodule Solar do
    def power(%{classification: classification, scale: scale}) do
        multiplier(classification) * scale
    end

    defp multiplier(classification) do
        case classification do
            :C -> 1
            :M -> 10
            :X -> 1000
        end
    end

    def no_eva(flares), do: Enum.filter flares, &(power(&1) > 1000)

    def deadliest(flares) do
        Enum.map(flares, &(power(&1)))
            |> Enum.max
    end

    def flare_list(flares) do
        #for flare <- flares, flare.classification == :X, do: %{power: power(flare), is_deadly: power(flare) > 1000}

        for flare <- flares,
            power <- [power(flare)],
            is_deadly <- [power > 1000],
            do: %{power: power, is_deadly: is_deadly}

        #Enum.map flares, fn(flare) ->
        #    p = power(flare)
        #    %{power: p, is_deadly: p > 1000}
        #end

        #(Enum.map flares, fn(flare) ->
        #    [power: power(flare), is_dead: power(flare) > 1000]
        #end) |> List.flatten
    end

    def total_flare_power(list) do

        Enum.reduce list, 0, fn(flare, total) ->
            power(flare) + total
        end
        #(for flare <- flares, do: power(flare)) |> Enum.sum
    end
end
