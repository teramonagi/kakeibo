class AccountbooksController < ApplicationController
  before_action :set_accountbook, only: [:show, :edit, :update, :destroy]

  # GET /accountbooks
  # GET /accountbooks.json
  def index
    @accountbooks = Accountbook.all
  end

  # GET /accountbooks/1
  # GET /accountbooks/1.json
  def show
  end

  # GET /accountbooks/new
  def new
    @accountbook = Accountbook.new
  end

  # GET /accountbooks/1/edit
  def edit
  end

  # POST /accountbooks
  # POST /accountbooks.json
  def create
    @accountbook = Accountbook.new(accountbook_params)

    respond_to do |format|
      if @accountbook.save
        format.html { redirect_to @accountbook, notice: 'Accountbook was successfully created.' }
        format.json { render :show, status: :created, location: @accountbook }
      else
        format.html { render :new }
        format.json { render json: @accountbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accountbooks/1
  # PATCH/PUT /accountbooks/1.json
  def update
    respond_to do |format|
      if @accountbook.update(accountbook_params)
        format.html { redirect_to @accountbook, notice: 'Accountbook was successfully updated.' }
        format.json { render :show, status: :ok, location: @accountbook }
      else
        format.html { render :edit }
        format.json { render json: @accountbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accountbooks/1
  # DELETE /accountbooks/1.json
  def destroy
    @accountbook.destroy
    respond_to do |format|
      format.html { redirect_to accountbooks_url, notice: 'Accountbook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def aggregate()
    this_month = Date.parse(params[:date]+"-1")
    next_month = this_month.next_month(1)
    summarized_records = Accountbook.all.where('date <= :tm and date < :nm', {tm:this_month, nm:next_month })
    res = summarized_records.group(:person).sum(:amount)
    @this_month = this_month
    @amount = 100
    # render :text => "Hello, #{params[:name]} san"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accountbook
      @accountbook = Accountbook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accountbook_params
      params.require(:accountbook).permit(:date, :amount, :person, :content)
    end

end
