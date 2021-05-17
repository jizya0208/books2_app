class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @books = Book.all.order(created_at: :desc)
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all.order(created_at: :desc)
      render 'books/index'
    end
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = current_user
    @booker = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
      unless @book.user_id == current_user.id
        redirect_to books_path
      end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render 'books/edit'
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    book = Book.find_by(id: params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end
end
