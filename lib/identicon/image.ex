defmodule Identicon.Image do

    @doc """
        ## Example
            iex> %Identicon.Image{}
            %Identicon.Image{hex: nil}

            iex> %Identicon.Image{}
            %Identicon.Image{color: nil}

            iex> %Identicon.Image{}
            %Identicon.Image{color: nil, hex: nil}

            iex> image = %Identicon.Image{}
            iex> %Identicon.Image{image | color: {1,2,3} }
            %Identicon.Image{color: {1, 2, 3}, hex: nil}

    """
    defstruct hex: nil, color: nil, grid: nil, pixel_map: nil


end