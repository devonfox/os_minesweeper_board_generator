class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]

  # GET /boards or /boards.json
  def index
    @boards = Board.all
  end

  def home
    @boards = Board.all
    @recent_boards = Board.order(created_at: :desc).limit(10)
  end

  # GET /boards/1 or /boards/1.json
  def show
    @board = Board.find(params[:id])
    @mine_board = make_board
  end

  # GET /boards/new
  def new
    @board = Board.new  
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)
  
    if !@board.mine_count.nil? && !@board.width.nil? && !@board.height.nil?
      if @board.mine_count <= @board.width * @board.height
        # only generating if my active record validations work in the model
        generate_board
      end
    end

    respond_to do |format|
      if @board.save
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy!

    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    def generate_board
      width = @board.width
      height = @board.height
      mine_count = @board.mine_count
      mine_locations = Set.new
      while mine_locations.length < mine_count
        point = [rand(height), rand(width)]
        mine_locations.add(point)
      end
        
      @board.mine_locations = mine_locations
    end

    def make_board
      render_board = Array.new(@board.height) { Array.new(@board.width, 0) }

      @board.mine_locations.each do |x, y|
          render_board[y][x] = 1
      end
    
      return render_board
    end
    


    
    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:email, :width, :height, :mine_count, :board_name, :mine_locations)
    end
end

