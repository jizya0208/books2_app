class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @books = Book.all.order(created_at: :desc)
    @book = Book.new
  end
  
  def create
    @book = current_user.books.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notce] = 'You have created book successfully.'
      redirect_to books_path
    else
      render 'books/index'
    end
  end

  def show
    @book = Book.find(params[:id])
    # @user = User.find_by(id: @book.user_id)
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book)
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
end
