class ReservationsController < ApplicationController
  before_filter :authenticate_user!
  # GET /reservations
  # GET /reservations.json
  def index
    authorize! :read, Reservation, :message => "Unable to list reservations."

    if params[:open]
      @reservations = Reservation.where(:return_date => nil).recent
    elsif params[:book_id]
      @reservations = Reservation.where(:book_id => params[:book_id]).recent
    elsif params[:user_id]
      @reservations = Reservation.where(:user_id => params[:user_id]).recent
    else
      @reservations = Reservation.all.recent
    end

    @reservations = @reservations.map do |r|
      {:reservation => r, :book => Book.find(r.book_id), :user => User.find(r.user_id)}
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    authorize! :read, Reservation, :message => "Unable to show reservation."

    r = Reservation.find(params[:id])
    @r = {:reservation => r, :book => Book.find(r.book_id), :user => User.find(r.user_id)}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @r }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new
    authorize! :create, Reservation, :message => "Unable to create reservation."

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(params[:reservation])
    authorize! :create, Reservation, :message => "Unable to create reservation."

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to :back, notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    authorize! :update, Reservation, :message => "Unable to update reservation."

    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to :back, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    authorize! :delete, Reservation, :message => "Unable to delete reservation."

    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end
end
