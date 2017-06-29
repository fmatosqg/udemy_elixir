defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "create_deck makes 20 cards" do
    deck_lenght = length(Cards.create_deck)
    assert deck_lenght == 20
  end

  test "shuffle makes a deck random" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
    refute deck == Cards.shuffle(deck)
  end

end
