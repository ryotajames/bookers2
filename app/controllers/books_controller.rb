class BooksController < ApplicationController

before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @user = current_user
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "successfully　投稿に成功しました"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error　投稿に失敗しました"
      render :index
    end

  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = @user.books
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "successfully　更新に成功しました"
      redirect_to book_path
    else
      flash[:notice] = "error　更新に失敗しました"
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
  
end