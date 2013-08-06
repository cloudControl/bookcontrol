require 'net/http'
require 'json'

class BooksController < ApplicationController
  before_filter :authenticate_user!
  # GET /books
  # GET /books.json
  def index
    if params[:search]
      @books = Book.search(params[:search])
    else
      @books = Book.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    @reservation = ReservationsHelper.isBookReserved @book.id, nil
    if @reservation and @reservation.user_id.to_s != current_user.id.to_s
      @owner = User.find(@reservation.user_id)
    else
      @owner = current_user
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    ReservationsHelper.deleteBook(params[:id])
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def qr
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html
      format.svg  { render :qrcode => (url_for @book), :level => :l, :unit => 5 }
    end
  end

  def isbn
    res = Net::HTTP.get(URI('http://openlibrary.org/api/books?bibkeys=ISBN:' + params[:isbn] + '&jscmd=data&format=json'))
    data = JSON.parse(res)["ISBN:#{ params[:isbn] }"]

    if not data.nil?
      puts data
      if data["authors"].nil?
        res = Net::HTTP.get(URI('http://openlibrary.org/api/books?bibkeys=ISBN:' + params[:isbn] + '&jscmd=details&format=json'))
        details = JSON.parse(res)["ISBN:#{ params[:isbn] }"]
        puts details
        data["authors"] = details["details"]["authors"]
      end
    end

    respond_to do |format|
      format.html { render json: data }
      format.json { render json: data }
    end
  end
end
