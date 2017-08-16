defmodule Physics.Rocketry do
    import Converter
    import Calcs
    import Physics.Laws

    @planet Planet.select[:earth]

    def orbital_speed(height, planet \\ @planet) do
        newtons_gravitational_constant() * planet.mass / orbital_radius(height, planet)
            |> square_root
    end

    def orbital_acceleration(height, planet \\ @planet) do
        (orbital_speed(height, planet) |> squared) / orbital_radius(height, planet)
    end

    def orbital_term(height, planet \\ @planet) do
        (4 * (:math.pi |> squared) * (orbital_radius(height, planet) |> cubed) / (newtons_gravitational_constant() * planet.mass))
            |> square_root
            |> seconds_to_hours
    end

    def orbital_height(planet, term) do
        orbital_height_including_planet_radius = (newtons_gravitational_constant() * planet.mass * (term |> squared)) / (4 * (:math.pi |> squared))
            |> cube_root

        orbital_height_including_planet_radius - planet.radius
    end

    defp orbital_radius(height, planet \\ @planet) do
        planet.radius + (height |> to_meters)
    end
end
