class SampletablezzzzsController < ApplicationController
  before_action :set_sampletablezzzz, only: [:show, :edit, :update, :destroy]

  # GET /sampletablezzzzs
  # GET /sampletablezzzzs.json
  def index
    @sampletablezzzzs = Sampletablezzzz.all
  end

  # GET /sampletablezzzzs/1
  # GET /sampletablezzzzs/1.json
  def show
  end

  # GET /sampletablezzzzs/new
  def new
    @sampletablezzzz = Sampletablezzzz.new
  end

  # GET /sampletablezzzzs/1/edit
  def edit
  end

  # POST /sampletablezzzzs
  # POST /sampletablezzzzs.json
  def create
    @sampletablezzzz = Sampletablezzzz.new(sampletablezzzz_params)

    respond_to do |format|
      if @sampletablezzzz.save
        format.html { redirect_to @sampletablezzzz, notice: 'Sampletablezzzz was successfully created.' }
        format.json { render :show, status: :created, location: @sampletablezzzz }
      else
        format.html { render :new }
        format.json { render json: @sampletablezzzz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sampletablezzzzs/1
  # PATCH/PUT /sampletablezzzzs/1.json
  def update
    respond_to do |format|
      if @sampletablezzzz.update(sampletablezzzz_params)
        format.html { redirect_to @sampletablezzzz, notice: 'Sampletablezzzz was successfully updated.' }
        format.json { render :show, status: :ok, location: @sampletablezzzz }
      else
        format.html { render :edit }
        format.json { render json: @sampletablezzzz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sampletablezzzzs/1
  # DELETE /sampletablezzzzs/1.json
  def destroy
    @sampletablezzzz.destroy
    respond_to do |format|
      format.html { redirect_to sampletablezzzzs_url, notice: 'Sampletablezzzz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sampletablezzzz
      @sampletablezzzz = Sampletablezzzz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sampletablezzzz_params
      params.require(:sampletablezzzz).permit(:name, :age, :id)
    end
end
