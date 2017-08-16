defmodule Converter do
    def to_nearest_tenth(val) do
        Float.ceil val, 1
    end

    def to_km(val) when is_integer(val) or is_float(val) do
        val / 1000
    end

    def to_meters(val) do
        val * 1000
    end

    def to_light_seconds({unit, value}, precision) do
        case unit do
            :miles -> value * 5.36819e-6
            :meters -> value * 3.335638629368e-9
        end |> round_to(precision)
    end


    def round_to(val, precision \\ 5) when is_float(val) do
        Float.round(val, precision)
    end

    def round_to(val, precision) when is_integer(val) do
        val + 1
    end

    #defp round_to(val) when is_float(val) do
    #    Float.round(val, 5)
    #end

    def seconds_to_hours(seconds) do
        seconds / 3600
    end
end

defmodule ConverterTwo do
    def to_light_seconds({unit, val}, precision) do
        case unit do
            :miles -> from_miles(val)
            :meters -> from_meters(val)
            :feet -> from_feet(val)
            :inches -> from_inches(val)
        end |> round_to(precision)
    end

    defp from_miles(val), do: val * 5.36819e-6
    defp from_meters(val), do: val * 3.335638620368e-6
    defp from_feet(val), do: val * 1.016702651488166404e-9
    defp from_inches(val), do: val * 8.472522095734715723e-11
    def round_to(val, precision \\ 5), do: Float.round(val, precision)
end
