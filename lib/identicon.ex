defmodule Identicon do
    @moduledoc """
    Creates identicons, which are the avatar-like image that github autogenerates for new users
"""

    @doc """

        ## Example

            iex> Identicon.main "t"
            [227, 88, 239, 164, 137, 245, 128, 98,
            241, 13, 215, 49, 107, 101, 100, 158]

    """
    def main(input) do

        input
        |> hash_input

    end

    @doc """




    """
    def hash_input(input) do

        :crypto.hash(:md5,input)
        |> :binary.bin_to_list

    end

end