defmodule ConverterTest do
  use ExUnit.Case
  doctest Converter

  test "convert meters to km" do
    meters = 1000
    km = meters
        |> Converter.to_km
    assert km == 1
  end


  test "round to nearest tenth" do
    val = 10.21
    rounded = val
        |> Converter.to_nearest_tenth
    assert rounded == 10.3
  end

  test "miles to light seconds" do
    light_seconds = {:miles, 1000000}
        |> Converter.to_light_seconds(5)
    assert light_seconds == 5.36819
  end

  test "meters to light seconds" do
    light_seconds = {:meters, 1000000000}
        |> Converter.to_light_seconds(5)
    assert light_seconds == 3.33564
  end

  test "round to a value" do
      rounded = 5.345213 |> Converter.round_to(2)
      assert rounded == 5.35
  end
end

defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  test "escape velocity of earth is correct" do
    ev = Planet.select[:earth]
        |> Planet.escape_velocity
    assert ev == 11.2
  end

  test "escape velocity of mars is correct" do
      ev = Planet.select[:mars]
          |> Planet.escape_velocity
      assert ev == 5.1
  end

  test "escape velocity of of planet X is correct" do
    ev = %{mass: 4.0e22, radius: 6.21e6}
        |> Planet.escape_velocity
    assert ev == 1.0
  end

  test "orbital acceleration for earth at 100km" do
      earth = Planet.select[:earth]
      orbital_acceleration = Physics.Rocketry.orbital_acceleration(100, earth);
      assert orbital_acceleration == 9.515619587729839
  end

  test "orbital term for 100km above Earth" do
      # calculate height like this
      # term = 4.5 * 3600
      # height = Physics.Rocketry.orbital_height(term)
      #   |> Converter.to_km

      height = 6448.581965500235
      term = Physics.Rocketry.orbital_term(height)
      assert (term > 4) && (term < 5)
  end

  @tag :pending
  test "Orbital acceleration for Jupiter at 100km" do
    acceleration = Physics.Rocketry.orbital_acceleration(100, Planet.select[:jupiter])
    # acceleration = Planet.select[:jupiter]
      #|> Physics.Rocketry.orbital_acceleration(Planet.select[:jupiter], 100)
    assert acceleration == 24.659005330334
  end

  @tag :pending
  test "Orbital term at 100km for Saturn at 6000km" do
    #acceleration = Planet.select[:saturn]
    #|> Physics.Rocketry.orbital_acceleration(100)

    term = Physics.Rocketry.orbital_term(6000, Planet.select[:saturn])
    # assert term == 4.9
    assert term == 4.82977908991254
  end
end
