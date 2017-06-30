defmodule Identicon do
    @moduledoc """
    Creates identicons, which are the avatar-like image that github autogenerates for new users
"""

    @doc """

        ## Examples

            iex> Identicon.main "t"
            %Identicon.Image{color: {227, 88, 239} , hex: [227, 88, 239, 164, 137, 245, 128, 98,
            241, 13, 215, 49, 107, 101, 100, 158]}

    """
    def main(input) do

        input
        |> hash_input
        |> pick_color

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

end