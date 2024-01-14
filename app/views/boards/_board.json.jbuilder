json.extract! board, :id, :email, :width, :height, :mine_count, :board_name, :created_at, :updated_at
json.url board_url(board, format: :json)
