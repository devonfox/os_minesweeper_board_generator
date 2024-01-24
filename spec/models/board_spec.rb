require 'rails_helper'

RSpec.describe Board, type: :board do
  it "is valid with valid attributes" do
    board = Board.new(email: "test@test.com", width: 10, height: 10, mine_count: 10, mine_locations: "[]", board_name: "Test Board")
    expect(board).to be_valid
  end

  it "is invalid without email" do
    board = Board.new(width: 10, height: 10, mine_count: 10, mine_locations: "[]", board_name: "Test Board")
    expect(board).to_not be_valid
  end
end