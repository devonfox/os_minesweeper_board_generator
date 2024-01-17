class Board < ApplicationRecord
    serialize :mine_locations, coder: JSON
    # todo: look into email validation practices
    validates :board_name, presence: true, length: { minimum: 1 }
    validates :email, presence: true, length: { minimum: 1 }
    validates :height, presence: true, numericality: { greater_than: 0 }
    validates :width, presence: true, numericality: { greater_than: 0 }
    validates :mine_count, presence: true, numericality: { greater_than: 0 }
    validate :mine_count_cant_be_larger_than_board_size

  private

  def mine_count_cant_be_larger_than_board_size
    if mine_count.present? && height.present? && width.present? && (mine_count > height * width)
      errors.add(:mine_count, "can't be larger than the total board size cell count")
    end
  end
  
    
end
