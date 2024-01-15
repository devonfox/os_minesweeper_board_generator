class Board < ApplicationRecord
    serialize :mine_locations, coder: JSON
end
