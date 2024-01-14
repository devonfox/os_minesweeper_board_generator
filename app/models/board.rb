class Board < ApplicationRecord
    serialize :mine_locations, JSON
end
