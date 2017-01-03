class SampletablesController < ApplicationController
  before_action :set_sampletable, only: [:show, :edit, :update, :destroy]

  # GET /sampletables
  # GET /sampletables.json
  def index
    @sampletables = Sampletable.all
  end

  # GET /sampletables/1
  # GET /sampletables/1.json
  def show
  end

  # GET /sampletables/new
  def new
    @sampletable = Sampletable.new
  end

  # GET /sampletables/1/edit
  def edit
  end

  # POST /sampletables
  # POST /sampletables.json
  def create
    @sampletable = Sampletable.new(sampletable_params)

    respond_to do |format|
      if @sampletable.save
        format.html { redirect_to @sampletable, notice: 'Sampletable was successfully created.' }
        format.json { render :show, status: :created, location: @sampletable }
      else
        format.html { render :new }
        format.json { render json: @sampletable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sampletables/1
  # PATCH/PUT /sampletables/1.json
  def update
    respond_to do |format|
      if @sampletable.update(sampletable_params)
        format.html { redirect_to @sampletable, notice: 'Sampletable was successfully updated.' }
        format.json { render :show, status: :ok, location: @sampletable }
      else
        format.html { render :edit }
        format.json { render json: @sampletable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sampletables/1
  # DELETE /sampletables/1.json
  def destroy
    @sampletable.destroy
    respond_to do |format|
      format.html { redirect_to sampletables_url, notice: 'Sampletable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sampletable
      @sampletable = Sampletable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sampletable_params
      params.require(:sampletable).permit(:name, :age)
    end
end
