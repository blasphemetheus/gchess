defmodule Model.UrBoardTest do
  @moduledoc """
  Testing the Ur Board module in Model.
  """
  use ExUnit.Case
  doctest UrBoard
  import UrBoard
  describe "UrBoard. width, length, home_posns, end_posns" do
    # test "height of old board" do
    #   assert width() == 3
    #   assert length() == 8
    # end
  end

  describe "UrBoard. heaven or hell" do
    test "heaven" do
      #posn = {w, l} = {0, 2}

      assert in_heaven(0, 6) == true
      assert in_heaven(1, 7) == true
      assert in_heaven(2, 6) == true
      assert in_heaven(0, 5) == false
      assert in_heaven(1, 4) == false
      assert in_heaven(2, 3) == false

      assert in_hell(1, 4) == true
      assert in_hell(1, 5) == true
      assert in_hell(2, 4) == false
      assert in_hell(2, 0) == false
      assert in_hell(0, 7) == false

      assert in_limbo(0, 4) == true
      assert in_limbo(2, 4) == true
      assert in_limbo(0, 5) == true
      assert in_limbo(2, 5) == true

      assert on_earth(1, 3) == true
      assert on_earth(0, 2) == true
      assert on_earth(2, 1) == true
      assert on_earth(0, 0) == true

      assert on_earth(1, 4) == false
      assert on_earth(2, 4) == false
      assert on_earth(0, 4) == false
      assert on_earth(1, 6) == false
      assert on_earth(2, 7) == false

      assert upside(0, 0) == true
      assert upside(0, 4) == true
      assert upside(0, 7) == true

      assert downside(2, 5) == true
      assert downside(2, 0) == true
      assert downside(2, 7) == true
    end
  end

  describe "UrBoard. square_type" do
    test "find the square_type of a posn" do

      assert square_type(0, 0) == :rosette
      assert square_type(0, 1) == :eyes
      assert square_type(0, 2) == :water
      assert square_type(0, 3) == :eyes
      assert square_type(0, 4) == :home
      assert square_type(0, 5) == :end
      assert square_type(0, 6) == :rosette
      assert square_type(0, 7) == :plasma

      assert square_type(1, 0) == :crystal
      assert square_type(1, 1) == :water
      assert square_type(1, 2) == :ice
      assert square_type(1, 3) == :rosette
      assert square_type(1, 4) == :water
      assert square_type(1, 5) == :ice
      assert square_type(1, 6) == :eyes
      assert square_type(1, 7) == :water

      assert square_type(2, 0) == :rosette
      assert square_type(2, 1) == :eyes
      assert square_type(2, 2) == :water
      assert square_type(2, 3) == :eyes
      assert square_type(2, 4) == :home
      assert square_type(2, 5) == :end
      assert square_type(2, 6) == :rosette
      assert square_type(2, 7) == :plasma
    end
  end

  describe "UrBoard. get_at" do
    test "get what's at a posn" do

    end
  end
end
