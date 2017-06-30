defmodule Identicon do
    @moduledoc """
    Creates identicons, which are the avatar-like image that github autogenerates for new users
"""

    @doc """


    """
    def main(input) do

        input
        |> hash_input
        |> pick_color
        |> build_grid
        |> build_pixel_map

    end

    def start(_type,_args) do
        main("banana")
    end

    @doc """
    Produces md5 hash of string
        ## Examples
            iex> Identicon.hash_input []
            %Identicon.Image{hex: [212, 29, 140, 217, 143,
            0, 178, 4, 233, 128,
            9, 152, 236, 248, 66, 126]}
    """
    def hash_input(input) do

        hex = :crypto.hash(:md5,input)
        |> :binary.bin_to_list

        %Identicon.Image{hex: hex}

    end

    @doc """
        Uses the first 3 numbbers in image list to build a RGB color
        ## Examples
            iex> vec = [1,2,3,4,5]
            iex> image = %Identicon.Image{ hex: vec}
            iex> Identicon.pick_color(image )
            %Identicon.Image{ color: {1,2,3} , hex: [1,2,3,4,5] }
    """
    def pick_color(image) do

        %Identicon.Image { hex: [r,g,b | tail ]} = image

        %Identicon.Image { image | color: {r,g,b }}
    end

    @doc """
        Works the same as pick_color, but does pattern matching on the function parameter

               ## Examples

                    iex> vec = [1,2,3,4,5]
                    iex> image = %Identicon.Image{ hex: vec}
                    iex> Identicon.pick_color_smart(image )
                    %Identicon.Image{ color: {1,2,3} , hex: [1,2,3,4,5] }

    """
    def pick_color_smart(%Identicon.Image { hex: [r,g,b | tail ]} = image) do

        %Identicon.Image { image | color: {r,g,b }}

    end

    @doc """

        ## Examples

            iex> image = %Identicon.Image{ hex: [1,2,3, 4,5,6] }
            iex> Identicon.build_grid(image)
            %Identicon.Image { grid: [ 1,2,3,2,1 ,
            4,5,6,5,4 ] , color: nil , hex: [1,2,3, 4,5,6] }

    """
    def build_grid(%Identicon.Image{ hex: hex} = image) do

        grid =
            hex
            |> Enum.chunk(3)
            |> Enum.map(&mirror_row/1)
            |> List.flatten

        %Identicon.Image { image | grid: grid }

    end

    @doc """
        ## Examples
            iex> image = %Identicon.Image { grid: [11, 12, 13] }
            iex> Identicon.build_grid_with_index ( image )
            %Identicon.Image { grid: [{11,0}, {12,1} , {13,2} ] }
    """
    def build_grid_with_index(%Identicon.Image{ grid: grid } = image) do

        %Identicon.Image{ image | grid: Enum.with_index(grid) }

    end

    @doc """

        ## Examples

            iex> Identicon.filter_odd_squares(%Identicon.Image {grid: [{11,0}, {12,1} ] } )
            %Identicon.Image { grid: [ {12, 1} ] }
    """
    def filter_odd_squares(%Identicon.Image { grid: grid } = image) do

        grid = Enum.filter grid,
            fn({ code, _index }) ->
                rem(code,2) == 0
            end

        %Identicon.Image { image | grid: grid}
    end

    @doc """

            ## Examples
                iex> row = [1,2,3]
                iex> Identicon.mirror_row(row)
                [1,2,3,2,1]
    """
    def mirror_row(row) do

        [first,second | _tail ] = row

        row ++ [second , first]

    end

    @doc """
          ## Examples
              iex> %Identicon.Image{ grid: [{11, 1}, {11, 11} , {11,19} ] }
              %Identicon.Image{color: nil,
                grid: [{11, 1441}, {11, 11}, {11, 19}],
                hex: nil}
    """
    def build_pixel_map( %Identicon.Image{grid: grid} = image ) do

        stride = 5
        square_width_px = 50

        Enum.map grid, fn ({_code,index}) ->
            x = rem(index,stride)
            y = div(index,stride)

            {  {x,y} , {x+square_width_px , y+square_width_px} }
        end



    end


end