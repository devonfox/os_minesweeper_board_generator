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

    if @board.width <= 0 || @board.height <= 0 || @board.mine_count <= 0
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity, notice: "Make sure the width, height, and mine count are all greater than zero." }
        format.json { render json: { error: "Make sure the width, height, and mine count are all greater than zero." }, status: :unprocessable_entity }
      end
      return
    end
  
    if @board.mine_count > @board.width * @board.height
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity, notice: "Make sure mine count is less than total cell count" }
        format.json { render json: { error: "Make sure mine count is less than total cell count" }, status: :unprocessable_entity }
      end
      return
    end

    generate_board

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
      board_array = Array.new(height) { Array.new(width, 0) }
    
      mine_count.times do
        row = rand(height)
        col = rand(width)
    
        while board_array[row][col] == 1
          row = rand(height)
          col = rand(width)
        end
    
        board_array[row][col] = 1
      end

      @board.mine_locations = board_array
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:email, :width, :height, :mine_count, :board_name, :mine_locations)
    end
end
