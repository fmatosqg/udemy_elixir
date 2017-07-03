defmodule Cards do
    @moduledoc """
        Creates decks of cards
    """

  @doc """
  Returns list of cards
  """
  def create_deck do
    values = ["Ace","Two",  "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end

  end

  def shuffle (deck) do
    Enum.shuffle(deck)
  end


    @doc """
        ## Examples
            iex> deck = Cards.create_deck
            iex> Cards.contains?(deck,"")
            false
            iex> Cards.contains?(deck,"Ace of Diamonds")
            true
    """

    def contains?(deck, card) do
        Enum.member?(deck,card)
    end

  @doc """
    Divides deck into a hand. `hand_size` argument shows how many cards a player gets,
    `deck` is a deck of cards

        ## Examples
            iex> deck = Cards.create_deck
            iex> {hand,_deck} = Cards.deal(deck,1)
            iex> hand
            ["Ace of Spades"]
  """
  def deal(deck, hand_size) do

    Enum.split(deck,hand_size)
  end

  def save(deck,filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename,binary)
  end


  def load(filename) do

    case File.read(filename) do
        {:ok, binary } -> :erlang.binary_to_term binary
        {:error, _reason} -> "No file '#{filename}' was loaded"
    end

  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
