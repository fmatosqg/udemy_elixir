defmodule IdenticonTest do
    use ExUnit.Case
    doctest Identicon

    test "the truth" do
      assert 1 + 1 == 2
    end


    test "pixel mapping" do

        val = 111
        image = %Identicon.Image{ grid: [{val, 0}, {val, 9} , {val, 11}] }
        Identicon.build_grid_with_index(image)
    end

end
